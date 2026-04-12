# Task: Deploy Weave Network Plugin

## Purpose

Deploys Weave - a simple, easy-to-use container networking solution that enables pod-to-pod communication across all cluster nodes.

## Deployment Process

### 1. Load Configuration Variables

Loads kubeconfig settings to identify credentials for kubectl.

### 2. Apply Weave Manifest

Uses kubectl to apply official Weave manifests:

```bash
kubectl apply -f {weave.files} \
  --kubeconfig {admin.kubeconfig}
```

Where:

- `{weave.files}` - Path to Weave deployment manifests (typically GitHub URL)
- `--kubeconfig` - Admin kubeconfig for API authentication
- Delegation to master ensures proper cluster authentication

### 3. Creating Weave Components

The manifest deployment creates:

- **Weave DaemonSet**: Runs one pod per node for networking
- **Weave service**: Cluster service for internal communication
- **IPAM DaemonSet**: IP allocation manager
- **weave-net namespace** or **kube-system**: Namespace containing Weave pods
