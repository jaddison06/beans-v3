import 'Display.dart';
import 'SDLDisplay.dart';
import 'Event.dart';
import 'SDLEvent.dart';
import '../dart_codegen.dart';
import 'Renderable.dart';
import 'V2.dart';
import 'UIBase.dart';
import '../core/BeansEngine.dart';

class BeansUI {
  final Display _display = SDLDisplay('beans');
  final Event _event = SDLEvent();
  Renderable base = UIBase();

  BeansUI() {
    libSDLFont().Init();
  }

  void frame() {
    while (_event.Poll() > 0) {
      _onEvent();
    }
    _frame();
  }

  void _onEvent() {
    if (_event.type == EventType.Quit) {
      BeansEngine.quit();
      return;
    }
    base.onEvent(V2.origin(), _display.size, _event);
  }

  void _frame() {
    base.render(
      _display,
      V2.origin(),
      _display.size
    );
    _display.Flush();
  }

  void destroy() {
    _event.Destroy();
    _display.Destroy();
    libSDLFont().Quit();
    // V2 is in the UI module, so I reckon BeansUI is responsible for it
    V2.destroy();
  }
}