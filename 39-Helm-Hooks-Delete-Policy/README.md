# Helm Hooks Delete Policy

## Step-01: Introduction
- Implement Helm Hooks deletion policy

## Step-02: List Kubernetes Pods
- **Important Note:** We are in continuation to the previous demo
```t
# List Kuberentes Pods
kubectl get pods
Observation:
1. We should see hook pods were in completed state but not removed
2. How do we need to remove them ?
Option-1: Manually delete them
Option-2: Use Helm Hook Deletion Policies
```

## Step-03: What are Helm Hook Deletion Policies ?
1. We can define when to delete the hook resources using Hook Deletion Policies
2. **before-hook-creation:** Delete the previous resource before a new hook is launched (default)
3. **hook-succeeded:** Delete the resource after the hook is successfully executed
4. **hook-failed:** Delete the resource if the hook failed during execution
```yaml
annotations:
  "helm.sh/hook-delete-policy": before-hook-creation,hook-succeeded, hook-failed
```
## Step-04: Deploy new Helm Release
```t
# Change Directory (In Helm Chart Folder)
cd hooksdemo1

# List Kubernetes Pods
kubectl get pods
Observation: Make a note of pods running age before installing new release

# Install Helm Release
helm install myapp101 . 

# List Helm Release
helm list

# List Kubernetes Pods
kubectl get pods
Observation:
1. We should see "myhook-preinstall" pod just got deleted and recreated
2. How does this happen ?
3. For Helm Hook deletion policy, even though it is not defined in our hookpod yaml files, "before-hook-creation" is a default value which got triggered. So the old hook pod is deleted and new one created during "helm install" 

"helm.sh/hook-delete-policy": before-hook-creation
before-hook-creation:Delete the previous resource before a new hook is launched (default) 
```

## Step-05: Uninstall Helm Release and clean-up 
- We are going uninstall helm release and clean-up all hook pods before testing the hook delete policy changes we added.
```t
# Uninstall Helm Release
helm uninstall myapp101

# List Kubernetes Pods
kubectl get pods

# Delete Hook pods
kubectl delete pod myhook-preinstall
kubectl delete pod myhook-preupgrade
kubectl delete pod myhook-postdelete
```

## Step-06: Update hookpod yaml files with below Hook Deletion Policy
- Update below 3 files with annotation `helm.sh/hook-delete-policy`
- preinstall-hookpod.yaml
- preupgrade-hookpod.yaml
- postdelete-hookpod.yaml
```yaml
  "helm.sh/hook-delete-policy": before-hook-creation,hook-succeeded
```

## Step-07: Install Helm Release and Test Hook Deletion Policy
```t
# Change Directory (In Helm Chart Folder)
cd hooksdemo1

# Install Helm Release
helm install myapp101 .

# List Kubernetes Pods
kubectl get pods
Observation: 
1. We should not see "myhook-preinstall" pod
2. It got created, completed and deleted as we have provided "hook-succeeded" in "helm.sh/hook-delete-policy"
```

## Step-08: Upgrade Helm Release and Test Hook Deletion Policy
```t
# Change Directory (In Helm Chart Folder)
cd hooksdemo1

# Upgrade Helm Release
helm upgrade myapp101 . --set image.tag=0.2.0

# List Kubernetes Pods
kubectl get pods
Observation: 
1. We should not see "myhook-preupgrade" pod
2. It got created, completed and deleted as we have provided "hook-succeeded" in "helm.sh/hook-delete-policy"
```

## Step-09: Uninstall Helm Release and Test Hook Deletion Policy
```t
# Change Directory (In Helm Chart Folder)
cd hooksdemo1

# Uninstall Helm Release
helm uninstall myapp101 

# List Kubernetes Pods
kubectl get pods
Observation: 
1. We should not see "myhook-postdelete" pod
2. It got created, completed and deleted as we have provided "hook-succeeded" in "helm.sh/hook-delete-policy"
```

## Step-10: Downside of using hook-failed 
1. **hook-failed:** Delete the resource if the hook failed during execution
2. The downside of this during Chart Development phase is, when our hook fails and its resource deleted, we will not have an option to troubleshoot.
3. If we don't use `hook-failed` our resource created will be present and we can describe that resource, review events and troubleshoot. 
4. This is not a recommendation, just my personal observation. 
