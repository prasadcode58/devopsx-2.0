# DevOpsX 2.0 — Project Overview

## Objective

DevOpsX 2.0 demonstrates a DevOps workflow integrating:

- Source Code Management
- Build Automation
- Containerization
- Kubernetes Orchestration
- Infrastructure as Code
- Monitoring
- Alerting

## Technology Stack

| Component | Technology |
|---|---|
| Source Code Management | Git / GitHub |
| CI/CD | Jenkins |
| Application | Python / Flask |
| Containerization | Docker |
| Container Registry | Minikube Registry |
| Orchestration | Kubernetes / Minikube |
| Infrastructure as Code | Terraform |
| Monitoring | Prometheus |
| Visualization | Grafana |
| Alerting | PrometheusRule |

## Project Structure

```text
devopsx-2.0/
├── app/
│   └── app.py
├── docs/
├── k8s/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── devopsx-alerts.yaml
│   └── jenkins-rbac.yaml
├── terraform/
│   └── main.tf
├── Dockerfile
├── Jenkinsfile
├── README.md
├── requirements.txt
└── .gitignore
```

## CI/CD

```text
GitHub
   ↓
Jenkins
   ↓
Docker Build
   ↓
Registry Push
   ↓
Kubernetes Deployment
   ↓
Rollout Verification
```

Jenkins Build #5 successfully verified the complete pipeline.

## Monitoring

```text
Kubernetes
   ↓
Prometheus
   ↓
Grafana
```

A custom Prometheus alert monitors whether fewer than two DevOpsX replicas are available.

## Infrastructure as Code

Terraform manages local Docker infrastructure consisting of a Docker network and a Terraform-managed DevOpsX container.

## Scope

This is a local academic DevOps implementation using Minikube. It demonstrates the requested DevOps technologies and their integration without claiming to be a cloud-hosted production deployment.
