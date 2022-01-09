import '../dmx/DmxManager.dart';
import '../ui/BeansUI.dart';

class BeansEngine {
  static late DmxManager dmx;
  static late BeansUI _ui;

  static var _quit = false;
  static void quit() => _quit = true;

  static void go() async {
    dmx = DmxManager();
    _ui = BeansUI();

    while (!_quit) {
      _ui.frame();
      dmx.frame();
    }

    _ui.destroy();
  }
}