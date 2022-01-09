import '../dmx/DmxManager.dart';
import '../ui/BeansUI.dart';
import 'dart:async';

class BeansEngine {
  static late DmxManager dmx;
  static late BeansUI _ui;

  // The UI doesn't quit immediately - it finishes drawing the current frame, then exits.
  // So, if we call _ui.Destroy() here, all the internals will get
  // destroyed *while they're still drawing a frame*.
  static void quit() => _ui.quit();

  static void go() async {
    dmx = DmxManager();
    _ui = BeansUI();

    // async, runs in background
    unawaited(dmx.go());
    // blocks until completion
    await _ui.go();

    dmx.quit();
    _ui.destroy();
  }
}