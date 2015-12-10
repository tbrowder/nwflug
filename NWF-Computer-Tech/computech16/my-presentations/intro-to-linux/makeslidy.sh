#!/bin/bash

TITLE='Introduction to Linux'
DEST=html

# use 50 min as base time
TIME='--attribute duration=50'

THEME=
#THEME='--attribute theme=volnitsky'

# run it
asciidoc --backend slidy $TIME $THEME $1
