from os.path import dirname, basename, isfile, join
import glob
modules = glob.glob(join(dirname(__file__), "*.py"))
__all__ = [basename(f)[:-3] for f in modules if isfile(f) and not f.endswith('__init__.py')]


# def setup():
#     print(__all__)
#     try:
#         for func in __all__:
#             func.__doc__ = eval(f"DOCS_{func}")
#     except NameError as err: 
#         print(err)
#     except:
#         raise

# if __name__ == "__main__":
#     setup()