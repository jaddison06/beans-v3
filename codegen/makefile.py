from config import *
from codegen_types import *
import os.path as path
from shared_library_extension import *

def generate_makefile_item(target: str, dependencies: list[str], commands: list[str]) -> str:
    out = f'{target}:'
    for dependency in dependencies: out += f' {dependency}'
    for command in commands: out += f'\n	{command}'
    out += '\n\n'
    return out

UTIL = f'{get_config(ConfigField.python)} codegen/fs_util.py'
def rm_file(fname: str) -> str: return f'{UTIL} rm_file {fname}'
def rm_dir(dirname: str) -> str: return f'{UTIL} rm_dir {dirname}'
def mkdir(dirname: str) -> str: return f'{UTIL} mkdir {dirname}'
def copy_dir(from_: str, to: str) -> str: return f'{UTIL} copy_dir {from_} {to}'

def codegen(files: list[ParsedGenFile]) -> str:
    out = ''

    libs: list[str] = []
    for file in files:
        if not file.has_code(): continue

        lib_path = f'build/{file.libpath_no_ext()}'
        lib_name = f'{lib_path}{shared_library_extension()}'

        link_libs: list[str] = []

        for annotation in file.annotations:
            if annotation.name == 'LinkWithLib':
                link_libs.append(annotation.args[0])

        command = f'{get_config(ConfigField.gcc)} -shared -o {lib_name} -fPIC -I{get_config(ConfigField.c_source_dir)} {file.name_no_ext()}.c'
        for lib in link_libs:
            command += f' -l{lib}'

        # todo: #included dependencies
        out += generate_makefile_item(
            lib_name,
            [
                f'{file.name_no_ext()}.c'
            ],
            [
                mkdir(path.dirname(lib_name)),
                command
            ]
        )

        libs.append(lib_name)
    
    
    # there's a directory called codegen, so we have to use .PHONY to
    # tell make to use the rule called 'codegen' instead of the directory
    out = '.PHONY: codegen\n\n' \
      + generate_makefile_item(
        'all',
        ['codegen', 'libraries'], # codegen MUST be before libraries because the C files might need to include c_codegen.h
        []
    ) + generate_makefile_item(
        'release',
        [
            'codegen-release', 'libraries'
        ],
        [
            rm_dir('build/release'),
            mkdir('build/release'),
            copy_dir(f'build/{get_config(ConfigField.c_source_dir)}', f'build/release/{get_config(ConfigField.c_source_dir)}'),
            'dart compile kernel bin/beans.dart -o build/release/beans.dill'
        ]
    ) + generate_makefile_item(
        'libraries',
        libs,
        []
    ) + generate_makefile_item(
        'codegen',
        [],
        [
            f'{get_config(ConfigField.python)} codegen/main.py'
        ]
    ) + generate_makefile_item(
        'codegen-release',
        [],
        [
            f'{get_config(ConfigField.python)} codegen/main.py --release'
        ]
    ) + generate_makefile_item(
        'run',
        [
            'all'
        ],
        [
            'dart run'
            #'dart run --enable-vm-service'
        ]
    ) + generate_makefile_item(
        'clean',
        [],
        [
            rm_dir('build'),
            rm_file(get_config(ConfigField.c_output_path)),
            rm_file(get_config(ConfigField.dart_output_path)),
            rm_file(get_config(ConfigField.cloc_exclude_list_path))
        ]
    ) + (
        ''.join([generate_makefile_item(
            # The `cloc` command-line utility MUST be installed, or this won't work.
            # https://github.com/AlDanial/cloc
            'cloc',
            [],
            [
                # exclude generated files so cloc actually shows real results
                f'{get_config(ConfigField.cloc)} . --exclude-list={get_config(ConfigField.cloc_exclude_list_path)}'
            ]
        ) + generate_makefile_item(
            'cloc-by-file',
            [],
            [
                f'{get_config(ConfigField.cloc)} . --exclude-list={get_config(ConfigField.cloc_exclude_list_path)} --by-file'
            ]
        )]) if get_config(ConfigField.use_cloc) == 'True' else ''
    ) + out

    return out