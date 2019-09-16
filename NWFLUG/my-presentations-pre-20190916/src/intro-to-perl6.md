title: Perl 6 Scripting Language
<!-- insert-file headers.md -->

## Introduction to Perl 6

- From the schedule:

    - Part (1) Install Perl 6.
    - Part (2) Tour of IDE.
    - Part (3) Demo some short programs written with Perl 6.
 
<!-- insert-file background.md -->

<!-- insert-file common-1.md -->

## What is Perl 6

Perl 6 is what is known as a scripting or interpreted programming
language as opposed to a compiled language like C++ or Fortran.

The first stable release of Perl 6 was announced as available on Dec
15, 2015.  Its predecessor, Perl (versions 1 through 5), was first
released around 1987, and Perl 6 started being developed in 2000 (15
years in the making!).

Although Perl 6 has a lot of compatibility with her big sister, it is
largely a new language.  Larry Wall, the author of
both languages, can explain the evolution of both languages.

Perl 6 is a much larger language than Perl 5, but all its features
don't have to be used for beginning to learn the language.

## Getting Perl 6

All official things Perl 6 should be found on its website

- <**<http://perl6.org>**>

It is available for Windows but I recommend using on Linux if
possible.  Currently it is a challenge to install on Windows unless
you are used to Windows program development.

Download and installation instructions for Linux and Mac are found here:

-  <**<http://perl6.org/downloads/>**>

Windows instructions are a bit hard to find but they are here:

- <**<https://github.com/tadzik/rakudobrew>**>

By the way, Perl 6 has been installed on the Computer Tech 2016 VM
available here:

- <**< https://computertechnwf.org/virtualbox-vm.html>**>

## Learning Perl 6

One of the easiest ways to start is to follow along with this tutorial

- <**<http://perl6intro.com/>**>

A somewhat more intense route is here:

- <**<https://github.com/rakudo/star/raw/master/docs/2015-spw-perl6-course.pdf>**>

Both links are available on the Download link on the Perl 6 site shown earlier.

## The REPL

Running Perl 6 code can be done using the REPL (Read-Eval-Print Loop).
Within the terminal, type **perl6**, write your code and hit [Enter]

~~~
$ perl6
> say "Hello, World!";
Hello, World!
> 
~~~

Use [Ctrl-D] to exit.  The REPL is handy for experimenting and
following along with tutorials.

You write longer programs inside a text file and then execute them as
will be demonstrated in a bit.

## Perl 6 handles rational numbers

One of Perl 6's many unique features.  A rational number is defined as

~~~
... any number that can be expressed as the quotient or fraction
**p/q** of two integers, **p** and **q**, with the denominator, **q**,
not equal to zero.
~~~

Some rational numbers are

~~~
2/3
1/7
~~~

## Perl 6 handles rational numbers (2)

Normally if we carry out the division we get a real number:

~~~
> my $a = 2/3
0.666667
> my $b = 1/7
0.142857
> say $a * $b
0.095238
~~~

But we can see the values carry the rational numbers along with them:

~~~
> say $a.nude
(2 3)
> say ($a * $b).nude
(2 21)
~~~

## Perl 6 handles rational numbers (3)

We can also represent a real number in rational form:

~~~
> say 2.3287.nude
(23287 10000)
~~~

## Perl 6 scripts (programs)

(**demo**)

## Perl 6 ecosystem

Perl 6 uses modules in a similar way to Perl 5. One of the strengths
of Perl 5 are the thousands of modules available on what is known as
CPAN:

- <**<http://www.cpan.org/>**>

As you can imagine, Perl 6 users will need equivalent modules for Perl
6 development and there is a very active module development effort
underway. (See the next slide for work-arounds for missing modules.)

## Perl 6 ecosystem (2)

Currently available modules are listed here:

- <**<https://modules.perl6.org/>**>

If you are working on a program and find you need a certain module you
used in Perl 5 and it is not currently available, you can add it to
the list of most wanted modules as described on the link above.

By the way, I got into that situation as I started diving into Perl 6
last year and I am working on translating module **Geo::Ellipsoid**
which you will see in that list.


## Perl 6 for Perl 5 users

- Much help on the Perl 6 website.

- One can use Perl 5 code in Perl 6 with appropriate measures (I have
  not yet experimented with that).

- There are two Perl 5 to Perl 6 translators available (I have not
  experimented with that either).

- If you are a Perl 5 user and are interested in Perl 6, there is lots
  of work to do in providing translation of Perl 5 modules to Perl 6
  form.

## Summary

- Today we have taken a look at the newly-released, stable version of Perl 6.

- If you are interested in continuing into the Perl 6 world, consider
  joining our local Perl Mongers group.

    - If we have enough interest, we can also start a regular class in
      Perl 6 and use the Niceville library for meetings.

<!-- insert-file closer-help.md -->

## One last word

From my experience, the Perl 6 community is somewhat rare in the
sometimes rough and unfriendly world of open source software
development. The folks are helpful, friendly, patient, kind, and
welcoming of all who want to participate.

Larry Wall and his attitudes permeate the community.  Google him to
find out much more about him and his activities.

We believe Perl 6 is a leading modern programming language and are
advocating Perl 6 to be the new language for teaching introductory
programming (and to replace Python).

If you would like to contribute to a very worthy endeavor, Perl 6 is
one to consider.  You don't have to be a developer. either.  Technical
writers and web designers are always in short supply.

If your children or grandchildren have the least interest in the
technical field, I highly recommend you pointing them to Perl 6.
