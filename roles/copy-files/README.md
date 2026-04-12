# Copy-Files Role

## Overview

The copy-files role transfers critical configuration files and certificates from the master node to worker nodes. This is an essential step in the worker bootstrap process, as workers need access to certificates and kubeconfigs generated on the master to authenticate with the control plane.

## Key Responsibilities

- Reads certificates and configuration files from master's `/etc/kubernetes/pki/`
- Transfers worker-specific kubeconfigs from master
- Transfers worker certificates to their respective nodes
- Reads and distributes container runtime credentials
- Ensures file permissions are properly maintained during transfer

## Files Transferred

### Certificates and Keys

- **ca.crt** - Root CA certificate for verifying API server
- **{hostname}.crt** - Worker-specific client certificate
- **{hostname}.key** - Worker-specific private key (confidential)
- **kube-proxy.crt/key** - Service proxy credentials
- Other component certificates as needed

### Kubeconfigs

- **{hostname}.kubeconfig** - Worker's kubelet kubeconfig for API authentication
- **kube-proxy.kubeconfig** - Kube-proxy authentication configuration
- Bootstrap kubeconfigs for initial worker authentication

## Security Model

The transfer process:

- Reads files from master as base64-encoded content
- Uses `slurp` module to capture file contents in memory
- Transfers via Ansible (works with SSH for security)
- Writes files to worker with secure permissions
- Sets restrictive file permissions (0600 - readable only by root)

## Worker Identity

Each worker receives:

- Unique certificate signed by cluster CA
- Identity based on its hostname
- Kubeconfig containing its certificate and key
- These prove the worker's identity to the API server

## Timing

This role runs:

- After certificates are generated on master
- After worker certificates are created in security role
- Before workers attempt to join the cluster
- Before tls-bootstrap-workers role runs
