import 'DmxInterface.dart';
import 'SacnInterface.dart';

class DmxManager {
  DmxInterface interface = SacnInterface('127.0.0.1');
  var _quit = false;

  Future<void> go() async {
    while (!_quit) {
      
    }
  }

  void quit() {
    _quit = true;
  }
}