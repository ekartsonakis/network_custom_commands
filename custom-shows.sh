#!/bin/bash
#Manos Kartsonakis - cloud services support
#Script for custom show commands 
# versioning - comments to git!

#Keep starting time in a variable:

starting=`date`
startingts=`date "+%s"`

#Check for lock

tmpdir=/tmp/custom-shows
lockfile=$tmpdir/custom-shows.lock

if ! [ -d $tmpdir ]; then
	/bin/mkdir $tmpdir
fi

if [ -f $lockfile ]; then
	echo "ERROR lock file exists, aborting"
	exit 1
else
	trap "/bin/rm -f $lockfile; exit" INT TERM EXIT
	echo $starting > $lockfile
fi


#Check if required directories exist and if not create them.

bckfolder="./"

if ! [ -d $bckfolder ]; then
	echo "ERROR $bckfolder does not exist"
	exit 1
fi

for vendor in cisco; do
	if [ ! -d $bckfolder/$vendor ]; then
		mkdir $bckfolder/$vendor
	fi
done
echo "Parent directories OK"
	

#Running custom script for given devices:

#Get device list and run expects.
cat $1 | sort -u | xargs -i -P 20 ./customcase.sh {}



#Keep ending time in a variable:

ending=`date`
endingts=`date "+%s"`


#Finito...	

echo "Custom-shows started at $starting"
echo "Completed at $ending"

/bin/rm -f $lockfile

trap - INT TERM EXIT
