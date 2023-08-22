# Helm Plugins

## Step-01: Introduction
- Install Helm Plugins
- [Helm Starter Plugin](https://github.com/salesforce/helm-starter.git)
- [Helm Dashboard Plugin](https://github.com/komodorio/helm-dashboard.git)

## Step-02: Install Helm Plugin
- [Helm Starter Plugin](https://github.com/salesforce/helm-starter)
- [Review Helm Starter Plugin plugin.yaml](https://github.com/salesforce/helm-starter/blob/master/plugin.yaml)
```t
# List Helm Plugins
helm plugin list

# Install Helm Plugins
helm plugin install https://github.com/salesforce/helm-starter.git

# List Helm Plugins
helm plugin list

# Helm env
helm env 
Observation:
1. Find the value for HELM_PLUGINS
HELM_PLUGINS="/Users/kalyan/Library/helm/plugins"

# Verify in Helm plugins directory
cd /Users/kalyan/Library/helm/plugins
ls
```

## Step-03: Play with Helm Starter Plugin
```t
# List Helm Starters
helm plugin list
helm <PLUGIN-NAME> <PLUGIN-SUB-COMMAND-AS-PER-PLUGIN>
helm starter list

# Fetch Helm Starter
helm starter fetch https://github.com/salesforce/helm-starter-istio.git

# List Helm Starters
helm starter list
```

## Step-04: Play with Helm Plugin Commands
```t
# Update Helm Plugin
helm plugin list
helm plugin update PLUGIN-NAME
helm plugin update starter

# Uninstall Helm Plugin
helm plugin list
helm plugin uninstall PLUGIN-NAME
helm plugin uninstall starter
helm plugin list
```

## Step-05: Install Couple of Releases
```t
# Helm Rep Add
helm repo list
helm repo add stacksimplify https://stacksimplify.github.io/helm-charts/
helm repo list

# Helm Install dev101
helm install dev101 stacksimplify/mychart1 --atomic
helm upgrade dev101 stacksimplify/mychart1 --atomic --set replicaCount=2
helm upgrade dev101 stacksimplify/mychart1 --atomic --set replicaCount=3

# Helm Install dev102
helm install dev102 stacksimplify/mychart2 --atomic

# List Helm Releases
helm list
```

## Step-06: (Optional) Lets install Helm Dashboard Plugin
- [Helm Dashboard Plugin Git Repo](https://github.com/komodorio/helm-dashboard)
- [Helm Dashboard Plugin from Artifacthub](https://artifacthub.io/packages/helm-plugin/helm-dashboard/dashboard)
- [Review Helm Dashboard Plugin plugin.yaml](https://github.com/komodorio/helm-dashboard/blob/main/plugin.yaml)

```t
# List Helm Plugins
helm plugin list

# Install Helm Plugin
helm plugin install https://github.com/komodorio/helm-dashboard.git

# Start Helm Plugin: dashboard
helm dashboard

# Review Dashboard Concepts
1. Clusters
2. Installed Charts
    - Release: dev101 
        - Resources
        - Manifests
        - Values
        - Notes
    - Revision: 1, 2, 3 
    - Revision Differences
3. Repository
4. Logout 
```

## Step-07: Uninstall Releases
```t
# Helm Uninstall
helm uninstall dev101
helm uninstall dev102
```
