# escape=`
ARG REPOSITORY=icfnext.azurecr.io/
ARG TAG=latest
FROM sitecore/xconnect/cortex-processing/foundation:${TAG}

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV INSTALL_TEMP='c:\\install'

COPY ./*.ps1 ${INSTALL_TEMP}/

WORKDIR ${INSTALL_TEMP}

ENTRYPOINT ./boot.ps1
