# Helm Development - Variables

## Step-01: Introduction
- How to use Variables ?

## Step-02: Variables in Helm Templates
```yaml
# Change-1: Add Variable at the top of deployment template
{{- $chartname := .Chart.Name -}}

# Change-2: Add appHelmChart annotation with variable in deployment.yaml
  template:
    metadata:
      {{- with .Values.podAnnotations }}
      annotations:
        {{- toYaml . | nindent 8 }}
        appManagedBy: {{ $.Release.Service }}
        appHelmChart: {{ $chartname }}        
      {{- end }}  

# Change to Chart Directory
cd helmbasics  

# Helm Template
helm template myapp101 .

# Helm Install with dry-run
helm install myapp101 . --dry-run  

# Observation:
We should see variable value substituted successfully
```

## Step-03: Test Variables in combination with Pipelines
```t
# Add Pipeline with quote and upper function
{{- $chartname := .Chart.Name | quote | upper -}}
apiVersion: apps/v1
kind: Deployment
metadata:

# Change to Chart Directory
cd helmbasics  

# Helm Template
helm template myapp101 .

# Helm Install with dry-run
helm install myapp101 . --dry-run  

# Helm Install with --atomic
helm install myapp101 . --atomic 

# List Helm Releases
helm list

# List Kubernetes Pods
kubectl get pods

# Helm get manifest
helm get manifest myapp101

# Helm Uninstall
helm uninstall myapp101
```
