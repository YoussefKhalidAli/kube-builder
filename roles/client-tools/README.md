# Client-Tools Role

## Overview

The client-tools role automatically downloads and installs the latest Kubernetes client tools, specifically kubectl, on all nodes. It handles version detection, checksum verification, and intelligent installation based on existing state.

## Key Responsibilities

- Determines the latest stable Kubernetes version from official releases
- Checks if kubectl is already installed and if an upgrade is needed
- Downloads kubectl binary with checksum verification
- Installs kubectl to `/usr/local/bin/` making it available system-wide
- Verifies successful installation

## Smart Version Management

The role implements intelligent version handling:

- Uses official Kubernetes stable release API to fetch the latest version
- Checks currently installed kubectl version (if any)
- Only downloads and installs if the version differs from what's needed
- Ensures idempotent behavior - doesn't reinstall if already at correct version

## Security Features

- Downloads official Kubernetes binaries from `dl.k8s.io`
- Verifies binary integrity using SHA256 checksums
- Fails if checksum verification doesn't pass
- Ensures only validated binaries are installed

## Retrieved Artifacts

Once installed, kubectl can be used to:

- Interact with the Kubernetes API server
- Manage cluster resources
- Execute administrative commands
- Deploy applications
