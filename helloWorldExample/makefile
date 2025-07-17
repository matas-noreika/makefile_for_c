#C compiler
CC= gcc
#C++ compiler
CXX= g++

#C compiler flags
CCFLAGS= -c
#C++ compiler flags
CXXFLAGS= 
#pre-processor flags used between C/C++
CPPFLAGS= 

#libraries to link
LIBS= 
#add prefix to all libs
LDLIBS=$(addprefix -l, $(LIBS))

#binary directory
LOCALBIN= bin
#object file directory
LOCALOBJ= obj
#dependency file directory
LOCALDEP= dep

#retrieve all source files (replace extension based on target language)
SRCS=$(wildcard *.c)
#retrieve all object files from sources
OBJS=$(SRCS:%.c=%.o)
#retrieve all dep files
DEPS=$(SRCS:%.c=%.d)
#build targets to for executables (make sure to prefix with $(LOCALBIN) and add .exe extension)
TARGET=$(LOCALBIN)/helloWorld.exe 

#decleration of phony rules
.PHONY : all clean
#decleration to keep object files post compilation of executable
.PRECIOUS: $(LOCALOBJ)/%.o

#rule to build all executables
all:$(TARGET)

#rule to remove all compiled files
clean:
	-rm -f $(LOCALBIN)/*.exe 2> /dev/null
	-rm -f $(LOCALOBJ)/*.o 2> /dev/null
	-rm -f $(LOCALDEP)/*.d 2> /dev/null

#include all the dependeny files
-include $(DEPS)

#static pattern rule to make object files from source
$(LOCALOBJ)/%.o:src/%.c
	$(CC) $(CCFLAGS) -MMD $< -o $@
	mv $(LOCALOBJ)/$(*F).d $(LOCALDEP)/$(*F).d

#static pattern rule to make executables from object files
$(LOCALBIN)/%.exe:$(LOCALOBJ)/%.o
	$(CC) $< -o $@

