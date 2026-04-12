# Cleanup Role

## Overview

The cleanup role performs post-installation housekeeping by removing temporary files and build artifacts that were created during the cluster setup process. This keeps the system clean and reduces disk usage.

## Key Responsibilities

- Removes temporary download files
- Cleans up rendered manifest files
- Deletes intermediate build artifacts
- Keeps only permanent cluster configuration
- Ensures no leftover files occupy disk space

## What Gets Cleaned

### Temporary Directory

The role cleans `/kube_builder/tmp/` which contains:

- Downloaded Kubernetes binaries
- Extracted archive files
- Rendered bootstrap manifests
- Certificate CSR files
- Intermediate configuration files
- Temporary build artifacts
