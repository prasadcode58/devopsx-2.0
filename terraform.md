# DevOpsX 2.0 — Terraform Infrastructure as Code

## Overview

Terraform is used as the Infrastructure as Code component.

The current implementation manages local Docker infrastructure rather than cloud resources.

## Provider

The project uses:

```text
kreuzwerker/docker
```

Docker is accessed through:

```text
unix:///var/run/docker.sock
```

## Managed Resources

### Docker Network

```text
devopsx-network
```

### Docker Container

```text
devopsx-terraform
```

Image:

```text
devopsx-2.0:1.0
```

Port mapping:

```text
Host:      5001
Container: 5000
```

## Terraform Workflow

```text
terraform init
        ↓
terraform validate
        ↓
terraform plan
        ↓
terraform apply
```

### init
Initializes the working directory and downloads the provider.

### validate
Checks configuration syntax and structure.

### plan
Displays intended infrastructure changes.

### apply
Creates or updates the defined resources.

## Benefits

- Declarative infrastructure
- Reproducible local infrastructure
- Version-controlled configuration
- Planned infrastructure changes
- Automated resource creation

## Scope

This Terraform configuration is for the local academic environment and does not claim to provision a cloud production environment.
