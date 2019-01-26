title: Intro to Computer Programming (Coding)
<!-- insert-file headers.md -->

## AUDIENCE EXPECTATIONS

**What do you expect from this presentation?**

## OBJECTIVE

My purpose is to give you a feel for **computer programming** in our
modern digital world.

## Computer programming

**Computer programming** is the process of writing instructions that
get executed by computers. The instructions, also known as code, are
written in a programming language which the computer can understand
and use to perform a task or solve a problem. [edX]

## General

Computer programming is required for almost all parts of a computer to
control the signals connecting all the pieces as well as the pieces
themselves.

## Computer: External interfaces

+ IO
+ Power
+ Keyboard
+ USB ports
+ Wireless device
+ Ethernet

## Computer: Internal interfaces

+ Graphics connectors
+ Drives
+ Display
+ CPU
+ Memory
+ Buses
+ Miscellaneous chips

## System(s) programming

That low-level programming is referred to as **System Programming**,
most of which is located in firmware or other semi-permanent medium.

**System programming** is the activity of programming computer system
software. The primary distinguishing characteristic of systems
programming...aims to produce software and software platforms which
provide services to other software, are performance constrained, or
both (e.g., operating systems, computational science applications, game
engines and AAA video games, industrial automation, and software as a
service applications). [Wikipedia]

## Application programming

An **application**, also referred to as an **application program** or
application software, is a computer software package that performs a
specific function directly for an end user or, in some cases, for
another application. An application can be self-contained or a group
of programs. [TechTarget]


## Application programming (cont.)

A working programmer then creates specific tools to solve a particular
requirement.

In general, requirements may dictate a set of software tools, each
reusable for other work flows.

## Examples

Transforming data via pipelines of separate filters (programs or
"tools"):

+ data => filter1 => format1 => filter2 => format2 => ...

+ PS square in text => gv => view => p6 prog => final product

+ xy points => graphviz => point cloud

+ text input => md2tex => Beamer => this presentation

+ text input => map

## Computer programming languages

Two general categories

+ Interpreted - build and execute

+ Compiled - build separate from execute

Two subcategories:

+ General purpose - broadly applicable across domains [Wikipedia]

+ Domain-specific (DSL) - specialized to a particular application
  domain [Wikipedia]

## General purpose languages

There are many general purpose languages, including the current top 10
most popular languages according to **GitHub**:

1. JavaScript [interp., behind much of the user-facing web]
2. Java [compiled, runs on JVM]
3. Python [interp.]
4. PHP [interp., inline with HTML]
5. C++ [compiled]
6. C# [Microsoft, silimar to Java]
7. TypeScript ["super JacaScript"] [interp.]
8. Shell (Bash, Zsh, Dash, etc.) [interp., a DSL]
9. C [compiled]
10. Ruby [interp.]

## Domain-specific languages (DSLs)

Further subdivided into:

+ markup

+ modeling

+ programming

Examples iclude:

+ PostScript - page description language (PDL)

+ Erlang - telecom

## Glue languages

A **glue** language is one that is suitable for calling other
languages or tools from one application.

Three glue languages I use a lot are

+ Perl 6 <**<https://perl6.org>**>

+ PostScript

+ Shell

## PostScript demonstration

Ojective: create a border around a title

~~~
%!
250 400 translate
0 0 moveto
 100   0 rlineto
   0 100 rlineto
-100  0 rlineto
closepath stroke
50 50 moveto
/Times-Roman 20 selectfont
(A Title) show
~~~

Break to the demonstration...

## PostScript demonstration

The natural extenstion to the simple PostScript document we just saw
is to create a much larger document from an organized collection of
text and images.

That is how a glue language, Perl 6 in this case, can add value to
other languages and data sets by tying them together into a final
product.

## Perl 6

If anyone is interested, I have an introductory course on Perl 6 I am
glad to present through the auspices of the **Niceville Perl Mongers**:

<**<http://niceville.pm.org>**>

## Summary

- Today we have taken a tiny peek at the huge world of computer
  programming.

- For me, creating PostScript documents is fun and challenging, your
  programming interest may differ.

- There is plenty of help to go in any direction you want to with
  college courses, books, videos, online training, and other
  resources.

<!-- insert-file closer-help.md -->
