from setuptools import Extension, setup
from Cython.Build import cythonize

extensions = [Extension("helloworld", ["helloworld.pyx"])]
                                                         
setup(
      name="Hello World",
      ext_modules = cythonize(extensions)
)



