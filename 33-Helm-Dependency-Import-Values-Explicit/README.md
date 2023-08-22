# Helm Dependency - Import Values Explicit

## Step-01: Introduction
- Import Values Explicit

## Step-02: Review / Update Subchart values.yaml
- **File Location:** parentchart/charts/mychart1/values.yaml
```yaml
# Export Values - MyChart1 (Used for Import Values Explicit Usecase)
exports:
  mychart1Data:
    mychart1appInfo:
      appName: kapp1
      appType: MicroService
      appDescription: Used for listing products    
```

## Step-03: Review / Update Chart.yaml mychart1 dependency with import-values argument
```yaml
- name: mychart1
  version: "0.1.0"
  repository: "file://charts/mychart1"
  alias: childchart1
  tags: 
    - frontend
  import-values:
    - mychart1Data # Explicit Values Import Usecase
```

## Step-04: Review / Update parentchart configmap.yaml
- **File Location:** parentchart/templates/configmap.yaml
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name:  {{ include "parentchart.fullname" . }}-import-explicit
data:
{{- toYaml .Values.mychart1appInfo | nindent 2 }}
```

## Step-05: Import Values Explicit: Deploy and Verify 
```t
# Change to Chart Directory
cd parentchart

# Helm Install
helm install myapp1 . --atomic

# Helm List
helm list

# Helm Status
helm status myapp1 --show-resources

# List k8s Deployments
kubectl get deploy

# List k8s pods
kubectl get pods

# List k8s ConfigMaps
kubectl get cm
kubectl get cm myapp1-parentchart-import-explicit -o yaml
Observation:
We should see the data exported from parentchart/charts/mychart1/values.yaml imported successfully to configmap in parentchart. 

# Helm Uninstall
helm uninstall myapp1 
```

## Step-06: Test when mychart1 is disabled 
```t
# Change to Chart Directory
cd parentchart

# Helm Install
helm install myapp1 . --atomic --set tags.frontend=false

# Review Configmap
kubectl get cm myapp1-parentchart-import-explicit -o yaml
Observation:
1. We should not see any data for configmap

# Helm Uninstall
helm uninstall myapp1
```