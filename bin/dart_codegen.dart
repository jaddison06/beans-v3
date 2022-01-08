// for native types & basic FFI functionality
import 'dart:ffi';
// for string utils
import 'package:ffi/ffi.dart';
// for @mustCallSuper
import 'package:meta/meta.dart';

// ----------FILE: NATIVE\3RDPARTY\LIBE131\E131.GEN----------

// ----------FUNCTION SIGNATURE TYPEDEFS----------

// void E131_test()
typedef _libe131_func_E131_test_native_sig = Void Function();
typedef _libe131_func_E131_test_sig = void Function();

// ----------LIBE131----------

class libe131 {

    static _libe131_func_E131_test_sig? _E131_test;

    void _initRefs() {
        if (
            _E131_test == null
        ) {
            final lib = DynamicLibrary.open('build/native/3rdparty/libe131/libe131.dll');

            _E131_test = lib.lookupFunction<_libe131_func_E131_test_native_sig, _libe131_func_E131_test_sig>('E131_test');
        }
    }

    libe131() {
        _initRefs();
    }

    void E131_test() {
        return _E131_test!();
    }

}


