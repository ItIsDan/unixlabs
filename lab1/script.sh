#!/bin/bash

start_path=$(pwd)

tempdir=$(mktemp -d)

cleanup() {
	rm -rf "$tempdir"
}

trap cleanup EXIT HUP INT QUIT PIPE TERM

if [ "$#" -ne 1 ]; then
	echo "Needs ONE source file"
	exit
fi

code_file="$1"

if [ ! -f "$code_file" ]; then
	echo "File was not found"
	exit	
fi

if [ ! -r "$code_file" ]; then
	echo "File is readonly"
	exit
fi
   
out_file=$(grep "Output:" $1 | cut -d ":" -f 2)

if [ -z "$out_file" ]; then
	echo "No comment in file"
	exit
fi

cp "$code_file" "$tempdir"

cd "$tempdir"

if ! g++ $code_file -o $out_file ; then
	echo "Compile error"
	cleanup
	exit
fi

mv -i $out_file "$start_path"

cd "$start_path"

./$out_file



