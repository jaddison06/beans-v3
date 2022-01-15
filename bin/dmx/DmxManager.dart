import 'DmxInterface.dart';
import 'SacnInterface.dart';
import 'Channel.dart';
import 'package:collection/collection.dart';
import '../core/BeansObject.dart';

import 'FixtureInfo.dart';
import 'Parameter.dart';

Channel testChannel(int addr, bool hasPan) => Channel(
  universe: 1,
  address: addr,
  fixture: FixtureInfo(
    name: 'Test Fixture',
    params: [
      hasPan ? ParamInfo(
        Parameter.pan,
        min: -360,
        max: 360,
      ) : ParamInfo(
        Parameter.level,
        min: 0,
        max: 255,
      )
    ]
  )
);

class DmxManager {
  DmxInterface interface = SacnInterface('127.0.0.1');
  final channels = <int, Channel> {
    1: testChannel(1, false),
    2: testChannel(2, false),
    3: testChannel(3, false),
    4: testChannel(4, true),
    5: testChannel(5, true)
  };

  /// you can call this from wherever you want! please don't though ❤️
  Map<int, Map<int, int>> addresses() {
    final addresses = <int, Map<int, int>>{};
      for (var channel in channels.values) {
        if (!addresses.containsKey(channel.universe)) {
          addresses[channel.universe] = <int, int>{};
        }
        channel.toDmx().forEachIndexed((i, data) {
          addresses[channel.universe]![channel.address + i] = data;
        });
      }
    return addresses;
  }

  Map<int, BeansObject> channelObjects() {
    final out = <int, BeansObject>{};
    for (var entry in channels.entries) {
      out[entry.key] = (BeansObject(
        'Channel',
        'c',
        { for (var param in entry.value.fixture.params) param.param.name: BeansObjectProperty(
          param.param.name,
          true,
          true
        ) },
        {}
      ));
    }
    return out;
  }

  void frame() {
    interface.Send(addresses());
  }
}