import 'dart:ffi';
import 'package:ffi/ffi.dart';

class V2 {
  final int x, y;
  V2(this.x, this.y);

  @override
  String toString() => 'V2 ($x, $y)';

  V2 operator +(Object other) {
    // using if instead of switch so we get automatic type promotion
    if (other is V2) {
      return V2(x + other.x, y + other.y);
    }
    else if (other is int) {
      return V2(x + other, y + other);
    }
    else {
      throw Exception("Can't add a V2 to an object of type ${other.runtimeType}.");
    }
  }
  
  V2 operator -() {
    return V2(-x, -y);
  }

  V2 operator -(dynamic other) {
    return this + -other;
  }

  V2 operator *(dynamic other) {
    if (other is int) {
      return V2(x * other, y * other);
    } else if (other is V2) {
      return V2(x * other.x, y * other.y);
    } else {
      throw Exception("Can't multiply a V2 by an object of type ${other.runtimeType}.");
    }
  }

  V2 operator /(dynamic other) => this ~/ other;

  V2 operator ~/(dynamic other) {
    if (other is int) {
      return V2(x ~/ other, y ~/ other);
    } else if (other is V2) {
      return V2(x ~/ other.x, y ~/ other.y);
    } else {
      throw Exception("Can't divide a V2 by an object of type ${other.runtimeType}.");
    }
  }

  bool containedBy(V2 pos, V2 size) {
    return
      x >= pos.x &&
      y >= pos.y &&
      x <= (pos.x + size.x) &&
      y <= (pos.y + size.y);
  }

  static V2 square(size) => V2(size, size);

  static V2 origin() => V2(0, 0);

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