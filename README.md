# Introduction
While studying computer engineering I was taught by my lecturers in my programming modules of the tool gnu make. In the many c and c++ projects I worked in, I tried to incorporate the make tool. The following content will showcase my personal experience with make and the features I found very interesting. **This is not a tutorial to teach you the correct way to write makefiles** instead I want it to serve the purpose in simplifying and expanding the scope of the tool to new users of make.
## What is gnu make
make is a build tool that automates the process of generating compiled files from source files. This is especially needed in larger projects that involve many dependencies and possibly external libraries. Make works of a simple file that describes *rules* which have specific requirements (prerequisites). You can think of make rules as a recipes, they require ingredients to make a finish product. The make rules also include the process by using an indentation to describe how to achieve the target using the ingredients. The following is an example of a make rule:
`helloWorld.exe : helloWorld.c
    gcc helloWorld.c -o helloWorld.exe`

