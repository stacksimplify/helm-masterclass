# Understand Helm Chart Folder Structure

## Step-01: Introduction
- Understand Helm Chart Folder Structure

## Step-02: Helm Create Chart
```t
# Helm Create Chart
helm create <CHART-NAME>
helm create basechart
Observation: 
1. It will create a Helm Chart template 
2. We can call it like a helm chart created from a default starter chart
```

## Step-03: Helm Chart Structure
```
└── basechart
    ├── .helmignore
    ├── Chart.yaml
    ├── LICENSE
    ├── README.md
    ├── charts
    ├── templates
    │   ├── NOTES.txt
    │   ├── _helpers.tpl
    │   ├── deployment.yaml
    │   ├── hpa.yaml
    │   ├── ingress.yaml
    │   ├── service.yaml
    │   ├── serviceaccount.yaml
    │   └── tests
    │       └── test-connection.yaml
    └── values.yaml
```

