find_package(dk_utils QUIET CONFIG HINTS ${CMAKE_CURRENT_BINARY_DIR}/dk_utils)

if (NOT dk_utils_FOUND)
    message(STATUS "Downloading dk_utils")
    execute_process(COMMAND git clone https://github.com/darkenk/dk_utils.git
                    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
    find_package(dk_utils CONFIG HINTS ${CMAKE_CURRENT_BINARY_DIR}/dk_utils REQUIRED)
endif()
