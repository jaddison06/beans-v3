from platform import system, machine

def main():
    with open('build/release/README.md', 'wt') as fh:
        fh.write(f'# beans\n\nBeans for {system()}-{machine()}\n')

if __name__ == '__main__': main()