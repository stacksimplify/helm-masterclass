# Helm Named Templates - Call Template in Template

## Step-01: Introduction
- We can call one named template in other named template.

## Step-02: Update _helpers.tpl 
- We will udpate the template `helmbasics.labels` with `template-in-template` as additional label by calling the named template `helmbasics.resourceName`
```t
{{/* Common Labels */}}
{{- define "helmbasics.labels"}}
    app.kubernetes.io/managed-by: helm
    app: nginx
    chartname: {{ .Chart.Name }}
    template-in-template: {{ include "helmbasics.resourceName" . }}
{{- end }}
```

## Step-03: Test the changes
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