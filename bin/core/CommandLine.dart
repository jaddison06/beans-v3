import 'package:tuple/tuple.dart';
import 'BeansEngine.dart';
import '../dmx/Parameter.dart';

extension on String {
  bool get isNumeric =>
    this != 'NaN' &&
    this != 'Infinity' &&
    double.tryParse(this) != null;
}

const commandNames = {
  't': 'thru',
  '=': '+',
  '-': '-',
  'a': '@',
  'c': 'Chan',
};

class CommandLine {
  final _commands = <String>[];
  var isExecuted = false;

  void addCommand(String command) {
    if (isExecuted) {
      clear();
    }
    if (commandNames.containsKey(command) || command.isNumeric) {
      _commands.add(command);
    } else if (commandNames.containsKey(command.toLowerCase())) {
      _commands.add(command.toLowerCase());
    }
  }

  void backspace() {
    if (isExecuted) clear();
    if (_commands.isEmpty) return;
    _commands.removeLast();
  }

  void clear() {
    _commands.clear();
    isExecuted = false;
  }

  List<String> _tokens() {
    final out = <String>[];
    String? num;
    for (var command in _commands) {
      if (command.isNumeric) {
        num ??= '';
        num += command;
        continue;
      }
      if (num != null) {
        out.add(num);
        num = null;
      }
      out.add(command);
    }

    if (num != null) out.add(num);

    return out;
  }

  /// Get a selection literal from [tokens], starting at the start.
  Tuple2<int, List<int>> _selection(List<String> tokens) {
    var pos = 0;
    final out = _thru(tokens);
    pos += (tokens[pos + 1] == 't') ? 3 : 1;
    
    while (true) {
      if (tokens[pos] == '=') {
        final thru = _thru(tokens.sublist(pos + 1));
        out.addAll(thru);
      } else if (tokens[pos] == '-') {
        final thru = _thru(tokens.sublist(pos + 1));
        thru.forEach(out.remove);
      } else {
        break;
      }
      if (
        pos >= tokens.length - 2 ||
        tokens[pos + 2] == 't' && pos >= tokens.length - 4
      ) break;
      pos += (tokens[pos + 2] == 't') ? 4 : 2;
    }

    return Tuple2(pos - 1, out);
  }

  List<int> _thru(List<String> tokens) {
    final out = [int.parse(tokens.first)];
    if (tokens.length == 1) return out;
    if (tokens[1] == 't') {
      for (var i = out.first + 1; i <= int.parse(tokens[2]); i++) {
        out.add(i);
      }
    }
    return out;
  }

  // command -> selectionType selection *action
  // selection -> thru *["+" thru] *["-" thru]
  // thru -> number ["thru" number]
  // action -> verb [number]
  void execute() {
    if (isExecuted) return;
    String selectionType;
    List<int> selection;
    int selectionLen;

    // minimal implementation, assumes everything is verbose
    final tokens = _tokens();
    selectionType = tokens[0];
    final selectionTuple = _selection(tokens.sublist(1));
    selectionLen = selectionTuple.item1;
    selection = selectionTuple.item2;

    // Could have duplicates, so use a list of tuples instead of a map.
    final actions = <Tuple2<String, double?>>[];
    String? current;
    for (var i = selectionLen + 2; i < tokens.length; i++) {
      if (tokens[i].isNumeric) {
        actions.add(Tuple2(current!, double.parse(tokens[i])));
        current = null;
      }
      else {
        if (current != null) {
          actions.add(Tuple2(current, null));
        }
        current = tokens[i];
      }
    }
    if (current != null) actions.add(Tuple2(current, null));

    for (var action in actions) {
      switch (selectionType) {
        case 'c': {
          for (var channel in selection) {
            switch (action.item1) {
              case 'a': {
                BeansEngine.dmx.channels[channel]?.setValue(Parameter.Intensity, action.item2!.toInt());
              }
            }
          }
        }
      }
    }

    isExecuted = true;
  }

  @override
  String toString() {
    var out = '';
    if (_commands.isEmpty) return out;
    for (var token in _tokens()) {
      if (token.isNumeric) {
        out += token;
      } else {
        out += commandNames[token]!;
      }
      out += ' ';
    }
    return out.substring(0, out.length - 1);
  }
}