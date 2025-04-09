from setuptools import Extension, setup
from Cython.Build import cythonize

extensions = [Extension("julia2", ["julia_cython.pyx"])]
                            
setup(
      name="Julia with Cython 2",
      ext_modules = cythonize(extensions)
)
