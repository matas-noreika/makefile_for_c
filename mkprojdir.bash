#!/bin/bash

# Programmer: Matas Noreika Thu Jul 17 01:16:17 PM IST 2025
# Purpose: Bash script to generate a C/C++ project directory. The script takes one argument which is used to name the root directory. The root directory will be placed in PWD.
# Ensure script has execution premissions. Can be set using sudo chmod +x mkprojdir.bash

# General comment to notify the user where the project directory will be made
echo -e "\e[32mMaking $1 in $PWD \e[m"
# the following will create root directory and all sub-directories
mkdir $1
mkdir $1/src
mkdir $1/obj
mkdir $1/bin
mkdir $1/include
mkdir $1/dep

#check if mkmakefile script exists 
if [[ -e mkmakefile.bash ]]; then
	echo -e "\e[32mmkmakefile script exists: Generating makefile in project directory\e[m"
	#we execute the mkmakefile script
	./mkmakefile.bash $1
else
	echo -e "\e[31mmkmkaefile script does not exist: not generating makefile\e[m"
fi
