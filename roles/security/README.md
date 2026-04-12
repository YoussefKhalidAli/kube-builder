# Security Role

## Overview

The security role is critical for establishing trust and secure communication within the Kubernetes cluster. It generates all required TLS certificates, private keys, and encryption configurations that enable secure communication between cluster components.

## Key Responsibilities

- Creates the Kubernetes Certificate Authority (CA)
- Generates certificates for all Kubernetes control plane components
- Creates etcd server certificates for the data store
- Generates worker node certificates
- Creates encryption keys for secret data encryption at rest
- Establishes the entire PKI (Public Key Infrastructure) for the cluster

## Certificate Hierarchy

The role establishes a hierarchical trust structure:

```
Kubernetes CA (self-signed root)
├── kube-apiserver certificate
├── etcd server certificate
├── kubelet certificates (per node)
├── kube-proxy certificates
├── kube-controller-manager certificate
├── kube-scheduler certificate
└── Admin user certificates
```

## Key Files Generated

All certificates and keys are stored in `/etc/kubernetes/pki/`:

- `ca.crt` / `ca.key` - Root CA certificate and private key
- `kube-apiserver.crt` / `kube-apiserver.key` - API server credentials
- `etcd.crt` / `etcd.key` - etcd server credentials
- `{hostname}.crt` / `{hostname}.key` - Worker node credentials
- Other component certificates for controller, scheduler, proxy, etc.

## Security Features

- Uses 2048-bit RSA encryption for all keys
- All certificates are properly scoped with Subject Alternative Names (SANs)
- Extended key usage constraints limit certificate purposes
- Critical extensions prevent misuse of certificates
- Encryption key for Kubernetes Secrets is randomly generated and stored securely

## Task Documentation

For detailed information about worker-specific tasks, see:

- [Worker Node Certificates](docs/worker_node_certificates.md)
