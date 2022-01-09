import 'DmxInterface.dart';
import 'SacnInterface.dart';
import 'Channel.dart';

import 'FixtureInfo.dart';
import 'Parameter.dart';

final testChannel = Channel(
  fixture: FixtureInfo(
    name: 'Test Fixture',
    addresses: {
      Parameter.Intensity: AddressInfo(1)
    }
  )
);

class DmxManager {
  DmxInterface interface = SacnInterface('127.0.0.1');
  final channels = <int, Map<int, Channel>>{
    1: {
      1: testChannel
    }
  };

  Map<int, Map<int, int>> addresses() {
    final addresses = <int, Map<int, int>>{};
      for (var uni in channels.entries) {
        addresses[uni.key] = <int, int>{};
        for (var channel in uni.value.entries) {
          final dmxData = channel.value.toDmx();
          for (var i = 0; i < dmxData.length; i++) {
            addresses[uni.key]![channel.key + i] = dmxData[i];
          }
        }
      }
    return addresses;
  }

  void frame() {
    final data = addresses();
    print('Sending $data');
    interface.Send(data);
  }
}