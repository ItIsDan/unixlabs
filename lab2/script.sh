#!/bin/bash -e

startPath="/data"
lockPath="/tmp/lockfile"
containerId=$(shuf -i 1-100000 -n 1) # generate numbers from 1 to 10e6 and pick 1

#echo $containerId
fileCounter=1
fileName=''
findFreeFileName() {
	local indexOfFile=1
	while true; do # we'll iterate from 0 to n until indexOfFile was not used
	    fileName=$(printf "%03d" $indexOfFile)
	    
	    if [ ! -e "$fileName" ]; then    
	        echo "$fileName"
	        return
	    else
	    	return
	    fi
	    
	    #indexOfFile=$((indexOfFile + 1))
	done
}

while true; do
  (
  	flock -x 200 # write lock
  	
  	fileName=$(findFreeFileName)
	echo "Creating file $fileName"
	echo "Container ID: $containerId" > "$fileName"
	echo "File number: $fileCounter" >> "$fileName"
	
	fileCounter=$((fileCounter + 1))
	
  )200>"$lockPath"
  
  	sleep 1
  (
  	flock -x 200
  	#if [ ! -e "$fileName" ]; then
	  	echo "Deleting file $fileName"
	  	echo "$fileName"
	  	ls
  		rm "$fileName"
  	
  )200<"$lockPath"
  
  sleep 1

done


