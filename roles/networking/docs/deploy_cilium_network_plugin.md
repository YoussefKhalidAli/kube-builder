# Task: Deploy Cilium Network Plugin

## Purpose

Deploys Cilium - a modern, eBPF-based networking solution providing advanced security, observability, and load balancing capabilities.

## Deployment Process

### 1. Install Helm Package Manager

- Downloading the official Helm installation script from GitHub
- Executing the script to install Helm 3
- Adding the Cilium Helm repository to Helm's repo list
- Updating the Helm repository cache

### 2. Add Cilium Repository

Adds the official Cilium Helm repository:

```bash
helm repo add cilium {cilium-repo-url}
helm repo update
```

This makes Cilium charts available for installation.

### 3. Deploy Cilium via Helm

Uses Helm to install Cilium:

```bash
helm upgrade --install cilium cilium/cilium \
  --namespace kube-system \
  --set operator.replicas=1 \
  --kubeconfig={admin.kubeconfig}
```

The `helm upgrade --install` command:

- Installs Cilium if not already present
- Upgrades if already installed
- Places all components in kube-system namespace
- Sets operator replicas to 1
- Uses admin kubeconfig for authentication

### 4. Creating Cilium Components

Helm deployment creates:

- **Cilium DaemonSet**: eBPF programs running on each node
- **Cilium Operator**: Manages Cilium cluster state
- **Hubble**: Observability and networking visibility
- **Cilium API**: Control plane for policy management

All components interact via the Cilium API server.
