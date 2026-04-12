# Task: Deploy Calico Network Plugin

## Purpose

Deploys Calico - an enterprise-grade networking and security solution providing advanced network policies, scalability, and visibility.

## Deployment Process

### 1. Load Configuration Variables

Loads kubeconfig for authenticating to the API server.

### 2. Apply Calico Manifest

Uses kubectl to apply official Calico manifests:

```bash
kubectl apply -f {calico.files} \
  --kubeconfig {admin.kubeconfig}
```

The manifest file is typically the official Calico definition from Project Calico.

### 3. Creating Calico Components

Manifest deployment creates:

- **Calico DaemonSet**: Networking node agents
- **Calico-kube-controllers**: Network policy enforcement
- **Typha**: Calico component communication layer
- **Felix**: Per-node policy enforcement
- **BIRD**: BGP routing daemon (optional)

All run in kube-system or calico-system namespace.
