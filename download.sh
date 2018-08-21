#!/bin/sh

if [[ -z "${AZURE_BLOB_URL}" ]]; then
  echo AZURE_BLOB_URL not defined
  exit 1
fi

if [[ -z "${AZURE_BLOB_KEY}" ]]; then
  echo AZURE_BLOB_KEY not defined
  exit 1
fi

DEFAULT_DESTINATION="/home/azure/mount/blob"

DESTINATION=${BLOB_DESTINATION:-DEFAULT_DESTINATION}

SLEEP_INTERVAL=${AZURE_SLEEP_INTERVAL:-2}

cleanup ()
{
kill -s SIGTERM $!
exit 0
}

trap cleanup SIGINT SIGTERM

while true
do 
    azcopy --source ${AZURE_BLOB_URL} --destination ${DESTINATION} --source-key ${AZURE_BLOB_KEY} --preserve-last-modified-time --recursive --exclude-older --quiet
    sleep ${SLEEP_INTERVAL}
done
