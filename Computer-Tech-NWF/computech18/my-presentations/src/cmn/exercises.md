## Exercises

1. Using the xed editor (or the editor of your choice), write a 
   program that prints "Hello, World!" to the screen (stdout) when executed.
   Name the source file "hello-world.*" where '*' is the conventional
   suffix (file extension) for the language.

Write it in one or more of the following languages:

- Perl6
- Bash
- Python
- C
- PostScript

2. Using either the command line (which uses the bash shell by default)
   or one of the languages above, determine how many files are known to the system.

## Solutions

Exercise 1: Write a program to show "Hello, World!"

Perl 6
~~~
$ # show file contents
$ cat hello-world.p6
say "Hello, World!"
$ # execute the file
perl6 hello-world.p6
Hello, World!
~~~

Bash
~~~
$ cat hello-world.sh
echo "Hello, World!"
~~~

Python
~~~
$ cat hello-world.py
 "Hello, World!"
~~~

C
~~~
$ cat hello-world.c
main() {
    print("Hello, World!\n");
}
$ make hello-world.c

~~~


PostScript
~~~
$ cat hello-world.ps
~~~

## Solutions

Exercise 2: Determine how many files are on this computer

~~~
$ locate * > files.list ; wc --lines files.txt
640000
~~~
~~~
