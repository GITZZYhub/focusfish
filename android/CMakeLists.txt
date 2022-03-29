cmake_minimum_required(VERSION 3.4.1)

add_library( native_string

             # Sets the library as a shared library.
             SHARED

             # Provides a relative path to your source file(s).
             ../native_string/ios/Classes/native_string.cpp )