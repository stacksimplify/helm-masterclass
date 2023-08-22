# Mychart2 - Helm Upgrade with Chart Versions

## Step-01: Introduction
- We are going to learn some additional flags for `helm search repo` command
- We are going to Install and Upgrade Helm Releases using Chart Versions
- In addition, we are going to learn about Helm Rollback 

## Step-02: Search Helm Repo for mychart2
- mychart2 has 4 chart versions (0.1.0, 0.2.0, 0.3.0, 0.4.0)
- mychart2 Chart Versions -> App Version
- 0.1.0 -> 1.0.0
- 0.2.0 -> 2.0.0
- 0.3.0 -> 0.3.0
- 0.4.0 -> 0.4.0
```t
# Search Helm Repo
helm search repo mychart2
Observation: Should display latest version of mychart2 from stacksimplify helm repo

# Search Helm Repo with --versions
helm search repo mychart2 --versions
Observation: Should display all versions of mychart2

# Search Helm Repo with --version
helm search repo mychart2 --version "CHART-VERSIONS"
helm search repo mychart2 --version "0.2.0"
Observation: Should display specified version of helm chart 
```

## Step-03: Install Helm Chart by specifying Chart Version
```t
# Install Helm Chart by specifying Chart Version
helm install myapp101 stacksimplify/mychart2 --version "CHART-VERSION"
helm install myapp101 stacksimplify/mychart2 --version "0.1.0"

# List Helm Release
helm list myapp101

# List Kubernetes Resources Deployed as part of this Helm Release
helm status myapp101 --show-resources

# Access Application
http://localhost:31232

# View Pod logs
kubectl get pods
kubectl logs -f POD-NAME
```

## Step-04: Helm Upgrade using Chart Version
```t
# Helm Upgrade using Chart Version
helm upgrade myapp101 stacksimplify/mychart2 --version "0.2.0"

# List Helm Release
helm list 

# List Kubernetes Resources Deployed as part of this Helm Release
helm status myapp101 --show-resources

# Access Application
http://localhost:31232

# List Release History
helm history myapp101
```

## Step-05: Helm Upgrade without Chart Version
```t
# Helm Upgrade using Chart Version
helm upgrade myapp101 stacksimplify/mychart2

# List Helm Release
helm list 

# List Kubernetes Resources Deployed as part of this Helm Release
helm status myapp101 --show-resources

# Access Application
http://localhost:31232
Observation: Should take the latest release which is Appversion 4.0.0, Chart Version 0.4.0

# List Release History
helm history myapp101
```

## Step-06: Helm Rollback
- Roll back a release to a previous revision or a specific revision
```t
# Rollback to previous version
helm rollback RELEASE-NAME 
helm rollback myapp101

# List Helm Release
helm list 

# List Kubernetes Resources Deployed as part of this Helm Release
helm status myapp101 --show-resources

# Access Application
http://localhost:31232
Observation: Should see V2 version of Application (Chart Version 0.2.0, AppVersion 2.0.0)

# List Release History
helm history myapp101
```

## Step-07: Helm Rollback to specific Revision
- Roll back a release to a previous revision or a specific revision
```t
# Rollback to previous version
helm rollback RELEASE-NAME REVISION
helm rollback myapp101 1

# List Helm Release
helm list 

# List Kubernetes Resources Deployed as part of this Helm Release
helm status myapp101 --show-resources

# Access Application
http://localhost:31232
Observation: Should see V1 version of Application (Chart Version 0.1.0, AppVersion 1.0.0)

# List Release History
helm history myapp101
```



