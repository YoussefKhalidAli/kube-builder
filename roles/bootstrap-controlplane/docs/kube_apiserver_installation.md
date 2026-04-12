# Task: Kube-Apiserver Installation

## Purpose

Downloads, installs, and configures the Kubernetes API server - the central control point for all cluster operations. Every action in the cluster goes through the API server.

## Installation Steps

### 1. Load Variables

Loads kube-apiserver configuration from:

- `roles/bootstrap-controlplane/vars/kube-apiserver.yml` - Ports, addresses, feature gates

### 2. Create Directories

Creates:

- Temporary download directory
- Binary installation directory (typically `/usr/local/bin/`)
- Certificate directory

### 3. Download Binary

- Fetches kube-apiserver from official Kubernetes releases
- Version matches cluster version
- Architecture-specific binary (amd64, arm64, arm, etc.)

### 4. Install Binary

- Copies binary to `/usr/local/bin/kube-apiserver`
- Sets executable permissions
- Makes available to systemd service

### 5. Deploy Certificates

Copies necessary certificates to `/etc/kubernetes/pki/`:

- `kube-apiserver.crt` / `kube-apiserver.key` - API server identity
- `ca.crt` / `ca.key` - Cluster CA for validating client certificates
- `etcd.crt` / `etcd.key` - For secure etcd communication
- `service-account.crt` / `service-account.key` - For service account tokens
- `apiserver-kubelet-client.crt/key` - For kubelet communication

### 6. Configure Service

Creates systemd service file with:

- Startup command and arguments
- Environment variables
- Restart policies
- Service ordering (runs after etcd)

## Critical Configuration

The API server configuration specifies:

- **Listen address**: Which IP/port to serve on (typically 0.0.0.0:6443)
- **etcd endpoints**: Where to find the datastore
- **Service CIDR**: IP range for Kubernetes services
- **Admission controllers**: Which validation plugins to use
- **Authorization mode**: RBAC (role-based access control)
- **Encryption provider**: For encrypting secrets at rest
- **Feature gates**: Which experimental features to enable

## Network Configuration

The API server:

- Listens on port 6443 (secure HTTPS)
- Uses TLS certificates for encryption
- Requires client certificates for authentication
- Serves internal and external clients

## Service Start

After installation:

- Systemd starts the API server
- Server reads kubeconfigs and certificates
- Connects to etcd to verify data store is ready
- Begins listening for client connections
- Cluster operations can begin
