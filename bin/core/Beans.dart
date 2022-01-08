import '../dmx/DmxManager.dart';
import '../ui/BeansUI.dart';

class Beans {
  void go() {
    final dmx = DmxManager();
    final ui = BeansUI();

    // async, runs in background
    dmx.go();
    // blocks until completion
    ui.go();

    dmx.quit();
    ui.destroy();
  }
}