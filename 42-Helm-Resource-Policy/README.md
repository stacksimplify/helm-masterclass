# Helm Resource Policy Demo

## Step-01: Introduction
- Sometimes there are resources that should not be uninstalled when Helm runs a helm uninstall 
- Chart developers can add an annotation to a resource to prevent it from being uninstalled.
- The annotation "helm.sh/resource-policy": keep instructs Helm to skip deleting this resource when a helm operation (such as helm uninstall, helm upgrade or helm rollback) would result in its deletion. 
- However, this resource becomes orphaned. 
- Helm will no longer manage it in any way. 
- This can lead to problems if using helm install --replace on a release that has already been uninstalled, but has kept resources.

## Step-02: Review Helm Resource Policy Annotation
```yaml
metadata:
  annotations:
    "helm.sh/resource-policy": keep
```
## Step-03: Create a Chart and Add Resource Policy Annotation to deployment.yaml
- **File Location:** respolicytest/templates/deployment.yaml
```t
# Helm Create
helm create respolicytest

# Update deployment.yaml with resource-policy
metadata:
  # To test Helm Resource Policy
  annotations:
    "helm.sh/resource-policy": keep
```

## Step-03: Helm Install, Uninstall and Verify
```t
# Change to Chart Directory
cd respolicytest

# Install Helm Release 
helm install myapp1 .

# List Deployment, pods and Services
kubectl get deploy
kubectl get pods
kubectl get svc

# Uninstall Helm Release
helm uninstall myapp1

# List Deployment, pods and Services
kubectl get deploy
kubectl get pods
kubectl get svc
Observation:
1. We should see deployment should not be uninstalled
2. Its pods also should be in running state

# Cleanup
kubectl delete deploy myapp1-respolicytest
```