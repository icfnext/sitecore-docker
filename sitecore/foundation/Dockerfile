# escape=`
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2-windowsservercore-ltsc2019

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV INSTALL_TEMP='c:\\install'
ENV VCREDISTX64_EXE=${INSTALL_TEMP}/VC_redist.x64.exe
ENV WPI_MSI='C:/Program Files/Microsoft/Web Platform Installer/WebpiCmd-x64.exe'

ADD https://aka.ms/vs/15/release/VC_redist.x64.exe ${VCREDISTX64_EXE}
COPY ./*.ps1 ${INSTALL_TEMP}/
COPY ./*.dll ${INSTALL_TEMP}/
COPY ./*.xml ${INSTALL_TEMP}/

# Install Sitecore dependencies, SIF, choco, vim
RUN Start-Process $env:VCREDISTX64_EXE -ArgumentList '/install', '/passive', '/norestart' -NoNewWindow -Wait; `
    Install-PackageProvider -Name NuGet -Force | Out-Null; `
    Register-PSRepository -Name SitecoreGallery -SourceLocation https://sitecore.myget.org/F/sc-powershell/api/v2; `
    Install-Module SitecoreInstallFramework -RequiredVersion 2.1.0 -Force; `
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); 

RUN Write-Host 'Web Platform Installer' ; `
    $WebPlatform = $env:INSTALL_TEMP + '\wpi.msi' ; `
    (New-Object Net.WebClient).DownloadFile('https://download.microsoft.com/download/C/F/F/CFF3A0B8-99D4-41A2-AE1A-496C08BEB904/WebPlatformInstaller_amd64_en-US.msi', $WebPlatform) ; `
    Write-Host 'Installing Web Platform Installer' ; `
    Start-Process msiexec.exe -ArgumentList '/i', $WebPlatform, '/quiet', '/norestart' -NoNewWindow -Wait

RUN Start-Process $env:WPI_MSI -ArgumentList '/Install', '/AcceptEULA', '/SuppressReboot', '/Products:WDeploy36PS' -NoNewWindow -Wait -PassThru;

# Need to install and register somethiing newer than DAC for SQL Server 2016
# https://kb.sitecore.net/articles/019579
# DacFx SQL Server 2017 x64
RUN Write-Host 'Dac Fx' ; `
    $DacFx64 = $env:INSTALL_TEMP + '\dacFx_64.msi' ; `
    (New-Object Net.WebClient).DownloadFile('https://download.microsoft.com/download/F/9/3/F938FCDD-3FAF-40DF-A530-778898E2E5EE/EN/x64/DacFramework.msi', $DacFx64) ; `
    Write-Host 'Installing Dac Fx x64' ; `
    Start-Process msiexec.exe -ArgumentList '/i', $DacFx64, '/quiet', '/norestart' -NoNewWindow -Wait

# DacFx SQL Server 2017 x86
RUN Write-Host 'Dac Fx' ; `
    $DacFx86 = $env:INSTALL_TEMP + '\dacFx_86.msi' ; `
    (New-Object Net.WebClient).DownloadFile('https://download.microsoft.com/download/5/2/8/528EE32B-A63B-462A-BF86-48EDE3DDF5A6/EN/x86/DacFramework.msi', $DacFx86) ; `
    Write-Host 'Installing Dac Fx x86' ; `
    Start-Process msiexec.exe -ArgumentList '/i', $DacFx86, '/quiet', '/norestart' -NoNewWindow -Wait

# SQL Server CLR Types 2017
RUN Write-Host 'SQL CLR Types' ; `
    $SqlClrTypes = $env:INSTALL_TEMP + '\dacFx.msi' ; `
    (New-Object Net.WebClient).DownloadFile('https://download.microsoft.com/download/C/1/9/C1917410-8976-4AE0-98BF-1104349EA1E6/x64/SQLSysClrTypes.msi', $SqlClrTypes) ; `
    Write-Host 'Installing SQL CLR Types' ; `
    Start-Process msiexec.exe -ArgumentList '/i', $SqlClrTypes, '/quiet', '/norestart' -NoNewWindow -Wait

# Register 
RUN $SqlClrTypes = 'C:\Program Files (x86)\Microsoft SQL Server\140\DAC\bin'; `
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\IIS Extensions\MSDeploy\3' -Name "DacFxPath" -Value "$SqlClrTypes"; `
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\IIS Extensions\MSDeploy\3' -Name "DacFxDependenciesPath" -Value "$SqlClrTypes"
