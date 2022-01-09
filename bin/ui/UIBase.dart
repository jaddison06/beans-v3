import 'Renderable.dart';
import 'Display.dart';
import 'V2.dart';
import 'BeansWindow.dart';
import 'Colour.dart';
import 'Fonts.dart';
import 'TestWindow.dart';
import 'Event.dart';
import '../dart_codegen.dart';
import '../core/BeansEngine.dart';

class _WindowInfo {
  // size and pos are in blocks
  V2 size;
  V2 pos;
  final BeansWindow win;
  _WindowInfo({required this.size, required this.pos, required this.win});
}

enum _WMModifyState {
  None,
  Move,
  Close,
  Resize
}

class UIBase extends Renderable {
  final _windows = <_WindowInfo>[
    _WindowInfo(
      pos: V2(2, 2),
      size: V2(10, 6),
      win: TestWindow()
    )
  ];

  _WindowInfo? _focusedWin;
  
  var _modifyState = _WMModifyState.None;
  _WindowInfo? _modifyWin;
  V2? _modifyData;

  static final minBlockSize = 40;

  V2 _getBlockSize(V2 constraints) => V2(
    minBlockSize + ((constraints.x % minBlockSize) ~/ (constraints.x ~/ minBlockSize)),
    minBlockSize + ((constraints.y % minBlockSize) ~/ (constraints.y ~/ minBlockSize))
  );

  @override
  V2 getSize(V2 constraints) {
    return constraints;
  }

  _WindowInfo? _titlebarAt(V2 pos, V2 constraints, V2 hit) {
    final blockSize = _getBlockSize(constraints);
    for (var win in _windows) {
      if (hit.containedBy(
        win.pos * blockSize,
        V2(win.size.x * blockSize.x, blockSize.y)
      )) return win;
    }
  }

  _WindowInfo? _windowAt(V2 pos, V2 constraints, V2 hit) {
    for (var win in _windows) {
      if (hit.containedBy(
        (win.pos + 1) * _getBlockSize(constraints),
        (win.size - 1) * _getBlockSize(constraints)
      )) return win;
    }
  }

  @override
  void render(Display display, V2 pos, V2 constraints) {
    // Use clip so we don't accidentally draw plusses over the edges
    display.SetClip(pos, constraints);

    final blockSize = _getBlockSize(constraints);

    for (var x = 0; x <= constraints.x; x += blockSize.x) {
      for (var y = 0; y <= constraints.y; y += blockSize.y) {
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
      final contentPos = winPos + V2(0, blockSize.y);
      final contentSize = winSize - V2(0, blockSize.y);
      display.FillRect(winPos, winSize, Colour.black);
      display.DrawRect(winPos, winSize, Colour.magenta);
      display.DrawText(Fonts()[null][blockSize.y - 3], window.win.title, winPos + V2(10, 0), Colour.magenta);
      
      // todo: fucking strange SetClip behaviour
      //display.SetClip(contentPos, contentSize);
      window.win.render(display, contentPos, contentSize, blockSize);
      //display.ResetClip();
    }
  }

  @override
  void onEvent(V2 pos, V2 constraints, Event event) {
    if (event.type == EventType.KeyDown && event.key == KeyCode.Escape) BeansEngine.quit();
    _windows.first.win.onEvent(pos, event);
  }
}