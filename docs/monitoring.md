# DevOpsX 2.0 — Monitoring and Alerting

## Overview

Prometheus and Grafana provide monitoring and visualization for the Kubernetes environment.

## Monitoring Stack

The project uses the Prometheus Community `kube-prometheus-stack`.

Key components include:

- Prometheus
- Grafana
- Kubernetes monitoring components
- Prometheus Operator

## Prometheus

Prometheus collects Kubernetes metrics.

The custom alert uses:

```text
kube_deployment_status_replicas_available
```

for:

```text
namespace="default"
deployment="devopsx-app"
```

## Grafana

Grafana provides dashboards for Kubernetes and DevOpsX workloads, including resource-related metrics.

## Custom Alert

Alert name:

```text
DevOpsXApplicationReplicasLow
```

Expression:

```text
kube_deployment_status_replicas_available{
  namespace="default",
  deployment="devopsx-app"
} < 2
```

Configured duration:

```text
1 minute
```

Severity:

```text
warning
```

## Alert Test

The alert was tested by reducing the DevOpsX deployment below its desired replica count.

The test verified that:

1. Available replicas fell below the threshold.
2. Prometheus detected the condition.
3. `DevOpsXApplicationReplicasLow` entered the firing state.
4. The deployment was restored to two replicas.
5. The alert recovered.

## Monitoring Flow

```text
Kubernetes
     ↓
Prometheus
     ├──→ Grafana
     ↓
PrometheusRule
     ↓
DevOpsXApplicationReplicasLow
```
