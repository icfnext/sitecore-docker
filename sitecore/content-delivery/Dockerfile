# escape=`
FROM icfnext.azurecr.io/sitecore/base:latest

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV INSTALL_TEMP='c:\\install'

COPY ./*.ps1 ${INSTALL_TEMP}/
COPY ./sif-params.json ${INSTALL_TEMP}/
COPY "./package.scwdp.zip" ${INSTALL_TEMP}/
COPY "./license.xml" ${INSTALL_TEMP}/

WORKDIR ${INSTALL_TEMP}

RUN Get-WebSite | Remove-Website; ./sif-install.ps1

EXPOSE 443

ENTRYPOINT ./boot.ps1
