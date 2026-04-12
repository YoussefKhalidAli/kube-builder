# Task: Kube-Scheduler Installation

## Purpose

Downloads, installs, and configures the kube-scheduler - the component responsible for assigning pods to nodes based on requirements, constraints, and cluster state.

## Installation Steps

### 1. Load Variables

Loads configuration from:

- `roles/bootstrap-controlplane/vars/kube-scheduler.yml` - Scheduler settings
- `roles/kubeconfig/vars/main.yml` - Kubeconfig paths

### 2. Create Directories

Creates required directories:

- Temporary directory for downloads
- Binary installation directory (typically `/usr/local/bin/`)
- Certificate storage directory

### 3. Download Binary

- Fetches kube-scheduler from Kubernetes official releases
- Architecture-specific binary (amd64, arm64, etc.)
- Version matches cluster's k8s_version

### 4. Install Binary

- Copies scheduler to `/usr/local/bin/kube-scheduler`
- Sets executable permissions (0755)
- Makes available for systemd

### 5. Deploy Certificates

Copies necessary certificates to `/etc/kubernetes/pki/`:

- `kube-scheduler.crt/key` - Scheduler identity and authentication
- `ca.crt/key` - Cluster CA
- `etcd.crt/key` - For etcd communication
- `admin.crt/key` - Additional permissions
- `service-account.crt/key` - For service account operations

These enable secure API server communication.

### 6. Create Systemd Service

Creates the scheduler systemd unit with:

- Startup command and necessary arguments
- Environment configuration
- Service dependencies
- Automatic restart on failure
