# sbotest

**[sbotest](https://pghvlaans.github.io/sbotools/sbotest/)** is a reverse dependency build tester based on the **[sbotools](https://pghvlaans.github.io/sbotools/)** library.

This **sbotools** extension was written with script maintainers in mind: Easily build and test scripts with their reverse dependencies in a single command. Copy built packages into an archive to be used again, and keep it up-to-date with **sbotest --archive-rebuild**.

**sbotest** is configured separately from **sbotools**. See the contents of `/etc/sbotest`, or run **sbotest --config** and **sbotest --hints** to set options from the command line.

See the man page for more information about options and settings!

## Trying sbotest

**sbotest** is not quite ready for a version release, which needs to wait for **sbotools-3.7**. In the meantime, please follow these steps if you would like to try **sbotest**:

* Use **[sbotools-git-slackbuild](https://github.com/pghvlaans/sbotools-git-slackbuild/)** to upgrade **sbotools** to version `20250616-0d4e3dd` at the oldest.
* Clone the **sbotest** repository.
* From the root directory, run `./tools/source_to_slackbuild.sh`.
* Run the SlackBuild in `slackbuild/sbotest`.

Issues and requests are welcome; please indicate the most recent commit with the output of:

    git log | head -n 1

## Acknowledgments

**Jacob Pipkin**, **Luke Williams** and **Andreas Guldstrand** are the original authors of **sbotools**.

**B. Watson** is the author and maintainer of **[sbo-maintainer-tools](https://slackware.uk/~urchlay/repos/sbo-maintainer-tools)**.

## Disclaimer

**sbotest** was designed and intended to be run in a build-testing environment, such as a virtual machine or a Docker image. Using **sbotest** on a general-purpose Slackware installation is **unsupported** and **unadvisable**.
