import 'Display.dart';
import 'V2.dart';

abstract class BeansWindow {
  /// Size in wm blocks **NOT** pixels
  V2 get size;
  /// Pos in wm blocks **NOT** pixels
  V2 get pos;
  String get title;

  void render(Display display, int blockSize) {
    
  }
}