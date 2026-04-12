# Task: Etcd Installation

## Purpose

Downloads, installs, and configures etcd - the distributed key-value store that holds all Kubernetes cluster state, configuration, and secrets. This is the most critical component for cluster persistence.

## Installation Steps

### 1. Load Variables

Loads etcd-specific configuration variables from:

- `roles/bootstrap-controlplane/vars/etcd.yml` - etcd version, paths, ports

### 2. Create Directories

Creates required directories:

- `/etc/etcd` - Configuration directory
- `/var/lib/etcd/` - Data directory (default, may vary)
- `/etc/kubernetes/pki/` - Certificate storage
- Temporary directory for downloads

### 3. Download Etcd

- Downloads official etcd release from GitHub releases
- Uses version specified in configuration
- Downloads architecture-specific binary (amd64, arm64, etc.)
- Stored as compressed tar.gz archive

### 4. Extract Archive

- Uncompresses the downloaded archive
- Extracts binaries and documentation
- Files placed in temporary directory for verification

### 5. Move Binaries

- Copies etcd binary to final location (typically `/usr/local/bin/etcd`)
- Sets executable permissions (0755)
- Makes binary available system-wide

### 6. Configure Service

- Creates systemd service unit file
- Configures etcd to start automatically on boot
- Sets up proper service dependencies
- Configures logging and output handling

## Data Persistence

Etcd data directory:

- Contains database files and transaction logs
- Persists across cluster restarts
- Backed up separately for disaster recovery
- Must never be lost or corrupted

## Certificates and Security

Etcd is configured with:

- Client certificate for authentication
- Server certificate for TLS encryption
- CA certificate for verification
- Private key for secure communication

All communication to etcd is encrypted.

## Starting the Service

After configuration:

- Systemd starts the etcd service
- Service runs as the specified user (typically root)
- Listens on configured port (typically 2379)
- Readiness can be verified with etcd health checks
