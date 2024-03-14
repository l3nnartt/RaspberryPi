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
datum=$(date +"%Y%m%d_%H%M%S")_

for file in $incomming_files_dir*.xml
do
        echo "Processing $file"
        cp  $file $archive_files_dir$datum$(basename $file)
        mv $file $exporting_files_dir
done
lennart@lennart-pi:~/sharedordner $
```

Folder structure looks like:

```
lennart@lennart-pi:~/sharedordner $ ls -la
total 20
drwxr-xr-x 4 lennart lennart 4096 Mar 14 15:24 .
drwxr-xr-x 6 lennart lennart 4096 Mar 14 15:22 ..
-rw-r--r-- 1 lennart lennart  446 Mar 14 15:24 check.sh
drwxr-xr-x 2 lennart lennart 4096 Mar 14 15:24 sensor_files_exports
drwxr-xr-x 3 lennart lennart 4096 Mar 14 15:24 sensor_files_incomming
lennart@lennart-pi:~/sharedordner $ ls -la ./sensor_files_incomming/
total 16
drwxr-xr-x 3 lennart lennart 4096 Mar 14 15:24 .
drwxr-xr-x 4 lennart lennart 4096 Mar 14 15:24 ..
drwxr-xr-x 2 lennart lennart 4096 Mar 14 15:24 Archived
-rw-r--r-- 1 lennart lennart  678 Mar  7 16:26 TemperaturSensor_X3DDS20221014.xml
lennart@lennart-pi:~/sharedordner $ ls -la ./sensor_files_exports/
total 8
drwxr-xr-x 2 lennart lennart 4096 Mar 14 15:24 .
drwxr-xr-x 4 lennart lennart 4096 Mar 14 15:24 ..
lennart@lennart-pi:~/sharedordner $
```