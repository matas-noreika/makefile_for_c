# Introduction
While studying computer engineering I was taught by my lecturers in my programming modules of the tool gnu make. In the many c and c++ projects I worked in, I tried to incorporate the make tool. The following content will showcase my personal experience with make and the features I found very interesting. **This is not a tutorial to teach you the correct way to write makefiles** instead I want it to serve the purpose in simplifying and expanding the scope of the tool to new users of make.
## What is gnu make
make is a build tool that automates the process of generating compiled files from source files. This is especially needed in larger projects that involve many dependencies and possibly external libraries. Make works of a simple file that describes *rules* which have specific requirements (prerequisites). You can think of make rules as a recipes, they require ingredients to make a finish product. The make rules also include the process by using an indentation to describe how to achieve the target using the ingredients. The following is an example of a make rule:
```
helloWorld.exe : helloWorld.c
    gcc helloWorld.c -o helloWorld.exe
```
## Variables
Imagine having a long makefile full of different rules to build desired targets and now you swapped your compiler from gcc to g++. You can go through everything again and change all instances of gcc to g++ or you can save yourself time and create a variable for your compiler. Say we are writing a c program. The convention would be to call the c compiler variable CC. Take another example where your repeatedly use the same compiler flags like `-c -O3` we can take these two flags and set our variable `CFLAGS= -c -O3`. this way we add or remove similar instances of the same flags with ease.

Decleration of variables can be done in two ways using `=` or `:=`. the = operator allows the variable to have a recursive definition which essentially means if it uses some function it will redefine itself whilst `:=` will only assign on initial call without calling any functions internally. I have not yet experienced a major difference but it is good to point out.
## Special variables
Make has some fancy variables that make simplifing the makefile even more. The ones I frequently use are `$<` and `$@`.
* `$<` is the variable to insert the name of the first source for the rule `$^` is similar except takes all sources and inserts in place.
* `$@` is the variable to insert the name of the target of the rule.
## General make rules
You may have now developed some makefiles and noticed its quite annoying having to essentially copy and paste the same rule with different target and source names. Well you would be happy to know that make has a handy feature call static pattern rules. Take the example two source files called helloWorld.c and helloWorld2.c. Without static pattern rules you would have the following makefile:
```
helloWorld.exe : helloWorld.c
    $(CC) $(CFLAGS) $< -o $@
helloWorld2.exe : helloWorld2.c
    $(CC) $(CFLAGS) $< -o $@
```
You can see in the above example the two rules are nearly identical. The static pattern rule now comes in use, where we have two make rules we can condense into one.
```
%.exe : %.c
    $(CC) $(CFLAGS) $< -o $@
```
The two examples are performing the same task except the second example using the static pattern rule reduces the complexity of the makefile. In the static pattern rule `%` refers to the name of the current build target name say if we have helloWorld then then the `%` will be replaced with helloWorld.
## Special functions
Make allows for more advanced features like selecting, replacing, prefixing and etc. This is incredibly useful if you have multiple source files and do not want to write all their names into a variable say SRC.
* wildcard allows for the selection of multiple files based on extension or specific string pattern. The following example will show how to select all the source .c files in current directory:
`SRC= $(wildcard *.c)`
* patsubst is another useful tool that can be written in two ways. Take the example we used above to retrieve all source files, say we wanted to get the names of all the file removing the extension or even replacing to .o.
```
SRC= $(wildcard *.c)
OBJ= $(patsubst %.c, %.o, $(SRC))
```
The above example replaces all source files with .o extension and saves into OBJ variable. The example below is does the exact same task with a simpler format:
```
SRC= $(wildcard *.c)
OBJ= $(SRC:%.c=%.o)
```
* addprefix is useful in a case where you might need to link libraries like math for mac platform. addprefix works as the name implies it takes a list of names and adds a prefix to them see the example below how to save libraries to link with `-l` prefix:
```
LIBNAMES= math
LIBS= $(addprefix -l, $(LIBNAMES))
```
The outcome would be that LIBS will contain `-lmath`
## Special flags
Make has special flags you can assign to a recipe that can enable further control of the output.
* `-` is a flag used to ignore errors particularly useful in a clean rule where there is a possiblity the file does not exist. `-rm -f *.o 2> /dev/null`
* `@` is a flag used to disable the echo print of the instruction that is being executed useful for echo prints `@echo "Hi user"`
## .d files
This is probably one of my most favourite recent features I discovered about make. In some cases you may not be able to use the static pattern rule and need to write a rule for a particular target. gnu have made it quite simple to avoid that all together, using the `-MMD` compiler flag for gcc or g++ you can generate a .d file of the name of the output. If you check the contents of the file you would find that it generated a make rule for that source file. Using a similar approach like c headers we include the .d file in our makefile. From experience its best to include prior any static pattern rule declerations. This way you will have a make rule which has the correct required source files for target and since no explicit recipe is declared it will default to compile using the static pattern rule.
## Final notes
Make is an incredibly powerful tool and many people skip it to use other tools like cmake which essential generate a makefile as an end result. I will hopefully over sometime include revisions to this mini tutorial and will make available some bash scripts to auto generate a very generic makefile suitable for most projects assuming of course a similar file structure as mine. I hope if you find this useful that you would share with your peers or add issues to add additional points that I have missed.
