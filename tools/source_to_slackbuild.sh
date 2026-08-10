#!/bin/bash

# Make sbotest-*.tar.gz and put it in the slackbuild/sbotest
# directory to build a packge.

SBOROOT="$(pwd)"
PWB="$(basename "$SBOROOT")"

if [ ! -d "./man1" ] || [ "$PWB" != "sbotest" ] || [ ! -d "./slackbuild/sbotest" ]; then
  echo "Run source_to_slackbuild.sh from the root sbotest directory."
  exit 1
fi

VER=$(awk -F\" '/^my \$SBOTEST_VERSION/{print $2}' bin/test)
TEMPDIR=$(mktemp -d)

if [ ! -d "$TEMPDIR" ]; then
  echo "Making the temporary directory failed. Exiting."
  exit 1
fi

(
  cd "$TEMPDIR" || exit 1
  cp -r "$SBOROOT" "sbotest-$VER"
  if [ ! -d "sbotest-$VER" ]; then
    echo "Copying the sbotest directory failed. Exiting."
    exit 1
  fi
  rm -rf "sbotest-$VER/.git"
  rm -f sbotest-"$VER"/slackbuild/sbotest/*.tar.gz
  tar cavf "sbotest-$VER.tar.gz" "sbotest-$VER/"
)

cp "$TEMPDIR/sbotest-$VER.tar.gz" slackbuild/sbotest
rm -r "$TEMPDIR"

echo ""
echo "Created sbotest-$VER.tar.gz and moved it to slackbuild/sbotest."
