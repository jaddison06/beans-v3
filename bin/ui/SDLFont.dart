import '../dart_codegen.dart';
import 'Fonts.dart';
import 'V2.dart';

class SDLFont extends SDLFontRaw implements Font {
  SDLFont(String family, int size) : super(family, size ~/ 1.333);

  @override
  V2 TextSize(String text) => V2.fromPointers((width, height) => GetTextSize(text, width, height));
}