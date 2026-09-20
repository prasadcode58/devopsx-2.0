# DevOpsX 2.0 — Setup and Execution Guide

## Prerequisites

The project is designed for a Linux environment using:

- Git
- GitHub
- Python
- Docker
- Jenkins
- Kubernetes
- Minikube
- kubectl
- Terraform
- Helm
- Prometheus
- Grafana

## Clone

```bash
git clone <repository-url>
cd devopsx-2.0
```

## Python Application

Application:

```text
app/app.py
```

Dependencies:

```text
requirements.txt
```

Application port:

```text
5000
```

## Docker

Build:

```bash
docker build -t devopsx-2.0:1.0 .
```

Run:

```bash
docker run --rm -p 5000:5000 devopsx-2.0:1.0
```

## Kubernetes

Start Minikube:

```bash
minikube start --driver=docker
```

Apply manifests:

```bash
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

Check:

```bash
kubectl get deployment devopsx-app
kubectl get pods -l app=devopsx-app
kubectl get service devopsx-service
```

## Jenkins

The repository contains the `Jenkinsfile`.

Pipeline:

```text
Checkout → Docker Build → Registry Push → Kubernetes Deploy → Rollout Verification
```

## Terraform

```bash
cd terraform
terraform init
terraform validate
terraform plan
terraform apply
```

## Monitoring

Check monitoring components:

```bash
kubectl get pods -n monitoring
```

Grafana can be exposed locally with:

```bash
kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80
```

## Alerting

Apply the custom alert:

```bash
kubectl apply -f k8s/devopsx-alerts.yaml
```

Check:

```bash
kubectl get prometheusrule -n monitoring
```

## Jenkins Kubernetes Access

Jenkins uses the dedicated ServiceAccount and RBAC configuration in:

```text
k8s/jenkins-rbac.yaml
```

Its Kubernetes configuration is maintained separately from the user's personal kubeconfig.

## Environment Note

This is a local academic DevOps implementation using Minikube. It demonstrates the requested technologies without claiming to be a cloud-hosted production deployment.
