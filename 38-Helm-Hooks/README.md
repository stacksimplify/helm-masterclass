# Helm Hooks

## Step-01: Introduction
- Understand Helm Hooks

## Step-02: Create a simple Chart from Starter Chart 
- **Important Note:** This step is optional for you because you will have all the Chart files and folders ready for you to implement hooksdemo1 in this respective section
```t
# Create Helm Chart from starter chart
helm create hooksdemo1 --starter=mystarterchart
```

## Step-03: Create/Review pre-install Hook
- **File Location:** templates/preinstall-hookpod.yaml
```yaml
apiVersion: v1
kind: Pod
metadata: 
  name: myhook-preinstall
  annotations:
    "helm.sh/hook": "pre-install"
spec:
  restartPolicy: Never
  containers:
    - name: myhook-preinstall-container
      image: busybox
      imagePullPolicy: IfNotPresent
      command:  ['sh', '-c', 'echo Pre-install hook Pod is running && sleep 15']      
```


## Step-04: Create/Review pre-upgrade hook
- **File Location:** templates/preupgrade-hookpod.yaml
```yaml
apiVersion: v1
kind: Pod
metadata: 
  name: myhook-preupgrade
  annotations:
    "helm.sh/hook": "pre-upgrade"
spec:
  restartPolicy: Never
  containers:
    - name: myhook-preupgrade-container
      image: busybox
      imagePullPolicy: IfNotPresent
      command:  ['sh', '-c', 'echo preupgrade hook Pod is running && sleep 15']       
```

## Step-05: Create/Review post-delete hook
- **File Location:** templates/postdelete-hookpod.yaml
```yaml
apiVersion: v1
kind: Pod
metadata: 
  name: myhook-postdelete
  annotations:
    "helm.sh/hook": "post-delete"
spec:
  restartPolicy: Never
  containers:
    - name: myhook-postdelete-container
      image: busybox
      imagePullPolicy: IfNotPresent
      command:  ['sh', '-c', 'echo post-delete hook Pod is running && sleep 15']
```

## Step-06: Test Helm Hook: pre-install
```t
# Change Directory (In Helm Chart Folder)
cd hooksdemo1

# Install Helm Release
helm install myapp101 . --atomic

# List Helm Release
helm list

# List Kubernetes Pods
kubectl get pods
Observation:
1. We should see "myhook-preinstall" pod which should be completed status

# Describe Pod
kubectl describe pod myhook-preinstall

# Verify Pod Start and Finish Times
kubectl get pods
kubectl describe pod myhook-preinstall | grep -E 'Anno|Started:|Finished:'
kubectl describe pod myapp101-hooksdemo1-65b7c4d5b9-2rqfx | grep -E 'Anno|Started:|Finished:'

# Access Application
kubectl get svc
http://localhost:31239
Observation: We should see V1 version of application
```

## Step-07: Hooks and the Release Lifecycle
1. Lets say for `helm install` lifecycle we have defined two hooks `pre-install` and `post-install`, lets understand what happens
2. Discuss by going to documentation [Hooks and the Release Lifecycle](https://helm.sh/docs/topics/charts_hooks/#hooks-and-the-release-lifecycle)

## Step-08: Test Helm Hook: pre-upgrade
```t
# Change Directory (In Helm Chart Folder)
cd hooksdemo1

# Upgrade Helm Release
helm list
helm upgrade myapp101 . --set image.tag=0.2.0

# List Kubernetes Pods
kubectl get pods
Observation:
1. We should see "myhook-preupgrade" pod which should be completed status

# Describe Pod
kubectl describe pod myhook-preupgrade

# Verify Pod Start and Finish Times
kubectl get pods
kubectl describe pod myhook-preupgrade | grep -E 'Anno|Started:|Finished:'
kubectl describe pod myapp101-hooksdemo1-7b997b4556-t6s75 | grep -E 'Anno|Started:|Finished:'

# Access Application
kubectl get svc
http://localhost:31239
Observation: We should see V2 version of Application
```

## Step-09: Test Helm Hook: post-delete
```t
# Change Directory (In Helm Chart Folder)
cd hooksdemo1

# Uninstall/Delete Helm Release
helm list
helm uninstall myapp101 

# List Kubernetes Pods
kubectl get pods
Observation:
1. We should see "myhook-postdelete" pod which should be completed status
2. We should see all the 3 hook pods present even after deleting/uninstalling the release
```

## Step-10: Hook resources are not managed with corresponding releases
1. The resources that a hook creates are currently not tracked or managed as part of the release. 
2. Once Helm verifies that the hook has reached its ready state, it will leave the hook resource alone.
3. In short, `helm uninstall` will not delete hook resources. 