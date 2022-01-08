import 'dart_codegen.dart';
import 'ui/V2.dart';
import 'ui/SDLEvent.dart';

Future<void> main(List<String> arguments) async {
  final disp = SDLDisplayRaw('beans');
  final event = SDLEvent();
  var rect = V2(10, 10);
  var quit = false;
  while (!quit) {
    while (event.Poll() > 0) {
      if (event.type == EventType.Quit) {
        quit = true;
      } else if (event.type == EventType.MouseMove) {
        rect = event.pos;
      } else if (event.type == EventType.KeyDown && event.key == KeyCode.Escape) {
        quit = true;
      }
    }
    disp.FillRect(rect.x, rect.y, 80, 50, 255, 0, 0);
    disp.Flush();
  }

  V2.destroy();
}
