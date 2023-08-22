# Helm Values - Validate with JSON Schema

## Step-01: Introduction
- Helm Values - Validate with JSON Schema

## Step-02: Review helmbasics Helm Chart
- Simple Helm Chart
- deployment.yaml
- Core focus will be on learning about `values.schema.json`

## Step-03: Convert values.yaml to json
-  [Use website json2yaml](https://www.json2yaml.com/)


## Step-04: Convert Json to Json Schema
- [Use website](https://transform.tools/json-to-json-schema)

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Generated schema for Root",
  "type": "object",
  "properties": {
    "replicaCount": {
      "type": "number"
    },
    "image": {
      "type": "object",
      "properties": {
        "repository": {
          "type": "string"
        },
        "pullPolicy": {
          "type": "string"
        },
        "tag": {
          "type": "string"
        }
      },
      "required": [
        "repository",
        "pullPolicy",
        "tag"
      ]
    }
  },
  "required": [
    "replicaCount",
    "image"
  ]
}
```

## Step-05: Create file values.schema.json on Helm Chart Root Directory
- Create file `values.schema.json`
- Copy JSON content from previous step

## Step-06: Add Pattern for pullPolicy
```json
        "pullPolicy": {
          "type": "string",
          "pattern": "^(Always|Never|IfNotPresent)$"
        },
```

## Step-06: Verify values.schema.json
```t
# Change to Chart Directory
cd helmbasics

# Helm lint
helm lint .

# Required Test: Pass null value and verify
helm template myapp1 . --set replicaCount=""

# Integer Test: Provide replicaCount as String
helm template myapp1 . --set replicaCount=kalyan

# Constraint Validation Test: Provide invalid value instead of allowed values (Allowed Values: Always, Never, IfNotPresent)
helm template myapp1 . --set image.pullPolicy=kalyan
```