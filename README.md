# sbotest

**[sbotest](https://pghvlaans.github.io/sbotools/sbotest/)** is a reverse dependency build tester based on the **[sbotools](https://pghvlaans.github.io/sbotools/)** library.

This **sbotools** companion script is written with script maintainers in mind: Easily build and test scripts with their reverse dependencies in a single command. Maintain an archive for built dependencies and keep it up-to-date with **sbotest --archive-rebuild**.

**sbotest** is configured separately from **sbotools**. See the contents of `/etc/sbotest`, or run **sbotest config** and **sbotest hints** to set options from the command line.

See the man page for more information about options and settings!

## Most Recent Changes
#### Post-Release
  * bin/test: Reflect changes in get_all_available() and use in()
  * bin/test: Arrange the testing list in build order for --archive-reverse
  * bin/test: Faster --dry-run
  * bin/test: Cut out repetitive reverse queue calculations for archive rebuilds

#### 1.1 - 2025-08-14
  * Report scripts with failures in the dependency queue separately
  * Use --archive-reverse to include all reverse dependencies in archive rebuilds
  * If SO_CHECK is TRUE, check for missing shared object dependencies upon build failure

## Getting sbotest

A SlackBuild is [available](https://slackbuilds.org/repository/15.0/system/sbotest/) at SlackBuilds.org.

To use a development version:

* Use **[sbotools-git-slackbuild](https://github.com/pghvlaans/sbotools-git-slackbuild/)** to upgrade **sbotools** to version `20250812-f11d5af` at the oldest.
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
