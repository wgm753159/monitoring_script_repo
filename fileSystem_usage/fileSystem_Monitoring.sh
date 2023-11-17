#!/bin/bash

# Set the threshold
THRESHOLD=20

# Email details
SUBJECT="Filesystem Usage Alert on $(hostname)"
RECIPIENT="your-email@example.com"
MESSAGE="/Users/gmw/filesystem_monitor_sh/filesystem-usage.txt"

# Check each filesystem
df -hP | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
do
  usage=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
  partition=$(echo $output | awk '{ print $2 }' )

  if [ $usage -ge $THRESHOLD ]; then
    echo "The partition \"$partition\" on $(hostname) is at $usage%." >> $MESSAGE
  fi
done

# Send email if any partition is above the threshold
if [ -f $MESSAGE ]; then
  mail -s "$SUBJECT" $RECIPIENT < $MESSAGE
#  rm $MESSAGE
fi

