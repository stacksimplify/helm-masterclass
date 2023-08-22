{{/* Common Labels */}}
{{- define "helmbasics.labels"}}
    app: nginx
    chartname: {{ .Chart.Name }}
{{- end }}