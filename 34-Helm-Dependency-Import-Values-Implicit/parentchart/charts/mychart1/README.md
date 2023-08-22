# MyChart1 Helm Chart

## Step-01: Introduction
- This chart will help us in learning Helm in a detailed manner

## Step-02: Installing the Chart
- To install the chart with the release name `hub` run:
```t
# Add Helm Repository
$ helm repo list
$ helm repo add stacksimplify https://stacksimplify.github.io/helm-charts
$ helm repo list

# Install Helm Chart
$ helm install myapp1 stacksimplify/mycahrt1
```

## Step-03: Verify if Helm Installed successfully
```t
# Helm Status
$ helm status --show-resources
or
# using kubectl commands
kubectl get pods
kubectl get svc

# Access Application
http://localhost:31231
```

## Step-04: Uninstall the Chart
```t
# Uninstall Helm Chart
$ helm uninstall myapp1
```
