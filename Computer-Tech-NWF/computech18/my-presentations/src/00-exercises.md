title: Exercises
<!-- insert-file headers.md -->

## Exercise 1

Using the *gedit* editor (or the editor of your choice), write a program
that prints "Hello, World!" to the screen (stdout) when executed.
Name the source file "hello-world.\*" where '*' is the conventional
suffix (file extension) for the language.

Write it in one or more of the following languages:

- **Perl6**
- **Bash**
- **Python**
- **C**
- **PostScript**

Note that the first three are commonly referred to as *scripting*
languages), *C* is a *compiled* language, and *PostScript* is a
*markup* language.


## Exercise 2

Using either the command line (which uses the bash shell by default)
or one of the languages above, determine how many files are known to the system.

## Exercise 3

Using one of the scripting languages, write a script that will execute
the other programs (except the PostScript one).

## Solutions

Exercise 1: Write a program to show "Hello, World!"

**Perl 6**

~~~
$ # show source file contents
$ cat hello-world.p6
say "Hello, World!"
$ # execute the file
$ perl6 hello-world.p6
Hello, World!
~~~

## Solutions

Exercise 1: Write a program to show "Hello, World!"

**Bash**

~~~
$ # show source file contents
$ cat hello-world.sh
$ # execute the file
$ bash hello-world.sh
echo "Hello, World!"
Hello, World!
~~~

## Solutions

Exercise 1: Write a program to show "Hello, World!"

**Python**

~~~
$ # show source file contents
$ cat hello-world.py
$ # execute the file
$ python hello-world.py
Hello, World!
~~~

## Solutions

Exercise 1: Write a program to show "Hello, World!"

**C**

~~~
$ # show source file contents
$ cat hello-world.c
main() {
    print("Hello, World!\n");
    return 0; /* shows a succesful exit code to the caller */
}
$ # create the executable
$ gcc hello-world.c -o hello-world
$ # execute the file
$ ./hello-world
Hello, World!
~~~

## Solutions

Exercise 1: Write a program to show "Hello, World!"

**PostScript** (part 1)

~~~
$ # show source file contents
$ cat hello-world.ps
%!
% the unit of length is the PS point: 72 points per inch
/in {72 mul} def % a convenience definition
% define the font and size
/Times-Roman findfont 50 scalefont setfont
% origin is the lower left corner of the page
% positions are in x,y pairs
%   x is the horizontal scale increasing to the right,
%   y is the vertical scale increasing up
% move to the desired lower left pint of the text
2.5 in 5 in moveto
~~~

## Solutions

Exercise 1: Write a program to show "Hello, World!"

**PostScript** (part 2)

~~~
% show for text
(Hello, World!) show
showpage
$ # create the pdf version
$ ps2pdf hello-world.ps
$ # view it with program *ev*
ev hello-world.pdf
~~~

## Solutions

Exercise 2: Determine how many files are on this computer

~~~
$ locate * > files.list ; wc --lines files.txt
640000
~~~


## Solutions

Exercise 3: Write a overarching script in one of the scripting languages

**Bash**

~~~
$ # show source file contents
$ cat run-all.sh
bash hello-world.sh
perl6 hello-world.p6
python hello-world.py
./hello-world
$ # execute the file
$ bash run-all.sh
Hello, World!
Hello, World!
Hello, World!
Hello, World!
~~~

## Solutions

Exercise 3: Write a overarching script in one of the scripting languages

**Perl 6**

~~~
$ # show source file contents
$ cat run-all.p6
shell "bash hello-world.sh"; # not recommended
run "perl6", "hello-world.p6"; # 'run' is safer
run "python", "hello-world.py";
run "./hello-world";
$ # execute the file
$ perl6 run-all.p6
Hello, World!
Hello, World!
Hello, World!
Hello, World!
~~~
