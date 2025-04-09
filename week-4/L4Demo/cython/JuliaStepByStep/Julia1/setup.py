from setuptools import Extension, setup
from Cython.Build import cythonize

extensions = [Extension("julia1", ["julia_cython.pyx"])]
                            
setup(
      name="Julia with Cython 1",
      ext_modules = cythonize(extensions)
)


