# module "testing"



# vars
$TestingModuleBasePath = $PSScriptRoot

$xUnitRunnerPathNETFramework = "$TestingModuleBasePath/testing/tools/xunit.runner.console/net452/xunit.console.exe"
$xUnitRunnerPathNETCore = "$TestingModuleBasePath/testing/tools/xunit.runner.console/netcoreapp2.0/xunit.console.dll"
$xUnitResultPath = "./.xunit/"


# import modules
Import-Module $TestingModuleBasePath/../project/project.psm1


# functions
function Invoke-Testing
{
    Invoke-TestingxUnit
}


function Invoke-TestingxUnit
{
    $items = Get-ChildItem -File -Filter *.sln -Recurse -Force
    foreach ($item in $items)
    {
        msbuild /t:build $item.FullName
    }
}


# export
Export-ModuleMember -function Invoke-Testing

Export-ModuleMember -function Invoke-TestingxUnit
 