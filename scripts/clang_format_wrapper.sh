#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

CLANG_FORMAT_COMMAND=clang-format

if [ -n "$2" ]; then
   CLANG_FORMAT_COMMAND="$2"
fi

case "$1" in
    "--check")
        find "${SCRIPT_DIR}/../" -regex '.*\.\(cpp\|hpp\|h\|cc\|cxx\)' ! -path "*build*" ! -path "third_party" -exec ${CLANG_FORMAT_COMMAND} -style=file --dry-run --Werror {} +;;
    "--format")
        find "${SCRIPT_DIR}/../" -regex '.*\.\(cpp\|hpp\|h\|cc\|cxx\)' ! -path "*build*" ! -path "third_party" -exec ${CLANG_FORMAT_COMMAND} -style=file -i {} +
esac
