#include "native/c_codegen.h"
#include <SDL2/SDL.h>
#include <stdlib.h>
#include <string.h>

typedef struct
{
    SDL_Event raw;

    EventType type;

    int x, y;
    Key key;
    uint16_t modifiers;
    char* text;
    MouseButton mouseButton;
} SDLEvent;

SDLEvent* SEInit()
{
    SDLEvent* out = malloc(sizeof(SDLEvent));

    out->type = EventType_None;
    out->text = malloc(32);

    return out;
}

void SEDestroy(SDLEvent* event)
{
    free(event->text);
    free(event);
}

void SEGetPos(SDLEvent* event, int* x, int* y)
{
    *x = event->x;
    *y = event->y;
}

Key SEGetKey(SDLEvent* event)
{
    return event->key;
}

char* SEGetText(SDLEvent* event)
{
    return event->text;
}

uint16_t SEGetModifiers(SDLEvent* event) {
    return event->modifiers;
}

BEANS_BOOL HasMod(SDLEvent* self, SDL_Keymod mod) {
    return self->modifiers & mod > 0;
}

BEANS_BOOL SEHasShift(SDLEvent* self) {
    return HasMod(self, KMOD_SHIFT);
}

BEANS_BOOL SEHasControl(SDLEvent* self) {
    return HasMod(self, KMOD_CTRL);
}

BEANS_BOOL SEHasAlt(SDLEvent* self) {
    return HasMod(self, KMOD_ALT);
}

BEANS_BOOL SEHasCaps(SDLEvent* self) {
    return HasMod(self, KMOD_CAPS);
}

MouseButton SEGetMouseButton(SDLEvent* event)
{
    return event->mouseButton;
}

EventType SEGetType(SDLEvent* event)
{
    return event->type;
}

MouseButton TranslateMouseButton(SDLEvent* event)
{
    switch (event->raw.button.button)
    {
        case SDL_BUTTON_LEFT:   return MouseButton_Left;
        case SDL_BUTTON_MIDDLE: return MouseButton_Middle;
        case SDL_BUTTON_RIGHT:  return MouseButton_Right;
        default:                return MouseButton_Unknown;
    }
}

Key TranslateKey(SDLEvent* event)
{
    switch (event->raw.key.keysym.sym)
    {
        case SDLK_RETURN:    return Key_Return;
        case SDLK_ESCAPE:    return Key_Escape;
        case SDLK_BACKSPACE: return Key_Backspace;
        case SDLK_DELETE:    return Key_Delete;
        case SDLK_TAB:       return Key_Tab;

        case SDLK_INSERT:   return Key_Insert;
        case SDLK_HOME:     return Key_Home;
        case SDLK_END:      return Key_End;
        case SDLK_PAGEUP:   return Key_PageUp;
        case SDLK_PAGEDOWN: return Key_PageDown;

        case SDLK_RIGHT: return Key_ArrowRight;
        case SDLK_LEFT:  return Key_ArrowLeft;
        case SDLK_DOWN:  return Key_ArrowDown;
        case SDLK_UP:    return Key_ArrowUp;

        case SDLK_LCTRL:  return Key_LControl;
        case SDLK_RCTRL:  return Key_RControl;
        case SDLK_LSHIFT: return Key_LShift;
        case SDLK_RSHIFT: return Key_RShift;
        case SDLK_LALT:   return Key_LAlt;
        case SDLK_RALT:   return Key_RAlt;
        
        default: return Key_Unknown;
    }
}

int SEPoll(SDLEvent* event)
{
    int out = SDL_PollEvent(&event->raw);

    switch (event->raw.type)
    {
        case SDL_QUIT:
        {
            event->type = EventType_Quit;
            break;
        }
        case SDL_KEYDOWN:
        {
            event->type = EventType_Key;
            event->key = TranslateKey(event);
            event->modifiers = event->raw.key.keysym.mod;
            break;
        }
        case SDL_TEXTINPUT:
        {
            event->type = EventType_Text;
            strcpy(event->text, event->raw.text.text);
            break;
        }
        case SDL_MOUSEMOTION:
        {
            event->type = EventType_MouseMove;
            event->x = event->raw.motion.x;
            event->y = event->raw.motion.y;
            break;
        }
        case SDL_MOUSEBUTTONDOWN:
        {
            event->type = EventType_MouseDown;
            event->x = event->raw.button.x;
            event->y = event->raw.button.y;
            event->mouseButton = TranslateMouseButton(event);
            break;
        }
        case SDL_MOUSEBUTTONUP:
        {
            event->type = EventType_MouseUp;
            event->x = event->raw.button.x;
            event->y = event->raw.button.y;
            event->mouseButton = TranslateMouseButton(event);
            break;
        }
        case SDL_MOUSEWHEEL:
        {
            event->type = EventType_MouseScroll;
            // todo: how do scroll events work?
            break;
        }
        default:
        {
            event->type = EventType_None;
            break;
        }
    }

    return out;
}