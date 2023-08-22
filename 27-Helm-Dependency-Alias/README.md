# Helm Dependency - Alias

## Step-01: Introduction
- Condition
- Alias
- Override subchart(child chart) values from parent chart

## Step-02: Update Parentchart CIP to NodePort Service
```yaml
# values.yaml
service:
  type: NodePort
  port: 80
```

## Step-03: Chart.yaml
- Understand the importance of `alias` when defining dependencies
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
  alias: childchart4dev
- name: mychart4
  version: "0.1.0"
  repository: "https://stacksimplify.github.io/helm-charts/"
  alias: childchart4qa  
- name: mychart2
  version: "0.4.0"
  repository: "https://stacksimplify.github.io/helm-charts/"
  alias: childchart2
```

## Step-04: Deploy and Test
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

# List Services
kubectl get svc

# Access Application
parentchart: http://localhost:<port-from-get-svc-output>
childchart4dev: http://localhost:<port-from-get-svc-output>
childchart4qa: http://localhost:<port-from-get-svc-output>
mychart2: http://localhost:31232
```

## Step-05: Uninstall Helm Release
```t
# Helm Uninstall
helm uninstall myapp1
```