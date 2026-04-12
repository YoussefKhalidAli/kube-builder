# Networking Role

## Overview

The networking role deploys the cluster's Container Network Interface (CNI) implementation and DNS infrastructure. It installs the network overlay that enables pod-to-pod communication across nodes and deploys CoreDNS for service discovery.

## Key Responsibilities

- Deploys CNI plugins (Weave, Calico, or Cilium) based on configuration
- Installs networking components that enable pod-to-pod communication
- Deploys CoreDNS for Kubernetes DNS and service discovery
- Configures overlay network for pod communication across cluster
- Enables network policies if using Calico or Cilium
- Sets up cluster internal DNS resolution

## Network Plugins Supported

### Weave

- Simple overlay network using VXLAN
- Easy to deploy and configure
- Good for small to medium clusters
- Less feature-rich than Calico/Cilium

### Calico

- Flexible networking with IP-in-IP or VXLAN encapsulation
- Advanced network policies for security
- BGP integration for production deployments
- Good scalability and performance

### Cilium

- Newest and most advanced option
- eBPF-based implementation with enhanced observability
- Advanced security and network policies
- Deep visibility into network traffic
- Container and pod awareness

## Networking Architecture

Before networking role:

- Pods on same node can communicate
- Pods on different nodes cannot communicate
- No DNS-based service discovery
- Network policies not enforced

After networking role:

- All pods can communicate cluster-wide
- Services accessible by DNS name
- Network policies enforced (if applicable)
- Load balancing for services
- Multi-node pod deployment possible

## CoreDNS

CoreDNS provides:

- DNS server for service discovery
- Service name resolution to ClusterIP
- Pod name resolution
- Custom DNS records
- Cluster-wide DNS queries

CoreDNS runs in the kube-system namespace and is exposed as a service.

## CNI Plugin Deployment

Each plugin is deployed as:

- Kubernetes DaemonSet or Deployment
- Runs system pods for networking
- Manages pod networking configuration
- Installs network drivers on each node

## Pod IP Allocation

After networking is deployed:

- Each pod gets unique IP from configured CIDR range
- IPs are routable across cluster
- CNI plugins manage IP allocation
- Pod IPs don't persist across pod restart

## Task Documentation

For detailed information about networking setup, see:

- [Deploy Weave Network Plugin](docs/deploy_weave_network_plugin.md)
- [Deploy Calico Network Plugin](docs/deploy_calico_network_plugin.md)
- [Deploy Cilium Network Plugin](docs/deploy_cilium_network_plugin.md)
- [Deploy CoreDNS](docs/deploy_coredns.md)
