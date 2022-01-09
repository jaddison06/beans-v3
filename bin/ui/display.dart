import 'V2.dart';
import 'Colour.dart';
import 'Fonts.dart';

abstract class Display {
  V2 get size;

  void Destroy();
  void Flush();

  void SetClip(V2 pos, V2 size);
  void ResetClip();

  void DrawPoint(V2 pos, Colour col);
  void DrawLine(V2 a, V2 b, Colour col);
  void DrawRect(V2 pos, V2 size, Colour col);
  void FillRect(V2 pos, V2 size, Colour col);

  void DrawText(Font font, String text, V2 pos, Colour col);
}