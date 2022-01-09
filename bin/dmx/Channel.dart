import 'FixtureInfo.dart';
import 'Parameter.dart';

int home(Parameter parameter) {
  switch (parameter) {
    case Parameter.Intensity: return 0;
  }
}

class Channel {
  FixtureInfo fixture;
  final int universe;
  final int address;
  final Map<Parameter, int> _values;
  Channel({required this.fixture, required this.universe, required this.address}) :
    _values = { for (var param in fixture.addresses.keys) param: home(param) };
  
  void _checkParam(Parameter param) {
    if (!_values.containsKey(param)) throw Exception("Fixture of type ${fixture.name} has no parameter '${param.name}'");
  }

  List<int> toDmx() {
    final out = <int>[];

    for (var address in fixture.addresses.entries.toList()..sort((a, b) => a.value.offset - b.value.offset)) {
      final value = _values[address.key]!;
      if (address.value.is16Bit) {
        out.add(value & 0xFF00);
        out.add(value & 0xFF);
      } else {
        out.add(value);
      }
    }

    return out;
  }
  
  void setValue(Parameter param, int value) {
    _checkParam(param);
    if (value < 0) {
      throw Exception('DMX value cannot be less than 0 (got $value)');
    }
    if (fixture.addresses[param]!.is16Bit) {
      if (value > 65535) {
        throw Exception('16-bit DMX value cannot be more than 65535 (got $value)');
      }
    } else {
      if (value > 255) {
        throw Exception('8-bit DMX value cannot be more than 255 (got $value)');
      }
    }
    _values[param] = value;
  }

  int getValue(Parameter param) {
    _checkParam(param);
    return _values[param]!;
  }
}