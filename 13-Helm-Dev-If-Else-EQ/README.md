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
```


## Step-03: Logic and Flow Control Function: and 
- [Logic and Flow Control Functions](https://helm.sh/docs/chart_template_guide/function_list/#logic-and-flow-control-functions)
- **eq:**  Returns the boolean equality of the arguments (e.g., Arg1 == Arg2).
```t
# and Syntax
eq .Arg1 .Arg2
```

## Step-04: Implement if-else for replicas
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-{{ .Chart.Name }}
  labels:
    app: nginx
spec:
{{- if eq .Values.myapp.env "prod" }}
  replicas: 4 
{{- else if eq .Values.myapp.env "qa" }}  
  replicas: 2
{{- else }}  
  replicas: 1
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

# Helm Template (when env: prod from values.yaml)
## TEST IF STATEMENT
helm template myapp1 .

# Helm Template (when env: qa using --set)
## TEST ELSE IF STATEMENT
helm template myapp1 . --set myapp.env=qa
 
# Helm Template (when env: dev or env: null using --set)
## TEST ELSE STATEMENT
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
