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
import '../core/unreachable.dart';

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
    ),
    _WindowInfo(
      pos: V2(15, 5),
      size: V2(7, 11),
      win: TestWindow()
    )
  ];

  final _keyboardFocus = Stack<_WindowInfo>();
  _WindowInfo? _mouseDownReceiver;

  // If modifyState isn't None, _modifyWin is the window being modified,
  // and modifyCurrent is the current mouse pos.

  // Move:
  //   - modifyStart is the mouse pos at the start of the drag
  // Close:
  //   - modifyStart is null
  // Resize:
  //   todo

  /// Only set when [_modifyState] is None.
  _WindowInfo? _closeHover;

  var _modifyState = _WMModifyState.None;
  _WindowInfo? _modifyWin;
  V2? _modifyStart;
  V2? _modifyCurrent;

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

  V2 _windowAreaSize(V2 constraints) => constraints - V2(0, topAreaHeight) - V2(0, bottomAreaHeight);

  V2 _getBlockSize(V2 constraints) {
    final windowAreaSize = _windowAreaSize(constraints);
    return V2(
      minBlockSize + ((windowAreaSize.x % minBlockSize) ~/ (windowAreaSize.x / minBlockSize)),
      minBlockSize + ((windowAreaSize.y % minBlockSize) ~/ (windowAreaSize.y / minBlockSize))
    );
  }

  @override
  V2 getSize(V2 constraints) {
    return constraints;
  }

  V2 _windowPos(_WindowInfo win, V2 pos, V2 constraints) => pos + V2(0, topAreaHeight) + (win.pos * _getBlockSize(constraints));

  V2 _closePos(_WindowInfo win, V2 pos, V2 constraints) =>
    _windowPos(win, pos, constraints) +
    V2((win.size.x - 1) * _getBlockSize(constraints).x, 0);

  _WindowInfo? _titlebarAt(V2 pos, V2 constraints, V2 hit) {
    final blockSize = _getBlockSize(constraints);
    for (var win in _windows) {
      if (hit.containedBy(
        _windowPos(win, pos, constraints),
        V2(win.size.x * blockSize.x, blockSize.y)
      )) return win;
    }
  }

  _WindowInfo? _closeButtonAt(V2 pos, V2 constraints, V2 hit) {
    final win = _titlebarAt(pos, constraints, hit);
    if (win == null) return null;
    if (hit.containedBy(
      _closePos(win, pos, constraints),
      _getBlockSize(constraints)
    )) return win;
  }

  _WindowInfo? _windowAt(V2 pos, V2 constraints, V2 hit) {
    final blockSize = _getBlockSize(constraints);
    for (var win in _windows) {
      if (hit.containedBy(
        _windowPos(win, pos, constraints) + V2(0, blockSize.y),
        (win.size - V2(0, 1)) * blockSize
      )) return win;
    }
  }

  bool _isOverlap(V2 aPos, V2 aSize, V2 bPos, V2 bSize) {
    final aTopRight = aPos + V2(aSize.x, 0);
    final aBottomLeft = aPos + V2(0, aSize.y);
    final bTopRight = bPos + V2(bSize.x, 0);
    final bBottomLeft = bPos + V2(0, bSize.y);
    return !(
      aTopRight.x <= bBottomLeft.x ||
      aBottomLeft.x >= bTopRight.x ||
      aPos.y >= bBottomLeft.y ||
      aBottomLeft.y <= bTopRight.y
    );
  }

  // newPos is in px!!!!!
  bool _hasOverlap(V2 pos, V2 constraints, V2 newPos, _WindowInfo window) {
    for (var win in _windows) {
      if (win == window) continue;
      if (_isOverlap(
        newPos,
        window.size * _getBlockSize(constraints),
        _windowPos(win, pos, constraints),
        win.size * _getBlockSize(constraints)
      )) return true;
    }
    return false;
  }

  @override
  void render(Display display, V2 pos, V2 constraints) {
    final windowAreaPos = pos + V2(0, topAreaHeight);
    final windowAreaSize = _windowAreaSize(constraints);

    // ---------- WINDOWS ----------

    // Use clip so we don't accidentally draw plusses over the edges
    display.SetClip(windowAreaPos, windowAreaSize);

    // todo: blockSize is still slightly suspect, could just be float precision wank. TEST!
    final blockSize = _getBlockSize(constraints);

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
      display.DrawText(Fonts.default_, window.win.title, winPos + V2(10, 0), Colour.pink);

      final closePos = _closePos(window, pos, constraints);
      final closeCenter = closePos + (_getBlockSize(constraints) / 2);
      final halfLength = 3;

      Colour closeCol;

      if (_closeHover == window || (
        _modifyState == _WMModifyState.Close &&
        _modifyWin == window &&
        _closeButtonAt(pos, constraints, _modifyCurrent!) == window
      )) {
        display.FillRect(closePos, _getBlockSize(constraints), Colour.pink);
        closeCol = Colour.black;
      } else {
        display.DrawRect(closePos, _getBlockSize(constraints), Colour.pink);
        closeCol = Colour.pink;
      }
      
      display.DrawLine(closeCenter - V2.square(halfLength), closeCenter + V2.square(halfLength), closeCol);
      display.DrawLine(closeCenter + V2(halfLength, -halfLength), closeCenter + V2(-halfLength, halfLength), closeCol);

      display.DrawLine(contentPos, contentPos + V2(winSize.x, 0), Colour.pink);
      
      // todo: fucking strange SetClip behaviour
      //display.SetClip(contentPos, contentSize);
      window.win.render(display, contentPos, contentSize, blockSize);
      //display.ResetClip();
    }

    if (_modifyState == _WMModifyState.Move) {
      var group = _titlebarAt(pos, constraints, _modifyCurrent!);
      group ??= _windowAt(pos, constraints, _modifyCurrent!);
      if (group == _modifyWin) group = null;
      V2 newPos;
      V2 newSize;
      var isAllowed = true;
      if (group != null) {
        newPos = _windowPos(group, pos, constraints);
        newSize = group.size * _getBlockSize(constraints);
      } else {
        newPos = _windowPos(_modifyWin!, pos, constraints) + (((_modifyCurrent! - _modifyStart!) ~/ (_getBlockSize(constraints))) * _getBlockSize(constraints));
        newSize = _modifyWin!.size * _getBlockSize(constraints);
        isAllowed = !_hasOverlap(pos, constraints, newPos, _modifyWin!);
      }
      display.DrawRect(
        newPos,
        newSize,
        isAllowed ? Colour.white : Colour.red
      );
    }

    final topAreaSize = V2(constraints.x, topAreaHeight);

    final bottomAreaPos = V2(pos.x, pos.y + topAreaHeight + windowAreaSize.y);
    final bottomAreaSize = V2(constraints.x, bottomAreaHeight);

    // ---------- TOP ----------
    display.DrawLine(pos + V2(0, topAreaHeight), pos + V2(constraints.x, topAreaHeight), Colour.pink);
    display.DrawText(Fonts.default_, DateFormat('HH:mm:ss').format(DateTime.now()), pos + V2(40, 0), Colour.pink);

    // ---------- BOTTOM ----------
    final font = Fonts.default_;
    final commandLine = BeansEngine.commandLine.toString();
    final error = BeansEngine.commandLine.error;
    final commandLinePos = bottomAreaPos + V2(10, 10);
    display.DrawText(font, commandLine, commandLinePos, Colour.pink);
    if (error != null) {
      display.DrawText(font, error, commandLinePos + V2(font.TextSize(commandLine).x + 15, 0), Colour.red);
    }
  }

  void _executeModify(V2 pos, V2 constraints) {
    switch (_modifyState) {
      case _WMModifyState.Move: {
        var group = _titlebarAt(pos, constraints, _modifyCurrent!);
        group ??= _windowAt(pos, constraints, _modifyCurrent!);
        if (group == _modifyWin) group = null;
        V2 newPos;
        V2 newSize;
        var isAllowed = true;
        if (group != null) {
          newPos = _windowPos(group, pos, constraints);
          newSize = group.size * _getBlockSize(constraints);
        } else {
          newPos = _windowPos(_modifyWin!, pos, constraints) + (((_modifyCurrent! - _modifyStart!) ~/ (_getBlockSize(constraints))) * _getBlockSize(constraints));
          newSize = _modifyWin!.size * _getBlockSize(constraints);
          isAllowed = !_hasOverlap(pos, constraints, newPos, _modifyWin!);
        }
        if (isAllowed) {
          if (group != null) {
            // todo: create group
          } else {
            _modifyWin!.pos = newPos / _getBlockSize(constraints);
            _modifyWin!.size = newSize / _getBlockSize(constraints);
          }
        }
        break;
      }
      case _WMModifyState.Close: {
        if (_closeButtonAt(pos, constraints, _modifyCurrent!) == _modifyWin) {
          _windows.remove(_modifyWin);
        }
        break;
      }
      case _WMModifyState.Resize: {
        break;
      }

      default: {}
    }
  }

  void _winOnEvent(_WindowInfo win, Event event, V2 pos, V2 constraints) {
    win.win.onEvent(_windowPos(win, pos, constraints) + V2(0, _getBlockSize(constraints).y), event);
  }

  // WM modify logic:
  //   MouseDown:
  //     - Set state
  //     - Set window
  //     - Maybe set start mouse pos
  //     - Set current mouse pos
  //   MouseMove:
  //     - Set current mouse pos
  //   MouseUp:
  //     - Set current mouse pos (just to be sure)
  //     - Execute
  //     - Reset everything
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
      case EventType.MouseDown: {
        final win = _windowAt(pos, constraints, event.pos);
        if (win != null) {
          _winOnEvent(win, event, pos, constraints);
          _mouseDownReceiver = win;
          break;
        }
        final tb = _titlebarAt(pos, constraints, event.pos);
        if (tb != null) {
          final close = _closeButtonAt(pos, constraints, event.pos);
          if (close != null) {
            _modifyState = _WMModifyState.Close;
            _modifyWin = close;
            _modifyCurrent = event.pos;
          } else {
            _modifyState = _WMModifyState.Move;
            _modifyWin = tb;
            _modifyStart = _modifyCurrent = event.pos;
          }
        } else {
          // clicked empty space - add window or smth
        }
        break;
      }
      case EventType.MouseMove: {
        _closeHover = null;
        if (_modifyState != _WMModifyState.None) {
          _modifyCurrent = event.pos;
        } else {
          if (_mouseDownReceiver != null) {
            _winOnEvent(_mouseDownReceiver!, event, pos, constraints);
            break;
          }
          var win = _windowAt(pos, constraints, event.pos);
          if (win != null) {
            _winOnEvent(win, event, pos, constraints);
            break;
          }
          win = _closeButtonAt(pos, constraints, event.pos);
          if (win != null) {
            _closeHover = win;
          }
        }
        break;
      }
      case EventType.MouseUp: {
        if (_modifyState != _WMModifyState.None) {
          _modifyCurrent = event.pos;
          _executeModify(pos, constraints);
          _modifyState = _WMModifyState.None;
          _modifyWin = _modifyStart = _modifyCurrent = null;
        } else if (_mouseDownReceiver != null) {
          _winOnEvent(_mouseDownReceiver!, event, pos, constraints);
          _mouseDownReceiver = null;
        }
        break;
      }
      default: {}
    }
  }
}