# Logstash azcopy sidecar

## Introduction
Running applications in a App Service in Azure I want to be able to pick up those logs and insert them into my elasticsearch cluster. There are several ways of doing that which all would work fine.

Ways of accomplish that could be:
- Filebeat installed as a webjob in Azure
- Custom code to push to logstash/elastic
- Other plugins available on the internet

This plugin allows for logstash to use the log files added to a storage container in Azure as local files available for pickup.

## How it works
The container will download the logs, checking last-modified etc to download *only* the changed files.
You need to give the url of the container, the access key and optinally how long it should sleep between each run against azure. Default sleep is 2 seconds.

The log files is downloaded to the folder /home/azure/mount and is kept in the folder blob under that mount.
It would be possible to mount a disk on the host to this folder if you are running barebone docker. A deployment for kubernetes has been added to show how logstash and this sidecar can work together.

## Kubernetes

I have provided an example on how to deploy this into a kubernetes cluster.
Change the environment variables.

### Kubernetes disk
The example use an empty disk which is not probably what you want in production.
THe disk should be persistent to avoid having to download all files in the sidecar again.
Logstash pipeline will also write it sincedb to this mounted disk.
