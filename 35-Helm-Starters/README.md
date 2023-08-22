# Helm Starters

## Step-01: Introduction
- We are going to learn about Helm Starter Charts
- Create / Build a Starter Chart
- Using starter chart build a base chart

## Step-02: Helm Starter Charts
### What are Helm Starter Charts ?
1. Starter charts are same as regular Helm Charts
2. Starter charts are reusable template that helps us in building new charts. 
3. A new developer don't need to start from scratch in your organization if you already have starter charts. He can use them and build on top of it. 
4.  We can also enforce certain resources that needs to be available in the created charts.
### Where do we place the starter charts ?
5. We need to place starter charts in folder "$HELM_DATA_HOME/starters" folder
### Are there any drawbacks ?
6. The `Chart.yaml` will be overwritten by the generator.
7. Due to that we don't get the version or dependency charts from the starter chart template.

## Step-03: Create a Simple Helm Chart and Modify to a Starter Chart
- This step is completely optional for you.
- You will have `mystarterchart` folder ready for you to move on with next steps in the demo.
```t
# Helm Create
helm create mystarterchart

# Important Note
1. We are going to modify the default helm chart when we create it using "helm create" to very simpler one with only "deployment.yaml" and "service.yaml"

# Changes in Templates folder
1. Delete "tests" folder
2. Delete hpa.yaml, ingress.yaml and serviceaccount.yaml
3. Update "_helpers.tpl" to remove "serviceAccountName" template
4. In values.yaml, remove serviceaccount, ingress and autoscaling values
5. In values.yaml, update the service to NodePort with port as 31239
6. In values.yaml, update the repository value to "ghcr.io/stacksimplify/kubenginxhelm"
7. In deployment.yaml, remove autoscaling and serviceaccount references
8. In service.yaml, add nodeport argument with action to bring the port 31239 from values.yaml
9. In Chart.yaml, just change appversion and version to 1.0.0. This will anyway override when we create charts using starter charts but just want to compare and test it. 
10. In Chart.yaml, update the dependencies section. This will anyway override when we create charts using starter charts but just want to compare and test it. 
dependencies:
- name: mychart4
  version: "0.1.0"
  repository: "https://stacksimplify.github.io/helm-charts/"
11. Sub Charts: Download and untar a Helm Chart to "charts" directory. We are going to observe what happens to "charts" directory when we create a chart from starter chart
helm pull https://stacksimplify.github.io/helm-charts/mychart4-0.1.0.tgz --untar
12. Update NOTES.txt: remove if statement for Ingress
```

## Step-04: Test the Chart before converting it completely to Starter Chart
```t
# Change Directory
cd mystarterchart

# Helm Lint
helm lint 
URL: https://helm.sh/docs/helm/helm_lint/
1. examine a chart for possible issues
2. This command takes a path to a chart and runs a series of tests to verify that the chart is well-formed.
3. If the linter encounters things that will cause the chart to fail installation, it will emit [ERROR] messages. 
4. If it encounters issues that break with convention or recommendation, it will emit [WARNING] messages.

# Install Helm Release
helm install myapp1 . --atomic

# List Pods and Services
kubectl get pods
kubectl get svc

# Access Application
Parent Chart: http://localhost:31239
mychart4 chart: http://localhost:<port-from-get-svc-output>

# Uninstall Helm Release
helm uninstall myapp1
```

## Step-05: Replace "mystarterchart" with `<CHARTNAME>` in all files
**Important Note:**  All occurrences of `<CHARTNAME>` will be replaced with the specified chart name so that starter charts can be used as templates.
1. _helpers.tpl
2. deployment.yaml
3. service.yaml
4. NOTES.txt
5. Chart.yaml
6. values.yaml (Here just in comment)


## Step-06: Copy mystarterchart to HELM_DATA_HOME/starters
```t
# Helm env command
helm env

# Helm env HELM_DATA_HOME
helm env HELM_DATA_HOME
HELM_DATA_HOME="/Users/kalyan/Library/helm"

# Create folder helm and helm/starters
cd /Users/kalyan/Library/
mkdir helm
cd helm
mkdir starters

# COPY mystarterchart folder 
cp -r mystarterchart /Users/kalyan/Library/helm/starters/
```

## Step-07: Create new chart using Starter Chart
- [Docker Image: kubenginxhelm](https://github.com/users/stacksimplify/packages/container/package/kubenginxhelm)
```t
# Change Directory
cd MYCHARTS

# Helm Create using starter chart
helm create mychart9 --starter=mystarterchart

# Review mychart9 files
1. Chart.yaml
- It should be regenerated and versions should be overided for both version and appversion to 0.1.0
- Update the appVersion to "0.3.0" with quotes(it should be string in quotes) 
- Our Docker Image version is also "0.3.0" which matches our Chart appVersion so we are good. 
- https://github.com/users/stacksimplify/packages/container/package/kubenginxhelm
2. deployment.yaml - Review it
3. service.yaml - Review it
4. values.yaml - Review it
5. NOTES.txt - Review it
6. "charts" directory: We should see "mychart4" should be present as packaged file "mychart4-0.1.0.tgz" even though in our starter chart we have it as UNZIPPED
```

## Step-08: Create Helm Release from new chart created using starter chart
```t
# Change Directory
cd MYCHARTS/mychart9

# Helm Lint
helm lint 

# Install Helm Release
helm install myapp901 .

# List Pods and Services
kubectl get pods
kubectl get svc

# Access Application
Parent Chart: http://localhost:31239
mychart4 chart: http://localhost:<port-from-get-svc-output>

# Uninstall Helm Release
helm uninstall myapp901
```