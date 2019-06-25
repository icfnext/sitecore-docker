# escape=`
ARG REPOSITORY=icfnext.azurecr.io/
ARG TAG=latest
FROM ${REPOSITORY}solr-win:${TAG}

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV INSTALL_TEMP='c:\\install'

COPY ./*.ps1 ${INSTALL_TEMP}/
COPY ./*.json ${INSTALL_TEMP}/

WORKDIR ${INSTALL_TEMP}

RUN ./sitecore-solr.ps1; ./xconnect-solr.ps1; ./sitecore-sxa-solr.ps1
