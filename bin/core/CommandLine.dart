import 'package:tuple/tuple.dart';
import 'BeansEngine.dart';
import '../dmx/Parameter.dart';
import '../dmx/Channel.dart';

extension on String {
  bool get isNumeric =>
    this != 'NaN' &&
    this != 'Infinity' &&
    double.tryParse(this) != null;
}

extension <T> on List<T> {
  List<R> asType<R>() => map((element) => element as R).toList();
}

const commandNames = {
  't': 'thru',
  '=': '+',
  '-': '-',
  'f': 'full',
  'c': 'Chan',
  'l': 'level'
};

class CommandLine {
  final _commands = <String>[];
  var isExecuted = false;
  String? error;

  String? objectType;
  List<int>? selection;
  Map<String, String?>? properties;

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
    if (command.isNumeric && _commands.last.isNumeric) {
      _commands.last += command;
    }

    if (commandNames.containsKey(command) || command.isNumeric) {
      _commands.add(command);
    } else if (commandNames.containsKey(command.toLowerCase())) {
      _commands.add(command.toLowerCase());
    }

    _parse();
  }

/*
  void _validate() {
    error = null;
    final tokens = _tokens();
    if (tokens.length < 2) return;

    var hadThru = false;
    if (tokens.last == 't') {
      tokens.removeLast();
      hadThru = true;
    }

    final selection = _selection(tokens.sublist(1));
    final objects = _objects(tokens.first, selection.item2);
    if (hadThru) tokens.add('t');
    if (objects.any((obj) => obj == null)) {
      error = 'Invalid selection';
      return;
    }
  }*/

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
  
  // OHHHHH how i wish i could use a Type as a generic parameter
  List<Object?> _objects(String name, List<int> selection) {
    Object? Function(int) getObject;
    switch (name) {
      case 'c': getObject = BeansEngine.getObject<Channel>; break;
      default: throw Exception("'$name' is not the short name for an object type");
    }
    return selection.map((i) => getObject(i)).toList();
  }

  /// Get a selection literal from [tokens], starting at the start.
  Tuple2<int, List<int>> getSelection(List<String> tokens) {
    if (tokens.isEmpty) return Tuple2(0, []);
    /// pos is the token BEFORE the next binary operator
    var pos = 0;
    final out = _thru(tokens);
    if (tokens.length > 1 && tokens[1] == 't') {
      pos += 2;
    }
    if (tokens.length == 1) {
      return Tuple2(1, out);
    }
    while (pos != tokens.length - 1) {      
      final thru = _thru(tokens.sublist(pos + 2));
      if (tokens[pos + 1] == '=') {
        out.addAll(thru);
      } else if (tokens[pos + 1] == '-') {
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

    return Tuple2(pos + 1, out);
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

  void _parse() {
    error = null;
    if (_commands.isEmpty) return;
    // check for valid object type
    if (!['c'].contains(_commands.first)) {
      error = "Can't have '${commandNames[_commands.first]}' here.";
      return;
    }
  }

  // command -> objectType selection *action
  // selection -> thru *["+" thru] *["-" thru]
  // thru -> number ["thru" number]
  // action -> property [val]
  void execute() {
    if (isExecuted || error != null) return;
    String selectionType;
    List<int> selection;
    int selectionLen;

    // minimal implementation, assumes everything is verbose & property values are numbers
    selectionType = _commands.first;
    final selectionTuple = getSelection(_commands.sublist(1));
    selectionLen = selectionTuple.item1;
    selection = selectionTuple.item2;

    // Could have duplicates, so use a list of tuples instead of a map.
    final actions = <Tuple2<String, double?>>[];
    String? current;
    for (var i = selectionLen + 2; i < _commands.length; i++) {
      if (_commands[i].isNumeric) {
        actions.add(Tuple2(current!, double.parse(_commands[i])));
        current = null;
      }
      else {
        if (current != null) {
          actions.add(Tuple2(current, null));
        }
        current = _commands[i];
      }
    }
    if (current != null) actions.add(Tuple2(current, null));

    final objects = _objects(selectionType, selection);

    for (var action in actions) {
      switch (selectionType) {
        case 'c': {
          for (var channel in objects.asType<Channel?>()) {
            switch (action.item1) {
              case 'l': {
                channel?.setValue(Parameter.Intensity, action.item2!.toInt());
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
    for (var token in _commands) {
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