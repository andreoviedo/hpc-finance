from setuptools import Extension, setup
from Cython.Build import cythonize
import numpy

extensions = [Extension("julia3", ["julia_calc.pyx"],
                               include_dirs=[numpy.get_include()],
                               extra_compile_args=['-fopenmp'],
                               extra_link_args=['-lgomp'])]
setup(
      name="Julia with OpenMP",
      ext_modules = cythonize(extensions)
)
