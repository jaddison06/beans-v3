import 'BeansWindow.dart';
import 'Display.dart';
import 'V2.dart';
import 'Colour.dart';
import '../core/BeansEngine.dart';
import 'Fonts.dart';

class TestWindow extends BeansWindow {
  @override
  final String title = 'Test';

  @override
  void render(Display display, V2 pos, V2 size, V2 blockSize) {
    for (var x = 0; x < size.x; x += blockSize.x) {
      for (var y = 0; y < size.y; y += blockSize.y) {
        display.DrawText(Fonts()[null][20], BeansEngine.dmx.addresses()[1]![
          ((y / blockSize.y) * (size.y / blockSize.y)) + (x / blockSize.x) + 1
        ].toString(), pos + V2(x, y), Colour.pink);
      }
    }
  }
}