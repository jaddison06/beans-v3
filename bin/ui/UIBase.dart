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

// you could just use a List but this makes it obvious what it's doing
class Stack<T> {
  final _list = <T>[];

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  T pop() => _list.removeLast();
  T peek() => _list.last;
  void push(T val) => _list.add(val);
}

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

  final _keyboardFocus = Stack<_WindowInfo>();
  
  var _modifyState = _WMModifyState.None;
  _WindowInfo? _modifyWin;
  V2? _modifyData;

  final minBlockSize = 40;
  final topAreaHeight = 30;
  final bottomAreaHeight = 80;

  void requestKeyboardFocus(BeansWindow win) {
    _keyboardFocus.push(_windows.firstWhere((info) => info.win == win));
  }

  void endKeyboardFocus(BeansWindow win) {
    if (_keyboardFocus.isNotEmpty && win == _keyboardFocus.peek().win) {
      _keyboardFocus.pop();
    }
  }

  V2 _getBlockSize(V2 constraints) => V2(
    minBlockSize + ((constraints.x % minBlockSize) ~/ (constraints.x ~/ minBlockSize)),
    minBlockSize + ((constraints.y % minBlockSize) ~/ (constraints.y ~/ minBlockSize))
  );

  @override
  V2 getSize(V2 constraints) {
    return constraints;
  }

  V2 _windowPos(_WindowInfo win, V2 pos, V2 constraints) => pos + V2(0, topAreaHeight) + (win.pos * _getBlockSize(constraints));

  _WindowInfo? _titlebarAt(V2 pos, V2 constraints, V2 hit) {
    final blockSize = _getBlockSize(constraints);
    for (var win in _windows) {
      if (hit.containedBy(
        _windowPos(win, pos, constraints),
        V2(win.size.x * blockSize.x, blockSize.y)
      )) return win;
    }
  }

  _WindowInfo? _windowAt(V2 pos, V2 constraints, V2 hit) {
    final blockSize = _getBlockSize(constraints);
    for (var win in _windows) {
      if (hit.containedBy(
        _windowPos(win, pos, constraints) + V2(0, blockSize.y),
        (win.size - 1) * blockSize
      )) return win;
    }
  }

  @override
  void render(Display display, V2 pos, V2 constraints) {
    final windowAreaPos = pos + V2(0, topAreaHeight);
    final windowAreaSize = constraints - V2(0, topAreaHeight) - V2(0, bottomAreaHeight);

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
          Colour.pink
        );
        display.DrawLine(
          windowAreaPos + V2(x - (length ~/ 2), y),
          windowAreaPos + V2(x + (length ~/ 2), y),
          Colour.pink
        );
      }
    }

    display.ResetClip();

    for (var window in _windows) {
      final winPos = _windowPos(window, pos, constraints);
      final winSize = window.size * blockSize;
      final contentPos = winPos + V2(0, blockSize.y);
      final contentSize = winSize - V2(0, blockSize.y);
      display.FillRect(winPos, winSize, Colour.black);
      display.DrawRect(winPos, winSize, Colour.pink);
      display.DrawText(Fonts()[null][blockSize.y - 3], window.win.title, winPos + V2(10, 0), Colour.pink);
      
      // todo: fucking strange SetClip behaviour
      //display.SetClip(contentPos, contentSize);
      window.win.render(display, contentPos, contentSize, blockSize);
      //display.ResetClip();
    }

    final topAreaSize = V2(constraints.x, topAreaHeight);

    final bottomAreaPos = V2(pos.x, pos.y + topAreaHeight + windowAreaSize.y);
    final bottomAreaSize = V2(constraints.x, bottomAreaHeight);

    // ---------- TOP ----------
    display.DrawLine(pos + V2(0, topAreaHeight), pos + V2(constraints.x, topAreaHeight), Colour.pink);
    display.DrawText(Fonts()[null][25], DateFormat('HH:mm:ss').format(DateTime.now()), pos + V2(40, 0), Colour.pink);

    // ---------- BOTTOM ----------
    final font = Fonts()[null][20];
    final commandLine = BeansEngine.commandLine.toString();
    final error = BeansEngine.commandLine.error;
    final commandLinePos = bottomAreaPos + V2(10, 10);
    display.DrawText(font, commandLine, commandLinePos, Colour.pink);
    if (error != null) {
      display.DrawText(font, error, commandLinePos + V2(font.TextSize(commandLine).x + 15, 0), Colour.red);
    }
  }

  void _winOnEvent(_WindowInfo win, Event event, V2 pos, V2 constraints) {
    win.win.onEvent(_windowPos(win, pos, constraints) + V2(0, _getBlockSize(constraints).y), event);
  }

  @override
  void onEvent(V2 pos, V2 constraints, Event event) {
    if (event.type == EventType.Key && event.key == Key.Escape) BeansEngine.quit();
    switch (event.type) {
      case EventType.Key: {
        if (_keyboardFocus.isNotEmpty) {
          _winOnEvent(_keyboardFocus.peek(), event, pos, constraints);
          break;
        }
        switch (event.key) {
          case Key.Backspace: {
            if (event.modifiers.contains(Modifier.Shift)) {
              BeansEngine.commandLine.clear();
            } else {
              BeansEngine.commandLine.backspace();
            }
            break;
          }
          case Key.Return: {
            BeansEngine.commandLine.execute();
            break;
          }
          default: {}
        }
        break;
      }
      case EventType.Text: {
        if (_keyboardFocus.isNotEmpty) {
          _winOnEvent(_keyboardFocus.peek(), event, pos, constraints);
          break;
        }
        BeansEngine.commandLine.addCommand(event.text);
        break;
      }
      default: {}
    }
    _windows.first.win.onEvent(pos, event);
  }
}