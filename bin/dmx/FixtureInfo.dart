import 'Parameter.dart';

class ParamInfo {
  Parameter param;
  double min;
  double max;
  double home;
  bool is16Bit;
  ParamInfo(this.param, {this.min = 0, this.max = 255, this.home = 0, this.is16Bit = false});
}

class FixtureInfo {
  final String name;
  final List<ParamInfo> params;

  ParamInfo getInfo(Parameter param) => params.firstWhere((paramInfo) => paramInfo.param == param);

  int get addressCount => params.fold(0, (count, address) => address.is16Bit ? count + 2 : count + 1);

  FixtureInfo({required this.name, required this.params});
}