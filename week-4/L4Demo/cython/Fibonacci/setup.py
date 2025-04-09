from setuptools import Extension, setup
from Cython.Build import cythonize

extensions = [Extension("fib", ["fib.pyx"])]
                                                         
setup(
      name="Fibonacci",
      ext_modules = cythonize(extensions)
)

