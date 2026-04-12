# Task: Kube-Proxy Installation

## Purpose

Downloads, installs, and configures kube-proxy - the network proxy that runs on every node to implement Kubernetes service networking, load balancing, and network policies.

## Installation Steps

### 1. Load Variables

Loads configuration from:

- `roles/bootstrap-controlplane/vars/kube-proxy.yml` - Proxy settings
- `roles/kubeconfig/vars/main.yml` - Kubeconfig locations

### 2. Create Directories

Creates required directories:

- Temporary directory for binary downloads
- Binary installation directory (typically `/usr/local/bin/`)
- Certificate directory
- Kube-proxy configuration directory

### 3. Download Binary

- Fetches kube-proxy from Kubernetes official releases
- Architecture-specific version (amd64, arm64, arm, etc.)
- Version matches cluster's k8s_version

### 4. Install Binary

- Copies to `/usr/local/bin/kube-proxy`
- Sets executable permissions (0755)
- Makes available to systemd

### 5. Create Configuration File

Generates configuration at:

```
/var/lib/kube-proxy/kube-proxy-config.yaml
```

Configuration specifies:

- **Mode**: How to implement load balancing
- **Cluster CIDR**: Pod network range
- **Service CIDR**: Service IP range
- **Node name**: Identification on this node

### 6. Create Systemd Service

Creates systemd unit file:

```
/etc/systemd/system/kube-proxy.service
```

With configuration for:

- Startup command with arguments
- Configuration file path
- Environment variables
- Automatic restart on failure
