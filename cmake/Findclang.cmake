# Copyright (c) 2016 Andrew Kelley
# This file is MIT licensed.
# See http://opensource.org/licenses/MIT

# CLANG_FOUND
# CLANG_INCLUDE_DIRS
# CLANG_LIBRARIES
# CLANG_LIBDIRS

if(MSVC)
  find_package(CLANG REQUIRED CONFIG)

  set(CLANG_LIBRARIES
      clangFrontend
      clangDriver
      clangSerialization
      clangSema
      clangAnalysis
      clangAST
      clangParse
      clangSema
      clangBasic
      clangEdit
      clangLex
  )

else()
  find_path(CLANG_INCLUDE_DIRS NAMES clang/Frontend/ASTUnit.h
      PATHS
          /usr/lib/llvm/7/include
          /usr/lib/llvm-7/include
          /usr/lib/llvm-7.0/include
          /usr/local/llvm70/include
          /mingw64/include)

      macro(FIND_AND_ADD_CLANG_LIB _libname_)
      string(TOUPPER ${_libname_} _prettylibname_)
      find_library(CLANG_${_prettylibname_}_LIB NAMES ${_libname_}
          PATHS
              ${CLANG_LIBDIRS}
              /usr/lib/llvm/7/lib
              /usr/lib/llvm-7/lib
              /usr/lib/llvm-7.0/lib
              /usr/local/llvm70/lib
              /mingw64/lib
              /c/msys64/mingw64/lib
              c:\\msys64\\mingw64\\lib)
      if(CLANG_${_prettylibname_}_LIB)
          set(CLANG_LIBRARIES ${CLANG_LIBRARIES} ${CLANG_${_prettylibname_}_LIB})
      endif()
  endmacro(FIND_AND_ADD_CLANG_LIB)

  FIND_AND_ADD_CLANG_LIB(clangFrontend)
  FIND_AND_ADD_CLANG_LIB(clangDriver)
  FIND_AND_ADD_CLANG_LIB(clangSerialization)
  FIND_AND_ADD_CLANG_LIB(clangSema)
  FIND_AND_ADD_CLANG_LIB(clangAnalysis)
  FIND_AND_ADD_CLANG_LIB(clangAST)
  FIND_AND_ADD_CLANG_LIB(clangParse)
  FIND_AND_ADD_CLANG_LIB(clangSema)
  FIND_AND_ADD_CLANG_LIB(clangBasic)
  FIND_AND_ADD_CLANG_LIB(clangEdit)
  FIND_AND_ADD_CLANG_LIB(clangLex)
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(CLANG DEFAULT_MSG CLANG_LIBRARIES CLANG_INCLUDE_DIRS)

mark_as_advanced(CLANG_INCLUDE_DIRS CLANG_LIBRARIES CLANG_LIBDIRS)
