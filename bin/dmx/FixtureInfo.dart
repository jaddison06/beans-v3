import 'Parameter.dart';

class AddressInfo {
  int offset;
  bool is16Bit;
  AddressInfo({required this.offset, this.is16Bit = false});
}

class FixtureInfo {
  final String name;
  final Map<Parameter, AddressInfo> addresses;

  int get addressCount => addresses.values.fold(0, (count, address) => address.is16Bit ? count + 2 : count + 1);

  FixtureInfo({required this.name, required this.addresses});
}