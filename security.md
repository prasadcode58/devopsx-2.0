# DevOpsX 2.0 — Security and Scalability Considerations

## Kubernetes RBAC

Jenkins uses a dedicated `jenkins` ServiceAccount with namespace-scoped permissions.

The Role covers only resources needed by the CI/CD pipeline:

- Deployments
- Deployment scaling
- Pods
- Services

This is preferable to granting unrestricted cluster administrator permissions.

## Resource Controls

The application specifies:

```text
Requests:
CPU: 100m
Memory: 64Mi

Limits:
CPU: 500m
Memory: 128Mi
```

## Availability

The Deployment maintains two replicas:

```text
replicas: 2
```

This provides basic redundancy and supports rolling updates.

## Image Versioning

Jenkins uses build-specific image tags:

```text
192.168.49.2:5000/devopsx-2.0:<BUILD_NUMBER>
```

This makes individual build outputs distinguishable.

## Pipeline Verification

Jenkins explicitly waits for Kubernetes rollout completion instead of assuming that changing the image means deployment succeeded.

## Registry Security

The current registry is a local Minikube development registry using HTTP.

A production environment should use a private registry with TLS and appropriate authentication.

## Credentials

Kubernetes authentication material should not be committed to Git.

The Jenkins Kubernetes configuration is maintained outside the repository.

## Scalability

The Kubernetes Deployment can be scaled, for example:

```bash
kubectl scale deployment devopsx-app --replicas=3
```

The monitoring alert detects when available replicas fall below the desired count of two.

For a larger production environment, additional measures could include:

- Horizontal Pod Autoscaling
- Ingress/load balancing
- Highly available Kubernetes infrastructure
- Persistent storage where required
- Centralized secret management
- TLS
- Production-grade container registry infrastructure

These are outside the current local project scope.

## Scope

The security and scalability controls demonstrate practical DevOps practices for the academic local environment and should not be interpreted as a complete production security architecture.
