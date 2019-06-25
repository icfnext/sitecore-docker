# escape=`
ARG REPOSITORY=icfnext.azurecr.io/
ARG TAG=latest
FROM ${REPOSITORY}sitecore/foundation:${TAG}

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV INSTALL_TEMP='c:\\install'

COPY ./*.ps1 ${INSTALL_TEMP}/

RUN powershell (new-object System.Net.WebClient).Downloadfile('https://javadl.oracle.com/webapps/download/AutoDL?BundleId=238729_478a62b7d4e34b78b671c754eaaf38ab', 'C:\jre-8u211-windows-x64.exe')
RUN powershell start-process -filepath C:\jre-8u211-windows-x64.exe -passthru -wait -argumentlist "/s,INSTALLDIR=C:\Java\jre1.8.0_211,/L,install64.log"
RUN del C:\jre-8u211-windows-x64.exe

WORKDIR ${INSTALL_TEMP}

EXPOSE 443

RUN ./install-solr.ps1
