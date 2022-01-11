import '../dmx/DmxManager.dart';
import '../ui/BeansUI.dart';
import 'CommandLine.dart';

class BeansEngine {
  static final dmx = DmxManager();
  static final commandLine = CommandLine();
  static late final BeansUI _ui;

  static var _quit = false;
  static void quit() => _quit = true;

  static void go() {
    _ui = BeansUI();

    final start = DateTime.now();
    var frame = 0;
    while (!_quit) {
      _ui.frame();
      dmx.frame();
      frame++;
    }

    final end = DateTime.now();
    final diff = end.difference(start).inMilliseconds;
    print('$frame frames in $diff ms = ${(frame * 1000 / diff).toStringAsPrecision(4)}fps');

    _ui.destroy();
  }
}