# escape=`
ARG REPOSITORY=icfnext.azurecr.io/
ARG TAG=latest
FROM ${REPOSITORY}sitecore/foundation:${TAG}

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV INSTALL_TEMP='c:\\install'

COPY ./sif-params.json ${INSTALL_TEMP}/
COPY ./package.scwdp.zip ${INSTALL_TEMP}/
COPY ./license.xml ${INSTALL_TEMP}/
