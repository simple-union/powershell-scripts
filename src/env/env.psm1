# module "env"


# vars
$EnvModuleBasePath = $PSScriptRoot


# functions
function Test-EnvCommand
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string] $Command,
        [Parameter(Mandatory=$true, Position=1)]
        [string] $Description,
        [Parameter(Mandatory=$false, Position=2)]
        [string] $PrintResult = $false
    )
    
    $checkResult = $false

    try
    {
        $commandResult = Invoke-Expression $Command
        if ($lastExitCode -eq 0) { $checkResult = $true } else { $checkResult = $false }
    }
    catch { $checkResult = $false }

    if ($PrintResult)
    {
        if ($checkResult) { Write-Host + $Description } else { Write-Host - $Description }
    }

    return $checkResult
}


# full check
function Test-Env
{
    Test-EnvSubversion
    Test-EnvGit
    Test-EnvMercurial
    $checkResult = Test-EnvDotNet
    if ($checkResult)
    {
        Test-EnvDotNet20
        Test-EnvDotNet21
        Test-EnvDotNet30
        Test-EnvDotNet31
    }
    $checkResult = Test-EnvPython
    if ($checkResult)
    {
        Test-EnvPython27
        Test-EnvPython36
        Test-EnvPython37
        Test-EnvPython38
        Test-EnvPython39
    }
    Test-EnvNuget
    Test-EnvMSBuild
    Test-EnvDocker
}


# CVS
function Test-EnvSubversion
{
    Test-EnvCommand "svn help" "subversion" $true
}

function Test-EnvGit
{
    Test-EnvCommand "git help" "git" $true
}

function Test-EnvMercurial
{
    Test-EnvCommand "hg help" "mercurial" $true
}

function Test-EnvNuget
{
    Test-EnvCommand "nuget help" "nuget" $true
}


# runtimes
## .NET
function Test-EnvDotNet
{
    Test-EnvCommand "dotnet --help" "dotnet" $true
}

function Test-EnvDotNet20
{
    Test-EnvCommand "dotnet --help" "dotnet 2.0" $true
}

function Test-EnvDotNet21
{
    Test-EnvCommand "dotnet --help" "dotnet 2.1" $true
}

function Test-EnvDotNet30
{
    Test-EnvCommand "dotnet --help" "dotnet 3.0" $true
}

function Test-EnvDotNet31
{
    Test-EnvCommand "dotnet --help" "dotnet 3.1" $true
}

## Python
function Test-EnvPython
{
    Test-EnvCommand "python -V" "python" $true
}

function Test-EnvPython27
{
    Test-EnvCommand "python2.7 -V" "python 2.7" $true
}

function Test-EnvPython36
{
    Test-EnvCommand "python3.6 -V" "python 3.6" $true
}

function Test-EnvPython37
{
    Test-EnvCommand "python3.7 -V" "python 3.7" $true
}

function Test-EnvPython38
{
    Test-EnvCommand "python3.8 -V" "python 3.8" $true
}

function Test-EnvPython39
{
    Test-EnvCommand "python3.9 -V" "python 3.9" $true
}


# build systems
function Test-EnvMSBuild
{
    Test-EnvCommand "msbuild /help" "msbuild" $true
}


# tools
function Test-EnvDocker
{
    Test-EnvCommand "docker --help" "docker" $true
}


# export
Export-ModuleMember -function Test-EnvCommand

Export-ModuleMember -function Test-Env

Export-ModuleMember -function Test-EnvSubversion
Export-ModuleMember -function Test-EnvGit
Export-ModuleMember -function Test-EnvMercurial

Export-ModuleMember -function Test-EnvDotNet
Export-ModuleMember -function Test-EnvDotNet20
Export-ModuleMember -function Test-EnvDotNet21
Export-ModuleMember -function Test-EnvDotNet30
Export-ModuleMember -function Test-EnvDotNet31

Export-ModuleMember -function Test-EnvPython
Export-ModuleMember -function Test-EnvPython27
Export-ModuleMember -function Test-EnvPython36
Export-ModuleMember -function Test-EnvPython37
Export-ModuleMember -function Test-EnvPython38
Export-ModuleMember -function Test-EnvPython39

Export-ModuleMember -function Test-EnvNuget

Export-ModuleMember -function Test-EnvMSBuild

Export-ModuleMember -function Test-EnvDocker
