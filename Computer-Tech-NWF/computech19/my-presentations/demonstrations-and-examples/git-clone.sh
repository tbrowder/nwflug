#!/bin/bash

REPO=git@github.com:tbrowder/Computer-Tech-Expo-NWF.git

R="tbrowder/Computer-Tech-Expo-NWF"

if [[ -z $1 ]] ; then
    echo "Usage: $0 go"
    echo
    echo "Clones repo '$R' from 'https://github.com'"
    exit
fi

git clone $REPO
