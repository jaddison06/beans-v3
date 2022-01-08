import '../dart_codegen.dart';
import 'Event.dart';
import 'V2.dart';

class SDLEvent extends SDLEventRaw implements Event {
  V2 get pos => V2.fromPointers(GetPos);
}