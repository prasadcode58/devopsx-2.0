# DevOpsX 2.0 — CI/CD Pipeline

## Overview
Jenkins automates the continuous integration and continuous deployment workflow from the GitHub repository to Kubernetes.

## Pipeline Flow

```text
GitHub
  ↓
Checkout SCM
  ↓
Build Docker Image
  ↓
Push Image to Registry
  ↓
Deploy to Kubernetes
  ↓
Verify Deployment
```

## Jenkins Stages

### Checkout SCM
Jenkins retrieves the source code from the `main` branch.

### Build Docker Image
Jenkins builds the application using `Dockerfile`.

Images are tagged with the Jenkins build number:

```text
192.168.49.2:5000/devopsx-2.0:<BUILD_NUMBER>
```

### Push Image
The generated image is pushed to the Minikube registry.

### Deploy to Kubernetes
Jenkins updates the `devopsx-app` Deployment to use the image produced by the current build.

### Verify Deployment
Jenkins runs Kubernetes rollout verification with a configured timeout. A failed rollout causes the pipeline to fail.

## Jenkins Environment

```text
REGISTRY   = 192.168.49.2:5000
IMAGE_NAME = devopsx-2.0
IMAGE      = <registry>/<image-name>:<build-number>
KUBECONFIG = /var/lib/jenkins/.kube/config
```

## Image Versioning

For example:

```text
Jenkins Build #5
       ↓
192.168.49.2:5000/devopsx-2.0:5
```

This provides traceability between a Jenkins build and the container image deployed to Kubernetes.

## Jenkins Kubernetes Permissions

Jenkins uses a dedicated `jenkins` ServiceAccount and namespace-scoped RBAC permissions for deployments, deployment scaling, pods, and services.

## Successful Verification

Jenkins Build #5 completed successfully, including:

1. Checkout SCM
2. Build Docker Image
3. Push Image
4. Deploy to Kubernetes
5. Verify Deployment
6. Post Actions

This verified the complete automated path from source code to a running Kubernetes deployment.
