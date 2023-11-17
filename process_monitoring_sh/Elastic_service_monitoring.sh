#!/bin/bash

# Check if Elasticsearch process is running
process_count=$(ps aux | grep -v grep | grep -ic 'elasticsearch')

# Check if Elasticsearch service is active and running
service_status=$(systemctl status elasticsearch | grep -c 'active (running)')

#another condition to check elastic # && [ $service_status -gt 0 ] #
#command to show all running services #systemctl list-units --type=service --state=running

if [ $process_count -gt 0 ]; then
    echo "Elasticsearch service is active and running."
else
    echo "Elasticsearch is not running."
fi
