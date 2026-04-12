# Task: Kubelet Installation

## Purpose

Downloads, installs, and configures kubelet - the node agent that runs on every node (master and worker) to manage containers and report node status to the control plane.

## Installation Steps

### 1. Load Variables

Loads configuration from:

- `roles/bootstrap-controlplane/vars/kubelet.yml` - Kubelet settings
- `roles/kubeconfig/vars/main.yml` - Kubeconfig paths
- `roles/cri/vars/main.yml` - Container runtime details

### 2. Create Directories

Creates required directories:

- Temporary directory for downloads
- Binary installation directory (typically `/usr/local/bin/`)
- Certificate storage directory
- Kubelet configuration directory

### 3. Download Binary

- Fetches kubelet from Kubernetes official releases
- Architecture-specific version (amd64, arm64, arm, etc.)
- Version matches cluster's k8s_version

### 4. Install Binary

- Copies kubelet to `/usr/local/bin/kubelet`
- Sets executable permissions (0755)
- Makes available to systemd

### 5. Create Configuration File

Generates kubelet configuration file at:

```
/var/lib/kubelet/kubelet-config.yaml
```

Configuration includes:

- **Container runtime**: Which CRI socket to use (e.g., /run/containerd/containerd.sock)
- **Node name**: Hostname for cluster identification
- **Kubeconfig**: Path to kubeconfig for API server authentication
- **Cluster DNS**: DNS server for service discovery
- **Feature gates**: Experimental kubelet features
- **Logging**: Log level and verbosity

### 6. Configure Systemd Service

Creates systemd unit file:

```
/etc/systemd/system/kubelet.service
```

With configuration for:

- Startup command with arguments
- Configuration file path
- Environment variables
- Automatic restart on failure
- Dependencies and ordering
