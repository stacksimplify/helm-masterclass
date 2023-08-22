# Helm Printf Function

## Step-01: Introduction
- **[printf](https://helm.sh/docs/chart_template_guide/function_list/#printf):** Returns a string based on a formatting string and the arguments to pass to it in order.


## Step-02: Create a Named Template with printf function
```t
{{/* Kubernetes Resource Name: String Concat with Hyphen */}}
{{- define "helmbasics.resourceName" }}
{{- printf "%s-%s" .Release.Name .Chart.Name }}
{{- end }}
```

## Step-03: Call the named template in deployment.yaml
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "helmbasics.resourceName" . }}-deployment 
  labels:
```

## Step-04: Test the changes
```t
# Change to Chart Directory 
cd helmbasics

# Helm Template Command
helm template myapp1 .

# Helm Install with dry-run command
helm install myapp1 . --dry-run

# Helm Install with --atomic flag
helm install myapp1 . --atomic

# Helm Uninstall
helm uninstall myapp1
```