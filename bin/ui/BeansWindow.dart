import 'Display.dart';
import 'V2.dart';
import 'Event.dart';

abstract class BeansWindow {
  String get title;
  /// [pos] and [size] are in px!!!
  void render(Display display, V2 pos, V2 size, V2 blockSize);
  void onEvent(V2 pos, Event event) {}
}