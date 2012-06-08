#!/bin/bash

fileName=test4.txt

# most recent modified time
currModTime=`stat -f %m $fileName`

#if modLog exists
if [ -f ./modLogFile.txt ] 
then
   
   IN_MOD_LOG=`grep -a "$fileName" modLogFile.txt`

   #if modLog does NOT contain file
   if [ -z "$IN_MOD_LOG" ]
   then
#       echo "ADDING $fileName TO MOD LOG"
       echo "$fileName $STR 0">>modLogFile.txt 
   else
#       echo "FOUND YOUR FILE"
       lastModTime=`grep -a $fileName modLogFile.txt | awk '{print $2}'`

#       echo $currModTime

       # if currModTime > savedModTime ...aka was updated  
       if [ "$currModTime" -gt "$lastModTime" ]
       then

        numCompiles=`grep -a $fileName modLogFile.txt | awk '{print $3}'`
	numCompiles=$(($numCompiles+1))
#	echo $numCompiles

	sed -i -e "/$fileName/s/\(.*\) [0-9]* /\1 $currModTime /" modLogFile.txt
	sed -i -e "/$fileName/s/\(.*\) [0-9].*/\1 $numCompiles/" modLogFile.txt
       fi
    fi
else

   # create logfile
   echo "CREATING MODLOG"
   echo "$fileName $STR 0">>modLogFile.txt 
fi