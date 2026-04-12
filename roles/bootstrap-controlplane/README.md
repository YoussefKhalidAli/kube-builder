# Bootstrap-Controlplane Role

## Overview

The bootstrap-controlplane role is the centerpiece of cluster control plane setup. It downloads, configures, and starts all critical Kubernetes control plane components on the master node. This role handles the installation and configuration of etcd, kube-apiserver, kube-controller-manager, kube-scheduler, kubelet, and kube-proxy.

## Key Responsibilities

- Downloads official Kubernetes component binaries from GitHub releases
- Sets up systemd services for all control plane components
- Configures each component with appropriate certificates and credentials
- Starts and enables all services for cluster operation
- Manages component dependencies and service ordering

## Control Plane Components

### Master-Only Components

1. **etcd** - Distributed key-value store holding cluster state
2. **kube-apiserver** - RESTful API server for cluster management
3. **kube-controller-manager** - Control loops for cluster state
4. **kube-scheduler** - Pod scheduling and placement engine

### All Nodes (Control Plane + Workers)

1. **kubelet** - Node agent managing containers
2. **kube-proxy** - Network proxy for service traffic

## Conditional Installation

Each component's installation is conditional:

- Master nodes install: etcd, kube-apiserver, kube-controller-manager, kube-scheduler, kubelet, kube-proxy
- Worker nodes install: kubelet, kube-proxy only

This is controlled by the `components` list variable in the playbook.

## Service Management

Each component is:

- Installed as a systemd service unit
- Configured to auto-start on reboot
- Managed by systemd for restart and recovery
- Monitored through systemd journal logs

## Task Documentation

For detailed information about each component, see:

- [Etcd Installation](docs/etcd_installation.md)
- [Kube-Apiserver Installation](docs/kube_apiserver_installation.md)
- [Kube-Controller-Manager Installation](docs/kube_controller_manager_installation.md)
- [Kube-Scheduler Installation](docs/kube_scheduler_installation.md)
- [Kubelet Installation](docs/kubelet_installation.md)
- [Kube-Proxy Installation](docs/kube_proxy_installation.md)
