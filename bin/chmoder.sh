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
echo "[$time_stamp] detecting file in $target_dir with any of the following missing permissions: $permissions" >> $logfile

## find every file without the required permissions
find $target_dir ! -perm $permissions -type f -exec ls -l {} \;
