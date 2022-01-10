import '../dmx/DmxManager.dart';
import '../ui/BeansUI.dart';
import 'CommandLine.dart';

import '../dmx/Channel.dart';

class BeansEngine {
  static final dmx = DmxManager();
  static final commandLine = CommandLine();
  static late final BeansUI _ui;

  static T? getObject<T>(int id) {
    switch (T) {
      case Channel: return dmx.channels[id] as T?;

      default: throw Exception('$T is not a BeansObject');
    }
  }

  static var _quit = false;
  static void quit() => _quit = true;

  static void go() {
    _ui = BeansUI();

    while (!_quit) {
      _ui.frame();
      dmx.frame();
    }

    _ui.destroy();
  }
}