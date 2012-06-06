#!/bin/bash

STR=`stat -f %m test1.txt`
echo $STR

#if logFile exists
if [ -f ./modLogFile.txt ] 
then
   echo "EXISTS!"
   #if logFile.contains( fileName )
    #if [ grep -Fxq "test1.txt" modLogFile.txt ] then
	

       # if currModTime > savedModTime  
          # savedModTime = currModTime
          # ++ count
   #else
       # append fileName
       # ex: myFile modTime 0
   # fi
   #else
   # create logfile
   #echo "DOES NOT EXIST"
fi