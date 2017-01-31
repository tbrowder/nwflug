title: Using Linux
<!-- insert-file headers.md -->

<!-- insert-file prelims.md -->

# Using Linux

## Preview

Two personal projects:

- A personalized calendar

    - Programmed in Perl 5 (soon Perl 6)
    - Started in 1999, continuously improved since
    - Done annually
    - Plan to make most code public

- A Christmas card system

    - Programmed in Perl 5 (soon Perl 6)
    - Started in 1992, continuously improved since
    - Done annually
    - Plan to make most code public

Another project:

- Presentation slide maker

    - Programmed in Perl 5

- Not original but tweaked a bit

# A Personalized Wall Calendar

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

## Planned Features

Planned features:

- customizable special events
- data on facing page:
    - three-month view
    - sunrise/sunset
    - moonrise/moonset
    - astronomical events
    - pictures

## Requirements

Requirements for me to produce your calendar in the current format:

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

## Example Inputs

Let's look at some files...

# A Christmas Card System

## Products

Products:

- PDF poem insert (personal, example only)
- mailing labels in PDF for printing
    - with guidelines for testing
    - without guidelines for final printing
    - able to use blank labels remaining later
- a picture legend

## Requirements

Requirements for me to produce your mailing labels:

- A pipe-separated ASCII text file

Example (note the single lines are broken into two lines to fit the slide):

~~~
Spcl|Rcvd|Sent|Label|Owner|Salutation|FirstName|LastName|
Address|Address2|City|State|Zip|Country|Suffix|MiddleName
~~~

~~~
|||Y|Missy|Dr. and Mrs.|Charles|Stewart|
1005 Stovall Blvd.||Atlanta|GA|30319|||P.
~~~

Let's look at some files, including the final product...

# A Presentation Slide Maker

## Slide Maker

The output is the PDF you're seeing now.

A quick look at the directory structure and input files to produce my
session slides...

## Summary

We've looked at some personal projects (and one public FOSS project)
done on Linux that would be somewhat harder to do on Windows (IMHO):

- Personalized calendar
- Christmas card system
- Text input presentation program

I'm happy to help with any and all.

<!-- insert-file closer-help.md -->
