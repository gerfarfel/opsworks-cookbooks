#!/bin/bash
bucket=doink-backup

function backup() {
 what=$1

 database=$what
 temp_dir=$(mktemp -d /tmp/$what.XXXXXXX)
 trap "rm -rf $temp_dir" INT EXIT
 cd $temp_dir

 folder=mongoBackup
 when=$(date '+%Y-%m-%d-%H-%M-%S')
 backup_file=$what-$when.tar.gz
 mongodump -d $database -o $folder
 tar --create --gzip --file $backup_file $folder
 s3cmd  -c /home/ubuntu/.s3cfg put $backup_file s3://$bucket/$database/$backup_file
}

backup doink
