#!/bin/bash
# Programmer: Matas Noreika Thu Jul 17 01:30:19 PM IST 2025
# Purpose: Bash script to generate a generic make file for a C/C++ project. Takes one arguement for the destination directory. Will default to PWD if argument is empty.

#variable decleration to make text of makefile more clear instead of one large string
compilerVar="#C compiler\nCC= gcc\n#C++ compiler\nCXX= g++\n" 
flagVar="#C compiler flags\nCCFLAGS= -c\n#C++ compiler flags\nCXXFLAGS= \n#pre-processor flags used between C/C++\nCPPFLAGS= \n"
linkerVar="#libraries to link\nLIBS= \n#add prefix to all libs\nLDLIBS=\$(addprefix -l, \$(LIBS))\n"
locationVar="#binary directory\nLOCALBIN= bin\n#object file directory\nLOCALOBJ= obj\n#dependency file directory\nLOCALDEP= dep\n"
variableVar="#retrieve all source files (replace extension based on target language)\nSRCS=\$(wildcard *.c)\n#retrieve all object files from sources\nOBJS=\$(SRCS:%.c=%.o)\n#retrieve all dep files\nDEPS=\$(SRCS:%.c=%.d)\n#build targets to for executables (make sure to prefix with \$(LOCALBIN) and add .exe extension)\nTARGET= \n"
phonyVar="#decleration of phony rules\n.PHONY : all clean\n#decleration to keep object files post compilation of executable\n.PRECIOUS: \$(LOCALOBJ)/%.o\n"
genericVar="#rule to build all executables\nall:\$(TARGET)\n\n#rule to remove all compiled files\nclean:\n\t-rm -f \$(LOCALBIN)/*.exe 2> /dev/null\n\t-rm -f \$(LOCALOBJ)/*.o 2> /dev/null\n\t-rm -f \$(LOCALDEP)/*.d 2> /dev/null\n"
depVar="#include all the dependeny files\n-include \$(DEPS)\n"
patternVar="#static pattern rule to make object files from source\n\$(LOCALOBJ)/%.o:src/%.c\n\t\$(CC) \$(CCFLAGS) -MMD \$< -o \$@\n\tmv \$(LOCALOBJ)/\$(*F).d \$(LOCALDEP)/\$(*F).d\n\n#static pattern rule to make executables from object files\n\$(LOCALBIN)/%.exe:\$(LOCALOBJ)/%.o\n\t\$(CC) \$< -o \$@\n"

# indicate to user the script is generating a makefile
echo "Generating makefile..."

#check if any argument was passed
if [[ ! -z $1 ]]; then
	echo "destination directory: $PWD/$1"
	touch $1/makefile
	echo -e "$compilerVar" >> $1/makefile
	echo -e "$flagVar" >> $1/makefile
	echo -e "$linkerVar" >> $1/makefile
	echo -e "$locationVar" >> $1/makefile
	echo -e "$variableVar" >> $1/makefile
	echo -e "$phonyVar" >> $1/makefile
	echo -e "$genericVar" >> $1/makefile
	echo -e "$depVar" >> $1/makefile
	echo -e "$patternVar" >> $1/makefile
else
	echo "destination directory: $PWD"
	touch makefile
	echo -e "$compilerVar" >> makefile
	echo -e "$flagVar" >> makefile
	echo -e "$linkerVar" >> makefile
	echo -e "$locationVar" >> makefile
	echo -e "$variableVar" >> makefile
	echo -e "$phonyVar" >> makefile
	echo -e "$genericVar" >> makefile
	echo -e "$depVar" >> makefile
	echo -e "$patternVar" >> makefile
fi

echo "makefile generated"
