#!/bin/sh

# Make sbotest-*.tar.gz and put it in the slackbuild/sbotest
# directory to build a packge.

SBOROOT=$(pwd)
PWB=$(basename $SBOROOT)

if [ ! -d "./man1" -o $PWB != "sbotest" ]; then
  echo "Run version.sh from the root sbotest directory."
  exit 1
fi

VER=$(awk -F\" '/^my \$SBOTEST_VERSION/{print $2}' bin/sbotest)
TEMPDIR=$(mktemp -d)

if [ ! -d $TEMPDIR ]; then
  echo "Making the temporary directory failed. Exiting."
  exit 1
fi

(
  cd $TEMPDIR
  cp -r $SBOROOT sbotest-$VER
  rm -rf sbotest-$VER/.git
  tar cavf sbotest-$VER.tar.gz sbotest-$VER/
)

cp $TEMPDIR/sbotest-$VER.tar.gz slackbuild/sbotest
rm -r $TEMPDIR

echo ""
echo "Created sbotest-$VER.tar.gz and moved it to slackbuild/sbotest."
