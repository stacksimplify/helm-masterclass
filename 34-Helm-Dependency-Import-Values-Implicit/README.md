# Helm Dependency - Import Values Implicit

## Step-01: Introduction
- Implement Import Values Implicit usecase

## Step-02: Review / Update parentchart Chart.yaml
- **File Location:** parentchart/Chart.yaml
- Define `import-values`
```yaml
apiVersion: v2
name: parentchart
description: Learn Helm Dependency Concepts
type: application
version: 0.1.0
appVersion: "1.16.0"
dependencies:
- name: mychart1
  version: "0.1.0"
  repository: "file://charts/mychart1"
  alias: childchart1
  tags: 
    - frontend

- name: mychart2
  version: "0.4.0"
  repository: "file://charts/mychart2"
  alias: childchart2
  tags: 
    - backend
  import-values: # Implicit Values Usecase
    - child: service 
      parent: mychart2service   
    - child: image 
      parent: mychart2image      
```

## Step-03: Review / Update parentchart configmap.yaml
- **File Location:** parentchart/templates/configmap.yaml
- Use imported values in `configmap.yaml`
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name:  {{ include "parentchart.fullname" . }}-import-implicit
data:
  serviceType: {{ .Values.mychart2service.type }}
  servicePort: {{ .Values.mychart2service.port | quote}}
  servicenodePort: {{ .Values.mychart2service.nodePort | quote }}
  imageRepository: {{ .Values.mychart2image.repository }}
```


## Step-04: Import Values Implicit: Deploy and Verify 
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
kubectl get cm myapp1-parentchart-import-implicit -o yaml
Observation:
We should see the data exported from parentchart/charts/mychart2/values.yaml imported successfully to configmap in parentchart. 

# Helm Uninstall
helm uninstall myapp1 
```

## Step-06: Test when mychart2 is disabled 
```t
# Change to Chart Directory
cd parentchart

# Helm Install (When mychart2 is disabled)
helm install myapp1 . --atomic --set tags.backend=false
Observation:
Should fail with error 

## Error
Kalyans-Mac-mini:parentchart kalyanreddy$ helm install myapp1 . --atomic --set tags.backend=false
Error: INSTALLATION FAILED: template: parentchart/templates/configmap.yaml:6:25: executing "parentchart/templates/configmap.yaml" at <.Values.mychart2service.type>: nil pointer evaluating interface {}.type
```