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
import 'package:intl/intl.dart';

const commands = {
  'c': 'Channel'
};

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

  _WindowInfo? _keyboardFocus;
  
  var _modifyState = _WMModifyState.None;
  _WindowInfo? _modifyWin;
  V2? _modifyData;

  final minBlockSize = 40;
  final topAreaHeight = 30;
  final bottomAreaHeight = 80;

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
    final windowAreaPos = pos + V2(0, topAreaHeight);
    final windowAreaSize = constraints - V2(0, topAreaHeight) - V2(0, bottomAreaHeight);

    final topAreaSize = V2(constraints.x, topAreaHeight);

    final bottomAreaPos = V2(pos.x, pos.y + topAreaHeight + windowAreaSize.y);
    final bottomAreaSize = V2(constraints.x, bottomAreaHeight);

    // ---------- TOP ----------
    display.DrawLine(pos + V2(0, topAreaHeight), pos + V2(constraints.x, topAreaHeight), Colour.magenta);
    display.DrawText(Fonts()[null][25], DateFormat('hh:mm:ss').format(DateTime.now()), pos + V2(40, 0), Colour.magenta);

    // ---------- BOTTOM ----------
    

    // ---------- WINDOWS ----------

    // Use clip so we don't accidentally draw plusses over the edges
    display.SetClip(windowAreaPos, windowAreaSize);

    // todo: blockSize is still slightly suspect, could just be float precision wank. TEST!
    final blockSize = _getBlockSize(windowAreaSize);

    for (var x = 0; x <= windowAreaSize.x; x += blockSize.x) {
      for (var y = 0; y <= windowAreaSize.y; y += blockSize.y) {
        final length = 4;
        display.DrawLine(
          windowAreaPos + V2(x, y - (length ~/ 2)),
          windowAreaPos + V2(x, y + (length ~/ 2)),
          Colour.magenta
        );
        display.DrawLine(
          windowAreaPos + V2(x - (length ~/ 2), y),
          windowAreaPos + V2(x + (length ~/ 2), y),
          Colour.magenta
        );
      }
    }

    display.ResetClip();

    for (var window in _windows) {
      final winPos = windowAreaPos + window.pos * blockSize;
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