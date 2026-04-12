# TLS-Bootstrap-Workers Role

## Overview

The tls-bootstrap-workers role configures the kubeconfig and kubelet configuration files on worker nodes to enable the TLS bootstrap process. This allows workers to authenticate using a temporary bootstrap token and request certificates from the cluster.

## Key Responsibilities

- Renders bootstrap kubeconfig file for initial worker authentication
- Configures kubelet with bootstrap-specific settings
- Sets up the bootstrap kubeconfig that works without pre-existing certificates
- Enables workers to request and receive certificates automatically
- Transitions workers from bootstrap credentials to signed certificates

## Bootstrap vs Standard Kubeconfig

### Bootstrap Kubeconfig

- Uses temporary bootstrap token (not certificate-based)
- Allows initial authentication without existing certificate
- Limited permissions (can only make CSR requests)
- Temporary - replaced by real kubeconfig after bootstrap completes

### Standard Kubeconfig

- Uses worker certificate and private key
- Full authentication after bootstrap
- Can be used for all worker operations
- Persists from bootstrap onwards

## Configuration Files Generated

### 1. Bootstrap Kubeconfig

**Location**: `/var/lib/kubelet/bootstrap-kubeconfig`

Contains:

- Bootstrap ServiceAccount authentication
- Bootstrap token from prepare-tls-bootstrap-workers
- API server endpoint (master IP)
- CA certificate for server verification

Kubelet uses this to:

1. Connect to API server with bootstrap credentials
2. Request a certificate (CSR)
3. Get certificate signed by control plane
4. Switch to using the signed certificate

### 2. Kubelet Configuration

**Location**: `/var/lib/kubelet/kubelet-config.yaml`

Contains bootstrap-specific settings:

- Bootstrap kubeconfig path
- Server certificate request parameters
- Certificate rotation settings
- Auto-approval configuration

## Bootstrap Process Flow

On a worker node during bootstrap:

1. **Load bootstrap kubeconfig** - Kubelet reads bootstrap-kubeconfig
2. **Authenticate with token** - Connects to API server using bootstrap token
3. **Generate CSR** - Creates certificate signing request
4. **Submit request** - Sends CSR to control plane
5. **Await approval** - Waits for CSR to be approved by control plane
6. **Receive certificate** - Gets signed certificate from control plane
7. **Switch kubeconfig** - Kubelet begins using real kubeconfig with certificate
8. **Full operation** - Kubelet is now fully authenticated

This entire process happens automatically without manual intervention.

## Master Delegation

All tasks run on master via delegation:

```
delegate_to: "{{ master_ip }}"
```

This ensures:

- Bootstrap configurations are created with accurate master IP
- Files are rendered with control plane information
- Consistent bootstrap credentials across all workers

## Bootstrap Token Handling

The bootstrap token:

- Is time-limited (typically expires after 24 hours)
- Is shared with multiple workers
- Used only during initial bootstrap
- Discarded once certificates are received
- Cannot be used again after bootstrap completes

## Security Model

Bootstrap security is maintained through:

- Limited bootstrap token permissions (only CSR creation)
- Time-limited token expiration
- CSR auto-approval only for bootstrappers group
- Certificate-based authentication after bootstrap
- No continuous use of bootstrap tokens

## Transition Phase

After bootstrap completes:

- Kubelet switches from bootstrap token to certificate
- Real kubeconfig with certificate takes over
- Worker becomes a full cluster member
- Can receive pod assignments
- Integrated into networking and service discovery
