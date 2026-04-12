# Kubeconfig Role

## Overview

The kubeconfig role generates kubeconfig files for all Kubernetes components and users. These configuration files contain the necessary credentials and endpoint information for clients to authenticate with and connect to the Kubernetes API server.

## What is a Kubeconfig?

A kubeconfig file is a YAML configuration file that contains:

- **Cluster information**: API server endpoint and CA certificate
- **User credentials**: Client certificate and key for authentication
- **Context**: Association between a user and cluster
- **Current context**: Which cluster/user combination to use by default

Kubeconfig files enable:

- **Authentication**: Clients prove their identity using certificates
- **Authorization**: The API server checks what actions the client is allowed to perform
- **Encryption**: All communication between client and API server is encrypted

## Components with Kubeconfigs

The role generates kubeconfigs for:

- **kubelet** - Worker node daemon authentication
- **kube-proxy** - Network proxy component
- **kube-controller-manager** - Control loop manager
- **kube-scheduler** - Pod scheduling component
- **admin** - Administrator user for cluster management
- **bootstrap** (workers) - Temporary credentials for node bootstrap process

## File Organization

All kubeconfig files are stored in `/etc/kubernetes/`:

- Master node kubeconfigs are generated and stored on the master
- Worker kubeconfigs are generated on the master but distributed to worker nodes
- Each kubeconfig is protected with restrictive permissions (0600)

## Security Features

- Each certificate is unique to its user/component
- Private keys are embedded in the kubeconfig file
- File permissions restrict access to root only
- Certificates are signed by the cluster's CA
- API server endpoints are configured for both internal and external access

## Task Documentation

For detailed information about worker kubeconfigs, see:

- [Worker Kubeconfigs Generation](docs/worker_kubeconfigs_generation.md)
