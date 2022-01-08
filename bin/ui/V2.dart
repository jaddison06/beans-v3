import 'dart:ffi';
import 'package:ffi/ffi.dart';

class V2 {
  final int x, y;
  V2(this.x, this.y);

  static Pointer<Int32> _xPtr = nullptr, _yPtr = nullptr;

  static V2 fromPointers(void Function(Pointer<Int32>, Pointer<Int32>) populate) {
    if (_xPtr == nullptr) _xPtr = malloc<Int32>();
    if (_yPtr == nullptr) _yPtr = malloc<Int32>();

    populate(_xPtr, _yPtr);
    return V2(_xPtr.value, _yPtr.value);
  }

  static void destroy() {
    if (_xPtr != nullptr) malloc.free(_xPtr);
    if (_yPtr != nullptr) malloc.free(_yPtr);
  }
}