import 'Display.dart';
import 'V2.dart';
import 'Fonts.dart';
import 'Colour.dart';

import 'Renderable.dart';
import 'Display.dart';
import 'V2.dart';

abstract class BeansWindow {
  String get title;
  /// [pos] and [size] are in px!!!
  void render(Display display, V2 pos, V2 size, int blockSize);
}