# Helm Hook Weights

## Step-01: Introduction
- Hook weights can be positive or negative numbers but must be represented as strings (in double quotes "8")
```yaml
annotations:
  "helm.sh/hook-weight": "5"
```
- When Helm starts the execution cycle of hooks of a particular Kind (Example: kind:pod) it will sort those hooks in ascending order.

## Step-02: Review Hook Pod Template Annotations
### preinstall-hookpod1.yaml
```yaml
  annotations:
    "helm.sh/hook": "pre-install"
    "helm.sh/hook-delete-policy": before-hook-creation
    "helm.sh/hook-weight": "-2"
```
### preinstall-hookpod2.yaml
```yaml
  annotations:
    "helm.sh/hook": "pre-install"
    "helm.sh/hook-delete-policy": before-hook-creation
    "helm.sh/hook-weight": "5"
```
### preinstall-hookpod3.yaml
```yaml
  annotations:
    "helm.sh/hook": "pre-install"
    "helm.sh/hook-delete-policy": before-hook-creation
    "helm.sh/hook-weight": "6"
```

## Step-03: Install Helm Release
```t
# Change Directory (In Helm Chart Folder)
cd hooksdemo1

# Install Helm Release
helm install myapp101 . 

# List Helm Release
helm list

# List Kubernetes Pods
kubectl get pods
Observation:
1. We should see all 3 hook pods created and in completed state.
2. Verify the AGE field for timing when they executed
3. Hook pod with lowest hook weight will be executed first
4. In shot, hooks will be executed in ascending order of hook weight

# Verify Pod Stated and Finished Timestamps
kubectl describe pod myhook-preinstall1 | grep -E 'Anno|Started:|Finished:'
kubectl describe pod myhook-preinstall2 | grep -E 'Anno|Started:|Finished:'
kubectl describe pod myhook-preinstall3 | grep -E 'Anno|Started:|Finished:'

```

## Step-04: Uninstall Helm Release and Clean-Up
```t
# List Helm Releases
helm list

# Uninstall Helm Release
helm uninstall myapp101

# Delete Hook Pods
kubectl get pods
kubectl delete pod myhook-preinstall1 
kubectl delete pod myhook-preinstall2
kubectl delete pod myhook-preinstall3
```