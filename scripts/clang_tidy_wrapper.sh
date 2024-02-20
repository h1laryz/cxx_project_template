#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
ROOT_PROJECT_DIR="${SCRIPT_DIR}/../"

# Path to the global ignore list
IGNORE_FILE="${ROOT_PROJECT_DIR}/.clang-tidy-ignore"

# Read exclusions and format them for grep -v
GREP_EXCLUDES=$(awk '{print "-e " $0}' $IGNORE_FILE | tr '\n' ' ')

# The actual clang-tidy command
CLANG_TIDY_CMD="clang-tidy"

# Check if --fix or --fix-errors was passed
if [[ " $* " == *" --fix "* ]]; then
    CLANG_TIDY_CMD+=" --fix"
fi

if [[ " $* " == *" --fix-errors "* ]]; then
    CLANG_TIDY_CMD+=" --fix-errors"
fi

# If --fix or --fix-errors was specified, run clang-tidy with the specified fix option for all files except those ignored
find $ROOT_PROJECT_DIR \( -name '*.cpp' -o -name '*.h' \) -print | grep -v $GREP_EXCLUDES | while read file; do
    $CLANG_TIDY_CMD $file -p $ROOT_PROJECT_DIR
done

exit $?