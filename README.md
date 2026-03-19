# Kubernetes “The Hard Way” Automation with Ansible + CRDs

## 📌 Overview

This project aims to **automate the deployment of a Kubernetes cluster built “The Hard Way”** using **Ansible**, and trigger infrastructure workflows dynamically using **Kubernetes Custom Resource Definitions (CRDs)**.

Instead of relying on tools like `kubeadm`, this project focuses on:
- Deep control over Kubernetes components  
- Full transparency of cluster setup  
- Infrastructure-as-Code principles  
- Event-driven automation via Kubernetes APIs  

The end goal is to create a system where:

> You define a custom Kubernetes resource → it triggers automation → nodes are provisioned and configured automatically.

---

## 🎯 Objectives

- Automate manual Kubernetes setup steps using Ansible  
- Build a reproducible and customizable cluster provisioning system  
- Gain production-level understanding of Kubernetes internals  

---

## 🧠 Tech Stack

- Kubernetes (manual setup - “The Hard Way”)  
- Ansible  
- YAML / Bash  
- Custom Resource Definitions (CRDs)  

---

## ⚙️ How It Works (High Level)

1. A custom Kubernetes resource is created (CRD instance)
2. A controller (planned) watches for this resource
3. The controller triggers Ansible playbooks
4. Playbooks provision and configure nodes step-by-step
5. Nodes join the cluster with full manual configuration

---

## 🗺️ Project Phases

### 🔹 Phase 1 — Control Plane Automation
Automate the setup of the Kubernetes **control plane node(s)**:
- Install and configure:
  - API Server  
  - Scheduler  
  - Controller Manager  
  - etcd  
- Generate and distribute TLS certificates  
- Configure systemd services  
- Validate cluster health  

---

### 🔹 Phase 2 — Worker Node Automation
Automate provisioning of **worker nodes**:
- Install:
  - kubelet  
  - kube-proxy  
- Configure networking  
- Handle TLS bootstrapping / certificates  
- Join nodes to the cluster  
- Validate node readiness  

---

### 🔹 Phase 3 — Customization & Extensibility
Introduce flexibility through **custom variables and configs**:
- Parameterized cluster setup
- Extend CRD schema for dynamic configuration  
- Improve reusability of playbooks  

---

## 🔮 Future Enhancements

- Add support for scaling nodes dynamically  
- Integrate with cloud providers  

---

## ⚠️ Disclaimer

This project is primarily for:
- Learning Kubernetes internals  
- Demonstrating advanced automation skills  

It is **not intended for production use** without significant hardening.

---
