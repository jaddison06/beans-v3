import 'Renderable.dart';
import 'Display.dart';
import 'V2.dart';
import 'Fonts.dart';
import 'Colour.dart';

class Window {
  // in the window coordinate space !!
  V2 pos, size;
  Renderable window;

  Window({required this.pos, required this.size, required this.window});

  void render(Display display, int blockSize, V2 windowSpaceStart) {
    window.render(
      display,
      windowSpaceStart + (pos * blockSize),
      size * (pos * blockSize)
    );
  }
}

class UIBase extends Renderable {
  @override
  V2 getSize(V2 constraints) {
    return constraints;
  }

  @override
  void render(Display display, V2 pos, V2 constraints) {
    
  }
}