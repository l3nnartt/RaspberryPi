#!/bin/bash
echo "Starting copy script"

incoming_files_dir=/home/lennart/sharedordner/sensor_files_incomming/
archive_files_dir=/home/lennart/sharedordner/sensor_files_incomming/Archived/
exporting_files_dir=/home/lennart/sharedordner/sensor_files_exports/
datum=$(date +"%Y%m%d_%H%M%S")_

for file in $incoming_files_dir*.xml
do
        echo "Processing $file"
        cp  $file $archive_files_dir$datum$(basename $file)
        mv $file $exporting_files_dir
done