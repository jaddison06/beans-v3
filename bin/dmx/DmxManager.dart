import 'DmxInterface.dart';
import 'SacnInterface.dart';
import 'Channel.dart';

import 'FixtureInfo.dart';
import 'Parameter.dart';

Channel testChannel(int addr) => Channel(
  universe: 1,
  address: addr,
  fixture: FixtureInfo(
    name: 'Test Fixture',
    addresses: {
      Parameter.Intensity: AddressInfo(1)
    }
  )
);

class DmxManager {
  DmxInterface interface = SacnInterface('127.0.0.1');
  final channels = <int, Channel> {
    1: testChannel(1),
    2: testChannel(2),
    3: testChannel(3),
    4: testChannel(4),
    5: testChannel(5)
  };

  /// you can call this from wherever you want! please don't though ❤️
  Map<int, Map<int, int>> addresses() {
    final addresses = <int, Map<int, int>>{};
      for (var channel in channels.values) {
        if (!addresses.containsKey(channel.universe)) {
          addresses[channel.universe] = <int, int>{};
        }
        final dmxData = channel.toDmx();
        for (var i = 0; i < dmxData.length; i++) {
          addresses[channel.universe]![channel.address + i] = dmxData[i];
        }
      }
    return addresses;
  }

  void frame() {
    interface.Send(addresses());
  }
}