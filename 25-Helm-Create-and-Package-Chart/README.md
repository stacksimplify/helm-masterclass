# Create and Package Helm Charts

## Step-01: Introduction
1. We will learn the following things
2. helm create to create a new Helm Chart
3. Update the Chart with basic information like our Docker Image, appversion, chart version 
4. Update the Chart to support to NodePort Service, helm install and test
5. helm package 
6. helm package --app-version --version
- [Docker Image used](https://github.com/users/stacksimplify/packages/container/package/kubenginx)

## Step-02: Helm Create Chart
```t
# Helm Create Chart
helm create <CHART-NAME>
helm create myfirstchart
Observation: 
1. It will create a base Helm Chart template 
2. We can call it as a starter chart. 
```

## Step-03: Update values.yaml with our Application Docker Image
- [Docker Image used](https://github.com/users/stacksimplify/packages/container/package/kubenginx)
- Review `templates/deployment.yaml`
```yaml
image:
  repository: ghcr.io/stacksimplify/kubenginx
  pullPolicy: IfNotPresent
  # Overrides the image tag whose default is the chart appVersion.
  tag: ""
```
## Step-04: Convert the Kubernetes Service to NodePort
```yaml
# Update values.yaml
service:
  type: NodePort
  port: 80 
  nodePort: 31231

# Update templates/service.yaml
nodePort: {{ .Values.service.nodePort }}
```

## Step-05: Update Chart.yaml
```t
### Chart Version and Description
# Before
version: 0.1.0
description: A Helm chart for Kubernetes

# After
version: 1.0.0
description: A Helm Chart with NodePort Service

### appVersion
# Before
appVersion: "1.16.0"

# After (update our Docker Image tag version)
appVersion: "1.0.0"
```

## Step-06: Helm Install - Chart Version 1.0.0 and Test it
```t
# Helm Install
cd myfirstchart
helm install myapp1v1 .

# List Helm Releases
helm list
helm list --output=yaml

# Helm Status
helm status myapp1v1 --show-resources

# Using kubectl commands
kubectl get pods
kubectl get svc

# Access in Browser
http://127.0.0.1:31231
http://localhost:31231
```
## Step-07: Helm Package - v1.0.0
```t
# Check if you are  in Directory
25-Helm-Create-and-Package-Chart

# Helm Package
helm package myfirstchart/ --destination packages/
or
helm package myfirstchart/ -d packages/

# Review Package file
cd pakcages
ls -lrta
Package file name: myfirstchart-1.0.0.tgz
```

## Step-08: Helm Package - v2.0.0
```t
### Chart Version and Description
# Before
version: 1.0.0
description: A Helm Chart with NodePort Service

# After
version: 2.0.0
description: A Helm Chart with NodePort Service

### appVersion
# After (update our Docker Image tag version)
appVersion: "1.0.0"

# After (update our Docker Image tag version)
appVersion: "2.0.0"

# Helm Package
helm package myfirstchart/ --destination packages/
helm package myfirstchart/ -d packages/

# Review Package file
cd pakcages
ls -lrta
Package file name: myfirstchart-1.0.0.tgz
Package file name: myfirstchart-2.0.0.tgz
```

## Step-09: Helm Install by path to a packaged chart and Verify
```t
# Helm Install
helm install myapp1v2 packages/myfirstchart-2.0.0.tgz --set service.nodePort=31232

# Using kubectl commands
kubectl get pods
kubectl get svc

# List Helm Releases
helm list
helm list --output=yaml

# Helm Status
helm status myapp1v2 --show-resources

# Access in Browser
http://127.0.0.1:31232
http://localhost:31232
```

## Step-10: Helm Package with --app-version, --version
- [Docker Image used](https://github.com/users/stacksimplify/packages/container/package/kubenginx)
```t
# Helm Package  --app-version
helm package myfirstchart/ --app-version "3.0.0" --version "3.0.0" --destination packages/
```

## Step-11: Helm Install and Test if --version "3.0.0" worked
```t
# Helm Install from package
helm install myapp1v3 packages/myfirstchart-3.0.0.tgz --set service.nodePort=31233

# Using kubectl commands
kubectl get pods
kubectl get svc

# List Helm Releases
helm list
helm list --output=yaml

# Helm Status
helm status myapp1v3 --show-resources

# Access in Browser
http://127.0.0.1:31233
http://localhost:31233
Observation:
1. We can see V3 version of Application 
```

## Step-12: Uninstall Helm Releases
```t
# List Helm Releases
helm list
helm list --output=yaml

# Uninstall Helm Releases
helm uninstall myapp1v1
helm uninstall myapp1v2
helm uninstall myapp1v3
```
## Step-13: Helm Show Commands
- **helm show:** show information of a chart
```t
# Helm Show Chart
helm show chart myfirstchart/
helm show chart packages/myfirstchart-2.0.0.tgz

# Helm Show Values
helm show values myfirstchart/
helm show values packages/myfirstchart-2.0.0.tgz

# Helm Show readme
helm show readme myfirstchart/

# Helm Show All
helm show all myfirstchart/
helm show all packages/myfirstchart-2.0.0.tgz
```


