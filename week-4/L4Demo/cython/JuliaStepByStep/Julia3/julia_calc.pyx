# -*- coding: utf-8 -*-

from cython.parallel import prange
import numpy as np

def calculate_z(int maxiter, double complex[:] zs, double complex[:] cs):
    """Calculate output list using Julia update rule"""
    cdef unsigned int i, n
    cdef double complex z, c
    cdef int[:] output = np.empty(len(zs), dtype=np.int32)
    length_zs = len(zs)
    with nogil:
        for i in prange(length_zs, schedule="static"):
            z = zs[i]
            c = cs[i]
            output[i] = 0
            while output[i] < maxiter and (z.real*z.real + z.imag * z.imag < 4):
                z = z * z + c
                output[i] += 1
    return output
