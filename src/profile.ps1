# Profile


# vars
$ProfileBasePath = $PSScriptRoot


# import modules
Import-Module -Force -Global $ProfileBasePath/env/env.psm1
Import-Module -Force -Global $ProfileBasePath/project/project.psm1
Import-Module -Force -Global $ProfileBasePath/testing/testing.psm1
