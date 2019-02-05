#!/bin/bash
ARCH=${ARCH:=amd64}

SCRIPT_FILENAME=`readlink -f $0`
SCRIPT_DIR=`dirname $SCRIPT_FILENAME`

COMMAND=$1
COMMAND=${COMMAND:=help}


if [ "version" == $COMMAND ] ; then
	go version

	exit
fi

if [ "list" == $COMMAND ] ; then
	cd "$SCRIPT_DIR"

	for i in `ls -d */`; do echo ${i%%/}; done

	exit
fi

if [ "set" == $COMMAND ] ; then
	cd "$SCRIPT_DIR"

	VERSION=$2
	FILENAME="go${VERSION}.linux-${ARCH}.tar.gz"

	# Check if folder exists
	DIR="$SCRIPT_DIR/$VERSION"
	if [ ! -d "$DIR/go" ] ; then
		echo "El directorio no existe en local, me lo descargo..."

		# Create dir
		mkdir -p "$DIR"
		cd "$DIR"

		# Download
		wget -c "https://storage.googleapis.com/golang/${FILENAME}"

		# Unzip
		tar -xzf "$FILENAME"
	fi

	# Set links
	rm "$SCRIPT_DIR/go" >&- 2>&-
	ln -fs "$SCRIPT_DIR/$2/go/bin/go" "$SCRIPT_DIR/go"
	rm "$SCRIPT_DIR/.goroot" >&- 2>&-
	ln -fs "$SCRIPT_DIR/$2/go" "$SCRIPT_DIR/.goroot"

	exit
fi

if [ "install" == $COMMAND ] ; then

	sudo ln -fs "$SCRIPT_DIR/gvm.sh" /usr/bin/gvm

	sudo ln -fs "$SCRIPT_DIR/go" /usr/bin/go	
	sudo ln -fs "$SCRIPT_DIR/.goroot" /usr/local/go

	exit
fi

if [ "help" == $COMMAND ] ; then
	echo "A command should be provided: gvm <command>"
else
	echo "Invalid command '$COMMAND'"
fi

help=$(cat <<'ZZZZZZHEREDOC'
version	Get current version
list	See all local available versions
set 	Set go version
install	Install this script
help	Show this help
ZZZZZZHEREDOC
)

echo "$help"
