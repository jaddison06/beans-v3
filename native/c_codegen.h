#ifndef C_CODEGEN_H
#define C_CODEGEN_H

// old-style booleans to ensure Dart compatibility
typedef char BEANS_BOOL;
#define TRUE 1
#define FALSE 0

// ----------NATIVE\3RDPARTY\LIBE131\E131.GEN----------

typedef enum {
    BeansE131ErrorCode_success = 0,
    BeansE131ErrorCode_socket = 1,
    BeansE131ErrorCode_source_name = 2,
    BeansE131ErrorCode_unicast_dest = 3,
} BeansE131ErrorCode;

// ----------NATIVE\UI\EVENTS.GEN----------

typedef enum {
    EventType_None = 0,
    EventType_Quit = 1,
    EventType_KeyDown = 2,
    EventType_KeyUp = 3,
    EventType_MouseMove = 4,
    EventType_MouseDown = 5,
    EventType_MouseUp = 6,
    EventType_MouseScroll = 7,
} EventType;

typedef enum {
    MouseButton_Left = 0,
    MouseButton_Right = 1,
    MouseButton_Middle = 2,
    MouseButton_Unknown = 3,
} MouseButton;

typedef enum {
    Modifier_Shift = 0,
    Modifier_Control = 1,
    Modifier_Alt = 2,
    Modifier_Caps = 3,
} Modifier;

typedef enum {
    KeyCode_a = 0,
    KeyCode_b = 1,
    KeyCode_c = 2,
    KeyCode_d = 3,
    KeyCode_e = 4,
    KeyCode_f = 5,
    KeyCode_g = 6,
    KeyCode_h = 7,
    KeyCode_i = 8,
    KeyCode_j = 9,
    KeyCode_k = 10,
    KeyCode_l = 11,
    KeyCode_m = 12,
    KeyCode_n = 13,
    KeyCode_o = 14,
    KeyCode_p = 15,
    KeyCode_q = 16,
    KeyCode_r = 17,
    KeyCode_s = 18,
    KeyCode_t = 19,
    KeyCode_u = 20,
    KeyCode_v = 21,
    KeyCode_w = 22,
    KeyCode_x = 23,
    KeyCode_y = 24,
    KeyCode_z = 25,
    KeyCode_One = 26,
    KeyCode_Two = 27,
    KeyCode_Three = 28,
    KeyCode_Four = 29,
    KeyCode_Five = 30,
    KeyCode_Six = 31,
    KeyCode_Seven = 32,
    KeyCode_Eight = 33,
    KeyCode_Nine = 34,
    KeyCode_Zero = 35,
    KeyCode_Exclamation = 36,
    KeyCode_Question = 37,
    KeyCode_DoubleQuote = 38,
    KeyCode_SingleQuote = 39,
    KeyCode_Pound = 40,
    KeyCode_Dollar = 41,
    KeyCode_Percent = 42,
    KeyCode_Caret = 43,
    KeyCode_Ampersand = 44,
    KeyCode_Asterisk = 45,
    KeyCode_Hyphen = 46,
    KeyCode_Underscore = 47,
    KeyCode_Equals = 48,
    KeyCode_Plus = 49,
    KeyCode_Pipe = 50,
    KeyCode_Semicolon = 51,
    KeyCode_Colon = 52,
    KeyCode_At = 53,
    KeyCode_Tilde = 54,
    KeyCode_Hash = 55,
    KeyCode_Backtick = 56,
    KeyCode_ForwardSlash = 57,
    KeyCode_BackSlash = 58,
    KeyCode_NormalBracketL = 59,
    KeyCode_NormalBracketR = 60,
    KeyCode_SquareBracketL = 61,
    KeyCode_SquareBracketR = 62,
    KeyCode_CurlyBraceL = 63,
    KeyCode_CurlyBraceR = 64,
    KeyCode_SmallerThan = 65,
    KeyCode_GreaterThan = 66,
    KeyCode_Return = 67,
    KeyCode_Escape = 68,
    KeyCode_Backspace = 69,
    KeyCode_Delete = 70,
    KeyCode_Tab = 71,
    KeyCode_Space = 72,
    KeyCode_Insert = 73,
    KeyCode_Home = 74,
    KeyCode_End = 75,
    KeyCode_PageUp = 76,
    KeyCode_PageDown = 77,
    KeyCode_ArrowRight = 78,
    KeyCode_ArrowLeft = 79,
    KeyCode_ArrowDown = 80,
    KeyCode_ArrowUp = 81,
    KeyCode_NumpadDivide = 82,
    KeyCode_NumpadMultiply = 83,
    KeyCode_NumpadSubtract = 84,
    KeyCode_NumpadAdd = 85,
    KeyCode_NumpadEquals = 86,
    KeyCode_NumpadEnter = 87,
    KeyCode_NumpadDecimalPoint = 88,
    KeyCode_NumpadOne = 89,
    KeyCode_NumpadTwo = 90,
    KeyCode_NumpadThree = 91,
    KeyCode_NumpadFour = 92,
    KeyCode_NumpadFive = 93,
    KeyCode_NumpadSix = 94,
    KeyCode_NumpadSeven = 95,
    KeyCode_NumpadEight = 96,
    KeyCode_NumpadNine = 97,
    KeyCode_NumpadZero = 98,
    KeyCode_Function_F1 = 99,
    KeyCode_Function_F2 = 100,
    KeyCode_Function_F3 = 101,
    KeyCode_Function_F4 = 102,
    KeyCode_Function_F5 = 103,
    KeyCode_Function_F6 = 104,
    KeyCode_Function_F7 = 105,
    KeyCode_Function_F8 = 106,
    KeyCode_Function_F9 = 107,
    KeyCode_Function_F10 = 108,
    KeyCode_Function_F11 = 109,
    KeyCode_Function_F12 = 110,
    KeyCode_LControl = 111,
    KeyCode_RControl = 112,
    KeyCode_LShift = 113,
    KeyCode_RShift = 114,
    KeyCode_LAlt = 115,
    KeyCode_RAlt = 116,
    KeyCode_AudioNext = 117,
    KeyCode_AudioPrev = 118,
    KeyCode_AudioStop = 119,
    KeyCode_AudioPlay = 120,
    KeyCode_Unknown = 121,
} KeyCode;

// ----------NATIVE\UI\SDL\SDLDISPLAY.GEN----------

typedef enum {
    SDLInitErrorCode_Success = 0,
    SDLInitErrorCode_InitVideo_Fail = 1,
    SDLInitErrorCode_CreateWindow_Fail = 2,
    SDLInitErrorCode_CreateRenderer_Fail = 3,
} SDLInitErrorCode;

// ----------NATIVE\UI\SDL\SDLEVENT.GEN----------

// ----------NATIVE\UI\SDL\SDLFONT.GEN----------

#endif // C_CODEGEN_H