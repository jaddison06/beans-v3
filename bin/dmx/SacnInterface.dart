import '../dart_codegen.dart';
import 'DmxInterface.dart';

class SacnInterface implements DmxInterface {
  final _universes = <int, E131>{};
  final String dest;
  SacnInterface(this.dest);
  
  @override
  void Send(Map<int, Map<int, int>> data) {
    for (var universe in data.entries) {
      if (!_universes.containsKey(universe.key)) {
        // Create a new universe
        _universes[universe.key] = E131(
          'beans',
          dest,
          universe.key
        );
      }
      for (var address in universe.value.entries) {
        _universes[universe.key]!.SetValue(address.key, address.value);
      }
      _universes[universe.key]!.Send();
    }
  }
}