# Task: Deploy CoreDNS

## Purpose

Deploys CoreDNS - the Kubernetes DNS server that provides service discovery and DNS resolution for all cluster components and applications.

## Deployment Process

### 1. Copy CoreDNS Manifest

The task templates the CoreDNS manifest:

```
Template: coredns.yml.j2
Destination: /kube_builder/tmp/coredns.yml
```

The template renders with:

- Cluster DNS IP (typically 10.0.0.10)
- Cluster domain (typically cluster.local)
- Custom DNS configuration if specified

### 2. Apply CoreDNS Deployment

Uses kubectl to create the Deployment:

```bash
kubectl create -f /kube_builder/tmp/coredns.yml \
  --kubeconfig {admin.kubeconfig}
```

Delegation to master ensures:

- Uses admin credentials
- Has proper cluster access
- Creates resources in correct namespace

The `ignore_errors: yes` allows graceful skipping if CoreDNS already exists.

## CoreDNS Components

### CoreDNS Pods

Deployed as a Kubernetes Deployment:

- Typically 2 replicas for high availability
- Runs in kube-system namespace
- Implements the DNS server

### CoreDNS Service

Exposed as a Kubernetes Service:

- Service IP: 10.0.0.10 (configurable)
- Service name: kube-dns
- Port: 53 (DNS port)
- Endpoints: CoreDNS Pod IPs

### ConfigMap

CoreDNS configuration:

- Plugin specification
- Zone definitions
- Custom DNS records
- Forwarding rules
