try:
    from termcolor import colored
except ImportError:
    def colored(text: str, *args, **kwargs) -> str:
        return text