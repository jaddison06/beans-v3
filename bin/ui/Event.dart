import '../dart_codegen.dart';
import 'V2.dart';

abstract class Event {
  EventType get type;
  V2 get pos;
  KeyCode get key;
  MouseButton get mouseButton;

  int Poll();
  void Destroy();
}