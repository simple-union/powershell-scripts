# module "env"



# vars
$EnvModuleBasePath = $PSScriptRoot



# functions
function Invoke-EnvCheck
{
    Invoke-EnvGitCheck
    Invoke-EnvNugetCheck
    Invoke-EnvMSBuildCheck
    Invoke-EnvDockerCheck
}

function Invoke-EnvGitCheck
{
    $result = git help
    if ($lastExitCode -eq 0) { Write-Host + git } else { Write-Host - git }
}

function Invoke-EnvNugetCheck
{
    $result = nuget help
    if ($lastExitCode -eq 0) { Write-Host + nuget } else { Write-Host - nuget }
}

function Invoke-EnvMSBuildCheck
{
    $result = msbuild /help
    if ($lastExitCode -eq 0) { Write-Host + msbuild } else { Write-Host - msbuild }
}

function Invoke-EnvDockerCheck
{
    $result = docker -h
    if ($lastExitCode -eq 0) { Write-Host + docker } else { Write-Host - docker }
}

function Invoke-EnvPrepare
{
    Invoke-EnvDockerPrepare
}

function Invoke-EnvDockerPrepare
{
    Invoke-EnvDockerPrepareMsSql
    Invoke-EnvDockerPreparePostgreSql
    Invoke-EnvDockerPrepareMySql
    Invoke-EnvDockerPrepareRedisSentinel
    Invoke-EnvDockerPrepareRabbitMQ
    Invoke-EnvDockerPrepareGraphite
}

function Invoke-EnvDockerPrepareMsSql
{
    docker stop simpleunion_mssql
    docker rm simpleunion_mssql
    docker pull microsoft/mssql-server-linux:latest
    docker run -d `
               --name simpleunion_mssql `
               --restart=always `
               -p 1433:1433 `
               -e 'ACCEPT_EULA=Y' `
               -e 'SA_PASSWORD=P@ssWord' `
               microsoft/mssql-server-linux:latest
}

function Invoke-EnvDockerPreparePostgreSql
{
    docker stop simpleunion_postgresql
    docker rm simpleunion_postgresql
    docker pull postgres:latest
    docker run -d `
               --name simpleunion_postgresql `
               --restart=always `
               -p 5432:5432 `
               postgres:latest
}

function Invoke-EnvDockerPrepareMySql
{
    docker stop simpleunion_mysql
    docker rm simpleunion_mysql
    docker pull mysql:latest
    docker run -d `
               --name simpleunion_mysql `
               --restart=always `
               -p 3306:3306 `
               -p 33060:33060 `
               -e 'MYSQL_ROOT_PASSWORD=P@ssWord' `
               mysql:latest
}

function Invoke-EnvDockerPrepareRedisSentinel
{
    docker stop simpleunion_redis-sentinel
    docker rm simpleunion_redis-sentinel
    docker pull joshula/redis-sentinel
    docker run -d `
               --name simpleunion_redis-sentinel `
               --restart=always `
               -p 26379:26379 `
               joshula/redis-sentinel
}

function Invoke-EnvDockerPrepareRabbitMQ
{
    docker stop simpleunion_rabbitmq
    docker rm simpleunion_rabbitmq
    docker pull rabbitmq:latest
    docker run -d `
               --name simpleunion_rabbitmq `
               --restart=always `
               -p 4369:4369 `
               -p 5671:5671 `
               -p 5672:5672 `
               -p 25672:25672 `
               rabbitmq:latest
}

function Invoke-EnvDockerPrepareGraphite
{
    docker stop simpleunion_graphite
    docker rm simpleunion_graphite
    docker pull graphiteapp/graphite-statsd
    docker run -d `
               --name simpleunion_graphite `
               --restart=always `
               -p 10080:80 `
               -p 2003-2004:2003-2004 `
               -p 2023-2024:2023-2024 `
               -p 8125:8125/udp `
               -p 8126:8126 `
               graphiteapp/graphite-statsd:latest
}



# export
Export-ModuleMember -function Invoke-EnvCheck
Export-ModuleMember -function Invoke-EnvGitCheck
Export-ModuleMember -function Invoke-EnvNugetCheck
Export-ModuleMember -function Invoke-EnvMSBuildCheck
Export-ModuleMember -function Invoke-EnvDockerCheck

Export-ModuleMember -function Invoke-EnvPrepare
Export-ModuleMember -function Invoke-EnvDockerPrepare
Export-ModuleMember -function Invoke-EnvDockerPrepareMsSql
Export-ModuleMember -function Invoke-EnvDockerPreparePostgreSql
Export-ModuleMember -function Invoke-EnvDockerPrepareMySql
Export-ModuleMember -function Invoke-EnvDockerPrepareRedisSentinel
Export-ModuleMember -function Invoke-EnvDockerPrepareRabbitMQ
Export-ModuleMember -function Invoke-EnvDockerPrepareGraphite
