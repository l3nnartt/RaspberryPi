# Cronjob Job

Edit with `crontab -e`
```
*/5 */2 * * * /home/sharedordner/check.sh >/dev/null 2>&1
```

Create folder  in ~ named `sharedordner`

Bash Script to check & move/rename the file(s)
```
lennart@lennart-pi:~/sharedordner $ cat check.sh
#!/bin/bash
echo "Starting copy script"

incomming_files_dir=/home/lennart/sharedordner/sensor_files_incomming/
archive_files_dir=/home/lennart/sharedordner/sensor_files_incomming/Archived/
exporting_files_dir=/home/lennart/sharedordner/sensor_files_exports/
datum=$(date +"%Y%m%d_%H%M%S")

for file in $incomming_files_dir*.xml
do
        echo "Processing $file"
        cp  $file $archive_files_dir$datum$(basename $file)
        mv $file $exporting_files_dir
done
lennart@lennart-pi:~/sharedordner $
```