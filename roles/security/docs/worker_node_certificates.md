# Task: Worker Node Certificates

## Purpose

Generates unique certificates for each worker/kubelet node in the cluster. These certificates are used by the kubelet daemon to authenticate with the Kubernetes API server and for node-to-node communication.

## Worker-Specific Configuration

Unlike control plane components, worker certificates have specific requirements:

### Common Name (CN)

- Format: `system:node:{hostname}`
- Example: `system:node:worker-1`
- The `system:node:` prefix identifies this as a node certificate
- Kubernetes authorization uses this CN for RBAC decisions

### Organization (O)

- Set to `system:nodes`
- Groups worker certificates together
- Used by Kubernetes for node-level authorization

### Subject Alternative Names (SANs)

- **DNS**: Worker hostname for DNS-based lookup
- **IP**: Worker node's private IP address

## Certificate Generation Steps

This task is executed on each worker node but delegates to the master for certificate signing:

### 1. Generate Worker Private Keys

- Creates a 2048-bit RSA private key per worker
- Stored on master at `{cert_dir}/{hostname}.key`
- The `delegate_to: master_ip` ensures signing happens on master

### 2. Generate Worker CSRs

- Creates a Certificate Signing Request
- Includes the node-specific CN and organization
- Adds hostname and IP as Subject Alternative Names
- Signed on the master node

### 3. Sign with Cluster CA

- Master CA signs the worker certificate
- Certificate is signed by the cluster's CA
- Uses proper expiration dates from configuration
- Provider: ownca (own certificate authority)

## Certificate Distribution

After signing on the master:

- The `copy-files` role transfers the certificates to worker nodes
- Each worker receives:
  - `ca.crt` - Cluster CA certificate (for verification)
  - `{hostname}.crt` - Worker's own certificate
  - `{hostname}.key` - Worker's private key (confidential)

## Kubelet Usage

The kubelet daemon on each worker uses its certificate to:

- Authenticate to the Kubernetes API server
- Encrypt communication with the API server
- Identify itself to the master using the `system:node:` CN
- Receive authorization decisions based on the node identity

## Bootstrap Certificates

Additionally, bootstrap certificates are created for:

- Initial worker authentication while joining the cluster
- TLS bootstrap process for automatic certificate rotation
- Temporary credentials that are later replaced by kubelet-managed certificates

## Security Model

- Each worker has a unique certificate
- Certificate CN includes the node hostname for identification
- Organization tag identifies the certificate role
- Master signs all worker certificates for consistency
- Certificates are properly scoped to prevent misuse
