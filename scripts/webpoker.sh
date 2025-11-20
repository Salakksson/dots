#!/usr/bin/env bash

# webpoker autoupdate

WEBPOKER_DIR="/h/git/webpoker"
WEBPOKER_URL="https://sillyval.net/webpoker/client-linux-x64"
VERSION_URL="https://sillyval.net/webpoker/version"

mkdir -p $WEBPOKER_DIR

update=true
clean=false

cd $WEBPOKER_DIR

if [[ -f version ]]
then
	version=$(cat version)
	latest=$(curl $VERSION_URL)
	if [[ "$version" == "$latest" ]]
	then
		echo "already up to date!"
		update=false
	fi
	echo $version > version
	clean=true
fi

if $update
then
	echo "updating"
	if $clean
	then
		echo "removing old version"
		rm -fr webpoker.zip install
	fi
	curl -L "$WEBPOKER_URL" -o webpoker.zip
	unzip webpoker.zip -d install
fi

cd -

