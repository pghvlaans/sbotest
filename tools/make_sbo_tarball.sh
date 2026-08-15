#!/bin/bash

# Make sbotest.tar and put it in the root sbotest directory
# for submission to SBo.

# Run only after the new version has been uploaded to the website.

# Requires sbo-maintainer-tools.

SBOROOT="$(pwd)"
PWB="$(basename "$SBOROOT")"

if [ ! -d "./man1" ] || [ "$PWB" != "sbotest" ] || [ ! -d "./slackbuild/sbotest" ]; then
  echo "Run make_sbo_tarball.sh from the root sbotest directory."
  exit 1
fi

TEMPDIR=$(mktemp -d)

if [ ! -d "$TEMPDIR" ]; then
  echo "Making the temporary directory failed. Exiting."
  exit 1
fi

(
  cd "$TEMPDIR" || exit 1
  cp -r "$SBOROOT/slackbuild/sbotest" .
  if [ ! -d sbotest ]; then
    echo "Copying the SlackBuild directory failed. Exiting."
    exit 1
  fi
  rm -f sbotest/*.tar.gz
  source ./sbotest/sbotest.info || exit 1
  wget $DOWNLOAD || exit 1
  NEW_MD5SUM="$(md5sum "sbotest-$VERSION.tar.gz" | awk '{print $1}')"
  sed -i "s/@MD5@/$NEW_MD5SUM/g" sbotest/sbotest.info || exit 1
  sed -i 's|_pghv|_SBo|g' sbotest/sbotest.SlackBuild || exit 1
  sed -i 's|/tmp/pghv|/tmp/SBo|g' sbotest/sbotest.SlackBuild || exit 1

  sbolint sbotest
  tar cavf sbotest.tar sbotest/
)

cp "$TEMPDIR/sbotest.tar" .
rm -r "$TEMPDIR"

echo ""
echo "Created sbotest.tar and moved it to the sbotest directory."
