{{/* Common Labels */}}
{{- define "helmbasics.labels"}}
    app.kubernetes.io/managed-by: helm
    app: nginx
    chartname: {{ .Chart.Name }}
{{- end }}

{{/* k8s Resource Name: String Concat with Hyphen */}}
{{- define "helmbasics.resourceName" }}
{{- printf "%s-%s" .Release.Name .Chart.Name }}
{{- end }}