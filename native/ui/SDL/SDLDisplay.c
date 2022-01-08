#include <SDL2/SDL.h>
#include <stdio.h>
#include "native/c_codegen.h"

typedef struct
{
    SDL_Window* window;
    SDL_Renderer* renderer;

    SDLInitErrorCode errorCode;
} SDLDisplay;

SDLInitErrorCode SDGetErrorCode(SDLDisplay* self)
{
    return self->errorCode;
}

SDLDisplay* LogSDLError(SDLDisplay* self, SDLInitErrorCode errorCode)
{
    printf("SDL error: %s\n", SDL_GetError());
    if (self->window != NULL)
        SDL_DestroyWindow(self->window);

    if (self->renderer != NULL)
        SDL_DestroyRenderer(self->renderer);
    
    SDL_Quit();

    self->errorCode = errorCode;
    return self;
}

SDLDisplay* SDInit(const char* title)
{
    SDLDisplay* out = malloc(sizeof(SDLDisplay));

    if (SDL_Init(SDL_INIT_VIDEO) != 0)
        return LogSDLError(out, SDLInitErrorCode_InitVideo_Fail);
    
    out->window = SDL_CreateWindow(title, 0, 0, 100, 100, SDL_WINDOW_FULLSCREEN_DESKTOP);
    if (out->window == NULL)
        return LogSDLError(out, SDLInitErrorCode_CreateWindow_Fail);

    out->renderer = SDL_CreateRenderer(out->window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
    if (out->renderer == NULL)
        return LogSDLError(out, SDLInitErrorCode_CreateRenderer_Fail);
    
    out->errorCode = SDLInitErrorCode_Success;
    return out;
}

void SDDestroy(SDLDisplay* self)
{
    SDL_DestroyRenderer(self->renderer);
    SDL_DestroyWindow(self->window);
    SDL_Quit();
    free(self);
}

void SDSetColour(SDLDisplay* self, int r, int g, int b, int a)
{
    SDL_SetRenderDrawColor(self->renderer, r, g, b, a);
}

void SDGetSize(SDLDisplay* self, int* w, int* h)
{/*
    SDL_DisplayMode dm;
    SDL_GetDesktopDisplayMode(0, &dm);
    *w = dm.w;
    *h = dm.h;
*/
    SDL_GetWindowSize(self->window, w, h);
}

void SDFlush(SDLDisplay* self)
{
    SDL_RenderPresent(self->renderer);
    SDSetColour(self, 0, 0, 0, 255);
    SDL_RenderClear(self->renderer);
}

void SDDrawPoint(SDLDisplay* self, int x, int y, int r, int g, int b, int a)
{
    SDSetColour(self, r, g, b, a);
    SDL_RenderDrawPoint(self->renderer, x, y);
}

void SDDrawLine(SDLDisplay* self, int x1, int y1, int x2, int y2, int r, int g, int b, int a)
{
    SDSetColour(self, r, g, b, a);
    SDL_RenderDrawLine(self->renderer, x1, y1, x2, y2);
}

void SDDrawRect(SDLDisplay* self, int x, int y, int w, int h, int r, int g, int b, int a)
{
    SDL_Rect rect = {x, y, w, h};
    SDSetColour(self, r, g, b, a);
    SDL_RenderDrawRect(self->renderer, &rect);
}

void SDFillRect(SDLDisplay* self, int x, int y, int w, int h, int r, int g, int b, int a)
{
    SDL_Rect rect = {x, y, w, h};
    SDSetColour(self, r, g, b, a);
    SDL_RenderFillRect(self->renderer, &rect);
}