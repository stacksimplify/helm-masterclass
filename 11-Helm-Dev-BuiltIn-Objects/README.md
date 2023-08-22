# Helm Builtin Objects

## Step-01: Introduction
- Objects are passed into a template from the template engine. 
- Objects can be simple, and have just one value or they can contain other objects or functions. 
- For example: the Release object contains several objects (like .Release.Name) and the Files object has a few functions.
### Helm Builtin Objects
- Release 
- Chart 
- Values 
- Capabilities 
- Template 
- Files 

## Step-02: Create a simple chart and clean-up NOTES.txt
```t
# Create Helm Chart
helm create CHART-NAME
helm create builtinobjects

# Remove all content from NOTES.txt
cd builtinobjects/templates
>NOTES.txt

# Change to Chart Directory
cd builtinobjects

# helm install --dry-run
helm install myapp1 . --dry-run
```

## Step-03: Helm Object: Root or dot or Period (.)
```t
# Update NOTES.txt
{{/* Root or Dot or Period Object */}}
Root Object: {{ . }}

# Change to Chart Directory
cd builtinobjects

# helm install with --dry-run
helm install myapp101 . --dry-run
```

## Step-04: Helm Object: Release
- This object describes the Helm release. 
- It has several objects inside it related to Helm Release.
- Put the below in `NOTES.txt` and test it
```t
{{/* Release Object */}}
Release Name: {{ .Release.Name }}
Release Namespace: {{ .Release.Namespace }}
Release IsUpgrade: {{ .Release.IsUpgrade }}
Release IsInstall: {{ .Release.IsInstall }}
Release Revision: {{ .Release.Revision }}
Release Service: {{ .Release.Service }}

# Change to CHART Directory 
cd builtinobjects 

# Helm Install with --dry-run
helm install myapp101 . --dry-run

# Sample Output
NOTES:
Release Name: myapp101
Release Namespace: default
Release IsUpgrade: false
Release IsInstall: true
Release Revision: 1
Release Service: Helm
```

## Step-05: Helm Object: Chart
- Any data in Chart.yaml will be accessible using Chart Object. 
- For example {{ .Chart.Name }}-{{ .Chart.Version }} will print out the builtinobjects-0.1.0.
- [Complte Chart.yaml Objects for reference](https://helm.sh/docs/topics/charts/#the-chartyaml-file)
- Put the below in `NOTES.txt` and test it
```t
{{/* Chart Objet */}}
Chart Name: {{ .Chart.Name }}
Chart Version: {{ .Chart.Version }}
Chart AppVersion: {{ .Chart.AppVersion }}
Chart Type: {{ .Chart.Type }}
Chart Name and Version: {{ .Chart.Name }}-{{ .Chart.Version }}

# Change to CHART Directory 
cd builtinobjects 

# Helm Install with --dry-run
helm install myapp101 . --dry-run

# Sample Output
Chart Name: builtinobjects
Chart Version: 0.1.0
Chart AppVersion: 0.1.0
Chart Type: application
Chart Name and Version: builtinobjects-0.1.0
```

## Step-06: Helm Objects: Values, Capabilities, Template
- **Values Object:** Values passed into the template from the values.yaml file and from user-supplied files. By default, Values is empty.
- **Capabilities Object:** This provides information about what capabilities the Kubernetes cluster supports
- **Template Object:** Contains information about the current template that is being executed
- Put the below in `NOTES.txt` and test it
```t
{{/* Values Object */}}
Replica Count: {{ .Values.replicaCount }}
Image Repository: {{ .Values.image.repository }}
Service Type: {{ .Values.service.type }}

{{/* Capabilities Object */}}
Kubernetes Cluster Version Major: {{ .Capabilities.KubeVersion.Major }}
Kubernetes Cluster Version Minor: {{ .Capabilities.KubeVersion.Minor }}
Kubernetes Cluster Version: {{ .Capabilities.KubeVersion }} and {{ .Capabilities.KubeVersion.Version }}
Helm Version: {{ .Capabilities.HelmVersion }}
Helm Version Semver: {{ .Capabilities.HelmVersion.Version }}

{{/* Template Object */}}
Template Name: {{ .Template.Name }} 
Template Base Path: {{ .Template.BasePath }}

# Change to CHART Directory 
cd builtinobjects 

# Helm Install with --dry-run
helm install myapp101 . --dry-run

# Sample Output
Replica Count: 1
Image Repository: ghcr.io/stacksimplify/kubenginxhelm
Service Type: NodePort

Kubernetes Cluster Version Major: 1
Kubernetes Cluster Version Minor: 27
Kubernetes Cluster Version: v1.27.2 and v1.27.2
Helm Version: {v3.12.1 f32a527a060157990e2aa86bf45010dfb3cc8b8d clean go1.20.5}
Helm Version Semver: v3.12.1

Template Name: builtinobjects/templates/NOTES.txt 
Template Base Path: builtinobjects/templates
```

## Step-07: Helm Objects: Files
- **Files Object:** 
- Put the below in `NOTES.txt` and test it
- [Additional Reference: Access Files Inside Templates](https://helm.sh/docs/chart_template_guide/accessing_files/)
```t
{{/* File Object */}}
File Get: {{ .Files.Get "myconfig1.toml" }}
File Glob as Config: {{ (.Files.Glob "config-files/*").AsConfig }}
File Glob as Secret: {{ (.Files.Glob "config-files/*").AsSecrets }}
File Lines: {{ .Files.Lines "myconfig1.toml" }}
File Lines: {{ .Files.Lines "config-files/myconfig2.toml" }}
File Glob: {{ .Files.Glob "config-files/*" }}

# Change to CHART Directory 
cd builtinobjects 

# Helm Install with --dry-run
helm install myapp101 . --dry-run

# Sample Output
File Get: message1 = Hello from config 1 line1
message2 = Hello from config 1 line2
message3 = Hello from config 1 line3

File Glob as Config: myconfig2.toml: |-
  appName: myapp2
  appType: db
  appConfigEnable: true
myconfig3.toml: |-
  appName: myapp3
  appType: app
  appConfigEnable: false
File Glob as Secret: myconfig2.toml: YXBwTmFtZTogbXlhcHAyCmFwcFR5cGU6IGRiCmFwcENvbmZpZ0VuYWJsZTogdHJ1ZQ==
myconfig3.toml: YXBwTmFtZTogbXlhcHAzCmFwcFR5cGU6IGFwcAphcHBDb25maWdFbmFibGU6IGZhbHNl
File Lines: [message1 = Hello from config 1 line1 message2 = Hello from config 1 line2 message3 = Hello from config 1 line3 ]
File Lines: [appName: myapp2 appType: db appConfigEnable: true]
File Glob: map[config-files/myconfig2.toml:[97 112 112 78 97 109 101 58 32 109 121 97 112 112 50 10 97 112 112 84 121 112 101 58 32 100 98 10 97 112 112 67 111 110 102 105 103 69 110 97 98 108 101 58 32 116 114 117 101] config-files/myconfig3.toml:[97 112 112 78 97 109 101 58 32 109 121 97 112 112 51 10 97 112 112 84 121 112 101 58 32 97 112 112 10 97 112 112 67 111 110 102 105 103 69 110 97 98 108 101 58 32 102 97 108 115 101]]
```

## Additional Reference
- [Helm Built-In Objects](https://helm.sh/docs/chart_template_guide/builtin_objects/)
- [Helm Chart.yaml Fields](https://helm.sh/docs/chart_template_guide/builtin_objects/)


