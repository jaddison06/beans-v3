import 'Display.dart';
import 'SDLDisplay.dart';
import 'Event.dart';
import 'SDLEvent.dart';
import '../dart_codegen.dart';

class BeansUI {
  final Display _display = SDLDisplay('beans');
  final Event _event = SDLEvent();

  var _quit = false;

  void go() {
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
    
      default: {}
    }
  }

  void _frame() {

  }

  void destroy() {
    _event.Destroy();
    _display.Destroy();
  }
}