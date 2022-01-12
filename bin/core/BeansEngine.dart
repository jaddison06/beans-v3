import '../dmx/DmxManager.dart';
import '../ui/BeansUI.dart';
import 'CommandLine.dart';
import '../ui/BeansWindow.dart';

class BeansEngine {
  static final dmx = DmxManager();
  static final commandLine = CommandLine();
  static late final BeansUI _ui;

  // i don't wanna expose _ui directly or anything could happen
  /// Send keyboard events ([EventType.Text] and [EventType.key])to [win]. Keyboard focus is implemented as a stack,
  /// so remember to call [endKeyboardFocus].
  static void requestKeyboardFocus(BeansWindow win) => _ui.base.requestKeyboardFocus(win);
  /// Stop sending keyboard events ([EventType.Text] and [EventType.key]) to [win]. If [win] is not at the top of the
  /// keyboard focus stack, this does nothing.
  static void endKeyboardFocus(BeansWindow win) => _ui.base.endKeyboardFocus(win);

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
    final fps = frame * 1000 / end.difference(start).inMilliseconds;
    print('$frame frames in ${end.difference(start).inSeconds} seconds = $fps fps');

    _ui.destroy();
  }
}