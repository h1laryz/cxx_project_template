# cxx_project_template

Template of a Modern C++ application with cmake, clang-tidy, clang-format, conan.


## Download and Build

To create your own application based on this template follow the following steps:

1. Press the green "Use this template button" at the top of this github page
2. Clone the service `git clone your-service-repo && cd your-service-repo`
3. Give a propper name to your service and replace all the occurences of "cxx_project_template" string with that name
   (could be done via `find . -not -path ".git/*" -not -path './build_*' -type f | xargs sed -i 's/cxx_project_template/YOUR_APPLICATION_NAME/g'`).


## Makefile

Makefile contains typicaly useful targets for development:

* `make build-debug` - debug build of the service with all the assertions and sanitizers enabled
* `make build-release` - release build of the service with LTO
* `make test-debug` - does a `make build-debug` and runs all the tests on the result
* `make test-release` - does a `make build-release` and runs all the tests on the result
* `make format` - run clang-format checks for all the C++ sources
* `make format-fix` - run clang-format fixes for all the C++ sources
* `make clean` - cleans the object files
* `make dist-clean` - clean all, including the CMake cached configurations
* `make conan-setup` - does a installation of all conan dependencies (automatically runs during `make build-debug` or `make build-release`)
* `make lint` - does a clang-tidy checks
* `make lint-fix` does a clang-tidy fixes

Edit `Makefile.local` to change the default configuration and build options.
