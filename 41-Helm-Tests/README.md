# Helm Tests

## Step-01: Introduction
- helm test command

## Step-02: Create Helm Chart and Release
```t
# Helm Create
helm create mydemoapp

# Helm Install
helm install myapp101 mydemoapp/

# List Helm Releases
helm list
```

## Step-03: Review Helm Test Yaml file
- **File Location:** mydemoapp/templates/test/test-connection.yaml
- Primarily review  test hook: `"helm.sh/hook": test`
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: "{{ include "mydemoapp.fullname" . }}-test-connection"
  labels:
    {{- include "mydemoapp.labels" . | nindent 4 }}
  annotations:
    "helm.sh/hook": test
spec:
  containers:
    - name: wget
      image: busybox
      command: ['wget']
      args: ['{{ include "mydemoapp.fullname" . }}:{{ .Values.service.port }}']
  restartPolicy: Never
```

## Step-04: Helm Test and Verify
```t
# List Kubernetes Pods
kubectl get pods

# Helm Test
helm test <RELEASE-NAME>
helm test myapp101

# List Kubernetes Pods
kubectl get pods
Observation:
1. Test connection pod should be created and in completed state

# Sample Output
Kalyans-Mac-mini:51-Helm-Tests kalyan$ helm test myapp101
NAME: myapp101
LAST DEPLOYED: Thu Aug  3 16:48:46 2023
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE:     myapp101-mydemoapp-test-connection
Last Started:   Thu Aug  3 16:48:50 2023
Last Completed: Thu Aug  3 16:49:00 2023
Phase:          Succeeded
```

## Step-05: Uninstall Helm Release
```t
# Uninstall Helm Release
helm uninstall myapp101

# List Helm Releases
helm list

# List Kubernetes Pods
kubectl get pods
```