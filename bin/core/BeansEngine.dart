import '../dmx/DmxManager.dart';
import '../ui/BeansUI.dart';
import 'CommandLine.dart';
import '../ui/BeansWindow.dart';
import '../dart_codegen.dart';

class BeansEngine {
  static final dmx = DmxManager();
  static final commandLine = CommandLine();
  static late final BeansUI _ui;

  // made it a getter so it seems sexy and fast when in reality it's a fucking abortion to call every frame
  static Map<String, Map<int, BeansObject>> get objects {
    return {
      'c': dmx.channelObjects()
    };
  }

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

    while (!_quit) {
      _ui.frame();
      dmx.frame();
    }

    _ui.destroy();
  }
}