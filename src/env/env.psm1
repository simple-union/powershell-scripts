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
        [string] $Description
    )
    
    $checkResult = $false

    try
    {
        $commandResult = Invoke-Expression $Command
        if ($lastExitCode -eq 0) { $checkResult = $true } else { $checkResult = $false }
    }
    catch { $checkResult = $false }

    if ($checkResult) { Write-Host + $Description } else { Write-Host - $Description }
}



function Test-Env
{
    Test-EnvSubversion
    Test-EnvGit
    Test-EnvMercurial
    Test-EnvNuget
    Test-EnvMSBuild
    Test-EnvDocker
}



function Test-EnvSubversion
{
    Test-EnvCommand "svn help" "subversion"
}

function Test-EnvGit
{
    Test-EnvCommand "git help" "git"
}

function Test-EnvMercurial
{
    Test-EnvCommand "hg help" "mercurial"
}

function Test-EnvNuget
{
    Test-EnvCommand "nuget help" "nuget"
}

function Test-EnvMSBuild
{
    Test-EnvCommand "msbuild /help" "msbuild"
}

function Test-EnvDocker
{
    Test-EnvCommand "docker --help" "docker"
}



# export
Export-ModuleMember -function Test-EnvCommand

Export-ModuleMember -function Test-Env

Export-ModuleMember -function Test-EnvSubversion
Export-ModuleMember -function Test-EnvGit
Export-ModuleMember -function Test-EnvMercurial

Export-ModuleMember -function Test-EnvNuget

Export-ModuleMember -function Test-EnvMSBuild

Export-ModuleMember -function Test-EnvDocker
