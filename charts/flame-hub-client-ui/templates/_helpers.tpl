{{/*
Expand the name of the chart.
*/}}
{{- define "flame-hub-client-ui.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "flame-hub-client-ui.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "flame-hub-client-ui.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "flame-hub-client-ui.labels" -}}
helm.sh/chart: {{ include "flame-hub-client-ui.chart" . }}
{{ include "flame-hub-client-ui.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "flame-hub-client-ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "flame-hub-client-ui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "flame-hub-client-ui.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "flame-hub-client-ui.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
core publicURL
*/}}
{{- define "core.publicURL" -}}
{{- if .Values.core.hostname }}
{{- if .Values.core.ssl }}
https://{{- .Values.core.hostname }}
{{- else }}
http://{{- .Values.core.hostname }}
{{- end }}
{{- else }}
{{- if .Values.core.ssl }}
https://{{ .Values.global.hub.hostname }}/core/
{{- else }}
http://{{ .Values.global.hub.hostname }}/core/
{{- end }}
{{- end }}
{{- end }}

{{/*
storage publicURL
*/}}
{{- define "storage.publicURL" -}}
{{- if .Values.storage.hostname }}
{{- if .Values.storage.ssl }}
https://{{- .Values.storage.hostname }}
{{- else }}
http://{{- .Values.storage.hostname }}
{{- end }}
{{- else }}
{{- if .Values.global.hub.ssl }}
https://{{ .Values.global.hub.hostname }}/storage/
{{- else }}
http://{{ .Values.global.hub.hostname }}/storage/
{{- end }}
{{- end }}
{{- end }}

{{/*
authup publicURL
*/}}
{{- define "authup.publicURL" -}}
{{- if .Values.authup.hostname }}
{{- if .Values.authup.ssl }}
https://{{- .Values.authup.hostname }}
{{- else }}
http://{{- .Values.authup.hostname }}
{{- end }}
{{- else }}
{{- if .Values.global.hub.ssl }}
https://{{ .Values.global.hub.hostname }}/auth/
{{- else }}
http://{{ .Values.global.hub.hostname }}/auth/
{{- end }}
{{- end }}
{{- end }}
