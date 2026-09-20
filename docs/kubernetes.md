# DevOpsX 2.0 — Kubernetes Deployment

## Overview
Kubernetes orchestrates the DevOpsX application in a local Minikube cluster.

## Deployment

Deployment name:

```text
devopsx-app
```

Desired replicas:

```text
2
```

The application container listens on port `5000`.

## Resources

Requests:

```text
CPU: 100m
Memory: 64Mi
```

Limits:

```text
CPU: 500m
Memory: 128Mi
```

## Service

```text
Name:       devopsx-service
Type:       NodePort
Port:       5000
TargetPort: 5000
```

The Service selects pods with:

```text
app=devopsx-app
```

## Rolling Updates

Jenkins updates the image using:

```text
kubectl set image deployment/devopsx-app ...
```

Jenkins then verifies:

```text
kubectl rollout status deployment/devopsx-app --timeout=120s
```

## Jenkins RBAC

A dedicated ServiceAccount named `jenkins` is used.

The namespace-scoped Role provides required access to:

- Deployments
- Deployment scaling
- Pods
- Services

The configuration does not grant unrestricted cluster administrator permissions.

## Registry Integration

The Minikube registry is available at:

```text
192.168.49.2:5000
```

Kubernetes/containerd is configured to communicate with this local development registry over HTTP.

## Verification

After Jenkins Build #5, the updated ReplicaSet reached two running pods and the Deployment reported:

```text
READY       2/2
UP-TO-DATE  2
AVAILABLE   2
```
