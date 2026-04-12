# Prepare-TLS-Bootstrap-Workers Role

## Overview

The prepare-tls-bootstrap-workers role creates the Kubernetes manifests and RBAC policies needed for the TLS bootstrap process. This process allows worker nodes to request and automatically receive certificates from the cluster, enabling secure node joins without pre-distributing certificates.

## Key Responsibilities

- Generates bootstrap tokens that workers use for authentication
- Creates RBAC cluster role bindings for CSR (Certificate Signing Request) creation
- Creates RBAC cluster role bindings for CSR approval (auto-approval)
- Creates RBAC cluster role bindings for CSR renewal
- Renders Kubernetes manifests that will be applied to the control plane
- Enables the automatic certificate bootstrap process for new workers

## Bootstrap Flow

The TLS bootstrap process:

1. Worker authenticates using a bootstrap token (temporary credential)
2. Worker requests a certificate from the control plane via CSR
3. Control plane auto-approves CSRs from authenticated workers
4. Worker receives signed certificate
5. Worker switches to using the signed certificate
6. Worker can now fully authenticate to the cluster

This eliminates the need to pre-generate and distribute certificates to every future worker.

## Bootstrap Components

### Bootstrap Token

- Temporary credential shared with workers
- Used for one-time authentication
- Short-lived for security
- Allows worker to make CSR requests

### RBAC Policies

The role creates cluster role bindings for:

1. **CSR Creation** - Allows authenticated bootstrap users to create CSRs
2. **CSR Auto-Approval** - Allows CSRs to be automatically approved without manual intervention
3. **CSR Renewal** - Allows workers to renew their certificates when expiring

These policies enable the bootstrap self-service process.

## Generated Manifests

Kubernetes manifest files are rendered in `/kube_builder/tmp/`:

- `bootstrap-token.yml` - ServiceAccount and secret for bootstrap token
- `csr-create-clusterrolebinding.yml` - Permission for CSR creation
- `csr-approve-clusterrolebinding.yml` - Auto-approval permission
- `csr-renew-clusterrolebinding.yml` - Certificate renewal permission

These are later applied to the cluster.

## Advantages Over Manual Distribution

Instead of:

- Generating certificates for every worker upfront
- Manually transferring certificates to each worker
- Managing certificate expiration and renewal

Workers can:

- Use a simple bootstrap token
- Request certificates automatically
- Get certificates signed by the cluster
- Maintain certificates without manual intervention

## Timing in Cluster Setup

This role runs:

- After all master components are configured
- Before workers are added to the cluster
- On the master to prepare infrastructure
- After security role (certificates are available)

The manifests generated are applied to the cluster after the master is fully operational.
