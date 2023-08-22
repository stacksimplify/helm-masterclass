# Helm Repository: Integrate with Artifact Hub

## Step-01: Introduction
- List our Public Helm Repositories on Artifact Hub

## Step-02: What is Artifact Hub
- Navigage to [Artifact Hub](https://artifacthub.io)

## Step-03: SignUp to Artifact Hub
- You can signup to Artifact Hub using your GitHub Account

## Step-04: Add Repository in Artifact Hub
- Artifact Hub -> User -> Control Panel -> Add
- **Kind:** Helm Charts
- **Name:** stacksimplify-helm-charts-repo
- **Display Name:** StackSimplify Helm Charts Repo
- **URL:** https://stacksimplify.github.io/helm-charts-repo/
- **Security Scanner Disabled:** LEAVE TO DEFAULTS
- Click on **ADD**

## Step-05: Create a file artifacthub-repo.yml in helm-charts-repo Git Repo
- **artifacthub-repo.yml**
```yaml
# Artifact Hub repository metadata file
#
# Some settings like the verified publisher flag or the ignored packages won't
# be applied until the next time the repository is processed. Please keep in
# mind that the repository won't be processed if it has not changed since the
# last time it was processed. Depending on the repository kind, this is checked
# in a different way. For Helm http based repositories, we consider it has
# changed if the `index.yaml` file changes. For git based repositories, it does
# when the hash of the last commit in the branch you set up changes. This does
# NOT apply to ownership claim operations, which are processed immediately.
#
#repositoryID: The ID of the Artifact Hub repository where the packages will be published to (optional, but it enables verified publisher)
repositoryID: < The ID of the Artifact Hub repository>
owners: # (optional, used to claim repository ownership)
  - name: Kalyan Reddy Daida
    email: stacksimplify@gmail.com
ignore: # (optional, packages that should not be indexed by Artifact Hub)
  - name: package1
  - name: package2 # Exact match
    version: beta # Regular expression (when omitted, all versions are ignored)
```
- Add this to to Git Repo helm-charts-repo
```t
# Commit the new file to Git Repo: helm-charts-repo
git add .
git commit -am "artifacthub-repo.yml added"
git push
```

## Step-06: In Artifact Hub, wait for next check-in
- Go to Artifact Hub -> Control Panel

## Step-07: Search our Helm Charts from Artifact Hub
- Search our Helm Charts from Artifact Hub

## Step-08: We can Host Artifact Hub privately in our organization
- Refer the link [Host Artifact Hub in your organization](https://artifacthub.io/packages/helm/artifact-hub/artifact-hub)

## Step-09: Search Artifact Hub
- [helm search hub](https://helm.sh/docs/helm/helm_search_hub/)
```t
# Helm Search hub
helm search hub myfirstchart
```