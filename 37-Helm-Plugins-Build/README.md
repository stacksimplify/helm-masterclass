# Build Helm Plugin

## Step-01: Introduction
- [Building Helm Plugins](https://helm.sh/docs/topics/plugins/#building-plugins)
- We will build 3 simple plugins and test

## Step-02: Create myplugin1 with env command -  Install and Verify
```t
# myplugin1
name: "myplugin1"
version: "0.1.0"
usage: "Printss Helm Environment Variables"
description: |-
  Prints Helm Environment Variables
command: "env"

# List Helm Plugins
helm plugin list

# Install Helm Plugin
helm plugin install myplugin1/

# List Helm Plugins
helm plugin list

# Run Helm Plugin
helm <PLUGIN-NAME>
helm myplugin1

# Observation
Prints Helm environment variables
```

## Step-03: Create myplugin2 with platformCommand -  Install and Verify
```t
# myplugin2
name: "myplugin2"
version: "0.1.0"
usage: "helm myplugin2"
description: "Print Helm plugin directory"
command: echo my helm plugin directory is $HELM_PLUGINS default command
platformCommand:
  - os: linux
    arch: i386
    command: "echo my helm plugin directory is $HELM_PLUGINS os is linux i386"
  - os: linux
    arch: amd64
    command: "echo my helm plugin directory is $HELM_PLUGINS os is linux amd64"
  - os: windows
    arch: amd64
    command: "echo my helm plugin directory is $HELM_PLUGINS os is windows amd64"

# List Helm Plugins
helm plugin list

# Install Helm Plugin
helm plugin install myplugin2/

# List Helm Plugins
helm plugin list

# Run Helm Plugin
helm <PLUGIN-NAME>
helm myplugin2

# Observation
Should execute the command from Default command section because we are running this on MacOS desktop which is not present in "platformCommand"
```
## Step-04: Create myplugin3 with shell script - Install and Verify
```t
# myplugin3
name: "myplugin3"
version: "0.1.0"
usage: "helm myplugin3"
description: "Print Helm plugin directory using script app.sh"
command: "$HELM_PLUGIN_DIR/app.sh"

# app.sh
#!/bin/sh
echo "my helm plugin directory is $HELM_PLUGINS from SHELL SCRIPT"

# List Helm Plugins
helm plugin list

# Install Helm Plugin
helm plugin install myplugin3/

# List Helm Plugins
helm plugin list

# Run Helm Plugin
helm <PLUGIN-NAME>
helm myplugin3

# Observation
We will see "app.sh" executed successfully
```

## Step-05: Uninstall Plugins
```t
# Uninstall Helm Plugins
helm plugin uninstall <PLUGIN-NAME>
helm plugin uninstall myplugin1
helm plugin uninstall myplugin2
helm plugin uninstall myplugin3
```


