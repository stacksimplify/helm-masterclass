# Helm Use OCI-based Registries

## Step-01: Introduction
- We will use Docker Hub as our OCI registry for storing Helm Charts

## Step-02: Review Helm Chart
```t
# Create Chart
helm create myocidemo

# values.yaml: Update service to NodePort
service:
  type: NodePort
  port: 80

# values.yaml: Change Docker Image to kubenginxhelm
image:
  repository: ghcr.io/stacksimplify/kubenginxhelm

# Chart.yaml: update appversion
version: 0.1.0
appVersion: "0.1.0"

# Package Helm Chart
cd 47-Helm-Use-OCI-based-Registries
helm package myocidemo
Observation:
Will create package with file name "myocidemo-0.1.0.tgz"
```

## Step-03: OCI Registry: Docker Hub
```t
# SigUp and SignIn to Docker Hub
https://hub.docker.com

# command line: docker login
docker login
Username: xxxxxxxxx
Password: xxxxxxxxx

# Push Helm Chart to Docker Hub
cd 47-Helm-Use-OCI-based-Registries
helm push <HELM-PACKAGE>  oci://registry-1.docker.io/<DOCKER-NAMESPACE>
helm push myocidemo-0.1.0.tgz  oci://registry-1.docker.io/stacksimplify

# Verify ons Docker Hub
Review Tabs
1. General
2. Tags
```

## Step-04: Update and Push Chart Version: 0.2.0
```t
# Package with Chart Version and App Version 0.2.0
helm package myocidemo --version "0.2.0" --app-version "0.2.0"

# Push Helm Chart to Docker Hub
helm push myocidemo-0.2.0.tgz  oci://registry-1.docker.io/stacksimplify
```

## Step-05: Pull Helm Chart from OCI Registry
```t
# Create Directory
mkdir mypackages

# Helm Pull
helm pull oci://registry-1.docker.io/stacksimplify/myocidemo --version 0.1.0
helm pull oci://registry-1.docker.io/stacksimplify/myocidemo --version 0.2.0
```
## Step-06: Helm Template and Show Commands
```t
# Helm Template Command
helm template <my-release> oci://registry-1.docker.io/stacksimplify/myocidemo --version 0.1.0
helm template myapp1 oci://registry-1.docker.io/stacksimplify/myocidemo --version 0.1.0
helm template myapp1 oci://registry-1.docker.io/stacksimplify/myocidemo --version 0.2.0

# Helm Show Command
helm show all oci://registry-1.docker.io/stacksimplify/myocidemo --version 0.1.0
helm show all oci://registry-1.docker.io/stacksimplify/myocidemo --version 0.2.0
```

## Step-07: Helm Install and Upgrade from OCI Registry
```t
# Helm Install
helm install <my-release> oci://registry-1.docker.io/stacksimplify/myocidemo --version 0.1.0
helm install myapp1 oci://registry-1.docker.io/stacksimplify/myocidemo --version 0.1.0

# Helm Status
helm status myapp1 --show-resources 

# List k8s services
kubectl get svc

# Access Application
http://localhost:<get-from-svc-output>

# Helm Upgrade
helm upgrade <my-release> oci://registry-1.docker.io/stacksimplify/myocidemo --version 0.2.0

# List k8s services
kubectl get svc

# Access Application
http://localhost:<get-from-svc-output>
```

## Step-08: Migrate from Classic Chart Repository to OCI Registry
```t
# List and add Helm Chart Repository
helm repo list
helm repo add mygithelmrepo https://stacksimplify.github.io/helm-charts-repo/
helm repo update

# Search Helm Repository
helm search repo myfirstchart

# Create folder migrate
mkdir migrate
cd migrate

# Helm Pull (downloads latest chart version - in our case it is 0.2.0)
helm pull mygithelmrepo/myfirstchart

# Helm Pull --version (downloads specified chart version)
helm pull mygithelmrepo/myfirstchart --version 0.1.0

# Docker Login (if not logged in)
docker login

# Helm Push
helm push myfirstchart-0.1.0.tgz  oci://registry-1.docker.io/stacksimplify
helm push myfirstchart-0.2.0.tgz  oci://registry-1.docker.io/stacksimplify

# Verify on Docker Hub
https://hub.docker.com
```

