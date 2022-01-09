import 'V2.dart';
import 'Display.dart';

abstract class Renderable {
  V2 getSize(V2 constraints);
  void render(Display display, V2 pos, V2 constraints);
}