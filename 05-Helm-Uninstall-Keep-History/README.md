# Helm Uninstall Keep History 

## Step-01: Introduction
- We will learn to uninstall Helm Release in a most effective way (best practice) so that we don't loose the history of our Helm Release
- **Important Note:** This demo is in continuation to previous release demo

## Step-02: Uninstall Helm Release with --keep-history Flag
```t
# List Helm Releases
helm list
helm list --superseded
helm list --deployed

# List Release History
helm history myapp101

# Uninstall Helm Release with --keep-history Flag
helm uninstall <RELEASE-NAME> --keep-history
helm uninstall myapp101 --keep-history

# List Helm Releases which are uninstalled
helm list --uninstalled
Observation:
We should see uninstalled release

# helm status command
helm status myapp101
Observation:
1. works only when we use --keep-history flag
2. We can see all the details of release with "Status: Uninstalled"
```

## Step-03: Rollback Uninstalled Release
```t
# List Release History
helm history myapp101

# Rollback Helm Uninstalled Release
helm rollback <RELEASE> [REVISION] [flags]
helm rollback myapp101 3
Observation: It should rollback to specific revision number from revision history

# List Helm Releases
helm list

# List Kubernetes Resources
kubectl get pods
kubectl get svc

# List Kubernetes Resources Deployed as part of this Helm Release
helm status myapp101 --show-resources

# Access Application 
http://localhost:31232
```

## Step-04: Uninstall Helm Release - NO FLAGS
```t
# List Helm Releases
helm list

# Uninstall Helm Release
helm uninstall <RELEASE-NAME>
helm uninstall myapp101

# List Helm Releases which are uninstalled
helm list --uninstalled
Observation:
We should not see uninstalled release, this command will completely remove the release and its all references

# helm status command
helm status myapp101
Observation:
As the release is permanently removed, we dont get an error "Error: release: not found"

# List Helm History
helm history myapp101
```

## Step-05: Rollback Uninstalled Release
```t
# Rollback Helm Uninstalled Release
helm rollback <RELEASE> [REVISION] [flags]
helm rollback myapp101 1 
Observation: 
Should throw error "Error: release: not found"
```

## Step-06: Best Practice for Helm Uninstall
- It is recommended to always use `--keep-history Flag` for following reasons
- Keeping Track of uninstalled releases
- Quick Rollback if that Release is required
