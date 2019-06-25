# XConnect Collection Service
This container is a utility for the Sitecore xconnect collection service, responsible for provisiiong the databases that the service requires.

## Building the Container Locally

Before building the container, copy a file named `license.xml` and `package.scwdp.zip` to this directory.  To build the container simply type

```docker build .```

## Building the Container in Azure Devops

The build steps are described in the file `azure-pipelines.yml`.  It builds the container and pushes it to an Azure Container Registry named `icfnext.azurecr.io`.

The Sitecore packages and license files are stored in Azure Devops Universal Artifacts.  To update the version of the packge that is build, update the the artifact in DevOps and then change the file name in yml file.

Builds to the registry are triggered off of commits to master.

## Running the container

The following environment variables and mount points are can be configured at runtime.

| Name                                 |Config Type| Required  | Description |
|---                                   |:-:        |:-:        |---          |
|`C:/EnvVarOutput`                     | Mount   | No   | If this volume is provided the container will output a file named `collection-service.out` containing the connection strings for all the databbases provisioned. |
|`SQL_ADMIN_USER`                      | Env Var | Yes  | The SQL admin user name | 
|`SQL_ADMIN_PASSWORD`                  | Env Var | Yes  | The SQL admin password | 
|`SQL_REFERENCE_DATA_USER`             | Env Var | No   | The SQL username for the sql reference db, defaults to `collection-user` | 
|`SQL_REFERENCE_DATA_PASSWORD`         | Env Var | No   | The SQL password for the sql reference db, defaults to `P@ssW0rd123` | 
|`SQL_SERVER`                          | Env Var | Yes  | The name of the SQL Server | 

To provision the databases run a command simliar to this.

```
docker run -e SQL_SERVER=[server-name] -e SQL_ADMIN_USER=[user-name] -e SQL_ADMIN_PASSWORD=[password] -v [Local Directory]:C:\EnvVarOutput  sitecore/xconnect/collection-db-builder
```