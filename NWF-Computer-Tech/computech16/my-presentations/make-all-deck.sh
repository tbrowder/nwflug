#!/bin/bash

P="\
free-win-progs \
intro-to-linux \
intro-to-perl6 \
"

for p in $P
do
  echo "Building '$p'..."
  echo "--------------"
  (cd $p; ls -CF)
  (cd $p; ./make-deck.sh $p.adoc-deck)
done