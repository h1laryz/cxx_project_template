cmake_minimum_required(VERSION 3.28.3)

find_program(CLANG_TIDY_EXECUTABLE NAMES "clang-tidy")

project(cxx_project_template CXX)

find_package(fmt REQUIRED)

file(GLOB_RECURSE SOURCES src/*.cpp)

add_executable(${PROJECT_NAME} ${SOURCES})
target_include_directories(${PROJECT_NAME} PRIVATE include)
target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_20)
target_compile_options(${PROJECT_NAME} PRIVATE -isystem -Wall -Wextra -Wpedantic -Werror)
target_link_libraries(${PROJECT_NAME} PRIVATE fmt::fmt)
set_target_properties(
    ${PROJECT_NAME} PROPERTIES
    CXX_CLANG_TIDY "${CLANG_TIDY_EXECUTABLE}"
)
