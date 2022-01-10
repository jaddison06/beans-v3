// for native types & basic FFI functionality
import 'dart:ffi';
// for string utils
import 'package:ffi/ffi.dart';
// for @mustCallSuper
import 'package:meta/meta.dart';

// ----------FILE: NATIVE\3RDPARTY\LIBE131\E131.GEN----------

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

// ----------E131----------

// void* BeansE131Init(char* source_name, char* dest, u16 universe)
typedef _libe131_class_E131_method_BeansE131Init_native_sig = Pointer<Void> Function(Pointer<Utf8>, Pointer<Utf8>, Uint16);
typedef _libe131_class_E131_method_BeansE131Init_sig = Pointer<Void> Function(Pointer<Utf8>, Pointer<Utf8>, int);

// BeansE131ErrorCode BeansE131GetError(void* struct_ptr)
typedef _libe131_class_E131_method_BeansE131GetError_native_sig = Int32 Function(Pointer<Void>);
typedef _libe131_class_E131_method_BeansE131GetError_sig = int Function(Pointer<Void>);

// void BeansE131Print(void* struct_ptr)
typedef _libe131_class_E131_method_BeansE131Print_native_sig = Void Function(Pointer<Void>);
typedef _libe131_class_E131_method_BeansE131Print_sig = void Function(Pointer<Void>);

// void BeansE131SetValue(void* struct_ptr, u16 channel, u8 value)
typedef _libe131_class_E131_method_BeansE131SetValue_native_sig = Void Function(Pointer<Void>, Uint16, Uint8);
typedef _libe131_class_E131_method_BeansE131SetValue_sig = void Function(Pointer<Void>, int, int);

// bool BeansE131Send(void* struct_ptr)
typedef _libe131_class_E131_method_BeansE131Send_native_sig = Uint8 Function(Pointer<Void>);
typedef _libe131_class_E131_method_BeansE131Send_sig = int Function(Pointer<Void>);

// ----------CLASS IMPLEMENTATIONS----------

class E131 {
    Pointer<Void> structPointer = nullptr;

    void _validatePointer(String methodName) {
        if (structPointer.address == 0) {
            throw Exception('E131.$methodName was called, but structPointer is a nullptr.');
        }
    }

    static _libe131_class_E131_method_BeansE131Init_sig? _BeansE131Init;
    static _libe131_class_E131_method_BeansE131GetError_sig? _BeansE131GetError;
    static _libe131_class_E131_method_BeansE131Print_sig? _BeansE131Print;
    static _libe131_class_E131_method_BeansE131SetValue_sig? _BeansE131SetValue;
    static _libe131_class_E131_method_BeansE131Send_sig? _BeansE131Send;

    void _initRefs() {
        if (
            _BeansE131Init == null ||
            _BeansE131GetError == null ||
            _BeansE131Print == null ||
            _BeansE131SetValue == null ||
            _BeansE131Send == null
        ) {
            final lib = DynamicLibrary.open('build/native/3rdparty/libe131/libe131.dll');

            _BeansE131Init = lib.lookupFunction<_libe131_class_E131_method_BeansE131Init_native_sig, _libe131_class_E131_method_BeansE131Init_sig>('BeansE131Init');
            _BeansE131GetError = lib.lookupFunction<_libe131_class_E131_method_BeansE131GetError_native_sig, _libe131_class_E131_method_BeansE131GetError_sig>('BeansE131GetError');
            _BeansE131Print = lib.lookupFunction<_libe131_class_E131_method_BeansE131Print_native_sig, _libe131_class_E131_method_BeansE131Print_sig>('BeansE131Print');
            _BeansE131SetValue = lib.lookupFunction<_libe131_class_E131_method_BeansE131SetValue_native_sig, _libe131_class_E131_method_BeansE131SetValue_sig>('BeansE131SetValue');
            _BeansE131Send = lib.lookupFunction<_libe131_class_E131_method_BeansE131Send_native_sig, _libe131_class_E131_method_BeansE131Send_sig>('BeansE131Send');
        }
    }

    E131(String source_name, String dest, int universe) {
        _initRefs();
        structPointer = _BeansE131Init!(source_name.toNativeUtf8(), dest.toNativeUtf8(), universe);
    }

    E131.fromPointer(Pointer<Void> ptr) {
        _initRefs();
        structPointer = ptr;
    }

    BeansE131ErrorCode get error {
        _validatePointer('error');
        return BeansE131ErrorCodeFromInt(_BeansE131GetError!(structPointer));
    }

    void Print() {
        _validatePointer('BeansE131Print');
        return _BeansE131Print!(structPointer);
    }

    void SetValue(int channel, int value) {
        _validatePointer('BeansE131SetValue');
        return _BeansE131SetValue!(structPointer, channel, value);
    }

    bool Send() {
        _validatePointer('BeansE131Send');
        return (_BeansE131Send!(structPointer)) == 1;
    }

}

// ----------FILE: NATIVE\UI\EVENTS.GEN----------

// ----------ENUMS----------

enum EventType {
    None,
    Quit,
    Key,
    Text,
    MouseMove,
    MouseDown,
    MouseUp,
    MouseScroll,
}

EventType EventTypeFromInt(int val) => EventType.values[val];
int EventTypeToInt(EventType val) => EventType.values.indexOf(val);

String EventTypeToString(EventType val) {
    switch (val) {
        case EventType.None: { return 'None'; }
        case EventType.Quit: { return 'Quit'; }
        case EventType.Key: { return 'Key'; }
        case EventType.Text: { return 'Text'; }
        case EventType.MouseMove: { return 'MouseMove'; }
        case EventType.MouseDown: { return 'MouseDown'; }
        case EventType.MouseUp: { return 'MouseUp'; }
        case EventType.MouseScroll: { return 'MouseScroll'; }
    }
}

enum MouseButton {
    Left,
    Right,
    Middle,
    Unknown,
}

MouseButton MouseButtonFromInt(int val) => MouseButton.values[val];
int MouseButtonToInt(MouseButton val) => MouseButton.values.indexOf(val);

String MouseButtonToString(MouseButton val) {
    switch (val) {
        case MouseButton.Left: { return 'Left'; }
        case MouseButton.Right: { return 'Right'; }
        case MouseButton.Middle: { return 'Middle'; }
        case MouseButton.Unknown: { return 'Unknown'; }
    }
}

enum Modifier {
    Shift,
    Control,
    Alt,
    Caps,
}

Modifier ModifierFromInt(int val) => Modifier.values[val];
int ModifierToInt(Modifier val) => Modifier.values.indexOf(val);

String ModifierToString(Modifier val) {
    switch (val) {
        case Modifier.Shift: { return 'Shift'; }
        case Modifier.Control: { return 'Control'; }
        case Modifier.Alt: { return 'Alt'; }
        case Modifier.Caps: { return 'Caps'; }
    }
}

enum Key {
    Return,
    Escape,
    Backspace,
    Delete,
    Tab,
    Insert,
    Home,
    End,
    PageUp,
    PageDown,
    ArrowRight,
    ArrowLeft,
    ArrowDown,
    ArrowUp,
    LControl,
    RControl,
    LShift,
    RShift,
    LAlt,
    RAlt,
    Unknown,
}

Key KeyFromInt(int val) => Key.values[val];
int KeyToInt(Key val) => Key.values.indexOf(val);

String KeyToString(Key val) {
    switch (val) {
        case Key.Return: { return 'Return'; }
        case Key.Escape: { return 'Escape'; }
        case Key.Backspace: { return 'Backspace'; }
        case Key.Delete: { return 'Delete'; }
        case Key.Tab: { return 'Tab'; }
        case Key.Insert: { return 'Insert'; }
        case Key.Home: { return 'Home'; }
        case Key.End: { return 'End'; }
        case Key.PageUp: { return 'PageUp'; }
        case Key.PageDown: { return 'PageDown'; }
        case Key.ArrowRight: { return 'ArrowRight'; }
        case Key.ArrowLeft: { return 'ArrowLeft'; }
        case Key.ArrowDown: { return 'ArrowDown'; }
        case Key.ArrowUp: { return 'ArrowUp'; }
        case Key.LControl: { return 'LControl'; }
        case Key.RControl: { return 'RControl'; }
        case Key.LShift: { return 'LShift'; }
        case Key.RShift: { return 'RShift'; }
        case Key.LAlt: { return 'LAlt'; }
        case Key.RAlt: { return 'RAlt'; }
        case Key.Unknown: { return 'Unknown'; }
    }
}

// ----------FILE: NATIVE\UI\SDL\SDLDISPLAY.GEN----------

// ----------ENUMS----------

enum SDLInitErrorCode {
    Success,
    InitVideo_Fail,
    CreateWindow_Fail,
    CreateRenderer_Fail,
}

SDLInitErrorCode SDLInitErrorCodeFromInt(int val) => SDLInitErrorCode.values[val];
int SDLInitErrorCodeToInt(SDLInitErrorCode val) => SDLInitErrorCode.values.indexOf(val);

String SDLInitErrorCodeToString(SDLInitErrorCode val) {
    switch (val) {
        case SDLInitErrorCode.Success: { return 'Success'; }
        case SDLInitErrorCode.InitVideo_Fail: { return 'SDL_InitVideo() failed'; }
        case SDLInitErrorCode.CreateWindow_Fail: { return 'SDL_CreateWindow() failed'; }
        case SDLInitErrorCode.CreateRenderer_Fail: { return 'SDL_CreateRenderer() failed'; }
    }
}

// ----------FUNC SIG TYPEDEFS FOR CLASSES----------

// ----------SDLDISPLAYRAW----------

// void* SDInit(char* title, bool fullscreen)
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDInit_native_sig = Pointer<Void> Function(Pointer<Utf8>, Uint8);
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDInit_sig = Pointer<Void> Function(Pointer<Utf8>, int);

// SDLInitErrorCode SDGetErrorCode(void* struct_ptr)
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDGetErrorCode_native_sig = Int32 Function(Pointer<Void>);
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDGetErrorCode_sig = int Function(Pointer<Void>);

// void SDDestroy(void* struct_ptr)
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDDestroy_native_sig = Void Function(Pointer<Void>);
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDDestroy_sig = void Function(Pointer<Void>);

// void SDGetSize(void* struct_ptr, int* width, int* height)
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDGetSize_native_sig = Void Function(Pointer<Void>, Pointer<Int32>, Pointer<Int32>);
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDGetSize_sig = void Function(Pointer<Void>, Pointer<Int32>, Pointer<Int32>);

// void SDFlush(void* struct_ptr)
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDFlush_native_sig = Void Function(Pointer<Void>);
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDFlush_sig = void Function(Pointer<Void>);

// void SDSetClip(void* struct_ptr, int x, int y, int w, int h)
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDSetClip_native_sig = Void Function(Pointer<Void>, Int32, Int32, Int32, Int32);
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDSetClip_sig = void Function(Pointer<Void>, int, int, int, int);

// void SDResetClip(void* struct_ptr)
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDResetClip_native_sig = Void Function(Pointer<Void>);
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDResetClip_sig = void Function(Pointer<Void>);

// void SDDrawPoint(void* struct_ptr, int x, int y, int r, int g, int b, int a)
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawPoint_native_sig = Void Function(Pointer<Void>, Int32, Int32, Int32, Int32, Int32, Int32);
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawPoint_sig = void Function(Pointer<Void>, int, int, int, int, int, int);

// void SDDrawLine(void* struct_ptr, int x1, int y1, int x2, int y2, int r, int g, int b, int a)
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawLine_native_sig = Void Function(Pointer<Void>, Int32, Int32, Int32, Int32, Int32, Int32, Int32, Int32);
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawLine_sig = void Function(Pointer<Void>, int, int, int, int, int, int, int, int);

// void SDDrawRect(void* struct_ptr, int x, int y, int w, int h, int r, int g, int b, int a)
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawRect_native_sig = Void Function(Pointer<Void>, Int32, Int32, Int32, Int32, Int32, Int32, Int32, Int32);
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawRect_sig = void Function(Pointer<Void>, int, int, int, int, int, int, int, int);

// void SDFillRect(void* struct_ptr, int x, int y, int w, int h, int r, int g, int b, int a)
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDFillRect_native_sig = Void Function(Pointer<Void>, Int32, Int32, Int32, Int32, Int32, Int32, Int32, Int32);
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDFillRect_sig = void Function(Pointer<Void>, int, int, int, int, int, int, int, int);

// void SDDrawText(void* struct_ptr, SDLFontRaw* font, char* text, int x, int y, int r, int g, int b, int a)
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawText_native_sig = Void Function(Pointer<Void>, Pointer<Void>, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32, Int32);
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawText_sig = void Function(Pointer<Void>, Pointer<Void>, Pointer<Utf8>, int, int, int, int, int, int);

// ----------CLASS IMPLEMENTATIONS----------

class SDLDisplayRaw {
    Pointer<Void> structPointer = nullptr;

    void _validatePointer(String methodName) {
        if (structPointer.address == 0) {
            throw Exception('SDLDisplayRaw.$methodName was called, but structPointer is a nullptr.');
        }
    }

    static _libSDLDisplay_class_SDLDisplayRaw_method_SDInit_sig? _SDInit;
    static _libSDLDisplay_class_SDLDisplayRaw_method_SDGetErrorCode_sig? _SDGetErrorCode;
    static _libSDLDisplay_class_SDLDisplayRaw_method_SDDestroy_sig? _SDDestroy;
    static _libSDLDisplay_class_SDLDisplayRaw_method_SDGetSize_sig? _SDGetSize;
    static _libSDLDisplay_class_SDLDisplayRaw_method_SDFlush_sig? _SDFlush;
    static _libSDLDisplay_class_SDLDisplayRaw_method_SDSetClip_sig? _SDSetClip;
    static _libSDLDisplay_class_SDLDisplayRaw_method_SDResetClip_sig? _SDResetClip;
    static _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawPoint_sig? _SDDrawPoint;
    static _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawLine_sig? _SDDrawLine;
    static _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawRect_sig? _SDDrawRect;
    static _libSDLDisplay_class_SDLDisplayRaw_method_SDFillRect_sig? _SDFillRect;
    static _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawText_sig? _SDDrawText;

    void _initRefs() {
        if (
            _SDInit == null ||
            _SDGetErrorCode == null ||
            _SDDestroy == null ||
            _SDGetSize == null ||
            _SDFlush == null ||
            _SDSetClip == null ||
            _SDResetClip == null ||
            _SDDrawPoint == null ||
            _SDDrawLine == null ||
            _SDDrawRect == null ||
            _SDFillRect == null ||
            _SDDrawText == null
        ) {
            final lib = DynamicLibrary.open('build/native/ui/SDL/libSDLDisplay.dll');

            _SDInit = lib.lookupFunction<_libSDLDisplay_class_SDLDisplayRaw_method_SDInit_native_sig, _libSDLDisplay_class_SDLDisplayRaw_method_SDInit_sig>('SDInit');
            _SDGetErrorCode = lib.lookupFunction<_libSDLDisplay_class_SDLDisplayRaw_method_SDGetErrorCode_native_sig, _libSDLDisplay_class_SDLDisplayRaw_method_SDGetErrorCode_sig>('SDGetErrorCode');
            _SDDestroy = lib.lookupFunction<_libSDLDisplay_class_SDLDisplayRaw_method_SDDestroy_native_sig, _libSDLDisplay_class_SDLDisplayRaw_method_SDDestroy_sig>('SDDestroy');
            _SDGetSize = lib.lookupFunction<_libSDLDisplay_class_SDLDisplayRaw_method_SDGetSize_native_sig, _libSDLDisplay_class_SDLDisplayRaw_method_SDGetSize_sig>('SDGetSize');
            _SDFlush = lib.lookupFunction<_libSDLDisplay_class_SDLDisplayRaw_method_SDFlush_native_sig, _libSDLDisplay_class_SDLDisplayRaw_method_SDFlush_sig>('SDFlush');
            _SDSetClip = lib.lookupFunction<_libSDLDisplay_class_SDLDisplayRaw_method_SDSetClip_native_sig, _libSDLDisplay_class_SDLDisplayRaw_method_SDSetClip_sig>('SDSetClip');
            _SDResetClip = lib.lookupFunction<_libSDLDisplay_class_SDLDisplayRaw_method_SDResetClip_native_sig, _libSDLDisplay_class_SDLDisplayRaw_method_SDResetClip_sig>('SDResetClip');
            _SDDrawPoint = lib.lookupFunction<_libSDLDisplay_class_SDLDisplayRaw_method_SDDrawPoint_native_sig, _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawPoint_sig>('SDDrawPoint');
            _SDDrawLine = lib.lookupFunction<_libSDLDisplay_class_SDLDisplayRaw_method_SDDrawLine_native_sig, _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawLine_sig>('SDDrawLine');
            _SDDrawRect = lib.lookupFunction<_libSDLDisplay_class_SDLDisplayRaw_method_SDDrawRect_native_sig, _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawRect_sig>('SDDrawRect');
            _SDFillRect = lib.lookupFunction<_libSDLDisplay_class_SDLDisplayRaw_method_SDFillRect_native_sig, _libSDLDisplay_class_SDLDisplayRaw_method_SDFillRect_sig>('SDFillRect');
            _SDDrawText = lib.lookupFunction<_libSDLDisplay_class_SDLDisplayRaw_method_SDDrawText_native_sig, _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawText_sig>('SDDrawText');
        }
    }

    SDLDisplayRaw(String title, bool fullscreen) {
        _initRefs();
        structPointer = _SDInit!(title.toNativeUtf8(), fullscreen ? 1 : 0);
    }

    SDLDisplayRaw.fromPointer(Pointer<Void> ptr) {
        _initRefs();
        structPointer = ptr;
    }

    SDLInitErrorCode get errorCode {
        _validatePointer('errorCode');
        return SDLInitErrorCodeFromInt(_SDGetErrorCode!(structPointer));
    }

    @mustCallSuper
    void Destroy() {
        _validatePointer('SDDestroy');
        final out = _SDDestroy!(structPointer);

        // this method invalidates the pointer, probably by freeing memory
        structPointer = nullptr;

        return out;
    }

    void GetSize(Pointer<Int32> width, Pointer<Int32> height) {
        _validatePointer('SDGetSize');
        return _SDGetSize!(structPointer, width, height);
    }

    void Flush() {
        _validatePointer('SDFlush');
        return _SDFlush!(structPointer);
    }

    void cSetClip(int x, int y, int w, int h) {
        _validatePointer('cSetClip');
        return _SDSetClip!(structPointer, x, y, w, h);
    }

    void ResetClip() {
        _validatePointer('SDResetClip');
        return _SDResetClip!(structPointer);
    }

    void cDrawPoint(int x, int y, int r, int g, int b, int a) {
        _validatePointer('cDrawPoint');
        return _SDDrawPoint!(structPointer, x, y, r, g, b, a);
    }

    void cDrawLine(int x1, int y1, int x2, int y2, int r, int g, int b, int a) {
        _validatePointer('cDrawLine');
        return _SDDrawLine!(structPointer, x1, y1, x2, y2, r, g, b, a);
    }

    void cDrawRect(int x, int y, int w, int h, int r, int g, int b, int a) {
        _validatePointer('cDrawRect');
        return _SDDrawRect!(structPointer, x, y, w, h, r, g, b, a);
    }

    void cFillRect(int x, int y, int w, int h, int r, int g, int b, int a) {
        _validatePointer('cFillRect');
        return _SDFillRect!(structPointer, x, y, w, h, r, g, b, a);
    }

    void cDrawText(SDLFontRaw font, String text, int x, int y, int r, int g, int b, int a) {
        _validatePointer('cDrawText');
        return _SDDrawText!(structPointer, font.structPointer, text.toNativeUtf8(), x, y, r, g, b, a);
    }

}

// ----------FILE: NATIVE\UI\SDL\SDLEVENT.GEN----------

// ----------FUNC SIG TYPEDEFS FOR CLASSES----------

// ----------SDLEVENTRAW----------

// void* SEInit()
typedef _libSDLEvent_class_SDLEventRaw_method_SEInit_native_sig = Pointer<Void> Function();
typedef _libSDLEvent_class_SDLEventRaw_method_SEInit_sig = Pointer<Void> Function();

// void SEDestroy(void* struct_ptr)
typedef _libSDLEvent_class_SDLEventRaw_method_SEDestroy_native_sig = Void Function(Pointer<Void>);
typedef _libSDLEvent_class_SDLEventRaw_method_SEDestroy_sig = void Function(Pointer<Void>);

// void SEGetPos(void* struct_ptr, int* x, int* y)
typedef _libSDLEvent_class_SDLEventRaw_method_SEGetPos_native_sig = Void Function(Pointer<Void>, Pointer<Int32>, Pointer<Int32>);
typedef _libSDLEvent_class_SDLEventRaw_method_SEGetPos_sig = void Function(Pointer<Void>, Pointer<Int32>, Pointer<Int32>);

// Key SEGetKey(void* struct_ptr)
typedef _libSDLEvent_class_SDLEventRaw_method_SEGetKey_native_sig = Int32 Function(Pointer<Void>);
typedef _libSDLEvent_class_SDLEventRaw_method_SEGetKey_sig = int Function(Pointer<Void>);

// char* SEGetText(void* struct_ptr)
typedef _libSDLEvent_class_SDLEventRaw_method_SEGetText_native_sig = Pointer<Utf8> Function(Pointer<Void>);
typedef _libSDLEvent_class_SDLEventRaw_method_SEGetText_sig = Pointer<Utf8> Function(Pointer<Void>);

// MouseButton SEGetMouseButton(void* struct_ptr)
typedef _libSDLEvent_class_SDLEventRaw_method_SEGetMouseButton_native_sig = Int32 Function(Pointer<Void>);
typedef _libSDLEvent_class_SDLEventRaw_method_SEGetMouseButton_sig = int Function(Pointer<Void>);

// EventType SEGetType(void* struct_ptr)
typedef _libSDLEvent_class_SDLEventRaw_method_SEGetType_native_sig = Int32 Function(Pointer<Void>);
typedef _libSDLEvent_class_SDLEventRaw_method_SEGetType_sig = int Function(Pointer<Void>);

// bool SEHasShift(void* struct_ptr)
typedef _libSDLEvent_class_SDLEventRaw_method_SEHasShift_native_sig = Uint8 Function(Pointer<Void>);
typedef _libSDLEvent_class_SDLEventRaw_method_SEHasShift_sig = int Function(Pointer<Void>);

// bool SEHasControl(void* struct_ptr)
typedef _libSDLEvent_class_SDLEventRaw_method_SEHasControl_native_sig = Uint8 Function(Pointer<Void>);
typedef _libSDLEvent_class_SDLEventRaw_method_SEHasControl_sig = int Function(Pointer<Void>);

// bool SEHasAlt(void* struct_ptr)
typedef _libSDLEvent_class_SDLEventRaw_method_SEHasAlt_native_sig = Uint8 Function(Pointer<Void>);
typedef _libSDLEvent_class_SDLEventRaw_method_SEHasAlt_sig = int Function(Pointer<Void>);

// bool SEHasCaps(void* struct_ptr)
typedef _libSDLEvent_class_SDLEventRaw_method_SEHasCaps_native_sig = Uint8 Function(Pointer<Void>);
typedef _libSDLEvent_class_SDLEventRaw_method_SEHasCaps_sig = int Function(Pointer<Void>);

// int SEPoll(void* struct_ptr)
typedef _libSDLEvent_class_SDLEventRaw_method_SEPoll_native_sig = Int32 Function(Pointer<Void>);
typedef _libSDLEvent_class_SDLEventRaw_method_SEPoll_sig = int Function(Pointer<Void>);

// ----------CLASS IMPLEMENTATIONS----------

class SDLEventRaw {
    Pointer<Void> structPointer = nullptr;

    void _validatePointer(String methodName) {
        if (structPointer.address == 0) {
            throw Exception('SDLEventRaw.$methodName was called, but structPointer is a nullptr.');
        }
    }

    static _libSDLEvent_class_SDLEventRaw_method_SEInit_sig? _SEInit;
    static _libSDLEvent_class_SDLEventRaw_method_SEDestroy_sig? _SEDestroy;
    static _libSDLEvent_class_SDLEventRaw_method_SEGetPos_sig? _SEGetPos;
    static _libSDLEvent_class_SDLEventRaw_method_SEGetKey_sig? _SEGetKey;
    static _libSDLEvent_class_SDLEventRaw_method_SEGetText_sig? _SEGetText;
    static _libSDLEvent_class_SDLEventRaw_method_SEGetMouseButton_sig? _SEGetMouseButton;
    static _libSDLEvent_class_SDLEventRaw_method_SEGetType_sig? _SEGetType;
    static _libSDLEvent_class_SDLEventRaw_method_SEHasShift_sig? _SEHasShift;
    static _libSDLEvent_class_SDLEventRaw_method_SEHasControl_sig? _SEHasControl;
    static _libSDLEvent_class_SDLEventRaw_method_SEHasAlt_sig? _SEHasAlt;
    static _libSDLEvent_class_SDLEventRaw_method_SEHasCaps_sig? _SEHasCaps;
    static _libSDLEvent_class_SDLEventRaw_method_SEPoll_sig? _SEPoll;

    void _initRefs() {
        if (
            _SEInit == null ||
            _SEDestroy == null ||
            _SEGetPos == null ||
            _SEGetKey == null ||
            _SEGetText == null ||
            _SEGetMouseButton == null ||
            _SEGetType == null ||
            _SEHasShift == null ||
            _SEHasControl == null ||
            _SEHasAlt == null ||
            _SEHasCaps == null ||
            _SEPoll == null
        ) {
            final lib = DynamicLibrary.open('build/native/ui/SDL/libSDLEvent.dll');

            _SEInit = lib.lookupFunction<_libSDLEvent_class_SDLEventRaw_method_SEInit_native_sig, _libSDLEvent_class_SDLEventRaw_method_SEInit_sig>('SEInit');
            _SEDestroy = lib.lookupFunction<_libSDLEvent_class_SDLEventRaw_method_SEDestroy_native_sig, _libSDLEvent_class_SDLEventRaw_method_SEDestroy_sig>('SEDestroy');
            _SEGetPos = lib.lookupFunction<_libSDLEvent_class_SDLEventRaw_method_SEGetPos_native_sig, _libSDLEvent_class_SDLEventRaw_method_SEGetPos_sig>('SEGetPos');
            _SEGetKey = lib.lookupFunction<_libSDLEvent_class_SDLEventRaw_method_SEGetKey_native_sig, _libSDLEvent_class_SDLEventRaw_method_SEGetKey_sig>('SEGetKey');
            _SEGetText = lib.lookupFunction<_libSDLEvent_class_SDLEventRaw_method_SEGetText_native_sig, _libSDLEvent_class_SDLEventRaw_method_SEGetText_sig>('SEGetText');
            _SEGetMouseButton = lib.lookupFunction<_libSDLEvent_class_SDLEventRaw_method_SEGetMouseButton_native_sig, _libSDLEvent_class_SDLEventRaw_method_SEGetMouseButton_sig>('SEGetMouseButton');
            _SEGetType = lib.lookupFunction<_libSDLEvent_class_SDLEventRaw_method_SEGetType_native_sig, _libSDLEvent_class_SDLEventRaw_method_SEGetType_sig>('SEGetType');
            _SEHasShift = lib.lookupFunction<_libSDLEvent_class_SDLEventRaw_method_SEHasShift_native_sig, _libSDLEvent_class_SDLEventRaw_method_SEHasShift_sig>('SEHasShift');
            _SEHasControl = lib.lookupFunction<_libSDLEvent_class_SDLEventRaw_method_SEHasControl_native_sig, _libSDLEvent_class_SDLEventRaw_method_SEHasControl_sig>('SEHasControl');
            _SEHasAlt = lib.lookupFunction<_libSDLEvent_class_SDLEventRaw_method_SEHasAlt_native_sig, _libSDLEvent_class_SDLEventRaw_method_SEHasAlt_sig>('SEHasAlt');
            _SEHasCaps = lib.lookupFunction<_libSDLEvent_class_SDLEventRaw_method_SEHasCaps_native_sig, _libSDLEvent_class_SDLEventRaw_method_SEHasCaps_sig>('SEHasCaps');
            _SEPoll = lib.lookupFunction<_libSDLEvent_class_SDLEventRaw_method_SEPoll_native_sig, _libSDLEvent_class_SDLEventRaw_method_SEPoll_sig>('SEPoll');
        }
    }

    SDLEventRaw() {
        _initRefs();
        structPointer = _SEInit!();
    }

    SDLEventRaw.fromPointer(Pointer<Void> ptr) {
        _initRefs();
        structPointer = ptr;
    }

    @mustCallSuper
    void Destroy() {
        _validatePointer('SEDestroy');
        final out = _SEDestroy!(structPointer);

        // this method invalidates the pointer, probably by freeing memory
        structPointer = nullptr;

        return out;
    }

    void GetPos(Pointer<Int32> x, Pointer<Int32> y) {
        _validatePointer('SEGetPos');
        return _SEGetPos!(structPointer, x, y);
    }

    Key get key {
        _validatePointer('key');
        return KeyFromInt(_SEGetKey!(structPointer));
    }

    String get text {
        _validatePointer('text');
        return (_SEGetText!(structPointer)).toDartString();
    }

    MouseButton get mouseButton {
        _validatePointer('mouseButton');
        return MouseButtonFromInt(_SEGetMouseButton!(structPointer));
    }

    EventType get type {
        _validatePointer('type');
        return EventTypeFromInt(_SEGetType!(structPointer));
    }

    bool HasShift() {
        _validatePointer('SEHasShift');
        return (_SEHasShift!(structPointer)) == 1;
    }

    bool HasControl() {
        _validatePointer('SEHasControl');
        return (_SEHasControl!(structPointer)) == 1;
    }

    bool HasAlt() {
        _validatePointer('SEHasAlt');
        return (_SEHasAlt!(structPointer)) == 1;
    }

    bool HasCaps() {
        _validatePointer('SEHasCaps');
        return (_SEHasCaps!(structPointer)) == 1;
    }

    int Poll() {
        _validatePointer('SEPoll');
        return _SEPoll!(structPointer);
    }

}

// ----------FILE: NATIVE\UI\SDL\SDLFONT.GEN----------

// ----------FUNCTION SIGNATURE TYPEDEFS----------

// bool SFInit()
typedef _libSDLFont_func_SFInit_native_sig = Uint8 Function();
typedef _libSDLFont_func_SFInit_sig = int Function();

// void SFQuit()
typedef _libSDLFont_func_SFQuit_native_sig = Void Function();
typedef _libSDLFont_func_SFQuit_sig = void Function();

// ----------LIBSDLFONT----------

class libSDLFont {

    static _libSDLFont_func_SFInit_sig? _SFInit;
    static _libSDLFont_func_SFQuit_sig? _SFQuit;

    void _initRefs() {
        if (
            _SFInit == null ||
            _SFQuit == null
        ) {
            final lib = DynamicLibrary.open('build/native/ui/SDL/libSDLFont.dll');

            _SFInit = lib.lookupFunction<_libSDLFont_func_SFInit_native_sig, _libSDLFont_func_SFInit_sig>('SFInit');
            _SFQuit = lib.lookupFunction<_libSDLFont_func_SFQuit_native_sig, _libSDLFont_func_SFQuit_sig>('SFQuit');
        }
    }

    libSDLFont() {
        _initRefs();
    }

    bool Init() {
        return (_SFInit!()) == 1;
    }

    void Quit() {
        return _SFQuit!();
    }

}


// ----------FUNC SIG TYPEDEFS FOR CLASSES----------

// ----------SDLFONTRAW----------

// void* SFCreate(char* family, int size)
typedef _libSDLFont_class_SDLFontRaw_method_SFCreate_native_sig = Pointer<Void> Function(Pointer<Utf8>, Int32);
typedef _libSDLFont_class_SDLFontRaw_method_SFCreate_sig = Pointer<Void> Function(Pointer<Utf8>, int);

// void SFDestroy(void* struct_ptr)
typedef _libSDLFont_class_SDLFontRaw_method_SFDestroy_native_sig = Void Function(Pointer<Void>);
typedef _libSDLFont_class_SDLFontRaw_method_SFDestroy_sig = void Function(Pointer<Void>);

// void SFGetTextSize(void* struct_ptr, char* text, int* width, int* height)
typedef _libSDLFont_class_SDLFontRaw_method_SFGetTextSize_native_sig = Void Function(Pointer<Void>, Pointer<Utf8>, Pointer<Int32>, Pointer<Int32>);
typedef _libSDLFont_class_SDLFontRaw_method_SFGetTextSize_sig = void Function(Pointer<Void>, Pointer<Utf8>, Pointer<Int32>, Pointer<Int32>);

// ----------CLASS IMPLEMENTATIONS----------

class SDLFontRaw {
    Pointer<Void> structPointer = nullptr;

    void _validatePointer(String methodName) {
        if (structPointer.address == 0) {
            throw Exception('SDLFontRaw.$methodName was called, but structPointer is a nullptr.');
        }
    }

    static _libSDLFont_class_SDLFontRaw_method_SFCreate_sig? _SFCreate;
    static _libSDLFont_class_SDLFontRaw_method_SFDestroy_sig? _SFDestroy;
    static _libSDLFont_class_SDLFontRaw_method_SFGetTextSize_sig? _SFGetTextSize;

    void _initRefs() {
        if (
            _SFCreate == null ||
            _SFDestroy == null ||
            _SFGetTextSize == null
        ) {
            final lib = DynamicLibrary.open('build/native/ui/SDL/libSDLFont.dll');

            _SFCreate = lib.lookupFunction<_libSDLFont_class_SDLFontRaw_method_SFCreate_native_sig, _libSDLFont_class_SDLFontRaw_method_SFCreate_sig>('SFCreate');
            _SFDestroy = lib.lookupFunction<_libSDLFont_class_SDLFontRaw_method_SFDestroy_native_sig, _libSDLFont_class_SDLFontRaw_method_SFDestroy_sig>('SFDestroy');
            _SFGetTextSize = lib.lookupFunction<_libSDLFont_class_SDLFontRaw_method_SFGetTextSize_native_sig, _libSDLFont_class_SDLFontRaw_method_SFGetTextSize_sig>('SFGetTextSize');
        }
    }

    SDLFontRaw(String family, int size) {
        _initRefs();
        structPointer = _SFCreate!(family.toNativeUtf8(), size);
    }

    SDLFontRaw.fromPointer(Pointer<Void> ptr) {
        _initRefs();
        structPointer = ptr;
    }

    @mustCallSuper
    void Destroy() {
        _validatePointer('SFDestroy');
        final out = _SFDestroy!(structPointer);

        // this method invalidates the pointer, probably by freeing memory
        structPointer = nullptr;

        return out;
    }

    void GetTextSize(String text, Pointer<Int32> width, Pointer<Int32> height) {
        _validatePointer('SFGetTextSize');
        return _SFGetTextSize!(structPointer, text.toNativeUtf8(), width, height);
    }

}

// ----------OBJECTS----------

class BeansObject {
    final String displayName;
    final String keyCode;
    final Map<String, BeansObjectProperty> properties;
    final Map<String, BeansObjectMethod> methods;
    const BeansObject(this.displayName, this.keyCode, this.properties, this.methods);
}

class BeansObjectProperty {
    final String name;
    final bool canGet;
    final bool canSet;
    const BeansObjectProperty(this.name, this.canGet, this.canSet);
}

class BeansObjectMethod {
    final String name;
    final bool returnsValue;
    const BeansObjectMethod(this.name, this.returnsValue);
}

const obj_Channel = BeansObject(
    'Chan',
    'c',
    {
        'level': BeansObjectProperty('level', true, true),
    },
    {}
);

const objectsByKeyCode = {
    'c': obj_Channel,
};

