# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.26

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /Applications/CMake.app/Contents/bin/cmake

# The command to remove a file.
RM = /Applications/CMake.app/Contents/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/hyakuzukamaya/Desktop/lab/oxDNA

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/hyakuzukamaya/Desktop/lab/oxDNA

# Utility rule file for randisi.

# Include any custom commands dependencies for this target.
include contrib/randisi/CMakeFiles/randisi.dir/compiler_depend.make

# Include the progress variables for this target.
include contrib/randisi/CMakeFiles/randisi.dir/progress.make

contrib/randisi/CMakeFiles/randisi: contrib/randisi/DNA2ModInteraction.dylib

randisi: contrib/randisi/CMakeFiles/randisi
randisi: contrib/randisi/CMakeFiles/randisi.dir/build.make
.PHONY : randisi

# Rule to build all files generated by this target.
contrib/randisi/CMakeFiles/randisi.dir/build: randisi
.PHONY : contrib/randisi/CMakeFiles/randisi.dir/build

contrib/randisi/CMakeFiles/randisi.dir/clean:
	cd /Users/hyakuzukamaya/Desktop/lab/oxDNA/contrib/randisi && $(CMAKE_COMMAND) -P CMakeFiles/randisi.dir/cmake_clean.cmake
.PHONY : contrib/randisi/CMakeFiles/randisi.dir/clean

contrib/randisi/CMakeFiles/randisi.dir/depend:
	cd /Users/hyakuzukamaya/Desktop/lab/oxDNA && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/hyakuzukamaya/Desktop/lab/oxDNA /Users/hyakuzukamaya/Desktop/lab/oxDNA/contrib/randisi /Users/hyakuzukamaya/Desktop/lab/oxDNA /Users/hyakuzukamaya/Desktop/lab/oxDNA/contrib/randisi /Users/hyakuzukamaya/Desktop/lab/oxDNA/contrib/randisi/CMakeFiles/randisi.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : contrib/randisi/CMakeFiles/randisi.dir/depend

