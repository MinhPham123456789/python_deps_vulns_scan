#!/bin/bash

# Check reports directory
if [ ! -d "./reports" ]; then
    mkdir reports
fi

report_path="./reports"
# Create a directory for today
today_report_path=$(date '+%Y_%m_%d')
if [ ! -d "${report_path}/${today_report_path}" ]; then
    mkdir "${report_path}/${today_report_path}"
fi

# Create a directory for time
time_report=$(date '+%H_%M_%S')
if [ ! -d "${report_path}/${today_report_path}/${time_report}" ]; then
    mkdir "${report_path}/${today_report_path}/${time_report}"
fi
report_deep_path="${report_path}/${today_report_path}/${time_report}"
# Generate the report
report_name="${time_report}_report.txt"
echo "Saving to ${report_path}/${today_report_path}/${report_name}"
./python_deps_vulns_scan.sh $report_deep_path |& tee ${report_deep_path}/${report_name}