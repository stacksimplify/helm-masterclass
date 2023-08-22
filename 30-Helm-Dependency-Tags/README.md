# Helm Dependency - Using Tags

## Step-01: Introduction
- Instead of using `condition` we are going to use `tags`
- If we have more amount of subcharts that need to be divided in to groups then we need to use `tags` instead of `condition`

 ## Step-02: Review Chart.yaml
 - Instead of using `condition` we are going to use `tags`
```yaml
apiVersion: v2
name: parentchart
description: Learn Helm Dependency Concepts
type: application
version: 0.1.0
appVersion: "1.16.0"
dependencies:
- name: mychart4
  version: "0.1.0"
  repository: "https://stacksimplify.github.io/helm-charts/"
  alias: childchart4dev
  #condition: childchart4dev.enabled
  tags: 
    - frontend 
- name: mychart4
  version: "0.1.0"
  repository: "https://stacksimplify.github.io/helm-charts/"
  alias: childchart4qa1
  #condition: childchart4qa.enabled
  tags: 
    - frontend   
- name: mychart4
  version: "0.1.0"
  repository: "https://stacksimplify.github.io/helm-charts/"
  alias: childchart4qa2
  #condition: childchart4qa2.enabled
  tags: 
    - frontend        
- name: mychart2
  version: "0.4.0"
  repository: "https://stacksimplify.github.io/helm-charts/"
  alias: childchart2
  #condition: childchart2.enabled
  tags: 
    - backend
 ```

 ## Step-03: Usecase-1: Both frontend and backend false
 ```t
 # Usecase-1: Both frontend and backend false
 # values.yaml
tags:
  frontend: false
  backend: false

# Helm Install
helm install myapp1 parentchart/ --atomic

# List Pods
kubectl get pods
Observation:
1.  We should see only 1 pod (parentchart) pod running
```


 ## Step-04: Usecase-2: Backend True and Frontend false
 ```t
# Helm Install
helm upgrade myapp1 parentchart/ --atomic --set tags.backend=true

# List Pods
kubectl get pods
Observation:
1.  We should see 2 pods (parentchart and childchart2) running
```

 ## Step-05: Usecase-2: Backend True and Frontend True
 ```t
# Helm Install
helm upgrade myapp1 parentchart/ --atomic --set tags.backend=true --set tags.frontend=true

# List Pods
kubectl get pods
Observation:
1.  We should see 5 pods (parentchart, childchart2, childchart4dev, childchart4qa1, childchart4qa2) running
```

## Step-06: Uninstall Helm Charts
```t
# Helm Uninstall
helm uninstall myapp1
```