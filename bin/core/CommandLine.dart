import 'package:tuple/tuple.dart';
import 'BeansEngine.dart';
import '../dmx/Parameter.dart';
import '../dmx/Channel.dart';
import '../dart_codegen.dart';
import 'dart:io';

extension on String {
  bool get isNumeric =>
    this != 'NaN' &&
    this != 'Infinity' &&
    double.tryParse(this) != null;
  
  bool get isInt =>
    isNumeric &&
    double.parse(this) % 1 == 0;
}

extension <T> on List<T> {
  List<R> asType<R>() => map((element) => element as R).toList();
}

class CommandLine {
  final _commands = <String>[];
  var isExecuted = false;
  String? error;

  BeansObject? objectType;
  List<int>? selection;
  BeansObjectMethod? method;
  // see specialValues in _parse()
  Map<BeansObjectProperty, double?>? properties;

  void addCommand(String command) {
    if (error != null) return;
    if (isExecuted) {
      clear();
    }
/*
    if (command.isNumeric && _commands.isEmpty) {
      _commands.add('c');
    }
*/
    if (command.isNumeric && _commands.isNotEmpty && _commands.last.isNumeric) {
      _commands.last += command;
    } else {
      if (_displayName(command) != null || command.isNumeric) {
        _commands.add(command);
      } else if (objectsByKeyCode.containsKey(command.toLowerCase())) {
        _commands.add(command.toLowerCase());
      }
    }

    _parse();
  }

  void backspace() {
    if (isExecuted) clear();
    if (_commands.isEmpty) return;
    _commands.removeLast();
    _parse();
  }

  void clear() {
    _commands.clear();
    isExecuted = false;
    _parse();
  }

  /// Get a selection literal from [tokens], starting at the start.
  List<int> getSelection(List<String> tokens) {
    if (tokens.isEmpty) return [];
    /// pos is the token BEFORE the next binary operator
    var pos = 0;
    final out = _thru(tokens);
    if (tokens.length == 1) return out;
    if (tokens[1] == 't') {
      pos += 2;
    }

    while (pos != tokens.length - 1) {
      /*
      print(tokens.join(', '));
      for (var i = 0; i < pos; i++) {
        for (var j = 0; j < tokens[i].length + 2; j++) {
          stdout.write(' ');
        }
      }
      print('^ ($pos)');
      print(out);
      */
      if (tokens[pos + 1] == '=') {
        final thru = _thru(tokens.sublist(pos + 2));
        out.addAll(thru);
      } else if (tokens[pos + 1] == '-') {
        final thru = _thru(tokens.sublist(pos + 2));
        thru.forEach(out.remove);
      } else {
        break;
      }
      if (tokens[pos + 3] == 't') {
        pos += 4;
      } else {
        pos += 2;
      }
    }

    return out;
  }

  List<int> _thru(List<String> tokens) {
    final out = [int.parse(tokens.first)];
    if (tokens.length == 1) return out;
    if (tokens[1] == 't') {
      final valB = int.parse(tokens[2]);
      if (out.first < valB) {
        for (var i = out.first + 1; i <= valB; i++) {
          out.add(i);
        }
      } else if (out.first > valB) {
        for (var i = valB; i < out.first; i++) {
          out.add(i);
        }
      }
    }
    return out;
  }

  String? _displayName(String key) {
    const _display = {
      '=': '+',
      '-': '-',
      't': 'thru',
      'a': 'max',
      'i': 'min',
      'l': 'level',
      'p': 'pan'
    };
    if (objectsByKeyCode.containsKey(key)) {
      return objectsByKeyCode[key]!.name;
    } else if (_display.containsKey(key)) {
      return _display[key];
    }
  }

  void _setError(int pos) {
    error = "Can't have '${_displayName(_commands[pos]) ?? _commands[pos]}' here.";
  }

  // command -> objectType selection (method | *action)
  // selection -> thru *["+" thru] *["-" thru]
  // thru -> int ["thru" int]
  // action -> (property [double]) | method
  void _parse() {
    error = null;
    objectType = null;
    selection = null;
    method = null;
    properties = null;

    if (_commands.isEmpty) return;

    // check for valid object type
    if (!objectsByKeyCode.containsKey(_commands.first)) {
      _setError(0);
      return;
    }
    objectType = objectsByKeyCode[_commands.first];

    // keep the position after the loop has ended
    var i = 0;
    // check for valid selection literal, WITHOUT causing a nasty error when it's unfinished,
    // eg ending with 'thru'
    for (; i < _commands.length; i++) {
      if (i != 0) {
        if (!['-', '='].contains(_commands[i])) {
          break;
        }
      }
      if (++i > _commands.length - 1) return;
      if (!_commands[i].isInt) {
        _setError(i);
        return;
      }
      // break instead of return bc this may be incomplete, but it's parseable, so
      // we want to tell the user if their selection is gonna be valid or not
      if (++i > _commands.length - 1) break;
      if (_commands[i] == 't') {
        if (++i > _commands.length - 1) return;
        if (!_commands[i].isInt) {
          _setError(i);
          return;
        }
      } else {
        i--;
      }
    }

    // we've (hopefully) returned if we're halfway through a selection literal,
    // so let's hope there's a valid one!
    selection = getSelection(_commands.sublist(1));
    if (!_selectionValid()) {
      error = 'Invalid ${objectType!.name}';
      return;
    }

    if (i > _commands.length - 1) return;
    
    // check for method or property literal
    if (objectType!.methods.containsKey(_displayName(_commands[i]))) {
      if (i != _commands.length - 1) {
        _setError(i + 1);
      } else {
        method = objectType!.methods[_displayName(_commands[i])]!;
      }
      return;
    }

    const specialValues = <String, double>{
      'a': -1,
      'i': -2
    };

    for (; i < _commands.length; i++) {
      final commandName = _displayName(_commands[i]);
      if (!objectType!.properties.containsKey(commandName)) {
        _setError(i);
        return;
      }
      if (++i > _commands.length - 1) return;
      if (_commands[i].isNumeric || specialValues.containsKey(_commands[i])) {
        if (!objectType!.properties[commandName]!.canSet) {
          _setError(i);
          return;
        } else {
          properties ??= {};
          final val = _commands[i].isNumeric ? double.parse(_commands[i]) : specialValues[_commands[i]]!;
          properties![objectType!.properties[commandName]!] = val;
          i++;
        }
      } else if (objectType!.properties.containsKey(_commands[i])) {
        properties ??= {};
        properties![objectType!.properties[commandName]!] = null;
      } else {
        _setError(i);
        return;
      }
    }

  }

  /// assumes [objectType] and [selection] are non-null
  bool _selectionValid() {
    switch (objectType!) {
      case obj_Channel: {
        for (var i in selection!) {
          if (!BeansEngine.dmx.channels.containsKey(i)) return false;
        }
        return true;
      }
    }
    // unreachable
    return false;
  }

  Map<String, dynamic>? execute() {
    if (isExecuted || error != null) return null;

    Map<String, dynamic>? out;

    switch (objectType!) {
      case obj_Channel: {
        for (var i in selection!) {
          final chan = BeansEngine.dmx.channels[i]!;
          for (var prop in properties!.entries) {
            final param = Parameter.values.firstWhere((param) => param.name == prop.key.name);
            if (prop.value == null) {
              out ??= {};
              out[param.name] = chan.getValue(param);
            } else {
              var val = prop.value!;
              if (val == -1) {
                val = chan.fixture.getInfo(param).max;
              } else if (val == -2) {
                val = chan.fixture.getInfo(param).min;
              }
              chan.setValue(param, val);
            }
          }
        }
      }
    }

    isExecuted = true;
    return out;
  }

  @override
  String toString() {
    var out = '';
    if (_commands.isEmpty) return out;
    for (var token in _commands) {
      out += _displayName(token) ?? token;
      out += ' ';
    }
    if (isExecuted) {
      return out + '✓';
    }
    return out.substring(0, out.length - 1);
  }
}