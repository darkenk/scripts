# this one is important
set(CMAKE_SYSTEM_NAME Linux)
#this one not so much
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(CMAKE_LIBRARY_ARCHITECTURE arm-linux-gnueabihf)

# specify the cross compiler
set(CMAKE_C_COMPILER $ENV{HOME}/bin/gcc-linaro-4.9-2016.02-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc)
set(CMAKE_CXX_COMPILER $ENV{HOME}/bin/gcc-linaro-4.9-2016.02-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++)
set(CMAKE_SYSROOT ${CMAKE_CURRENT_LIST_DIR}/rootfs/)

set(CMAKE_EXE_LINKER_FLAGS "-Wl,-rpath-link,${CMAKE_SYSROOT}/lib/${CMAKE_LIBRARY_ARCHITECTURE}:${CMAKE_SYSROOT}/usr/lib/${CMAKE_LIBRARY_ARCHITECTURE}" CACHE INTERNAL "")
set(CMAKE_MODULE_LINKER_FLAGS "-Wl,-rpath-link,${CMAKE_SYSROOT}/lib/${CMAKE_LIBRARY_ARCHITECTURE}:${CMAKE_SYSROOT}/usr/lib/${CMAKE_LIBRARY_ARCHITECTURE}" CACHE INTERNAL "")

# where is the target environment
set(CMAKE_FIND_ROOT_PATH ${CMAKE_FIND_ROOT_PATH}
    ${CMAKE_SYSROOT})

# search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
