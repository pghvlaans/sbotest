# sbotest

**[sbotest](https://pghvlaans.github.io/sbotools/sbotest/)** is a reverse dependency build tester based on the **[sbotools](https://pghvlaans.github.io/sbotools/)** library.

This **sbotools** companion script is written with script maintainers in mind: Easily build and test scripts with their reverse dependencies in a single command. Maintain an archive for built dependencies and keep it up-to-date with **sbotest --archive-rebuild**.

**sbotest** is configured separately from **sbotools**. See the contents of `/etc/sbotest`, or run **sbotest config** and **sbotest hints** to set options from the command line.

See the man page for more information about options and settings!

## Most Recent Changes

#### Post-Release
  * tools: Add a script to make a submission-ready archive.

#### 1.3.1 - 2026-08-13
  * Compatibility bump
  * Account for the new IDLE_BUILD setting; add --idle-build
    * Thanks to shamefulCake1 for the sbotools request
  * bin/test: Correct the valid package types

#### 1.3 - 2026-08-07
  * Compatibility bump
  * Account for the new NICENESS setting; add --niceness
    * Thanks to shamefulCake1 for the sbotools request
  * Show version and build number in the results summary where appropriate
  * bin/test: Add a --force option to rebuild up-to-date packages with full repo and archive rebuilds
  * bin/test: Add a --series option to test everything in a series
  * bin/test: More efficient queue score calculation
  * bin/test: Faster reusable package detection for dry runs

#### 1.2.3 - 2026-07-31
  * Compatibility bump
  * Document the manual download directory and symlink
  * Document the new SBO_HOME default of /var/lib/sbotest, etc.
  * Account for the NO_SOCHECK setting; replace --so-check with --no-socheck

#### 1.2.2 - 2026-05-06
  * Account for the new NONET setting
  * Compatibility bump

## Getting sbotest

A SlackBuild is [available](https://slackbuilds.org/repository/15.0/system/sbotest/) at SlackBuilds.org.

To use a development version:

* Use **[sbotools-git-slackbuild](https://github.com/pghvlaans/sbotools-git-slackbuild/)** to upgrade **sbotools** to version `20260809_92a0b0e` at the oldest.
* Clone the **sbotest** repository.
* Run `./tools/source_to_slackbuild.sh` from the root of the local repository.
* Run the SlackBuild in `slackbuild/sbotest`.

Issues and requests are welcome; if running post-release **sbotest**, please indicate the most recent commit with the output of:

    git log | head -n 1

## Acknowledgments

**Jacob Pipkin**, **Luke Williams** and **Andreas Guldstrand** are the original authors of **sbotools**.

**B. Watson** is the author and maintainer of **[sbo-maintainer-tools](https://slackware.uk/~urchlay/repos/sbo-maintainer-tools)**.

## Disclaimer

**sbotest** was designed and intended to be run in a build-testing environment, such as a virtual machine or a Docker image. Using **sbotest** on a general-purpose Slackware installation is **unsupported** and **unadvisable**.
