title: VirtualBox   
<!-- insert-file headers.md -->

## Introduction to Linux

- Using VirtualBox for Windows

- From the schedule:

    1. Demo install of **Oracle's Virtual Box**.
    2. Install a Virtual Machine image of **Ubuntu**.
    3. Take tour of **Ubuntu**'s features.

<!-- insert-file background.md -->

<!-- insert-file common-1.md -->

## Why GNU/Linux?

- Powerful operating system (O/S or OS) that can be used in place of
  Windows or Mac

- Command-line-interface (CLI) that permits complex pipeline tasks and
  GUI-less programming

- Thousands of free software packages to suit nearly every interest

- Especially valuable as a modern slide-rule or calculator for
  scientists, mathematicians, engineers, and analytical professionals
  in all fields

## Testing Linux distros (distributions)

Several methods

- VirtualBox

- Live CD/DVD

- Bootable USB drive

- Spare computer (native install; dual or single boot)

We'll use VirtualBox for this presentation

## The VirtualBox site

Note at the website the __Downloads__ and __End-user docs__ links and the __News Flash__ section

![38%](./pics/vbox-site.png)

## After selecting "Downloads"

![40%](./pics/vbox-dloads.png)

## Don't forget the "Extension Pack" (for USB 2/3)

The "Extension Pack" is not distributable

![38%](./pics/vbox-dloads-2.png)

## Upgrading or installing

After downloading the main file, double-click on it and install it as
usual on Windows (or the equivalent on Mac).

When upgrading or installing, you lose network access temporarily.
You may have to uninstall an old version when upgrading.

## Selecting the Linux distro

Considerations (* recommended)

- amount of RAM (* 2 GB+)
- 32- or 64-bit (* 64-bit)
- 64-bit guest on 32-bit host? (NOT recommended)
- type network interface (remote access needed?)

## Installing the Linux guest...

We have a VM already prepared for you here through a link on the
Computer Tech NWF home page:

- <**<https://computertechnwf.org/virtualbox-vm.html>**>

Download and import it

At 4+ Gb it will take a while to download!

## Importing the VM (1)

![38%](./pics/vbox-import-vm-1.png)

## Importing the VM (2)

![38%](./pics/vbox-import-vm-2.png)

## Importing the VM (3)

![38%](./pics/vbox-import-vm-file-selected.png)

## Importing the VM (4)

![38%](./pics/vbox-import-vm-progress.png)

## Importing the VM (5)

Complete, now check settings

![38%](./pics/vm-uploaded-ready)

## Importing the VM (6)

![38%](./pics/vm-import-vm-settings.png)

## Now start the VM

![38%](./pics/vm-start.png)

## VM goodies

The VM has a few things added over the initial installation:

- a simple Emacs customization file (**~/.emacs.d/init.el**)

- Perl 6

## A very brief Linux tour (1)

- Using the VM (**demo**)

    - Terminal window

    - Package manager

    - Emacs

    - Perl 6
    
##  A very brief Linux tour (2)

Some CLI fun using my Debian 7 laptop (**demo**)

How many files are on my laptop?

~~~
$ time locate / > tt
real	0m58.954s
user	0m0.712s
sys	0m1.876s
$ wc tt
 1141036  1371237 89324910 tt
~~~

##  A very brief Linux tour (3)

How many files are in my home directory?

~~~
$ time locate $HOME > t
real	0m0.513s
user	0m0.468s
sys	0m0.044s
$ wc t
102133  108278 8084166 t
~~~

How many are PDF files (end in ".pdf")?

~~~
$ grep -i '\.pdf$' t > ttt
$ wc ttt
  475   533 30446 ttt
~~~

## My Christmas card process

(**demo**)

## Resources

- Free Linux tutorial (sponsored by the Linux Foundation
<**<http://www.linuxfoundation.org/>**>: go to
<**<https://www.edx.org/>**> and search for "LFS101x.2"

- Linux for Dummies (book)

- Linux Bible (**demo**)

- Our local Linux user group: <**<https://nwflug.org>**> meets once a month

## Summary

- Today we have taken a look at getting a usable Linux installation
  for learning.

- If you find Linux useful, consider joining our local Linux user
  group.

- There is something out there in Linux land for nearly any interest.
  I encourage you to venture forth, have fun, and expand your
  knowledge and skills.

<!-- insert-file closer-help.md -->
