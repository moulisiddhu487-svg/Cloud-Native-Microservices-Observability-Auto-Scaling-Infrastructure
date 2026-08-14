<div align="center">

# ⚡ Resilient Cloud-Native Microservices & Self-Healing Platform

### *Production-Grade K3s Kubernetes Platform on AWS EC2 with Automated CI/CD, Dynamic HPA & Full Observability*

[![Kubernetes](https://img.shields.io/badge/Kubernetes-K3s-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)](https://k3s.io/)
[![AWS EC2](https://img.shields.io/badge/AWS-EC2%20(m7i--flex.large)-FF9900?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/ec2/)
[![Jenkins](https://img.shields.io/badge/CI%2FCD-Jenkins%20LTS-D24939?style=for-the-badge&logo=jenkins&logoColor=white)](https://www.jenkins.io/)
[![Grafana](https://img.shields.io/badge/Observability-Grafana%20v10-F46800?style=for-the-badge&logo=grafana&logoColor=white)](https://grafana.com/)
[![Microservices](https://img.shields.io/badge/Microservices-11--Tier%20Google%20Boutique-4285F4?style=for-the-badge&logo=google-cloud&logoColor=white)](https://github.com/GoogleCloudPlatform/microservices-demo)
[![OS](https://img.shields.io/badge/OS-Ubuntu%2024.04%20LTS-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)](https://ubuntu.com/)

</div>

<hr style="background-color: #FF0000; height: 3px; border: none; border-radius: 2px; margin: 25px 0;" />

## 📌 Executive Summary

This repository hosts the production-ready infrastructure manifests, automated provisioning scripts, and CI/CD pipelines for an **enterprise cloud-native e-commerce ecosystem**. 

Built on lightweight Kubernetes (**K3s**) hosted on **AWS EC2**, the platform automates the deployment of **Google Cloud's 11-tier polyglot microservices**, implements automated **Horizontal Pod Autoscaling (HPA)** based on real-time CPU telemetry, orchestrates **Jenkins CI/CD automation**, and delivers infrastructure-wide **Grafana observability**.

<hr style="background-color: #FF0000; height: 3px; border: none; border-radius: 2px; margin: 25px 0;" />

## 🛠️ Tech Stack & Engineering Tooling

<div align="center">

### ☁️ Cloud & Infrastructure as Code
[![AWS](https://img.shields.io/badge/AWS-FF9900?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![Azure](https://img.shields.io/badge/AZURE-0089D6?style=for-the-badge&logo=microsoft-azure&logoColor=white)](https://azure.microsoft.com/)
[![Terraform](https://img.shields.io/badge/TERRAFORM-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Ansible](https://img.shields.io/badge/ANSIBLE-EE0000?style=for-the-badge&logo=ansible&logoColor=white)](https://www.ansible.com/)
[![Linux](https://img.shields.io/badge/LINUX-FCC624?style=for-the-badge&logo=linux&logoColor=black)](https://www.kernel.org/)
[![Bash](https://img.shields.io/badge/BASH-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)

### 🐳 Containers & Orchestration
[![Docker](https://img.shields.io/badge/DOCKER-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Kubernetes](https://img.shields.io/badge/KUBERNETES-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)](https://kubernetes.io/)
[![K3s](https://img.shields.io/badge/K3S-FFC61C?style=for-the-badge&logo=rancher&logoColor=black)](https://k3s.io/)
[![Helm](https://img.shields.io/badge/HELM-0F1689?style=for-the-badge&logo=helm&logoColor=white)](https://helm.sh/)

### ⚙️ CI/CD & Observability
[![GitHub Actions](https://img.shields.io/badge/GITHUB%20ACTIONS-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)](https://github.com/features/actions)
[![Jenkins](https://img.shields.io/badge/JENKINS-D24939?style=for-the-badge&logo=jenkins&logoColor=white)](https://www.jenkins.io/)
[![Prometheus](https://img.shields.io/badge/PROMETHEUS-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)](https://prometheus.io/)
[![Grafana](https://img.shields.io/badge/GRAFANA-F46800?style=for-the-badge&logo=grafana&logoColor=white)](https://grafana.com/)

### 💻 Polyglot Microservices Runtime
[![Go](https://img.shields.io/badge/GO-00ADD8?style=for-the-badge&logo=go&logoColor=white)](https://go.dev/)
[![C#](https://img.shields.io/badge/C%23-239120?style=for-the-badge&logo=c-sharp&logoColor=white)](https://learn.microsoft.com/dotnet/csharp/)
[![Node.js](https://img.shields.io/badge/NODE.JS-339933?style=for-the-badge&logo=node.js&logoColor=white)](https://nodejs.org/)
[![Python](https://img.shields.io/badge/PYTHON-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![Java](https://img.shields.io/badge/JAVA-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://www.java.com/)
[![Redis](https://img.shields.io/badge/REDIS-DC382D?style=for-the-badge&logo=redis&logoColor=white)](https://redis.io/)

</div>

<hr style="background-color: #FF0000; height: 3px; border: none; border-radius: 2px; margin: 25px 0;" />

## 🏛️ System Architecture

                              AWS EC2 INSTANCE (m7i-flex.large / 8GB RAM)
┌──────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                                                                                          │
│   PUBLIC TRAFFIC INGRESS & NODEPORT ROUTING                                                              │
│   ├── Shoppers Traffic      ──────> NodePort :30088 ───> [ frontend-service (ClusterIP: 80) ]            │
│   ├── CI/CD Pipeline Ops    ──────> NodePort :30808 ───> [ jenkins-service  (ClusterIP: 8080) ]          │
│   └── Telemetry & Metrics   ──────> NodePort :30300 ───> [ grafana-service  (ClusterIP: 3000) ]          │
│                                                                                                          │
│  ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐  │
│  │                                   K3s KUBERNETES RUNTIME & CONTROL PLANE                           │  │
│  │                                                                                                    │  │
│  │   ┌─────────────────────────────────────────────────────────────────────────────────────────────┐  │  │
│  │   │  Namespace: boutique (11 Polyglot Microservices)                                            │  │  │
│  │   │                                                                                             │  │  │
│  │   │  [ Frontend Pod ] ◄── (HPA Dynamic Auto-Scaler: 1 to 3 Replicas @ 80% CPU Target)           │  │  │
│  │   │        │                                                                                    │  │  │
│  │   │        ├──► [ Cart Service ] ────────► [ Redis In-Memory Cart Store ]                       │  │  │
│  │   │        ├──► [ Product Catalog ]        ├──► [ Recommendation Service ]                      │  │  │
│  │   │        ├──► [ Currency Service ]       ├──► [ Shipping Service ]                            │  │  │
│  │   │        ├──► [ Payment Service ]        ├──► [ Email Service ]                               │  │  │
│  │   │        └──► [ Checkout Service ]       └──► [ Ad Service ]                                  │  │  │
│  │   │                                                                                             │  │  │
│  │   │  [ loadgenerator (Locust Engine) ] ── (Simulates Concurrent Customer Traffic Load)         │  │  │
│  │   └─────────────────────────────────────────────────────────────────────────────────────────────┘  │  │
│  │                                                                                                    │  │
│  │   ┌───────────────────────────────────┐        ┌────────────────────────────────────────────────┐  │  │
│  │   │  Namespace: jenkins               │        │  Namespace: monitoring                         │  │  │
│  │   │  • Jenkins CI/CD Controller Pod   │        │  • Grafana Metrics Dashboard UI                │  │  │
│  │   │  • Declarative Pipeline Execution │        │  • Real-Time Cluster Telemetry Engine          │  │  │
│  │   └───────────────────────────────────┘        └────────────────────────────────────────────────┘  │  │
│  │                                                                                                    │  │
│  │   ┌─────────────────────────────────────────────────────────────────────────────────────────────┐  │  │
│  │   │  SRE & Cluster Resilience Engine                                                            │  │  │
│  │   │  • Self-Healing Reconciliation: Pod crash recovery in < 2 seconds                           │  │  │
│  │   │  • Metrics Server & Autoscaling v2: Elastic scaling based on CPU consumption                │  │  │
│  │   └─────────────────────────────────────────────────────────────────────────────────────────────┘  │  │
│  └────────────────────────────────────────────────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────────────────────────────────────────────┘


<hr style="background-color: #FF0000; height: 3px; border: none; border-radius: 2px; margin: 25px 0;" />

## 🌐 Network & Ingress Port Matrix

| Application / Console | Namespace | Target Port | NodePort | Access Endpoint URL | Protocol / Status |
| :--- | :---: | :---: | :---: | :---: | :---: |
| 🛍️ **Boutique Storefront** | `boutique` | `8080` | **`30088`** | `http://<EC2-PUBLIC-IP>:30088` | `HTTP / Active` |
| 📊 **Grafana Dashboard** | `monitoring` | `3000` | **`30300`** | `http://<EC2-PUBLIC-IP>:30300` | `HTTP / Active` |
| ⚙️ **Jenkins Automation** | `jenkins` | `8080` | **`30808`** | `http://<EC2-PUBLIC-IP>:30808` | `HTTP / Active` |

<hr style="background-color: #FF0000; height: 3px; border: none; border-radius: 2px; margin: 25px 0;" />

## 🔥 Core Capabilities & Features

### 1. 🚀 Zero-Touch Automated Bootstrapping (`deploy-all.sh`)
* Provisions K3s Kubernetes, creates isolated namespaces (`boutique`, `monitoring`, `jenkins`), downloads Google Cloud Online Boutique microservices, applies NodePort patches, applies HPA configuration, and launches Jenkins and Grafana automatically in **under 3 minutes**.

### 2. 🛡️ Self-Healing Pod Architecture
* Continuous Kubernetes controller reconciliation loops. If any microservice pod experiences a crash, fatal panic, or manual deletion, Kubernetes reconciles cluster state and schedules a healthy pod replica in **$< 2$ seconds** without dropping application availability.

### 3. 📈 Dynamic Horizontal Pod Autoscaling (`hpa.yaml`)
* Configured using `autoscaling/v2` API:
  * **Target Metric:** 80% CPU Utilization
  * **Scaling Boundaries:** `Min: 1 Pod` | `Max: 3 Pods`
  * Dynamically provisions extra pods during traffic surges and scales back to 1 pod during idle periods to minimize cloud costs.

### 4. 🔄 Declarative CI/CD Automation (`Jenkinsfile` & `jenkins.yaml`)
* Jenkins LTS containerized inside Kubernetes, mapping pipeline tasks as code to validate deployment health, test endpoint accessibility, and manage microservice lifecycles.

### 5. 📊 Real-Time Observability (`monitoring.yaml`)
* Dedicated Grafana deployment in the `monitoring` namespace to monitor cluster infrastructure, resource consumption, and microservice behavior.

<hr style="background-color: #FF0000; height: 3px; border: none; border-radius: 2px; margin: 25px 0;" />

## ⚡ Quickstart & 1-Click Rebuild Guide

### Prerequisites
* 1x AWS EC2 Instance (**Ubuntu 24.04 LTS**, recommended type: `m7i-flex.large` or `t3.large` with 8GB RAM).
* AWS Security Group with inbound ports `22`, `30088`, `30300`, and `30808` open.

### Step 1: Clone and Run Deployment Script
```bash
git clone [https://github.com/moulisiddhu487-svg/k3s-self-healing-cloud-platform.git](https://github.com/moulisiddhu487-svg/k3s-self-healing-cloud-platform.git) ~/my-project
cd ~/my-project
chmod +x deploy-all.sh
sudo ./deploy-all.sh
Step 2: Verify Running Cluster
Bash
# Check all pods across all namespaces
kubectl get pods -A

# Check Horizontal Pod Autoscaler status
kubectl get hpa -n boutique
🧪 Chaos Engineering & Resilience Testing
🔬 Test 1: Simulating Pod Crash & Self-Healing
Verify zero-downtime container self-healing:

Bash
# Delete a running frontend pod
kubectl delete pod -l app=frontend -n boutique

# Observe instant recreation in real-time
kubectl get pods -n boutique -l app=frontend -w
🔬 Test 2: Simulating Traffic Spike & HPA Auto-Scaling
Drive synthetic traffic to trigger Horizontal Pod Autoscaling:

Bash
# Spin up the Locust traffic load generator
kubectl scale deployment loadgenerator -n boutique --replicas=1

# Watch HPA detect CPU spike and scale replicas from 1 to 3
kubectl get hpa -n boutique -w

# Stop traffic simulation and observe automatic scale-down
kubectl scale deployment loadgenerator -n boutique --replicas=0
📁 Repository Blueprint
Plaintext
├── deploy-all.sh          # Master one-click deployment & bootstrap script
├── boutique-patch.yaml    # NodePort service manifest exposing Storefront on :30088
├── hpa.yaml               # Horizontal Pod Autoscaler manifest (80% CPU target, 1-3 replicas)
├── jenkins.yaml           # Deployment & NodePort manifest for Jenkins Controller (:30808)
├── monitoring.yaml        # Deployment & NodePort manifest for Grafana (:30300)
├── Jenkinsfile            # Declarative Jenkins CI/CD Pipeline definition
└── README.md              # Production architectural documentation

---

#### 4. Save and Publish
1. Click the green **Commit changes...** button at the top right of GitHub.
2. Click **Commit changes** again on the confirmation prompt.

When you return to your main repository page, GitHub will render the badges, diagrams, red dividers, and documentation right on your project front page.
