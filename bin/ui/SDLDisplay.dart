import '../dart_codegen.dart';
import 'Display.dart';
import 'V2.dart';
import 'Colour.dart';
import 'SDLFont.dart';

class SDLDisplay extends SDLDisplayRaw implements Display {
  @override
  V2 get size => V2.fromPointers(GetSize);

  SDLDisplay(String title, {bool fullscreen = true}) : super(title, fullscreen);

  @override
  void SetClip(V2 pos, V2 size) {
    cSetClip(pos.x, pos.y, size.x, size.y);
  }

  @override
  void DrawPoint(V2 pos, Colour col) {
    cDrawPoint(pos.x, pos.y, col.r, col.g, col.b, col.a);
  }

  @override
  void DrawLine(V2 a, V2 b, Colour col) {
    cDrawLine(a.x, a.y, b.x, b.y, col.r, col.g, col.b, col.a);
  }

  @override
  void DrawRect(V2 pos, V2 size, Colour col) {
    cDrawRect(pos.x, pos.y, size.x, size.y, col.r, col.g, col.b, col.a);
  }

  @override
  void FillRect(V2 pos, V2 size, Colour col) {
    cFillRect(pos.x, pos.y, size.x, size.y, col.r, col.g, col.b, col.a);
  }

  @override
  void DrawText(covariant SDLFont font, String text, V2 pos, Colour col) {
    // SDL doesn't like drawing empty strings :(
    if (text == '') return;
    cDrawText(font, text, pos.x, pos.y, col.r, col.g, col.b, col.a);
  }
}