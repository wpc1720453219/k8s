{{- define "luna-env.app-image" -}}
{{ $version := .app.version | default "latest" }}
{{- if .app.image -}}
{{.app.image}}:{{$version}}
{{- else -}}
{{$.Values.global.dockerRegistery}}/{{$.Release.Namespace}}/{{.appName}}:{{$version}}
{{- end -}}
{{- end -}}
