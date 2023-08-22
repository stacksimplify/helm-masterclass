# Helm Subcharts - Dependency Command

## Step-01: Introduction
- Create Parent Chart
- helm dependency list
- helm dependency update
- helm dependency build
- helm dependency version constraints
- helm dependency repository @REPO vs REPO-URL

## Step-02: Create Parent Chart
```t
# Create Parent Chart
helm create parentchart
```

## Step-03: Update Helm Dependencies in Parent Chart Chart.yaml
```yaml
apiVersion: v2
name: parentchart
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "1.16.0"
dependencies:
- name: mychart1
  version: "0.1.0"
  repository: "https://stacksimplify.github.io/helm-charts/"
- name: mychart2
  version: "0.4.0"
  repository: "https://stacksimplify.github.io/helm-charts/"
- name: mysql
  version: "9.9.0"
  repository: "https://charts.bitnami.com/bitnami"
```

## Step-04: Helm Dependency Commands - List and Update
- **helm dependency list:** List all of the dependencies declared in a chart.
- **helm dependency update:** update parent chart `charts/` folded based on the contents of file `Chart.yaml`
```t
# Helm Dependency List
helm dependency list
Observation: 
You should see status "missing" because we still didnt do helm dependency update

# Verify Charts folder in parentchart
ls parentchart/charts
Observation: it should be empty. Dependency subcharts not downloaded

# Helm Dependency Update
helm dependency update CHART-NAME
helm dependency update parentchart/
ls parentchart/charts
Observation: 
1. We should see both charts (mychart1-0.1.0.tgz, mychart2-0.4.0.tgz, mysql-9.9.0.tgz)downloaded to "parentchart/charts" folder
2. We should see "Chart.lock" file in "parentchart" folder

# Review Chart.lock file
cat parentchart/Chart.lock 

# Helm Dependency list
helm dependency list parentchart/
Observation: Should see status as "OK"
```

## Step-05: Helm Dependency Chart Version Ranges
- Updates to parent chart `Chart.yaml`

### Step-05-01: Helm Chart Version Notation
```t
Helm Chart Version Notation: Major.Minor.Patch 
MySQL Helm Chart Version: 9.10.8
Major: 9
Minor: 10
Patch: 8
```
### Step-05-02: Basic Comparison Operators
- We can define the version constraints using basic comparison operators
- Where possible, use version ranges instead of pinning to an exact version.
```t
# Basic Comparison Operators
version: "= 9.10.8" 
version: "!= 9.10.8" 
version: ">= 9.10.8"
version: "<= 9.10.8"
version: "> 9.10.8"   
version: "< 9.10.8"
version: ">= 9.10.8 < 9.11.0"  
```

### Step-05-03: For Range Comparison Major: Caret Symbol(ˆ)
- `x` is a placeholder
- The caret (^) operator is for major level changes once a stable (1.0.0) release has occurred.
```t
# For Range Comparison Major: Caret Symbol(ˆ)
^9.10.1  is equivalent to >= 9.10.1, < 10.0.0
^9.10.x  is equivalent to >= 9.10.0, < 10.0.0   
^9.10    is equivalent to >= 9.10, < 10
^9.x     is equivalent to >= 9.0.0, < 10        
^0       is equivalent to >= 0.0.0, < 1.0.0
```

### Step-05-05: For Range Comparison Minor: Tilde Symbol(~)
- `x` is a placeholder
- The tilde (~) operator is for 
  - patch level ranges when a minor version is specified 
  - major level changes when the minor number is missing. 
- The suggested default is to use a patch-level version match which is first one in the below table 
```t
# For Range Comparison Major: Caret Symbol(ˆ)
~9.10.1  is equivalent to >= 9.10.1, < 9.11.0 # Patch-level version match
~9.10    is equivalent to >= 9.10, < 9.11
~9       is equivalent to >= 9, < 10
^9.x     is equivalent to >= 9.0.0, < 10        
^0       is equivalent to >= 0.0.0, < 1.0.0
```
### Step-05-06: Verify with some examples
```yaml
dependencies:
- name: mysql
  version:" "9.10.9"
  #version: ">=9.10.1" # Should dowload latest version available as on that day
  #version: "<=9.10.6" # Should download 9.10.6 mysql helm chart package
  #version: "~9.9.0" # Should download latest from 9.9.x (Patch version) 
  #version: "~9.9" # Should download latest from 9.9 
  #version: "~9" # Should download latest from 9.x 
  repository: "https://charts.bitnami.com/bitnami"


# helm dependency update
helm dependency update
or
helm dep update  
```

## Step-06: Helm Dependency Build Command
- **helm dependency build:** rebuild the `charts/` directory based on the `Chart.lock` file
- In short `dep update` command will negotiate with version constraints defined in `Chart.yaml` where as `dep build` will try to build or download or update whatever version preset in `Chart.lock` file
- If no lock file is found, `helm dependency build` will mirror the behavior of `helm dependency update`.
```t
# helm dependency build
helm dependency build CHART-NAME
helm dependency build parentchart
```

## Step-07: Helm Dependency Repository @REPO vs REPO-URL
- When we are using Helm with DevOps pipelines across environments "@REPO" approach is not recommended
- REPO-URL approach (repository: "https://charts.bitnami.com/bitnami") is always recommended
```t
# With Repository URL (Recommended approach)
dependencies:
- name: mysql
  version: ">=9.10.8"
  repository: "https://charts.bitnami.com/bitnami"

# List Helm Repo
helm repo list
helm search repo bitnami/mysql --versions

# With @REPO (local repo reference - NOT RECOMMENDED)
dependencies:
- name: mysql
  version: ">=9.10.8"
  repository: "@bitnami"

# Clean-Up Charts folder and Chart.lock
rm parentchart/charts/*
rm parentchart/Chart.lock

# Ensure we are using repository: "@bitnami"
helm dependency update
ls parentchart/charts/
cat parentchart/Chart.lock
Observation: Should work as expected
```
