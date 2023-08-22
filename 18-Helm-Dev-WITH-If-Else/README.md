# Helm Development - Flow Control If-Else

## Step-01: Introduction
-  We can use `if/else` for creating conditional blocks in Helm Templates
- **eq:** For templates, the operators (eq, ne, lt, gt, and, or and so on) are all implemented as functions. 
- In pipelines, operations can be grouped with parentheses ((, and )).
- [Additional Reference: Operators are functions](https://helm.sh/docs/chart_template_guide/functions_and_pipelines/#operators-are-functions)
### IF-ELSE Syntax
```t
{{ if PIPELINE }}
  # Do something
{{ else if OTHER PIPELINE }}
  # Do something else
{{ else }}
  # Default case
{{ end }}
```

## Step-02: Review values.yaml
```yaml
# If, else if, else
myapp:
  env: prod
  retail:
    enableFeature: true
```

## Step-03: Logic and Flow Control Function: and 
- [Logic and Flow Control Functions](https://helm.sh/docs/chart_template_guide/function_list/#logic-and-flow-control-functions)
- **and:**  Returns the boolean AND of two or more arguments (the first empty argument, or the last argument).
```t
# and Syntax
and .Arg1 .Arg2
```
## Step-04: Implement if-else for replicas with Boolean 

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-{{ .Chart.Name }}
  labels:
    app: nginx
spec:
{{- with .Values.myapp }}
{{- if and .retail.enableFeature (eq .env "prod") }}
  replicas: 6
{{- else if eq .env "prod" }}
  replicas: 4
{{- else if eq .env "qa" }}  
  replicas: 2
{{- else }}  
  replicas: 1  
{{- end }}
{{- end }}
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: ghcr.io/stacksimplify/kubenginx:4.0.0
        ports:
        - containerPort: 80
```

## Step-05: Verify if-else
```t
# Change to Chart Directory
cd helmbasics

# Helm Template 
helm template myapp1 . --set myapp.retail.enableFeature=true
helm template myapp1 . --set myapp.retail.enableFeature=false
helm template myapp1 . --set myapp.env=qa
helm template myapp1 . --set myapp.env=dev

# Helm Install Dry-run 
helm install myapp1 . --dry-run

# Helm Install
helm install myapp1 . --atomic

# Verify Pods
helm status myapp1 --show-resources

# Uninstall Release
helm uninstall myapp1
```
