FROM centos:7

USER root
RUN rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm && yum -y update && yum -y install rsync libunwind icu dotnet-sdk-2.1
RUN mkdir azcopy && cd azcopy && curl -L https://aka.ms/downloadazcopylinux64 -o azcopy.tar.gz && tar -xf azcopy.tar.gz && ./install.sh && cd .. && rm -Rf azcopy
COPY download.sh /usr/local/bin
RUN chmod +x /usr/local/bin/download.sh

# Provide a non-root user to run the process.
RUN groupadd --gid 1000 azure && \
    adduser --uid 1000 --gid 1000 \
      --home-dir /home/azure \
      azure

USER azure
ENTRYPOINT [ "download.sh" ]