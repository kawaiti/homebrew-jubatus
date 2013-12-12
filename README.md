# Homebrew-Jubatus

A repository for Jubatus brews. This is experimental support.

## How to use

	$ brew tap jubatus/jubatus
	$ brew install --HEAD jubatus --use-clang

## Configure Options

The following options are available:

* --prefix=PATH: Installation path
* --disable-onig: Disable oniguruma (regex library)
* --enable-mecab: Enable mecab
* --enable-zookeeper: Enable ZooKeeper (distributed mode)

Example:

    $ brew install --HEAD jubatus --use-clang --disable-onig --enable-zookeeper

## Requirement

* OS version: 10.8 (Mountain Lion)
    * 10.9 (Mavericks) is NOT supported due to c++ library issues.
* Compiler: clang
    * with env setting "export CXX=clang"
