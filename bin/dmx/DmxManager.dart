import 'DmxInterface.dart';
import 'SacnInterface.dart';

class DmxManager {
  DmxInterface interface = SacnInterface('127.0.0.1');
  var _quit = false;

  Future<void> go() async {
    while (!_quit) {
      // just over 60hz
      await Future.delayed(Duration(milliseconds: 15));
    }
  }

  void quit() {
    _quit = true;
  }
}