from codegen_types import *
from banner import *
from platform import system, uname

def generate_enum(enum: CodegenEnum) -> str:
    out = f'typedef enum {{\n'

    for i, val in enumerate(enum.values):
        out += f'    {enum.name}_{val.name} = {i},\n'
    
    out += f'}} {enum.name};\n\n'

    return out

def codegen(files: list[ParsedGenFile]) -> str:
    out = \
'''#ifndef C_CODEGEN_H
#define C_CODEGEN_H

// old-style booleans to ensure Dart compatibility
typedef char BEANS_BOOL;
#define TRUE 1
#define FALSE 0

'''

    match system():
        case 'Windows': out += '#define BEANS_WINDOWS\n'
        case 'Linux':   out += '#define BEANS_LINUX\n'
        case 'Darwin':  out += '#define BEANS_MACOS\n'
    
    if system() == 'Linux' and 'microsoft' in uname()[3].lower():
        out += '#define BEANS_WSL\n'
    
    out += '\n'

    for file in files:
        out += banner(file.name)
        for enum in file.enums:
            out += generate_enum(enum)
    
    out += '#endif // C_CODEGEN_H'

    return out