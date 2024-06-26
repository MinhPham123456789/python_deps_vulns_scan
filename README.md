# Shell script for Python dependencies vulnerability scanning
## Overview
This repository contains a small project to combine 3 Python dependencies vulnerability scanning tools to scan your python environments
This tool currently implemented for native python environment and the python virtual environment (venv)

## Installation
```
git clone https://github.com/MinhPham123456789/python_deps_vulns_scan.git
cd python_deps_vulns_scan
pip install -r requirements.txt
safety generate policy_file
```

## Usage
+ Open a terminal and make sure it is not in any python venv environment
    + In case, it is has a python venv env activated, run `deactivate`
+ Go into the repository and give execute permission to `run_scan.sh` and `python_deps_vulns_scan.sh`
+ Run `run_scan.sh`
+ The result is in the `reports` directory

## How the script uses the tools
+ safety commands
    + `safety scan`
    + `safety system-scan`
+ pip-audit commands
    + `pip-audit`
+ jake commands
    + `jake ddt`

## Vulnerability scanning tools
+ safety (https://github.com/pyupio/safety)
+ pip-audit (https://github.com/pypa/pip-audit)
+ jake (https://github.com/sonatype-nexus-community/jake)

## Note
Jake's dependencies have conflict; however jake can still be run in ddt mode currently
