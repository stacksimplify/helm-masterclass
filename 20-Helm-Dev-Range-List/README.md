# Helm Development - Flow Control Range Action with List

## Step-01: Introduction
- Implement `Range` with `List of Values` from `values.yaml`
- Implement on how to call `Helm Variable` in Range loop
 
## Step-02: Implement "Range Action" with "List of Values"
- **Source Location:** backupfiles/namespace.yaml
- **Destication Location:** helmbasics/templates/namespace.yaml
- **File Name:** namespace.yaml
```t
# values.yaml
# Flow Control: Range with List
namespaces:
  - name: myapp1
  - name: myapp2
  - name: myapp3

# Range with List
{{- range .Values.namespaces }}
apiVersion: v1
kind: Namespace
metadata:
  name: {{ .name }}
---  
{{- end }}      

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
kubectl get ns

# Observation:
We should see all the namespaces created

# Uninstall Helm Release
helm uninstall myapp1
```


## Step-03: Implement "Range Action" with "List of Values" with Variables
- **Source Location:** backupfiles/namespace-with-variable.yaml
- **Destication Location:** helmbasics/templates/namespace-with-variable.yaml
- **File Name:** namespace-with-variable.yaml
```t
# values.yaml
# Flow Control: Range with List and Helm Variables
environments:
  - name: dev
  - name: qa
  - name: uat  
  - name: prod    

# Range with List
{{- range $environment := .Values.environments }}
apiVersion: v1
kind: Namespace
metadata:
  name: {{ $environment.name }}
---  
{{- end }}           

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
kubectl get ns

# Observation:
We should see all the namespaces created

# Uninstall Helm Release
helm uninstall myapp1
```
