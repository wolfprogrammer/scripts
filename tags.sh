#!/bin/bash
# 
# Generate tags and C scope database
# Usage:  ./tags directory
#
#
# Find the files to create the data base
find ./ -name "*.C" -o -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.H" -o -name "*.hpp" > cscope.files

# Create cscope database
cscope -q -R -b -i cscope.files  &

# Create ctags database
ctags . -R   &

