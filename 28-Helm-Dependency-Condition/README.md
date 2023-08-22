# Helm Dependency - Condition

## Step-01: Introduction
- Implement `Condition` for enabling or disabling Sub Charts or Child Charts
- Override subchart(child chart) values from parent chart


## Step-02: Chart.yaml
- Understand the importance of `condition` when defining dependencies
- By default, if we the condition is defined or not `condition: mychart4.enabled`, chart is enaled when defined
- To disable it we need to explicitly make it `false` in `values.yaml`
```yaml
dependencies:
- name: mychart4
  version: "0.1.0"
  repository: "https://stacksimplify.github.io/helm-charts/"
  alias: childchart4
  condition: mychart4.enabled
- name: mychart2
  version: "0.4.0"
  repository: "https://stacksimplify.github.io/helm-charts/"
  alias: childchart2
  condition: mychart2.enabled
```

## Step-03: Deploy and Test - By Default enabled is true
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
mychart4: http://localhost:<port-from-get-svc-output>
mychart2: http://localhost:31232

# Helm Uninstall
helm uninstall myapp1
```

## Step-04: Update values.yaml
```yaml
# Values for Child Charts with Chart Name
mychart4:
  enabled: false
mychart2:
  enabled: false  
```


## Step-05: Deploy and Test - when childcharts are disabled
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
Observation:
1. Child Charts will not be deployed.
2. No k8s resources for child charts will be created

# List Pods
kubectl get pods

# List Services
kubectl get svc

# Access Application
parentchart: http://localhost:<port-from-get-svc-output>
```

## Step-06: Uninstall Helm Release
```t
# Helm Uninstall
helm uninstall myapp1
```