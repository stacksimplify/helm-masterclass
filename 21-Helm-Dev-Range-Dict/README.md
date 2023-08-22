# Helm Development - Flow Control Range with Dictionary

## Step-01: Introduction
- Implement Range with Map or Dictionary from `values.yaml`
- Implement on how to call `Helm Variable` in Range loop

## Step-02: Range with Key Value pairs or Map or Dictionary 
- **Source Location:** backupfiles/namespace.yaml
- **Destication Location:** helmbasics/templates/namespace.yaml
- **File Name:** namespace.yaml
```yaml
# values.yaml
# Range with Dictionary
myapps:
  config1: 
    appName: myapp1
    appType: webserver
    appTech: HTML
    appDb: mysql
  config2: 
    appName: myapp2
    appType: webserver
    appTech: HTML
    appDb: mysql
  
# Range with Dictionary
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-{{ .Chart.Name }}-configmap1
data: 
{{- range $key, $value := .Values.myapps.config1 }}
{{- $key | nindent 2}}: {{ $value }}
{{- end}}  

# Change to Chart Directory
cd helmbasics  

# Helm Template
helm template myapp1 .

# Helm Install with dry-run
helm install myapp1 . --dry-run 

# Helm Install and Test
helm install myapp1 . --atomic
helm list

# Helm Status
helm status myapp1 --show-resources

# List k8s namespaces
kubectl get configmap
kubectl get configmap <NAME-OF-CONFIGMAP> -o yaml
kubectl get configmap myapp1-helmbasics-configmap1 -o yaml

# Observation:
We should see configmap with key value pairs

# Uninstall Helm Release
helm uninstall myapp1
```


## Step-03: Range - Access Builtin Object from Root inside Range using Helm  Variable
- **Source Location:** backupfiles/namespace-with-variable.yaml
- **Destication Location:** helmbasics/templates/namespace-with-variable.yaml
- **File Name:** namespace-with-variable.yaml
```yaml
# values.yaml
# Range with Dictionary
myapps:
  config1: 
    appName: myapp1
    appType: webserver
    appTech: HTML
    appDb: mysql
  config2: 
    appName: myapp2
    appType: webserver
    appTech: HTML
    appDb: mysql
  
# Range: Access Root Object in Range with Helm Variable
{{- $chartName := .Chart.Name  }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-{{ .Chart.Name }}-configmap2
data: 
{{- range $key, $value := .Values.myapps.config2 }}
{{- $key | nindent 2}}: {{ $value }}-{{ $chartName }}
{{- end}}  

# Change to Chart Directory
cd helmbasics  

# Helm Template
helm template myapp1 .

# Helm Install with dry-run
helm install myapp1 . --dry-run 

# Helm Install and Test
helm install myapp1 . --atomic
helm list

# List k8s namespaces
kubectl get configmap
kubectl get configmap <NAME-OF-CONFIGMAP> -o yaml
kubectl get configmap myapp1-helmbasics-configmap2 -o yaml

# Observation:
We should see configmap with key value pairs

# Uninstall Helm Release
helm uninstall myapp1
```

