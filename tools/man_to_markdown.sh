#!/bin/sh

# Convert man pages to markdown; requires pandoc.

# This should be just about everything.

cd $(dirname $0) || exit
cp ../man1/* ../man-md
cd ../man-md || exit
cat sbotest.1 | groff -mandoc -Thtml > sbotest.1.html
rm *1

# If something happens to me and someone else takes over the project,
# a word to the wise: Add your email address here.
sed -i 's|kvngncrlsn@gmail.com|kvngncrlsn (at) gmail (dot) com|g' *html

pandoc --from=html --to=markdown sbotest.1.html > sbotest.1.md
rm -f ./*html

# And now the fun part...
sed -i "s/#NAME/#name/g" *
sed -i "s/#SYNOPSIS/#synopsis/g" *
sed -i "s/#OPTIONS/#options/g" *
sed -i "s/#DISCLAIMER/#disclaimer/g" *
sed -i "s/#DESCRIPTION/#description/g" *
sed -i "s/#BUGS/#bugs/g" *
sed -i "s/#TESTING\%20STRATEGIES/#testing-strategies/g" *
sed -i "s/#SEE\%20ALSO/#see-also/g" *
sed -i "s/#EXIT\%20CODES/#exit-codes/g" *
sed -i "s/#CONFIGURATION/#configuration/g" *
sed -i "s/#ACKNOWLEDGMENTS/#acknowledgments/g" *
sed -i 's|#AUTHOR)\\|#author)|g' *

sed -i "s/^## NAME.*/## NAME/g" *
sed -i "s/^## SYNOPSIS.*/## SYNOPSIS/g" *
sed -i "s/^## OPTIONS.*/## OPTIONS/g" *
sed -i "s/^## DISCLAIMER.*/## DISCLAIMER/g" *
sed -i "s/^## DESCRIPTION.*/## DESCRIPTION/g" *
sed -i "s/^## BUGS.*/## BUGS/g" *
sed -i "s/^## TESTING STRATEGIES.*/## TESTING STRATEGIES/g" *
sed -i "s/^## SEE ALSO.*/## SEE ALSO/g" *
sed -i "s/^## EXIT CODES.*/## EXIT CODES/g" *
sed -i "s/^## CONFIGURATION.*/## CONFIGURATION/g" *
sed -i "s/^## ACKNOWLEDGMENTS.*/## ACKNOWLEDGMENTS/g" *
sed -i "s/^## AUTHOR.*/## AUTHOR/g" *

sed -i "s/^# sbotest.*/# sbotest/g" *

# Want man page links, but not bold ones.
for item in check clean config hints find install remove upgrade ; do
  sed -i "s/sbo$item(1)/[sbo$item(1)](sbo$item.1.md)/g" *
  sed -i "s/[*]\+\[sbo$item(1)\](sbo$item.1.md)[*]\+/[sbo$item(1)](sbo$item.1.md)/g" *
done

sed -i "s/sbotools.conf(5)/[sbotools.conf(5)](sbotools.conf.5.md)/g" *
sed -i "s/[*]\+\[sbotools.conf(5)\](sbotools.conf.5.md)[*]\+/[sbotools.conf(5)](sbotools.conf.5.md)/g" *

sed -i "s/sbotools.hints(5)/[sbotools.hints(5)](sbotools.hints.5.md)/g" *
sed -i "s/[*]\+\[sbotools.hints(5)\](sbotools.hints.5.md)[*]\+/[sbotools.hints(5)](sbotools.hints.5.md)/g" *

# Right, time to work out code blocks.
sed -i "s/^sbotest/    sbotest/g" *
SPACES="            "
[ -f sbotest.1.md ] && sed -i "s/^\\\\\[/$SPACES\\\\[/g" sbotest.1.md
[ -f sbotest.1.md ] && sed -i "s/^sbo_name/$SPACES\sbo_name/g" sbotest.1.md

# Why, yes, these lines are horrible.
sed -i "s/     •      /\* /g" *
sed -i "/^\s.-/d" *
sed -i "s/\\\\\[/[/g" *
sed -i "s/\\\\\]/]/g" *
sed -i 's|\\\\\\$|\\|g' *
sed -i "/^    /s/\\\|/|/g" *
sed -i "/^    /s/\\\-/-/g" *
sed -i "/^    /s/\\\\\\$/$/g" *
sed -i "s/^git branch /    git branch /g" *
sed -i "s/^git checkout /    git checkout /g" *
sed -i "s/^git merge /    git merge /g" *
sed -i "s/^git push /    git push /g" *
