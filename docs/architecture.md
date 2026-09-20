# DevOpsX 2.0 — System Architecture

## 1. Overview

DevOpsX 2.0 is a DevOps Engineering project that demonstrates an end-to-end CI/CD workflow integrating source code management, automated build, containerization, container image distribution, Kubernetes deployment, infrastructure provisioning, monitoring, and alerting.

The project uses a local Minikube Kubernetes environment and Docker-based infrastructure.

## 2. Architecture

```text
                         ┌──────────────────────┐
                         │       Developer      │
                         │   Source Code / Git  │
                         └──────────┬───────────┘
                                    │
                                    ▼
                         ┌──────────────────────┐
                         │       GitHub         │
                         │   Source Repository  │
                         └──────────┬───────────┘
                                    │
                                    ▼
                         ┌──────────────────────┐
                         │       Jenkins        │
                         │      CI/CD           │
                         └──────────┬───────────┘
                                    │
                         ┌──────────┴───────────┐
                         │                      │
                         ▼                      ▼
                ┌─────────────────┐    ┌─────────────────┐
                │  Docker Build   │    │  Pipeline       │
                │  Application    │    │  Verification   │
                └────────┬────────┘    └─────────────────┘
                         │
                         ▼
                ┌─────────────────────┐
                │  Docker Registry     │
                │  Minikube Registry   │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │      Kubernetes      │
                │       Minikube       │
                │                      │
                │  ┌───────────────┐   │
                │  │ DevOpsX Pods  │   │
                │  │   2 replicas   │   │
                │  └───────────────┘   │
                │          │            │
                │          ▼            │
                │  ┌───────────────┐   │
                │  │ Kubernetes    │   │
                │  │ Service       │   │
                │  └───────────────┘   │
                └──────────┬────────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │      Prometheus      │
                │      Monitoring      │
                └──────────┬──────────┘
                           │
                 ┌─────────┴─────────┐
                 │                   │
                 ▼                   ▼
        ┌─────────────────┐  ┌─────────────────┐
        │     Grafana     │  │     Alerts      │
        │    Dashboard    │  │ PrometheusRule  │
        └─────────────────┘  └─────────────────┘


        Infrastructure as Code
        ────────────────────────

        Terraform
            │
            ▼
        Docker Network
            │
            ▼
        Terraform-managed
        DevOpsX Container
```
3. Major Components
Git / GitHub
Git is used for source code management and version control. GitHub hosts the remote repository containing the DevOpsX 2.0 source code and configuration files.
Jenkins
Jenkins provides the CI/CD automation layer.
The pipeline performs:
1. Source code checkout
2. Docker image build
3. Docker image push to the registry
4. Kubernetes deployment update
5. Kubernetes rollout verification
Docker
The application is packaged as a Docker image using the project's Dockerfile.
Jenkins creates an image tagged with the Jenkins build number.
Example:
192.168.49.2:5000/devopsx-2.0:<BUILD_NUMBER>
Docker Registry
A registry is provided through the Minikube registry addon.
Jenkins pushes application images to the registry, and Kubernetes pulls the required image from it during deployment.
Kubernetes
Minikube provides the Kubernetes cluster used for deployment.
The application is deployed as a Kubernetes Deployment with two replicas and exposed through a NodePort Service.
Terraform
Terraform is used as the Infrastructure as Code component of the project.
The Terraform configuration provisions Docker infrastructure including:
- A Docker network
- A Terraform-managed DevOpsX container
- Port mapping for application access
Prometheus
Prometheus collects Kubernetes and application-related monitoring metrics through the monitoring stack.
Grafana
Grafana provides visualization dashboards for the Kubernetes environment and DevOpsX workloads.
Alerting
A custom Prometheus alert named DevOpsXApplicationReplicasLow monitors the number of available DevOpsX application replicas.
The alert is triggered when fewer than two replicas are available for the configured duration.
4. CI/CD Flow
The complete automated deployment flow is:
Developer
   ↓
Git commit / push
   ↓
GitHub
   ↓
Jenkins
   ↓
Docker image build
   ↓
Push image to registry
   ↓
Update Kubernetes Deployment
   ↓
Kubernetes pulls new image
   ↓
Rolling deployment
   ↓
Jenkins verifies rollout
5. Monitoring Flow
Kubernetes
    ↓
Prometheus
    ↓
Grafana dashboards

Kubernetes metrics
    ↓
Prometheus alert rule
    ↓
DevOpsXApplicationReplicasLow
6. Deployment Characteristics
The Kubernetes deployment uses:
- 2 application replicas
- CPU and memory requests
- CPU and memory limits
- Kubernetes Service
- Rolling deployment updates
- Dedicated Jenkins Kubernetes RBAC permissions
The project is implemented locally using Minikube rather than a cloud-hosted Kubernetes cluster.
