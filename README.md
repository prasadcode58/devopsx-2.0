# DevOpsX 2.0

A DevOps Engineering Major Project demonstrating an end-to-end CI/CD workflow integrating source code management, build automation, containerization, Kubernetes deployment, Infrastructure as Code, monitoring, and alerting.

## Objective

Design and implement a complete CI/CD pipeline integrating code management, build automation, containerization, deployment, and monitoring for a production-grade application.

## Technology Stack

| Area | Technology |
|---|---|
| Source Code Management | Git / GitHub |
| Application | Python / Flask |
| CI/CD | Jenkins |
| Containerization | Docker |
| Container Registry | Minikube Registry |
| Orchestration | Kubernetes / Minikube |
| Infrastructure as Code | Terraform |
| Monitoring | Prometheus |
| Visualization | Grafana |
| Alerting | PrometheusRule |

## Architecture

```text
Developer
    │
    ▼
  GitHub
    │
    ▼
 Jenkins
    │
    ├── Build Docker Image
    ├── Push Image to Registry
    ├── Deploy to Kubernetes
    └── Verify Rollout
            │
            ▼
       Kubernetes
       ┌──────────┐
       │ 2 App    │
       │ Replicas │
       └────┬─────┘
            │
            ▼
        Prometheus
            │
       ┌────┴────┐
       ▼         ▼
    Grafana    Alerts

Terraform
    │
    ▼
Docker Network + Terraform-managed Container
```

For the detailed architecture, see [`docs/architecture.md`](docs/architecture.md).

## CI/CD Pipeline

The Jenkins pipeline performs the following stages:

1. **Checkout SCM** — retrieves the source from the GitHub `main` branch.
2. **Build Docker Image** — builds the application image.
3. **Push Image** — pushes the build-number-tagged image to the Minikube registry.
4. **Deploy to Kubernetes** — updates the `devopsx-app` Deployment with the new image.
5. **Verify Deployment** — waits for the Kubernetes rollout to complete.
6. **Post Actions** — reports pipeline completion.

Image format:

```text
192.168.49.2:5000/devopsx-2.0:<BUILD_NUMBER>
```

A successful Jenkins Build #5 verified all pipeline stages.

See [`docs/ci-cd.md`](docs/ci-cd.md) for details.

## Application

The application is a lightweight Flask service.

Endpoint:

```text
/
```

Application port:

```text
5000
```

The application returns:

```text
DevOpsX 2.0 - Application is running!
```

## Docker

The application is packaged using the project `Dockerfile`.

Example local build:

```bash
docker build -t devopsx-2.0:1.0 .
```

## Kubernetes

The Kubernetes deployment:

- Uses two application replicas.
- Exposes the application through a NodePort Service.
- Defines CPU and memory requests and limits.
- Uses rolling deployment updates.
- Uses a dedicated Jenkins ServiceAccount with namespace-scoped RBAC.

Main manifests:

```text
k8s/
├── deployment.yaml
├── service.yaml
├── devopsx-alerts.yaml
└── jenkins-rbac.yaml
```

See [`docs/kubernetes.md`](docs/kubernetes.md).

## Terraform

Terraform is used for local Docker Infrastructure as Code.

It manages:

- `devopsx-network` Docker network
- `devopsx-terraform` Docker container
- Application port mapping from host `5001` to container `5000`

See [`docs/terraform.md`](docs/terraform.md).

## Monitoring and Alerting

Prometheus and Grafana provide monitoring for the Kubernetes environment.

A custom Prometheus alert is configured:

```text
DevOpsXApplicationReplicasLow
```

It detects when fewer than two DevOpsX application replicas are available for the configured duration.

The alert was tested by reducing the deployment replica count, observing the alert enter the firing state, and restoring the deployment to two replicas.

See [`docs/monitoring.md`](docs/monitoring.md).

## Security and Scalability

The project includes:

- Namespace-scoped Jenkins Kubernetes RBAC.
- Dedicated Jenkins ServiceAccount.
- Kubernetes CPU and memory requests/limits.
- Two application replicas.
- Build-number-based container image versioning.
- Automated rollout verification.

The local registry uses HTTP because it is part of the Minikube development environment. A production deployment should use an appropriately secured private registry with TLS and authentication.

See [`docs/security.md`](docs/security.md).

## Project Structure

```text
devopsx-2.0/
├── app/
│   └── app.py
├── docs/
│   ├── architecture.md
│   ├── ci-cd.md
│   ├── kubernetes.md
│   ├── monitoring.md
│   ├── project-overview.md
│   ├── security.md
│   ├── setup.md
│   └── terraform.md
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

## Documentation

| Document | Description |
|---|---|
| [Project Overview](docs/project-overview.md) | Project scope and technology stack |
| [Architecture](docs/architecture.md) | System architecture and component relationships |
| [CI/CD](docs/ci-cd.md) | Jenkins pipeline and deployment workflow |
| [Kubernetes](docs/kubernetes.md) | Deployment, Service, resources, and RBAC |
| [Terraform](docs/terraform.md) | Infrastructure as Code configuration |
| [Monitoring](docs/monitoring.md) | Prometheus, Grafana, and alerting |
| [Security](docs/security.md) | Security and scalability considerations |
| [Setup Guide](docs/setup.md) | Local setup and execution instructions |

## Project Scope

This is a local academic DevOps implementation using Minikube. It demonstrates the integration of the requested DevOps technologies without claiming to be a cloud-hosted production deployment.

## CI/CD Verification

The complete pipeline was successfully verified through Jenkins Build #5:

```text
Checkout SCM        ✓
Build Docker Image  ✓
Push Image          ✓
Deploy to Kubernetes ✓
Verify Deployment   ✓
Post Actions        ✓
```
