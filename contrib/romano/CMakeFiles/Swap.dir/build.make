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

# Include any dependencies generated for this target.
include contrib/romano/CMakeFiles/Swap.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include contrib/romano/CMakeFiles/Swap.dir/compiler_depend.make

# Include the progress variables for this target.
include contrib/romano/CMakeFiles/Swap.dir/progress.make

# Include the compile flags for this target's objects.
include contrib/romano/CMakeFiles/Swap.dir/flags.make

contrib/romano/CMakeFiles/Swap.dir/src/Backends/MCMoves/Swap.cpp.o: contrib/romano/CMakeFiles/Swap.dir/flags.make
contrib/romano/CMakeFiles/Swap.dir/src/Backends/MCMoves/Swap.cpp.o: contrib/romano/src/Backends/MCMoves/Swap.cpp
contrib/romano/CMakeFiles/Swap.dir/src/Backends/MCMoves/Swap.cpp.o: contrib/romano/CMakeFiles/Swap.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/hyakuzukamaya/Desktop/lab/oxDNA/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object contrib/romano/CMakeFiles/Swap.dir/src/Backends/MCMoves/Swap.cpp.o"
	cd /Users/hyakuzukamaya/Desktop/lab/oxDNA/contrib/romano && /Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT contrib/romano/CMakeFiles/Swap.dir/src/Backends/MCMoves/Swap.cpp.o -MF CMakeFiles/Swap.dir/src/Backends/MCMoves/Swap.cpp.o.d -o CMakeFiles/Swap.dir/src/Backends/MCMoves/Swap.cpp.o -c /Users/hyakuzukamaya/Desktop/lab/oxDNA/contrib/romano/src/Backends/MCMoves/Swap.cpp

contrib/romano/CMakeFiles/Swap.dir/src/Backends/MCMoves/Swap.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/Swap.dir/src/Backends/MCMoves/Swap.cpp.i"
	cd /Users/hyakuzukamaya/Desktop/lab/oxDNA/contrib/romano && /Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/hyakuzukamaya/Desktop/lab/oxDNA/contrib/romano/src/Backends/MCMoves/Swap.cpp > CMakeFiles/Swap.dir/src/Backends/MCMoves/Swap.cpp.i

contrib/romano/CMakeFiles/Swap.dir/src/Backends/MCMoves/Swap.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/Swap.dir/src/Backends/MCMoves/Swap.cpp.s"
	cd /Users/hyakuzukamaya/Desktop/lab/oxDNA/contrib/romano && /Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/hyakuzukamaya/Desktop/lab/oxDNA/contrib/romano/src/Backends/MCMoves/Swap.cpp -o CMakeFiles/Swap.dir/src/Backends/MCMoves/Swap.cpp.s

# Object files for target Swap
Swap_OBJECTS = \
"CMakeFiles/Swap.dir/src/Backends/MCMoves/Swap.cpp.o"

# External object files for target Swap
Swap_EXTERNAL_OBJECTS =

contrib/romano/Swap.dylib: contrib/romano/CMakeFiles/Swap.dir/src/Backends/MCMoves/Swap.cpp.o
contrib/romano/Swap.dylib: contrib/romano/CMakeFiles/Swap.dir/build.make
contrib/romano/Swap.dylib: contrib/romano/CMakeFiles/Swap.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/hyakuzukamaya/Desktop/lab/oxDNA/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX shared library Swap.dylib"
	cd /Users/hyakuzukamaya/Desktop/lab/oxDNA/contrib/romano && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/Swap.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
contrib/romano/CMakeFiles/Swap.dir/build: contrib/romano/Swap.dylib
.PHONY : contrib/romano/CMakeFiles/Swap.dir/build

contrib/romano/CMakeFiles/Swap.dir/clean:
	cd /Users/hyakuzukamaya/Desktop/lab/oxDNA/contrib/romano && $(CMAKE_COMMAND) -P CMakeFiles/Swap.dir/cmake_clean.cmake
.PHONY : contrib/romano/CMakeFiles/Swap.dir/clean

contrib/romano/CMakeFiles/Swap.dir/depend:
	cd /Users/hyakuzukamaya/Desktop/lab/oxDNA && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/hyakuzukamaya/Desktop/lab/oxDNA /Users/hyakuzukamaya/Desktop/lab/oxDNA/contrib/romano /Users/hyakuzukamaya/Desktop/lab/oxDNA /Users/hyakuzukamaya/Desktop/lab/oxDNA/contrib/romano /Users/hyakuzukamaya/Desktop/lab/oxDNA/contrib/romano/CMakeFiles/Swap.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : contrib/romano/CMakeFiles/Swap.dir/depend
