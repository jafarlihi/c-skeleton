# c-skeleton
`init.sh` allows you to easily bootstrap basic C projects with [Unity][1] testing framework plugged in.

Run `init.sh`, enter your project name, and create as many *modules* as necessary. The script will create source/header files for each of your *modules* and also wire up a separate unit testing file for each.

## Makefile
The generated directory structure also plays well with the included Makefile (tested with GNU Make only).

Run `make build` for an optimized artifact.

Run `make dbg` for a debugging artifact.

Run `make test` to run tests with an optimized build artifact.

Run `make testdbg` to run tests with a debugging build artifact.

[1]: http://www.throwtheswitch.org/unity

## Depends
Existence of GNU sed is assumed; `init.sh` is not tested with other toolchains.
