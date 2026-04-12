# Task: Worker Kubeconfigs Generation

## Purpose

Generates kubeconfig files specifically for worker nodes. These files are created on the master node but are later distributed to worker nodes via the copy-files role.

These define the format and content of kubeconfigs needed for worker nodes.

## Delegation to Master

All operations are delegated to the master node:

```
delegate_to: "{{ master_ip }}"
```

This ensures:

- Certificates generated on the master are used
- All kubeconfigs are created with the same CA and credentials
- Easier file distribution to workers afterward

## Worker Kubeconfig Generation

### Generation Process

- **Source Template**: Uses `kubeconfig.j2` template (same template as master kubeconfigs)
- **Destination**: `/etc/kubernetes/{worker_name}.kubeconfig`
- **Ownership**: root:root
- **Permissions**: 0600 (read/write for root only)

The template rendering fills in:

- Cluster API server endpoint
- Worker's client certificate
- Worker's client private key
- Cluster CA certificate

### Worker Identity

Each kubeconfig identifies the worker using:

- **Common Name**: `system:node:{hostname}`
- **Organization**: `system:nodes`

This identity is critical for Kubernetes authorization - the API server uses the CN to determine what permissions the worker (kubelet) has.

## File Location Before Distribution

After generation, worker kubeconfigs reside on the master at:

```
/etc/kubernetes/{worker-hostname}.kubeconfig
```

## Worker Kubelet Usage

Once on the worker node, the kubelet daemon:

1. Reads its kubeconfig file
2. Extracts the API server endpoint
3. Uses the embedded certificate for authentication
4. Connects to the API server to report node status
5. Receives pod assignment requests from the scheduler

## Bootstrap vs Standard Kubeconfig

The role may generate both:

- **Standard kubeconfig**: For normal kubelet operation
- **Bootstrap kubeconfig**: For the initial TLS bootstrap process that occurs when a worker first joins the cluster

Bootstrap kubeconfigs have temporary certificates that are automatically rotated once the worker joins the cluster successfully.
