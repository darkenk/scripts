cmake_minimum_required(VERSION 3.4.1)
set (CMAKE_CXX_STANDARD 11)

set(CMAKE_MODULE_PATH
    ${CMAKE_MODULE_PATH}
    ${CMAKE_CURRENT_LIST_DIR}/cmake/modules
)
find_package(dk_utils REQUIRED)

add_subdirectory(src)
add_subdirectory(test)
