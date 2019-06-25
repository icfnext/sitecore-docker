function Ensure-Env {
  param ([string]$Name)

    if ( -not (Test-Path "Env:/$Name") ) 
    {
        throw "Environment Variablbe $Name is required"
    }
}

function Ensure-Mount {
  param ([string]$Name)

    if ( -not (Test-Path "C:/$Name") ) 
    {
        throw "C:/$Name mount point is required."
    }
}

function Ensure-Optional-Env {
  param ([string]$Name, [string]$DefaultValue)

    if ( -not (Test-Path "Env:/$Name") ) 
    {
        [Environment]::SetEnvironmentVariable($Name, $DefaultValue)
    }
}
