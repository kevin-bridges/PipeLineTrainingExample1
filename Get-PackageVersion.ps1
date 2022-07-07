<#
.SYNOPSIS
  Returns array contiaing version prefix and suffix from csproj file.
.DESCRIPTION
  Returns array contiaing version prefix and suffix from csproj file. 

.NOTES
 Version       :  1.0
 Author        :  Kevin Bridges
 Creation Date :  28 JAN 2022
 Purpose/Change: 
 Dependencies  : 
.EXAMPLE 
PS:> $var = .\Get-PackageVersion.ps1 -filename .\app.csproj
    Results:
        $var[0] --> 1.0.0
        $var[1] --> debug
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)] [string] $filename
  
)

function Get-XMLPackageValues {
    param (
        $file = $filename
    )
    [xml]$xmlElm = Get-Content -Path $file
    $versionPrefix = $xmlElm.Project.PropertyGroup.VersionPrefix
    $versionSuffix = $xmlElm.Project.PropertyGroup.VersionSuffix
    $data = @($versionPrefix,$versionSuffix)
    return $data
}

if (Test-Path $filename) {
    if ((Split-Path $filename -Leaf).Split('.')[1] -eq "csproj"){
        return Get-XMLPackageValues $filename
    }
    else {
        throw "csproj file extension expected"
    }
}
else {
    throw "File [$filename] not found."
}
