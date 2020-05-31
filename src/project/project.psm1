# module "project"



# vars
$ProjectModuleBasePath = $PSScriptRoot

$DirectoriesToRemoving = "packages","bin","obj","logs",".logs","publish",".publish"
$DirectoriesToRemovingAdditional = ".vs",".vscode",".idea"
$FilesToRemoving = "*.cache","*.log","*.o"
$FilesToRemovingAdditional = "*.vspscc","*.pubxml","*.bak","*.DotSettings.user"



# functions
function Invoke-ProjectClean
{
    Param
    (
         [Parameter(Mandatory=$false, Position=0)]
         [switch] $IncludeAdditional = $false
    )

    # clean directories
    foreach ($DirectoryToRemoving in $DirectoriesToRemoving)
    {
        $items = Get-ChildItem -Directory -Filter $DirectoryToRemoving -Recurse -Force
        foreach ($item in $items)
        {
            Write-Host Removing directory $item.FullName
            Remove-Item $item.FullName -Force -Recurse
        }
    }
    if ($IncludeAdditional)
    {
        foreach ($DirectoryToRemovingAdditional in $DirectoriesToRemovingAdditional)
        {
            $items = Get-ChildItem -Directory -Filter $DirectoryToRemovingAdditional -Recurse -Force
            foreach ($item in $items)
            {
                Write-Host Removing additional directory $item.FullName
                Remove-Item $item.FullName -Force -Recurse
            }
        }
    }
    # clean files
    foreach ($FileToRemoving in $FilesToRemoving)
    {
        $items = Get-ChildItem -File -Filter $FileToRemoving -Recurse -Force
        foreach ($item in $items)
        {
            Write-Host removing file $item.FullName
            Remove-Item $item.FullName -Force
        }
    }
    if ($IncludeAdditional)
    {
        foreach ($FileToRemovingAdditional in $FilesToRemovingAdditional)
        {
            $items = Get-ChildItem -File -Filter $FileToRemovingAdditional -Recurse -Force
            foreach ($item in $items)
            {
                Write-Host Removing additional file $item.FullName
                Remove-Item $item.FullName -Force
            }
        }
    }
}

function Invoke-ProjectRestore
{
    Invoke-ProjectNugetRestore
}

function Invoke-ProjectCleanAndRestore
{
    Invoke-ProjectClean
    Invoke-ProjectRestore
}

function Invoke-ProjectNugetRestore
{
    $items = Get-ChildItem -File -Filter *.sln -Recurse -Force
    foreach ($item in $items)
    {
        nuget restore $item.FullName
    }
}



# export
Export-ModuleMember -function Invoke-ProjectClean
Export-ModuleMember -function Invoke-ProjectRestore
Export-ModuleMember -function Invoke-ProjectCleanAndRestore

Export-ModuleMember -function Invoke-ProjectNugetRestore
