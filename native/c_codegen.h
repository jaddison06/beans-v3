#ifndef C_CODEGEN_H
#define C_CODEGEN_H

// old-style booleans to ensure Dart compatibility
typedef char BEANS_BOOL;
#define TRUE 1
#define FALSE 0

#define BEANS_LINUX

// ----------NATIVE/UI/EVENTS.GEN----------

typedef enum {
    EventType_None = 0,
    EventType_Quit = 1,
    EventType_Key = 2,
    EventType_Text = 3,
    EventType_MouseMove = 4,
    EventType_MouseDown = 5,
    EventType_MouseUp = 6,
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
    Key_Return = 0,
    Key_Escape = 1,
    Key_Backspace = 2,
    Key_Delete = 3,
    Key_Tab = 4,
    Key_Insert = 5,
    Key_Home = 6,
    Key_End = 7,
    Key_PageUp = 8,
    Key_PageDown = 9,
    Key_ArrowRight = 10,
    Key_ArrowLeft = 11,
    Key_ArrowDown = 12,
    Key_ArrowUp = 13,
    Key_LControl = 14,
    Key_RControl = 15,
    Key_LShift = 16,
    Key_RShift = 17,
    Key_LAlt = 18,
    Key_RAlt = 19,
    Key_Unknown = 20,
} Key;

// ----------NATIVE/UI/SDL/SDLEVENT.GEN----------

// ----------NATIVE/UI/SDL/SDLFONT.GEN----------

// ----------NATIVE/UI/SDL/SDLDISPLAY.GEN----------

typedef enum {
    SDLInitErrorCode_Success = 0,
    SDLInitErrorCode_InitVideo_Fail = 1,
    SDLInitErrorCode_CreateWindow_Fail = 2,
    SDLInitErrorCode_CreateRenderer_Fail = 3,
} SDLInitErrorCode;

// ----------NATIVE/3RDPARTY/LIBE131/E131.GEN----------

typedef enum {
    BeansE131ErrorCode_success = 0,
    BeansE131ErrorCode_socket = 1,
    BeansE131ErrorCode_source_name = 2,
    BeansE131ErrorCode_unicast_dest = 3,
} BeansE131ErrorCode;

#endif // C_CODEGEN_H