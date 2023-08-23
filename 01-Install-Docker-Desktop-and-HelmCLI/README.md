# Install Docker Desktop and HELM CLI

## Step-01: Introduction
1. Install Docker Desktop
2. Install Helm CLI on local desktop

## Step-02: Docker Desktop - Pricing, SignUp, Download
- [Docker Desktop Pricing](https://www.docker.com/pricing/)
- [SignUp Docker Hub](https://hub.docker.com/)
- [Download Docker Desktop](https://www.docker.com/products/docker-desktop/)

## Step-03: Install Docker Desktop 
### Step-03-01: MACOS: Install Docker Desktop 
```t
# Install Docker Desktop
Copy Docker dmg to Applications folder

# Create Docker Hub Account
https://hub.docker.com

# Signin Docker Desktop 
Open Docker Desktop and SignIn to Docker Hub
```
### Step-03-02: WINDOWS: Install Docker Desktop 
```t
# Download Docker Desktop
https://www.docker.com/products/docker-desktop/

# Install Docker Desktop on Windows
Run the "Docker Desktop Installer.exe"

# Create Docker Hub Account
https://hub.docker.com

# Signin Docker Desktop 
Open Docker Desktop and SignIn to Docker Hub

# Configure kubectl cli on Windows PATH
C:\Program Files\Docker\Docker\Resources\bin
```

## Step-04: Enable Kubernetes Cluster
- **Additional Reference:** [Docker Desktop - k8s Cluster](https://docs.docker.com/desktop/kubernetes/)
```t
# Enable Kubernetes Cluster
- Go to Settings -> Enable Kubernetes
- Apply and Restart
- Kubernetes Cluster Installation: Install
- Wait for 5 to 10 minutes for Kubernetes Cluster to come up
```

## Step-05: Configure kubeconfig for kubectl for Docker Desktop k8s Cluster
```t
# Verify if kubectl installed (Docker desktop should install kubectl automatically)
which kubectl

# Verify kubectl version
kubectl version 
kubectl version --short
kubectl version --client --output=yaml

# List Config Contexts
kubectl config get-contexts

# Config Current Context
kubectl config current-context

# Config Use Context (Only if someother context is present in current-context output)
kubectl config use-context docker-desktop

# List Kubernetes Nodes
kubectl get nodes
```

## Step-06: Verify if our k8s Cluster is functional with a Sample Application
- [StackSimplify Docker Images](https://github.com/stacksimplify?tab=packages)
- [Docker Image used in this Demo](https://github.com/users/stacksimplify/packages/container/package/kubenginxhelm)
```t
# Review Kubernetes Manifests
Folder: kube-manifests
deployment.yaml
service.yaml

# Deploy k8s Resources to Docker Desktop k8s Cluster
kubectl apply -f kube-manifests/

# List k8s Deployments
kubectl get deploy

# List k8s pods
kubectl get pods

# List k8s Services
kubectl get svc

# Access Application
http://localhost:31300
or
http://127.0.0.1:31300

# Uninstall k8s Resources from Docker Desktop k8s cluster
kubectl delete -f kube-manifests/

# List pods, svc, deploy
kubectl get pods
kubectl get svc
kubectl get deploy
```

## Step-07: Install Helm using Package Managers
- [Install Helm](https://helm.sh/docs/intro/install/)
```t
# MacOS
brew install helm

# From Chocolatey (Windows)
choco install kubernetes-helm

# From Scoop (Windows)
scoop install helm

# Verify Helm version
helm version

# Helm Environment variables
helm env
```
## Step-08: Windows Install Helm CLI using package
```t
# Helm Releases - Download Windows amd64
https://github.com/helm/helm/releases

# Uzip the file
helm-v3.12.3-windows-amd64.zip

# Copy to C:\helm Drive
C:\ Drive

# Set Path
C:\helm\windows-amd64
```

## Additional Optional Step: Install kubectl (if not installed by default)
```t
# Download & Install kubectl
https://kubernetes.io/docs/tasks/tools/
MacOS kubectl Install: https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/
# Downlaod MacOS Intel (Update kubectl version)
curl -LO "https://dl.k8s.io/release/v1.27.2/bin/darwin/amd64/kubectl"
# Download MacOS Apple Silicon (Update kubectl version)
curl -LO "https://dl.k8s.io/release/v1.27.2/bin/darwin/arm64/kubectl"

# Make Binary executable
chmod +x ./kubectl

# Move the kubectl binary to a file location on your system PATH.
sudo mv ./kubectl /usr/local/bin/kubectl
ls -lrta /usr/local/bin/kubectl

# Verify kubectl version
kubectl version 
kubectl version --short
kubectl version --client --output=yaml
```