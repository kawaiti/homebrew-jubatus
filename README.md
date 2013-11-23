# Homebrew-Jubatus

A repository for Jubatus brews.

## How to use

	$ brew tap jubatus/jubatus
	$ brew install jubatus --use-clang

## Configure Options

The following options are available:

* --prefix=PATH: Installation path
* --disable-onig: Disable oniguruma (regex library)
* --enable-mecab: Enable mecab
* --enable-zookeeper: Enable ZooKeeper (distributed mode)

Example:

    $ brew install jubatus --disable-onig --enable-zookeeper
