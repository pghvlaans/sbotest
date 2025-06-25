#!/bin/sh

# Prepare for a version update.

PWD=$(basename $(pwd))

if [ ! -d "./man1" -o $PWD != "sbotest" ]; then
  echo "Run version.sh from the root sbotest directory."
  exit 1
fi

if [ -z $1 ]; then
  echo "Usage: ./tools/version.sh NEW_VERSION"
  exit 1
fi

if [ -z "/usr/bin/ddate" ]; then
  echo "ddate needed for the man page; is this a full installation of Slackware?"
  exit 1
fi

NEWVER=$1
OLDVER=$(awk -F\" '/^my \$SBOTEST_VERSION/{print $2}' bin/test)

for dir in bin slackbuild man1; do
  find $dir -type f -exec sed -i "s/$OLDVER/$NEWVER/g" {} \;
done

OLDDDATE="$(awk -F\" '/^\.TH/{print $2}' man1/sbotest.1)"
NEWDDATE="$(/usr/bin/ddate +"%{%A, %B %d%}, %Y YOLD%N - %H")" 

sed -i "s/$OLDDDATE/$NEWDDATE/g" man1/sbotest.1
./tools/man_to_markdown.sh
