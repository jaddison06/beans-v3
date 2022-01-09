import 'Renderable.dart';
import 'Display.dart';
import 'V2.dart';
import 'Colour.dart';

class ExpandBox extends Renderable {
  final Colour colour;

  ExpandBox({this.colour = Colour.red});

  @override
  V2 getSize(V2 constraints) {
    return constraints;
  }

  @override
  void render(Display display, V2 pos, V2 constraints) {
    display.FillRect(pos, constraints, colour);
  }
}