from platform import system

def shared_library_extension() -> str:
    if system() == 'Linux': return '.so'
    elif system() == 'Darwin': return '.dylib'
    elif system() == 'Windows': return '.dll'
    else: raise ValueError('Couldn\'t get shared library extension - unknown platform')

def executable_extension() -> str:
    if system() == 'Windows': return '.exe'
    return ''