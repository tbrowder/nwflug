title: Introduction to "wkhtmltopdf"   
<!-- insert-file headers.md -->
date: 2016-06-06

## Introduction to "wkhtmltopdf"

Two programs in one:

- wkhtmltopdf

- wkhtmltoimage

## wkhtmltopdf

Website:

- <**<http://wkhtmltopdf.org/>**>

## Downloads

Download precompiled binary (or build from source).

Binaries available (32- and 64-bit) for Linux, Windows (Vista+;
bundles VC++ Runtime 2013), or Mac OS X (10.6+).

Download Linux 64-bit binary (comes in a tar.xz archive):

- wkhtmltox-0.12.3_linux-generic-amd64.tar.xz

Unpack it but watch for directory pollution ('tar -t' vs. 'tar -x'):

~~~
$ tar -tvJf wkhtmltox.tar.xz
drwxr-xr-x root/root 0 2016-01-20 wkhtmltox/
drwxr-xr-x root/root 0 2016-01-20 wkhtmltox/lib/
...
~~~

## Running wkhtmltopdf

Lots of options:

~~~
$ wkhtmltopdf --help
...
~~~

Simply use it on any html document:

~~~
$ wkhtmltopdf https://nwflug.org nwflug-org.pdf
~~~

## The NWFLUG.ORG pdf file

![30%](./nwflug-org.pdf)

## Running wkhtmltoimage

Again, lots of options:

~~~
$ wkhtmltoimage --help
...
~~~

But simply use it on any html document:

~~~
$ wkhtmltoimage https://nwflug.org nwflug-org.png
~~~

## The NWFLUG.ORG png file

![20%](./pics/nwflug-org.png)

## The real output files

Demonstration (demo dir)...

- Generate the pdf

- View the pdf (evince)

- Generate the png

- Edit the png (gimp)

## Summary

- Programs "wkhtmltopdf" and "wkhtmltoimage" give the user two
  powerful tools with more flexibility than most screenshot programs.

- They are scriptable and able to be fine-tuned for programmatic use.
