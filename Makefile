CMAKE_COMMON_FLAGS ?= -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
CMAKE_DEBUG_FLAGS ?= --preset conan-debug
CMAKE_RELEASE_FLAGS ?= --preset conan-release
CMAKE_OS_FLAGS ?=
NPROCS ?= $(shell nproc)
CLANG_FORMAT ?= clang-format

# NOTE: use Makefile.local for customization
-include Makefile.local

.PHONY: all
all: test-debug test-release

# Debug cmake configuration
build_debug/Makefile: conan-setup
	@mkdir -p build_debug
	@cd build_debug && \
      cmake -B . -DCMAKE_BUILD_TYPE=Debug $(CMAKE_COMMON_FLAGS) $(CMAKE_DEBUG_FLAGS) $(CMAKE_OS_FLAGS) $(CMAKE_OPTIONS) ..
	@rm -f compile_commands.json
	@ln -s build_debug/compile_commands.json compile_commands.json

# Release cmake configuration
build_release/Makefile: conan-setup
	@mkdir -p build_release
	@cd build_release && \
      cmake -B . -DCMAKE_BUILD_TYPE=Release $(CMAKE_COMMON_FLAGS) $(CMAKE_RELEASE_FLAGS) $(CMAKE_OS_FLAGS) $(CMAKE_OPTIONS) ..
	@rm -f compile_commands.json
	@ln -s build_release/compile_commands.json compile_commands.json

# Build using cmake
.PHONY: build-debug build-release
build-debug build-release: build-%: build_%/Makefile
	@cmake --build build_$* -j $(NPROCS) --target cxx_project_template

# Test
.PHONY: test-debug test-release
test-debug test-release: test-%: build-%
	@cd build_$* && ctest .

# Lint
.PHONY: lint
lint: build_debug/Makefile
	@./scripts/clang_tidy_wrapper.sh

.PHONY: lint-fix
lint-fix: build_debug/Makefile
	@./scripts/clang_tidy_wrapper.sh --fix --fix-errors

# Cleanup data
.PHONY: clean-debug clean-release
clean-debug clean-release: clean-%:
	cd build_$* && $(MAKE) clean

.PHONY: dist-clean
dist-clean:
	@rm -rf build_*

# Install
.PHONY: install-debug install-release
install-debug install-release: install-%: build-%
	@cd build_$* && \
		cmake --install . -v --component cxx_project_template

.PHONY: install
install: install-release

# Format the sources
.PHONY: format
format:
	@./scripts/clang_format_wrapper.sh --check

.PHONY: format-fix
format-fix:
	@./scripts/clang_format_wrapper.sh --format

.PHONY: conan-setup
conan-setup:
	@./scripts/conan_profile_creator.sh
	@conan install . --profile cxx_project_template --settings build_type=Debug --build=missing --profile:build=cxx_project_template --output-folder build_debug
	@conan install . --profile cxx_project_template --settings build_type=Release --build=missing --profile:build=cxx_project_template --output-folder build_release
