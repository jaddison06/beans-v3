.PHONY: codegen

all: codegen libraries

release: codegen-release libraries
	python codegen/fs_util.py rm_dir build/release
	python codegen/fs_util.py mkdir build/release
	python codegen/fs_util.py copy_dir build/native build/release/native
	python codegen/release_readme.py
	dart compile exe bin/beans.dart -o build/release/beans.exe

libraries: build/native\3rdparty\libe131/libe131.dll build/native\ui\SDL/libSDLDisplay.dll build/native\ui\SDL/libSDLEvent.dll build/native\ui\SDL/libSDLFont.dll

codegen:
	python codegen/main.py

codegen-release:
	python codegen/main.py --release

run: all
	dart run

run-release: release
	build/release/beans.exe

clean:
	python codegen/fs_util.py rm_dir build
	python codegen/fs_util.py rm_file native/c_codegen.h
	python codegen/fs_util.py rm_file bin/dart_codegen.dart
	python codegen/fs_util.py rm_file .cloc_exclude_list.txt

cloc:
	C:/Users/jjadd/Downloads/cloc-1.92.exe . --exclude-list=.cloc_exclude_list.txt

cloc-by-file:
	C:/Users/jjadd/Downloads/cloc-1.92.exe . --exclude-list=.cloc_exclude_list.txt --by-file

build/native\3rdparty\libe131/libe131.dll: native\3rdparty\libe131\e131.c
	python codegen/fs_util.py mkdir build/native\3rdparty\libe131
	gcc -shared -o build/native\3rdparty\libe131/libe131.dll -fPIC -Inative native\3rdparty\libe131\e131.c

build/native\ui\SDL/libSDLDisplay.dll: native\ui\SDL\SDLDisplay.c
	python codegen/fs_util.py mkdir build/native\ui\SDL
	gcc -shared -o build/native\ui\SDL/libSDLDisplay.dll -fPIC -Inative native\ui\SDL\SDLDisplay.c -lSDL2 -lSDL2_ttf

build/native\ui\SDL/libSDLEvent.dll: native\ui\SDL\SDLEvent.c
	python codegen/fs_util.py mkdir build/native\ui\SDL
	gcc -shared -o build/native\ui\SDL/libSDLEvent.dll -fPIC -Inative native\ui\SDL\SDLEvent.c -lSDL2

build/native\ui\SDL/libSDLFont.dll: native\ui\SDL\SDLFont.c
	python codegen/fs_util.py mkdir build/native\ui\SDL
	gcc -shared -o build/native\ui\SDL/libSDLFont.dll -fPIC -Inative native\ui\SDL\SDLFont.c -lSDL2_ttf

