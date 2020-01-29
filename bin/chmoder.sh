#!/bin/bash

## dev by iaguilaror@gmail.com

## define directory of residence for this script
logs_directory=$(dirname "$(readlink -f "$0")")

## define logfile from logs_directory location
logfile="$logs_directory"/chmoder_logs/log.txt

## create a dir if needed, relative to the logfile
# -p option avoids error if dir already exists
mkdir -p $(dirname "$logfile")

## touch the timestamp of the logfile
# if the files does not exist, it is created
touch "$logfile"

## capture the target directory
target_dir="$1"

## define time stamp
time_stamp=$(date | tr " " "_")

## Check, if target dir does NOT exist, the scripts ends abruptly
if [[ ! -d "$target_dir" ]]
then
	echo "[$time_stamp] $target_dir does not exists on your filesystem. chmoder won't do anything. Exit program" >> $logfile
	exit 1
fi

## define desired permissions (its better to use human nomenclature, like g+rw)
permissions="770"

## count the number of dirs without the expected permissions
number_of_dirs=$(find $target_dir ! -perm $permissions -type d | wc -l)
echo "[$time_stamp] found dirs without the correct permissions: $number_of_dirs" >> $logfile

## test if there are dirs in need of chmodding
if [[ "$number_of_dirs" -eq 0 ]]
then
	echo "[$time_stamp] No dirs need chmodding. Skipping change of permissions for directories" >> $logfile
else
	echo -e "[$time_stamp] detecting dirs in $target_dir NOT set to the following permissions: $permissions\n=" >> $logfile
	## find every dir without the required permissions
	find $target_dir ! -perm $permissions -type d >> $logfile
	echo -e "=\n[$time_stamp] modifying permissions on said dirs" >> $logfile
	## modify permissions in the dirs found
	find $target_dir ! -perm $permissions -type d -exec chmod $permissions {} \;
	## message of change
	echo "[$time_stamp] DETECTED dirs PERMISSIONS HAVE BEEN SET TO: $permissions" >> $logfile 
fi

## count the number of files without the expected permissions
number_of_files=$(find $target_dir ! -perm $permissions -type f | wc -l)
echo "[$time_stamp] found files without the correct permissions: $number_of_files" >> $logfile

## test if there are files in need of chmodding
if [[ "$number_of_files" -eq 0 ]]
then
	echo "[$time_stamp] No files need chmodding. Skipping change of permissions for files" >> $logfile
else
	echo -e "[$time_stamp] detecting files in $target_dir NOT set to the following permissions: $permissions\n=" >> $logfile
	## find every file without the required permissions
	find $target_dir ! -perm $permissions -type f >> $logfile
	echo -e "=\n[$time_stamp] modifying permissions on said files" >> $logfile
	## modify permissions in the files found
	find $target_dir ! -perm $permissions -type f -exec chmod $permissions {} \;
	## message of change
	echo "[$time_stamp] DETECTED files PERMISSIONS HAVE BEEN SET TO: $permissions" >> $logfile
fi

##end message
echo "[$time_stamp] ===== END OF CRONJOB" >> $logfile
