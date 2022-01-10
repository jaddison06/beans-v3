import 'FixtureInfo.dart';
import 'Parameter.dart';

int home(ParamInfo param) {
  return param.min;
}

class Channel {
  FixtureInfo fixture;
  final int universe;
  final int address;
  final Map<Parameter, int> _values;
  Channel({required this.fixture, required this.universe, required this.address}) :
    _values = { for (var param in fixture.params) param.param: home(param) };
  
  void _checkParam(Parameter param) {
    if (!_values.containsKey(param)) throw Exception("Fixture of type ${fixture.name} has no parameter '${param.name}'");
  }

  List<int> toDmx() {
    final out = <int>[];

    for (var param in fixture.params) {
      final value = _values[param.param]!;
      final dmxValue = ((value - param.min) * (param.is16Bit ? 65535 : 255)) ~/ (param.max - param.min);
      if (param.is16Bit) {
        out.add(dmxValue & 0xFF00);
        out.add(dmxValue & 0xFF);
      } else {
        out.add(dmxValue);
      }
    }

    return out;
  }
  
  void setValue(Parameter param, int value) {
    _checkParam(param);
    final info = fixture.getInfo(param);
    if (value < info.min) {
      throw Exception("Fixture '${fixture.name}' cannot have a ${param.name} less than ${info.min} (got $value)");
    } else if (value > info.max) {
      throw Exception("Fixture '${fixture.name}' cannot have a ${param.name} more than ${info.max} (got $value)");
    }
    _values[param] = value;
  }

  int getValue(Parameter param) {
    _checkParam(param);
    return _values[param]!;
  }
}