# CRI Role

## Overview

The CRI (Container Runtime Interface) role prepares the node environment for running containerized workloads. It installs and configures the container runtime (typically containerd), enables necessary kernel features, and installs essential networking tools.

## Key Responsibilities

- Installs and configures the container runtime (containerd)
- Loads required kernel modules (overlay and br_netfilter)
- Configures kernel networking parameters for pod communication
- Sets up APT repositories for Kubernetes and container runtime packages
- Installs networking tools and utilities (ipvsadm, ipset, cri-tools)
- Configures container runtime for Kubernetes compatibility

## Container Runtime

The role supports multiple container runtimes through configuration:

- **containerd** (primary/recommended) - Lightweight and efficient
- **cri-o** - Alternative CRI implementation

The configuration determines which runtime is installed and configured.

## Kernel Modules

Two critical kernel modules are loaded and persisted:

1. **overlay** - Enables overlay filesystem functionality for container root filesystems
2. **br_netfilter** - Enables netfilter rules on bridge traffic, necessary for pod-to-pod communication

These modules are:

- Loaded immediately
- Persisted in `/etc/modules-load.d/k8s.conf` for automatic loading on reboot

## Networking Configuration

Critical sysctl parameters are configured:

- `net.bridge.bridge-nf-call-iptables = 1` - Enables iptables rules on bridge traffic
- `net.bridge.bridge-nf-call-ip6tables = 1` - Enables iptables rules for IPv6
- `net.ipv4.ip_forward = 1` - Enables IP forwarding required for pod communication

## Packages Installed

- **kmod** - For kernel module management (modprobe)
- **gpg** - For verifying repository keys
- **linux-modules** - Kernel modules package
- **container runtime** (containerd/docker/cri-o) - The actual runtime
- **kubernetes-cni** - Container Networking Interface plugins
- **kubectl** - Kubernetes command-line tool
- **ipvsadm** - IPVS (IP Virtual Server) management tool
- **ipset** - IP set configuration tool
- **cri-tools** - CRI verification and debugging tools

## Repository Setup

The role configures official APT repositories for:

- Kubernetes packages and tools
- Container runtime packages
- All repositories are configured with GPG key verification for security
