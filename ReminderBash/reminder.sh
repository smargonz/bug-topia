#!/bin/bash

IFS='
'

#if modLog exists
if [ -f ./modLogFile.txt ] 
then
    #get directory path
    DIRPATH=$(head -n 1 modLogFile.txt)
else
   # create logfile
   echo "CREATING MODLOG FOR [specify full path]:"
   read -e DIRPATH
   echo $DIRPATH>>modLogFile.txt
fi

#read directory contents into array 
array=(`ls -1 $DIRPATH`)

len=${#array[*]}

#Compare mod times against logged mod 
# time for each file

i=0
while [ $i -lt $len ]
do

    fileName=${array[$i]}

    #most recent modified time
    currModTime=`stat -f %m $fileName`

    #get file's entry in modlog
    MOD_LOG_ENTRY=`grep -a "$fileName" modLogFile.txt`

     #if modLog does NOT contain file's entry
    if [ -z "$MOD_LOG_ENTRY" ]
    then
        #add it
	echo "$fileName $currModTime 0">>modLogFile.txt 
    else 
        #Check if update required.
        #Grab saved mod time.
	lastModTime=`grep -a $fileName modLogFile.txt | awk '{print $2}'`

        #if currModTime > savedModTime ...ie file was updated  
	if [ "$currModTime" -gt "$lastModTime" ]
	then

            numCompiles=`grep -a $fileName modLogFile.txt | awk '{print $3}'`
	    numCompiles=$(($numCompiles+1))

	    sed -i -e "/$fileName/s/\(.*\) [0-9]* /\1 $currModTime /" modLogFile.txt
	    sed -i -e "/$fileName/s/\(.*\) [0-9].*/\1 $numCompiles/" modLogFile.txt
	fi
    fi

let i++
done