# Task: Kube-Controller-Manager Installation

## Purpose

Downloads, installs, and configures the kube-controller-manager - the component that runs the control loops that reconcile the desired state with the actual state of the cluster.

## Installation Steps

### 1. Load Variables

Loads variables from:

- `roles/bootstrap-controlplane/vars/kube-controller-manager.yml` - Component configuration
- `roles/kubeconfig/vars/main.yml` - Kubeconfig location

### 2. Create Directories

Creates required directories:

- Temporary directory for binary download
- Installation directory (typically `/usr/local/bin/`)
- Certificate directory

### 3. Download Binary

- Fetches kube-controller-manager from Kubernetes releases
- Architecture-specific version
- Version matches cluster version from k8s_version

### 4. Install Binary

- Copies to `/usr/local/bin/kube-controller-manager`
- Sets executable permissions (0755)
- Available to systemd

### 5. Deploy Certificates and Keys

Copies critical certificates to `/etc/kubernetes/pki/`:

- `kube-controller-manager.crt/key` - Component authentication
- `ca.crt/key` - Cluster CA
- `etcd.crt/key` - Secure etcd communication
- `admin.crt/key` - Additional permissions
- `service-account.crt/key` - Service account token signing
- `apiserver-kubelet-client.crt/key` - For kubelet communication

These certificates allow the controller manager to:

- Authenticate to the API server
- Communicate securely with etcd
- Sign service account tokens for pods
- Authorize actions against cluster resources

### 6. Create Systemd Service

Creates and registers service unit file with:

- Startup command and arguments
- Required environment variables
- Dependencies and ordering
- Automatic restart on failure
