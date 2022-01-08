// for native types & basic FFI functionality
import 'dart:ffi';
// for string utils
import 'package:ffi/ffi.dart';
// for @mustCallSuper
import 'package:meta/meta.dart';

// ----------FILE: NATIVE\3RDPARTY\LIBE131\E131.GEN----------

// ----------FUNCTION SIGNATURE TYPEDEFS----------

// int e131_test()
typedef _libe131_func_e131_test_native_sig = Int32 Function();
typedef _libe131_func_e131_test_sig = int Function();

// ----------LIBE131----------

class libe131 {

    static _libe131_func_e131_test_sig? _e131_test;

    void _initRefs() {
        if (
            _e131_test == null
        ) {
            final lib = DynamicLibrary.open('build/native/3rdparty/libe131/libe131.dll');

            _e131_test = lib.lookupFunction<_libe131_func_e131_test_native_sig, _libe131_func_e131_test_sig>('e131_test');
        }
    }

    libe131() {
        _initRefs();
    }

    int test() {
        return _e131_test!();
    }

}


// ----------ENUMS----------

enum BeansE131ErrorCode {
    success,
    socket,
    source_name,
    unicast_dest,
}

BeansE131ErrorCode BeansE131ErrorCodeFromInt(int val) => BeansE131ErrorCode.values[val];
int BeansE131ErrorCodeToInt(BeansE131ErrorCode val) => BeansE131ErrorCode.values.indexOf(val);

String BeansE131ErrorCodeToString(BeansE131ErrorCode val) {
    switch (val) {
        case BeansE131ErrorCode.success: { return 'success'; }
        case BeansE131ErrorCode.socket: { return 'e131_socket() failed'; }
        case BeansE131ErrorCode.source_name: { return 'Source name was too long'; }
        case BeansE131ErrorCode.unicast_dest: { return 'e131_unicast_dest() failed'; }
    }
}

// ----------FUNC SIG TYPEDEFS FOR CLASSES----------

// ----------BEANSE131----------

// void* BeansE131Init(char* source_name, char* dest, u16 universe)
typedef _libe131_class_BeansE131_method_BeansE131Init_native_sig = Pointer<Void> Function(Pointer<Utf8>, Pointer<Utf8>, Uint16);
typedef _libe131_class_BeansE131_method_BeansE131Init_sig = Pointer<Void> Function(Pointer<Utf8>, Pointer<Utf8>, int);

// BeansE131ErrorCode BeansE131GetError(void* struct_ptr)
typedef _libe131_class_BeansE131_method_BeansE131GetError_native_sig = Int32 Function(Pointer<Void>);
typedef _libe131_class_BeansE131_method_BeansE131GetError_sig = int Function(Pointer<Void>);

// void BeansE131Print(void* struct_ptr)
typedef _libe131_class_BeansE131_method_BeansE131Print_native_sig = Void Function(Pointer<Void>);
typedef _libe131_class_BeansE131_method_BeansE131Print_sig = void Function(Pointer<Void>);

// void BeansE131SetValue(void* struct_ptr, u16 channel, u8 value)
typedef _libe131_class_BeansE131_method_BeansE131SetValue_native_sig = Void Function(Pointer<Void>, Uint16, Uint8);
typedef _libe131_class_BeansE131_method_BeansE131SetValue_sig = void Function(Pointer<Void>, int, int);

// bool BeansE131Send(void* struct_ptr)
typedef _libe131_class_BeansE131_method_BeansE131Send_native_sig = Uint8 Function(Pointer<Void>);
typedef _libe131_class_BeansE131_method_BeansE131Send_sig = int Function(Pointer<Void>);

// ----------CLASS IMPLEMENTATIONS----------

class BeansE131 {
    Pointer<Void> structPointer = nullptr;

    void _validatePointer(String methodName) {
        if (structPointer.address == 0) {
            throw Exception('BeansE131.$methodName was called, but structPointer is a nullptr.');
        }
    }

    static _libe131_class_BeansE131_method_BeansE131Init_sig? _BeansE131Init;
    static _libe131_class_BeansE131_method_BeansE131GetError_sig? _BeansE131GetError;
    static _libe131_class_BeansE131_method_BeansE131Print_sig? _BeansE131Print;
    static _libe131_class_BeansE131_method_BeansE131SetValue_sig? _BeansE131SetValue;
    static _libe131_class_BeansE131_method_BeansE131Send_sig? _BeansE131Send;

    void _initRefs() {
        if (
            _BeansE131Init == null ||
            _BeansE131GetError == null ||
            _BeansE131Print == null ||
            _BeansE131SetValue == null ||
            _BeansE131Send == null
        ) {
            final lib = DynamicLibrary.open('build/native/3rdparty/libe131/libe131.dll');

            _BeansE131Init = lib.lookupFunction<_libe131_class_BeansE131_method_BeansE131Init_native_sig, _libe131_class_BeansE131_method_BeansE131Init_sig>('BeansE131Init');
            _BeansE131GetError = lib.lookupFunction<_libe131_class_BeansE131_method_BeansE131GetError_native_sig, _libe131_class_BeansE131_method_BeansE131GetError_sig>('BeansE131GetError');
            _BeansE131Print = lib.lookupFunction<_libe131_class_BeansE131_method_BeansE131Print_native_sig, _libe131_class_BeansE131_method_BeansE131Print_sig>('BeansE131Print');
            _BeansE131SetValue = lib.lookupFunction<_libe131_class_BeansE131_method_BeansE131SetValue_native_sig, _libe131_class_BeansE131_method_BeansE131SetValue_sig>('BeansE131SetValue');
            _BeansE131Send = lib.lookupFunction<_libe131_class_BeansE131_method_BeansE131Send_native_sig, _libe131_class_BeansE131_method_BeansE131Send_sig>('BeansE131Send');
        }
    }

    BeansE131(String source_name, String dest, int universe) {
        _initRefs();
        structPointer = _BeansE131Init!(source_name.toNativeUtf8(), dest.toNativeUtf8(), universe);
    }

    BeansE131.fromPointer(Pointer<Void> ptr) {
        _initRefs();
        structPointer = ptr;
    }

    BeansE131ErrorCode get error {
        _validatePointer('error');
        return BeansE131ErrorCodeFromInt(_BeansE131GetError!(structPointer));
    }

    void Print() {
        _validatePointer('Print');
        return _BeansE131Print!(structPointer);
    }

    void SetValue(int channel, int value) {
        _validatePointer('SetValue');
        return _BeansE131SetValue!(structPointer, channel, value);
    }

    bool Send() {
        _validatePointer('Send');
        return (_BeansE131Send!(structPointer)) == 1;
    }

}

