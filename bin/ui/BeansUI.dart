import 'Display.dart';
import 'SDLDisplay.dart';
import 'Event.dart';
import 'SDLEvent.dart';
import '../dart_codegen.dart';
import 'Renderable.dart';
import 'V2.dart';
import 'UIBase.dart';

class BeansUI {
  final Display _display = SDLDisplay('beans');
  final Event _event = SDLEvent();
  Renderable root = UIBase();

  var _quit = false;

  void go() {
    libSDLFont().Init();
    while (!_quit) {
      while (_event.Poll() > 0) {
        _onEvent();
      }
      _frame();
    }
  }

  void _onEvent() {
    switch (_event.type) {
      case EventType.Quit: _quit = true; break;
      case EventType.KeyDown: {
        if (_event.key == KeyCode.Escape) _quit = true;
        break;
      }
    
      default: {}
    }
  }

  void _frame() {
    root.render(
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
    V2.destroy();
  }
}