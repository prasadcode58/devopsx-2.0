# DevOpsX 2.0 — System Architecture

## Overview
DevOpsX 2.0 demonstrates an end-to-end DevOps workflow integrating source code management, CI/CD automation, containerization, Kubernetes deployment, Infrastructure as Code, monitoring, and alerting.

The implementation uses a local Minikube Kubernetes environment and Docker-based infrastructure.

## Architecture

```text
Developer → GitHub → Jenkins
                       │
                       ├─ Build Docker Image
                       ├─ Push Image to Registry
                       ├─ Deploy to Kubernetes
                       └─ Verify Rollout
                              │
                              ▼
                         Kubernetes
                         ┌─────────┐
                         │ 2 Pods  │
                         └────┬────┘
                              │
                              ▼
                    Prometheus → Grafana
                              │
                              ▼
                           Alerts

Terraform → Docker Network + Terraform-managed DevOpsX Container
```

## Major Components

### Git / GitHub
Git provides version control and GitHub hosts the project repository.

### Jenkins
Jenkins automates source checkout, Docker image build, registry push, Kubernetes deployment, and rollout verification.

### Docker
The Flask application is packaged as a Docker image using the project Dockerfile.

### Docker Registry
The Minikube registry addon provides the local image registry used by Jenkins and Kubernetes.

### Kubernetes
Minikube hosts the DevOpsX Deployment and NodePort Service. The Deployment maintains two replicas.

### Terraform
Terraform manages local Docker infrastructure consisting of a Docker network and a DevOpsX container.

### Prometheus
Prometheus collects Kubernetes metrics.

### Grafana
Grafana visualizes Kubernetes and DevOpsX workload metrics.

### Alerting
`DevOpsXApplicationReplicasLow` alerts when fewer than two application replicas are available for the configured duration.

## CI/CD Flow

```text
Developer
   ↓
Git push
   ↓
GitHub
   ↓
Jenkins
   ↓
Docker build
   ↓
Registry push
   ↓
Kubernetes image update
   ↓
Rolling deployment
   ↓
Jenkins rollout verification
```

## Monitoring Flow

```text
Kubernetes → Prometheus → Grafana
                    ↓
             PrometheusRule
                    ↓
       DevOpsXApplicationReplicasLow
```

## Deployment Characteristics

- 2 application replicas
- CPU and memory requests
- CPU and memory limits
- Kubernetes NodePort Service
- Rolling deployment updates
- Dedicated Jenkins Kubernetes RBAC permissions
- Local Minikube implementation
