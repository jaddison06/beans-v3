import 'Renderable.dart';
import 'Display.dart';
import 'V2.dart';
import 'BeansWindow.dart';
import 'Colour.dart';
import 'Fonts.dart';
import 'TestWindow.dart';

class _WindowInfo {
  // size and pos are in blocks
  V2 size;
  V2 pos;
  final BeansWindow win;
  _WindowInfo({required this.size, required this.pos, required this.win});
}

class UIBase extends Renderable {
  final _windows = <_WindowInfo>[
    _WindowInfo(
      pos: V2(2, 2),
      size: V2(10, 6),
      win: TestWindow()
    )
  ];

  int blockSize = 40;

  @override
  V2 getSize(V2 constraints) {
    return constraints;
  }

  @override
  void render(Display display, V2 pos, V2 constraints) {
    // Use clip so we don't accidentally draw plusses over the edges
    display.SetClip(pos, constraints);

    for (var x = 0; x <= constraints.x; x += blockSize) {
      for (var y = 0; y <= constraints.y; y += blockSize) {
        final length = 4;
        display.DrawLine(
          pos + V2(x, y - (length ~/ 2)),
          pos + V2(x, y + (length ~/ 2)),
          Colour.magenta
        );
        display.DrawLine(
          pos + V2(x - (length ~/ 2), y),
          pos + V2(x + (length ~/ 2), y),
          Colour.magenta
        );
      }
    }

    display.ResetClip();

    for (var window in _windows) {
      final winPos = pos + window.pos * blockSize;
      final winSize = window.size * blockSize;
      final contentPos = winPos + V2(0, blockSize);
      final contentSize = winSize - V2(0, blockSize);
      display.FillRect(winPos, winSize, Colour.black);
      display.DrawRect(pos + window.pos * blockSize, window.size * blockSize, Colour.magenta);
      display.DrawText(Fonts()[null][blockSize - 3], window.win.title, pos + (window.pos * blockSize) + V2(10, 0), Colour.magenta);
      display.SetClip(contentPos, contentSize);
      window.win.render(display, contentPos, contentSize, blockSize);
      display.ResetClip();
    }
  }
}