# escape=`
ARG REPOSITORY=icfnext.azurecr.io/
ARG TAG=latest
FROM ${REPOSITORY}sitecore/xconnect/collection-search-solr/foundation:${TAG}

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV INSTALL_TEMP='c:\\install'

COPY ./*.ps1 ${INSTALL_TEMP}/

WORKDIR ${INSTALL_TEMP}

RUN Get-WebSite | Remove-Website; ./sif-install.ps1

ENTRYPOINT ./boot.ps1
