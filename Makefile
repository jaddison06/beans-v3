.PHONY: codegen

all: codegen libraries

libraries: build/native\3rdparty\libe131/libe131.dll

codegen:
	python codegen/main.py

run: all
	dart run

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
	gcc -shared -o build/native\3rdparty\libe131/libe131.dll -fPIC -I. native\3rdparty\libe131\e131.c -lws2_32

