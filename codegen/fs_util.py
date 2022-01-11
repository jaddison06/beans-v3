from sys import argv
import os.path as path
import os
from shutil import rmtree, copytree

def main():
    match argv[1]:
        case 'rm_file':
            if path.exists(argv[2]):
                os.remove(argv[2])
        case 'rm_dir':
            if path.exists(argv[2]):
                rmtree(argv[2])
        case 'mkdir':
            if not path.exists(argv[2]):
                os.makedirs(argv[2])
        case 'copy_dir':
            if path.exists(argv[3]): rmtree(argv[3])
            copytree(argv[2], argv[3])

if __name__ == '__main__': main()