#!/bin/bash

# EXPORTS ENV FROM .ENV FILE

if [ -f ".env" ]; then
    set -a
    source ".env"
    set +a
fi

# CHECKS IF POEDITOR_TOKEN IS SET

if [ -z "$POEDITOR_TOKEN" ]; then
    echo "POEDITOR_TOKEN is not set"
    exit 1
fi

# RETRIEVES PROJECTS LIST
# CACHES IT TO .projects.log.json

[ -f ".projects.log.json" ] || curl --verbose --silent -X POST "https://api.poeditor.com/v2/projects/list" -d api_token="$POEDITOR_TOKEN" -o .projects.log.json

# CHECKS IF JQ IS INSTALLED

if ! [ -x "$(command -v jq)" ]; then
    echo "jq is not installed"
    exit 1
fi

# JQ WRAPPER TO DECODE BASE64

_jq() {
  echo ${i} | base64 --decode | jq -r ${1}
}

# FOREACH RESULT PROJECTS ID CURLS POEDITOR API TO DELETE IT


jq -r '.result.projects[] | @base64' .projects.log.json | while read i; do

    project_id=$(_jq '.id')

    if [ -z "$project_id" ]; then
        echo "error reading project_id"
        exit 1
    fi

    result=$(curl --silent -sw '%{http_code}' -X POST "https://api.poeditor.com/v2/projects/delete" -d api_token="$POEDITOR_TOKEN" -d id="$project_id")

    echo "PROJECT $project_id DELETE responded with $result"

done

# DELETES .projects.log.json

rm .projects.log.json
