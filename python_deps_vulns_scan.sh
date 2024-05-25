#!/bin/bash

# Get the passing parameter
report_path=${1}
# Check the base environment
deactivate
echo "##### python base env ####################################"
echo "### Checking updates ##################"
echo "## Updating pip ############"
pip install --upgrade pip --quiet
echo "## Updating safety ############"
pip install --upgrade safety --quiet
echo "## Updating pip-audit ############"
pip install --upgrade pip-audit --quiet
echo "## Updating jake ############"
pip install --upgrade jake --quiet
echo "### Scanning with safety ##################"
$HOME/.local/bin/safety scan --policy-file ./.safety-policy.yml
echo "### Scanning with pip-audit ##################"
$HOME/.local/bin/pip-audit
echo "### Scanning with jake ##################"
pip freeze > "${report_path}/base_py_deps.txt"
$HOME/.local/bin/jake ddt -f "${report_path}/base_py_deps.txt" --clear-cache

# Change env
env_prefix="${HOME}/pyvenvs/"
env_suffix="/bin/activate"
dirs=$(ls $env_prefix)
envs=($dirs)

for env in ${envs[@]}
do
    env_path="${env_prefix}${env}${env_suffix}"
    echo "###### python ${env} env, env path ${env_path} ####################################"
    source $env_path
    echo "### Checking updates ##################"
    echo "## Updating pip ############"
    pip install --upgrade pip --quiet
    echo "## Updating safety ############"
    pip install --upgrade safety --quiet
    echo "## Updating pip-audit ############"
    pip install --upgrade pip-audit --quiet
    echo "## Updating jake ############"
    pip install --upgrade jake --quiet
    echo "### Scanning with safety ##################"
    safety scan --policy-file ./.safety-policy.yml
    echo "### Scanning with pip-audit ##################"
    pip-audit
    echo "### Scanning with jake ##################"
    pip freeze > "${report_path}/${env}_py_deps.txt"
    jake ddt -f "${report_path}/${env}_py_deps.txt" --clear-cache
    deactivate
done

# System wide scan with safety
echo "###### System scan with Safety ####################################"
$HOME/.local/bin/safety system-scan