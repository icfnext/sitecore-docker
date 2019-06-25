# escape=`
FROM icfnext.azurecr.io/sitecore/base:latest

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV INSTALL_TEMP='c:\\install'

COPY ./sif-install.ps1 ${INSTALL_TEMP}/
COPY ./sif-params.json ${INSTALL_TEMP}/

WORKDIR ${INSTALL_TEMP}

ENTRYPOINT ./sif-install.ps1
