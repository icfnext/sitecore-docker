# Creating Self Signed Certs

This container can be used to create self signed certs by providing two values:

* The export password as an environment variabble
* Mounting a local folder for certificates to bbe exported to

```
docker run -e EXPORT_PASSWORD=secret -v C:\Projects\sitecore-sandbox\certs:C:\Certificates sitecore/util:latest
```