{{/* Common Labels */}}
{{- define "helmbasics.labels"}}
    app: nginx
    chartname: {{ .Chart.Name }}
    template-in-template: {{ include "helmbasics.resourceName" . }}
{{- end }}

{{/* k8s Resource Name: String Concat with Hyphen */}}
{{- define "helmbasics.resourceName" }}
{{- printf "%s-%s" .Release.Name .Chart.Name }}
{{- end }}
