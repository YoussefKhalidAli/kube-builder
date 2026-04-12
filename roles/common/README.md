# Common Role

## Overview

The common role establishes the foundational environment for all Kubernetes nodes (both master and worker). It performs essential setup tasks that are required before any Kubernetes components can be installed.

## Key Responsibilities

- Creates required directories with proper ownership and permissions
- Installs system packages needed for Kubernetes components
- Loads configuration variables from other roles
- Prepares the filesystem structure for certificates, kubeconfigs, and associated files

## Directory Structure Created

The role creates the following directories:

- `/kube_builder/tmp` - Temporary directory for storing downloads and intermediate files
- `/etc/kubernetes/pki` - Directory for storing certificates and keys
- `/etc/kubernetes` - Main Kubernetes configuration directory

## Packages Installed

- `openssl` - For certificate generation and validation
- `curl` - For downloading binaries and API requests
- `apt-transport-https` - Required for secure apt repository access
- `ca-certificates` - For validating SSL/TLS connections
