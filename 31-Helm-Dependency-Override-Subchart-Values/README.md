# Helm Dependency - Override Subchart Values

## Step-01: Introduction
- Override subchart(child chart) values from parent chart


## Step-02: Review Chart.yaml
```yaml
apiVersion: v2
name: parentchart
description: Learn Helm Dependency Concepts
type: application
version: 0.1.0
appVersion: "1.16.0"
dependencies:
- name: mychart4
  version: "0.1.0"
  repository: "https://stacksimplify.github.io/helm-charts/"
  condition: mychart4.enabled
- name: mychart2
  version: "0.4.0"
  repository: "https://stacksimplify.github.io/helm-charts/"
  condition: mychart2.enabled
```

## Step-03: Review mychart4, mychart2 subchart replicaCount value
```t
# Change Directory
cd 31-Helm-Dependency-Override-Subchart-Values

# Review mychart4 Values from Helm package 
helm show values parentchart/charts/mychart4-0.1.0.tgz

# Review mychart2 Values from Helm package  
helm show values parentchart/charts/mychart2-0.4.0.tgz 
```

## Step-04: Update values.yaml
- Override `replicaCount` value in subcharts from parent chart `values.yaml`
```yaml
# Values for Child Charts with Chart Name
mychart4:
  enabled: true
  replicaCount: 3
mychart2:
  enabled: true  
  replicaCount: 3
```

## Step-05: Deploy and Test 
```t
# Helm Dependency Update
helm dependency update parentchart/
or
helm dep update parentchart/

# Helm Install
helm install myapp1 parentchart/ --atomic

# Helm List
helm list

# Helm Status
helm status myapp1 --show-resources

# List Deployments
kubectl get deploy

# List Pods
kubectl get pods
Observation:
1. We should see 3 pods for each child chart
2. 1 pod for parentchart
3. We have successfully overrided the child chart values from parentchart values.yaml

# List Services
kubectl get svc

# Access Application
parentchart: http://localhost:<port-from-get-svc-output>
mychart4: http://localhost:<port-from-get-svc-output>
mychart2: http://localhost:31232
```

## Step-06: Uninstall Helm Release
```t
# Helm Uninstall
helm uninstall myapp1
```