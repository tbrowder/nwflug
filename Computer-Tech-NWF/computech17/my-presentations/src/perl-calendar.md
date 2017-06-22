title: A Perl Calendar
<!-- insert-file headers.md -->

## My background

- I'm a retired USAF fighter pilot (1987-12-31), and retired engineer
  (2016-01-01) with ManTech International Corporation
  (**<http://mantech.com>**)

- I've used GNU/Linux, Perl, and other FOSS professionally for over 20
  years

- I still use them daily in my personal projects as well as my work on
  FOSS projects

- Perl 6 is my programmimg language of choice (since 2014)

- My favorite hobby is supporting the development of Perl 6

## Break for browser and doc


...

## Project background

A personal project started for my late mother-in-law, then for my
wife, then for the public

- A personalized calendar

    - Programmed in Perl 4..5 (and soon Perl 6)
    - Started in 1999, continuously improved since
    - Done annually
    - Plan to make most code public
	- Code is still ugly, but getting better
	    - early days: get in fast, do the job, and get the heck out!
		- now, with maturity, I've settled in with Perl 6

## Pass arounds

- Three color calendars

- Two B and W calendars

I take the final pdf file to Office Depot and get it spiral bound with
clear cover and black end sheet,and printed in color for about $15.

## Pertinent Links

This link will get you to some public files for the calendar:

<**<https://computertechnwf.org/2017/sessions/>**>

## Current Features

Current features:

- Federal holidays: name in red, actual date cell bordered in red
- other holidays: name in red
- birthdays: name in blue, date cell bordered in blue
- anniversaries: names in green
- special events: name in red (**not yet customizable**)
- phases of the moon
- season changes
- daylight savings time start/stop
- Federal tax dates

## Planned features

Planned features:

- customizable special events
- data on facing page:
    - three-month view
    - sunrise/sunset
    - moonrise/moonset
    - astronomical events
    - pictures

## Requirements

Until I can go public with the code, I can produce your calendar in
the current format, but I require from you:

- a single word, unique title for each calendar, e.g., 'name'

- specially formatted and named ASCII text files (note the dots in each name):
    - a list of lines for the cover [default is available]
        - "front-cover-words.name.txt"
    - a list of birthdays
        - "birthdays.name.txt"
    - a list of anniversaries
        - "anniversaries.name.txt"
    - a list of monthly sayings [default is available]
        - "monthly-quotes.name.txt"

## Example inputs

Let's look at some files...

## Front cover words

~~~
# Note all text in this file on a line from a '#' (pound or hash
# symbol) is ignored as are all blank lines.

# This file contains the front cover personalization for the
# personalized wall calendar.

# The following two lines will be typeset on the front cover of the wall
# calendar AFTER the identifying title:
#
#     The Year 2016
#
# The first line will be in bold and the second line will be typeset in a
# regular and smaller typeface.

A Special Calendar for a Special Person
To Missy with love, from Tom
~~~

## Birthdays file

~~~

# Year conversions:
#   {1999}  <= year number in curly braces results in a cardinal
#              number (1, 2, etc.)
#   [1999]  <= year number in square brackets results in an ordinal
#              number (1st, 2nd, etc.)
#
# The following examples assume a calendar year of 2010:
#
# This entry
#   '11 may Kim {1999}'
# will be formatted as:
#   'Kim b'day, 11'
#
# This entry
#   '11 may Kim [1999]'
# will be formatted as:
#   'Kim b'day, 11th'
#
# Note any text after a bracketed year is ignored.
 6 jan Willi {1950} # 66 in 2016
~~~

## Anniversaries file

Same input format as birthdays, but they get formatted on the calendar
differently

~~~
30 mar Lane & Dale {1989} # Cooke (25th in 2014)
 7 may Grace & Kurt {2006}
20 jun Em. & T. {1998} # Emily and Tom Browder
~~~


## Monthly sayings file

~~~
# Note all text in this file on a line from a '#' (pound or hash
# symbol) is ignored as are all blank lines.

# This file contains monthly quotations for the personalized wall
# calendar.

# Note that the quotations are one per line and the longest one (122
# characters) is as long as my calendar format can handle (one printed
# line).  Note also that they are printed on each sheet in top to
# bottom order from January through December.

# The following Bible verses are from the King James Version (KJV):

For by me [the Lord] thy days shall be multiplied, and the years of thy life shall be increased.  (Proverbs 9:10)
~~~

## Summary

We've looked at one personal project done on Linux with Perl that
would be somewhat harder to do on Windows (IMHO):

- Personalized calendar

I'm happy to help with any and all who want a personalized version.
Contact me via e-mail (please mention TPC NA 2017 in the
  subject):

	- [**tom.browder@gmail.com**]

## Finally

That's all Doc!
