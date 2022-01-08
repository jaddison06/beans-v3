import 'dart_codegen.dart';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  final e131 = BeansE131('beans', '127.0.0.1', 1);
  var level = 0;
  while (true) {
    for (var channel = 0; channel < 512; channel++) {
      e131.SetValue(channel + 1, level);
    }
    level++;
    e131.Print();
    if (!e131.Send()) {
      print('Uh oh :(');
      exit(1);
    }
    await Future.delayed(Duration(milliseconds: 600));
  }
}
