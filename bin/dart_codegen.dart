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
    KeyDown,
    KeyUp,
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
        case EventType.KeyDown: { return 'KeyDown'; }
        case EventType.KeyUp: { return 'KeyUp'; }
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

enum KeyCode {
    A,
    B,
    C,
    D,
    E,
    F,
    G,
    H,
    I,
    J,
    K,
    L,
    M,
    N,
    O,
    P,
    Q,
    R,
    S,
    T,
    U,
    V,
    W,
    X,
    Y,
    Z,
    One,
    Two,
    Three,
    Four,
    Five,
    Six,
    Seven,
    Eight,
    Nine,
    Zero,
    Exclamation,
    Question,
    DoubleQuote,
    SingleQuote,
    Pound,
    Dollar,
    Percent,
    Caret,
    Ampersand,
    Asterisk,
    Hyphen,
    Underscore,
    Equals,
    Plus,
    Pipe,
    Semicolon,
    Colon,
    At,
    Tilde,
    Hash,
    Backtick,
    ForwardSlash,
    BackSlash,
    NormalBracketL,
    NormalBracketR,
    SquareBracketL,
    SquareBracketR,
    CurlyBraceL,
    CurlyBraceR,
    SmallerThan,
    GreaterThan,
    Return,
    Escape,
    Backspace,
    Delete,
    Tab,
    Space,
    Insert,
    Home,
    End,
    PageUp,
    PageDown,
    ArrowRight,
    ArrowLeft,
    ArrowDown,
    ArrowUp,
    NumpadDivide,
    NumpadMultiply,
    NumpadSubtract,
    NumpadAdd,
    NumpadEquals,
    NumpadEnter,
    NumpadDecimalPoint,
    NumpadOne,
    NumpadTwo,
    NumpadThree,
    NumpadFour,
    NumpadFive,
    NumpadSix,
    NumpadSeven,
    NumpadEight,
    NumpadNine,
    NumpadZero,
    Function_F1,
    Function_F2,
    Function_F3,
    Function_F4,
    Function_F5,
    Function_F6,
    Function_F7,
    Function_F8,
    Function_F9,
    Function_F10,
    Function_F11,
    Function_F12,
    LControl,
    RControl,
    LShift,
    RShift,
    LAlt,
    RAlt,
    AudioNext,
    AudioPrev,
    AudioStop,
    AudioPlay,
    Unknown,
}

KeyCode KeyCodeFromInt(int val) => KeyCode.values[val];
int KeyCodeToInt(KeyCode val) => KeyCode.values.indexOf(val);

String KeyCodeToString(KeyCode val) {
    switch (val) {
        case KeyCode.A: { return 'A'; }
        case KeyCode.B: { return 'B'; }
        case KeyCode.C: { return 'C'; }
        case KeyCode.D: { return 'D'; }
        case KeyCode.E: { return 'E'; }
        case KeyCode.F: { return 'F'; }
        case KeyCode.G: { return 'G'; }
        case KeyCode.H: { return 'H'; }
        case KeyCode.I: { return 'I'; }
        case KeyCode.J: { return 'J'; }
        case KeyCode.K: { return 'K'; }
        case KeyCode.L: { return 'L'; }
        case KeyCode.M: { return 'M'; }
        case KeyCode.N: { return 'N'; }
        case KeyCode.O: { return 'O'; }
        case KeyCode.P: { return 'P'; }
        case KeyCode.Q: { return 'Q'; }
        case KeyCode.R: { return 'R'; }
        case KeyCode.S: { return 'S'; }
        case KeyCode.T: { return 'T'; }
        case KeyCode.U: { return 'U'; }
        case KeyCode.V: { return 'V'; }
        case KeyCode.W: { return 'W'; }
        case KeyCode.X: { return 'X'; }
        case KeyCode.Y: { return 'Y'; }
        case KeyCode.Z: { return 'Z'; }
        case KeyCode.One: { return '1'; }
        case KeyCode.Two: { return '2'; }
        case KeyCode.Three: { return '3'; }
        case KeyCode.Four: { return '4'; }
        case KeyCode.Five: { return '5'; }
        case KeyCode.Six: { return '6'; }
        case KeyCode.Seven: { return '7'; }
        case KeyCode.Eight: { return '8'; }
        case KeyCode.Nine: { return '9'; }
        case KeyCode.Zero: { return '0'; }
        case KeyCode.Exclamation: { return '!'; }
        case KeyCode.Question: { return '?'; }
        case KeyCode.DoubleQuote: { return '"'; }
        case KeyCode.SingleQuote: { return '\''; }
        case KeyCode.Pound: { return '£'; }
        case KeyCode.Dollar: { return '\$'; }
        case KeyCode.Percent: { return '%'; }
        case KeyCode.Caret: { return '^'; }
        case KeyCode.Ampersand: { return '&'; }
        case KeyCode.Asterisk: { return '*'; }
        case KeyCode.Hyphen: { return '-'; }
        case KeyCode.Underscore: { return '_'; }
        case KeyCode.Equals: { return '='; }
        case KeyCode.Plus: { return '+'; }
        case KeyCode.Pipe: { return '|'; }
        case KeyCode.Semicolon: { return ';'; }
        case KeyCode.Colon: { return ':'; }
        case KeyCode.At: { return '@'; }
        case KeyCode.Tilde: { return '~'; }
        case KeyCode.Hash: { return '#'; }
        case KeyCode.Backtick: { return '`'; }
        case KeyCode.ForwardSlash: { return '/'; }
        case KeyCode.BackSlash: { return '\\'; }
        case KeyCode.NormalBracketL: { return '('; }
        case KeyCode.NormalBracketR: { return ')'; }
        case KeyCode.SquareBracketL: { return '['; }
        case KeyCode.SquareBracketR: { return ']'; }
        case KeyCode.CurlyBraceL: { return '{'; }
        case KeyCode.CurlyBraceR: { return '}'; }
        case KeyCode.SmallerThan: { return '<'; }
        case KeyCode.GreaterThan: { return '>'; }
        case KeyCode.Return: { return 'Return'; }
        case KeyCode.Escape: { return 'Escape'; }
        case KeyCode.Backspace: { return 'Backspace'; }
        case KeyCode.Delete: { return 'Delete'; }
        case KeyCode.Tab: { return 'Tab'; }
        case KeyCode.Space: { return 'Space'; }
        case KeyCode.Insert: { return 'Insert'; }
        case KeyCode.Home: { return 'Home'; }
        case KeyCode.End: { return 'End'; }
        case KeyCode.PageUp: { return 'PageUp'; }
        case KeyCode.PageDown: { return 'PageDown'; }
        case KeyCode.ArrowRight: { return 'ArrowRight'; }
        case KeyCode.ArrowLeft: { return 'ArrowLeft'; }
        case KeyCode.ArrowDown: { return 'ArrowDown'; }
        case KeyCode.ArrowUp: { return 'ArrowUp'; }
        case KeyCode.NumpadDivide: { return 'NumpadDivide'; }
        case KeyCode.NumpadMultiply: { return 'NumpadMultiply'; }
        case KeyCode.NumpadSubtract: { return 'NumpadSubtract'; }
        case KeyCode.NumpadAdd: { return 'NumpadAdd'; }
        case KeyCode.NumpadEquals: { return 'NumpadEquals'; }
        case KeyCode.NumpadEnter: { return 'NumpadEnter'; }
        case KeyCode.NumpadDecimalPoint: { return 'NumpadDecimalPoint'; }
        case KeyCode.NumpadOne: { return '1'; }
        case KeyCode.NumpadTwo: { return '2'; }
        case KeyCode.NumpadThree: { return '3'; }
        case KeyCode.NumpadFour: { return '4'; }
        case KeyCode.NumpadFive: { return '5'; }
        case KeyCode.NumpadSix: { return '6'; }
        case KeyCode.NumpadSeven: { return '7'; }
        case KeyCode.NumpadEight: { return '8'; }
        case KeyCode.NumpadNine: { return '9'; }
        case KeyCode.NumpadZero: { return '0'; }
        case KeyCode.Function_F1: { return 'F1'; }
        case KeyCode.Function_F2: { return 'F2'; }
        case KeyCode.Function_F3: { return 'F3'; }
        case KeyCode.Function_F4: { return 'F4'; }
        case KeyCode.Function_F5: { return 'F5'; }
        case KeyCode.Function_F6: { return 'F6'; }
        case KeyCode.Function_F7: { return 'F7'; }
        case KeyCode.Function_F8: { return 'F8'; }
        case KeyCode.Function_F9: { return 'F9'; }
        case KeyCode.Function_F10: { return 'F10'; }
        case KeyCode.Function_F11: { return 'F11'; }
        case KeyCode.Function_F12: { return 'F12'; }
        case KeyCode.LControl: { return 'LControl'; }
        case KeyCode.RControl: { return 'RControl'; }
        case KeyCode.LShift: { return 'LShift'; }
        case KeyCode.RShift: { return 'RShift'; }
        case KeyCode.LAlt: { return 'LAlt'; }
        case KeyCode.RAlt: { return 'RAlt'; }
        case KeyCode.AudioNext: { return 'AudioNext'; }
        case KeyCode.AudioPrev: { return 'AudioPrev'; }
        case KeyCode.AudioStop: { return 'AudioStop'; }
        case KeyCode.AudioPlay: { return 'AudioPlay'; }
        case KeyCode.Unknown: { return 'Unknown'; }
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

// void* SDInit(char* title)
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDInit_native_sig = Pointer<Void> Function(Pointer<Utf8>);
typedef _libSDLDisplay_class_SDLDisplayRaw_method_SDInit_sig = Pointer<Void> Function(Pointer<Utf8>);

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
    static _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawPoint_sig? _SDDrawPoint;
    static _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawLine_sig? _SDDrawLine;
    static _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawRect_sig? _SDDrawRect;
    static _libSDLDisplay_class_SDLDisplayRaw_method_SDFillRect_sig? _SDFillRect;

    void _initRefs() {
        if (
            _SDInit == null ||
            _SDGetErrorCode == null ||
            _SDDestroy == null ||
            _SDGetSize == null ||
            _SDFlush == null ||
            _SDDrawPoint == null ||
            _SDDrawLine == null ||
            _SDDrawRect == null ||
            _SDFillRect == null
        ) {
            final lib = DynamicLibrary.open('build/native/ui/SDL/libSDLDisplay.dll');

            _SDInit = lib.lookupFunction<_libSDLDisplay_class_SDLDisplayRaw_method_SDInit_native_sig, _libSDLDisplay_class_SDLDisplayRaw_method_SDInit_sig>('SDInit');
            _SDGetErrorCode = lib.lookupFunction<_libSDLDisplay_class_SDLDisplayRaw_method_SDGetErrorCode_native_sig, _libSDLDisplay_class_SDLDisplayRaw_method_SDGetErrorCode_sig>('SDGetErrorCode');
            _SDDestroy = lib.lookupFunction<_libSDLDisplay_class_SDLDisplayRaw_method_SDDestroy_native_sig, _libSDLDisplay_class_SDLDisplayRaw_method_SDDestroy_sig>('SDDestroy');
            _SDGetSize = lib.lookupFunction<_libSDLDisplay_class_SDLDisplayRaw_method_SDGetSize_native_sig, _libSDLDisplay_class_SDLDisplayRaw_method_SDGetSize_sig>('SDGetSize');
            _SDFlush = lib.lookupFunction<_libSDLDisplay_class_SDLDisplayRaw_method_SDFlush_native_sig, _libSDLDisplay_class_SDLDisplayRaw_method_SDFlush_sig>('SDFlush');
            _SDDrawPoint = lib.lookupFunction<_libSDLDisplay_class_SDLDisplayRaw_method_SDDrawPoint_native_sig, _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawPoint_sig>('SDDrawPoint');
            _SDDrawLine = lib.lookupFunction<_libSDLDisplay_class_SDLDisplayRaw_method_SDDrawLine_native_sig, _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawLine_sig>('SDDrawLine');
            _SDDrawRect = lib.lookupFunction<_libSDLDisplay_class_SDLDisplayRaw_method_SDDrawRect_native_sig, _libSDLDisplay_class_SDLDisplayRaw_method_SDDrawRect_sig>('SDDrawRect');
            _SDFillRect = lib.lookupFunction<_libSDLDisplay_class_SDLDisplayRaw_method_SDFillRect_native_sig, _libSDLDisplay_class_SDLDisplayRaw_method_SDFillRect_sig>('SDFillRect');
        }
    }

    SDLDisplayRaw(String title) {
        _initRefs();
        structPointer = _SDInit!(title.toNativeUtf8());
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

// KeyCode SEGetKey(void* struct_ptr)
typedef _libSDLEvent_class_SDLEventRaw_method_SEGetKey_native_sig = Int32 Function(Pointer<Void>);
typedef _libSDLEvent_class_SDLEventRaw_method_SEGetKey_sig = int Function(Pointer<Void>);

// MouseButton SEGetMouseButton(void* struct_ptr)
typedef _libSDLEvent_class_SDLEventRaw_method_SEGetMouseButton_native_sig = Int32 Function(Pointer<Void>);
typedef _libSDLEvent_class_SDLEventRaw_method_SEGetMouseButton_sig = int Function(Pointer<Void>);

// EventType SEGetType(void* struct_ptr)
typedef _libSDLEvent_class_SDLEventRaw_method_SEGetType_native_sig = Int32 Function(Pointer<Void>);
typedef _libSDLEvent_class_SDLEventRaw_method_SEGetType_sig = int Function(Pointer<Void>);

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
    static _libSDLEvent_class_SDLEventRaw_method_SEGetMouseButton_sig? _SEGetMouseButton;
    static _libSDLEvent_class_SDLEventRaw_method_SEGetType_sig? _SEGetType;
    static _libSDLEvent_class_SDLEventRaw_method_SEPoll_sig? _SEPoll;

    void _initRefs() {
        if (
            _SEInit == null ||
            _SEDestroy == null ||
            _SEGetPos == null ||
            _SEGetKey == null ||
            _SEGetMouseButton == null ||
            _SEGetType == null ||
            _SEPoll == null
        ) {
            final lib = DynamicLibrary.open('build/native/ui/SDL/libSDLEvent.dll');

            _SEInit = lib.lookupFunction<_libSDLEvent_class_SDLEventRaw_method_SEInit_native_sig, _libSDLEvent_class_SDLEventRaw_method_SEInit_sig>('SEInit');
            _SEDestroy = lib.lookupFunction<_libSDLEvent_class_SDLEventRaw_method_SEDestroy_native_sig, _libSDLEvent_class_SDLEventRaw_method_SEDestroy_sig>('SEDestroy');
            _SEGetPos = lib.lookupFunction<_libSDLEvent_class_SDLEventRaw_method_SEGetPos_native_sig, _libSDLEvent_class_SDLEventRaw_method_SEGetPos_sig>('SEGetPos');
            _SEGetKey = lib.lookupFunction<_libSDLEvent_class_SDLEventRaw_method_SEGetKey_native_sig, _libSDLEvent_class_SDLEventRaw_method_SEGetKey_sig>('SEGetKey');
            _SEGetMouseButton = lib.lookupFunction<_libSDLEvent_class_SDLEventRaw_method_SEGetMouseButton_native_sig, _libSDLEvent_class_SDLEventRaw_method_SEGetMouseButton_sig>('SEGetMouseButton');
            _SEGetType = lib.lookupFunction<_libSDLEvent_class_SDLEventRaw_method_SEGetType_native_sig, _libSDLEvent_class_SDLEventRaw_method_SEGetType_sig>('SEGetType');
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

    KeyCode get key {
        _validatePointer('key');
        return KeyCodeFromInt(_SEGetKey!(structPointer));
    }

    MouseButton get mouseButton {
        _validatePointer('mouseButton');
        return MouseButtonFromInt(_SEGetMouseButton!(structPointer));
    }

    EventType get type {
        _validatePointer('type');
        return EventTypeFromInt(_SEGetType!(structPointer));
    }

    int Poll() {
        _validatePointer('SEPoll');
        return _SEPoll!(structPointer);
    }

}

