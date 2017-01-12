#!/bin/bash
#ekartso
#see git/gitlab for commits

#Check if argument 1 is empty

if [ "$1" == "" ]; then
	echo -e "\nusage is  $0 hostname\n"
	exit 1
fi

custfolder="./"
sysname=$1
username=YOUR_USERNAME
password=YOUR_PASSWORD
date=`/bin/date +"%Y-%m-%d"`
tmpdir=/tmp/custom-shows
commands=$custfolder/commands.list
logfile=$tmpdir/$sysname.log
lockfile=$tmpdir/$sysname.lock
new=0
maxversions=40
worked=0

function lecho {
	isodt=`/bin/date +"%Y-%m-%dT%H:%M:%S"`
	echo "$sysname $isodt $1" | tee -a $logfile
}

#Create a temp folder
if ! [ -d $tmpdir ]; then
        /bin/mkdir $tmpdir
	/bin/chmod 777 $tmpdir
fi

#Don't run again if running
if [ -f $lockfile ]; then
        lecho "Lock file exists, aborting."
        exit 1
else
        trap "/bin/rm -f $lockfile; exit" INT TERM EXIT
        /bin/date +"%Y-%m-%dT%M:%H:%S" > $lockfile
fi

#Clean old temp logfile and output file if any
if [ -f $logfile ]; then
        /bin/rm -f $logfile
        /bin/rm -f $tmpdir/$sysname*
	
fi


#Set Internal Field Separator in order to read per line and not per word
OLDIFS=$IFS
IFS=$'\n'
for command in `cat $commands`;do
	output=iosxr_`echo $command | sed 's/ /_/g'`
	type=cisco
	#setting/create the output directory:
	directory="$custfolder/$type/$sysname"
	if [ ! -d $directory ]; then
		mkdir $directory
		new=1
	fi
	# ****** RUN THE SCRIPT *******
	$custfolder/cisco_show.exp $username $password $1 $sysname $command > $directory/$output 2>&1 && echo "Done with $sysname"
done

IFS=$OLDIFS

/bin/rm -f  $lockfile

#
trap - INT TERM EXIT
