#!/bin/bash -e

start_path=$(pwd)

tempdir=$(mktemp -d)

cleanup() {
	rm -rf "$tempdir" 
	echo "$?"
}

trap cleanup EXIT HUP INT QUIT PIPE TERM

if [ "$#" -ne 1 ]; then
	echo "Needs ONE source file"
	exit
fi

code_file="$1"
   
out_file=$(grep "Otput:" $1 | cut -d ":" -f 2)

if [ -z "$out_file" ]; then
	echo "No comment in file"
	exit
fi

cp "$code_file" "$tempdir"

cd "$tempdir"

g++ $code_file -o $out_file 

mv -i $out_file "$start_path"

cd "$start_path"

./$out_file



