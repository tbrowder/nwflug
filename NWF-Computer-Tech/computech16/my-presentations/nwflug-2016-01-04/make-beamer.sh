#!/bin/bash

# output
O=agenda.pdf

# create it
pandoc -t beamer agenda.pdoc -o $O

echo "See file '$O'"