extension on String {
  bool get isNumeric => this != 'NaN' && this != 'Infinity' && double.tryParse(this) != null;
}

const commandNames = {
  'a': '@',
  'c': 'Chan',
  'g': 'Group'
};

class CommandLine {
  final commands = <String>[];
  var isExecuted = false;

  List<String> _tokens() {
    final out = <String>[];
    String? num;
    for (var command in commands) {
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

    return out;
  }

  void execute() {
    isExecuted = true;
  }

  @override
  String toString() {
    var out = '';
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