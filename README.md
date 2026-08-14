<div align="center">

# ⚡ K3s Self-Healing Cloud Platform

### Production-style Kubernetes & SRE Infrastructure on AWS EC2

**Self-healing workloads • HPA autoscaling • Jenkins CI/CD • Grafana observability • 3-minute EC2 rebuild**

<br>

[![AWS](https://img.shields.io/badge/AWS-EC2-FF9900?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/ec2/)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-K3s-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)](https://kubernetes.io/)
[![K3s](https://img.shields.io/badge/K3s-Lightweight_Kubernetes-FFC61C?style=for-the-badge&logo=k3s&logoColor=111827)](https://k3s.io/)
[![Docker](https://img.shields.io/badge/Docker-Containers-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Jenkins](https://img.shields.io/badge/Jenkins-CI%2FCD-D24939?style=for-the-badge&logo=jenkins&logoColor=white)](https://www.jenkins.io/)
[![Grafana](https://img.shields.io/badge/Grafana-Observability-F46800?style=for-the-badge&logo=grafana&logoColor=white)](https://grafana.com/)
[![Linux](https://img.shields.io/badge/Linux-Ubuntu-FCC624?style=for-the-badge&logo=linux&logoColor=111827)](https://ubuntu.com/)
[![Bash](https://img.shields.io/badge/Bash-Automation-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)

</div>

<p align="center"><img src="assets/red-line.svg" width="100%" alt=""></p>

## 🎯 Project Overview

I built a lightweight Kubernetes/SRE platform on **AWS EC2** using **K3s**, running Google's **Online Boutique** microservices.

The project focuses on practical platform engineering: **failure recovery, workload autoscaling, CI/CD automation, observability, and repeatable infrastructure recovery**.

The environment can be rebuilt on a fresh EC2 instance using the project's deployment files, with the target of getting the platform running again in approximately **3 minutes**.

<p align="center"><img src="assets/red-line.svg" width="100%" alt=""></p>

## 🏗️ System Architecture

<p align="center">
  <img src="assets/architecture.svg" width="100%" alt="K3s Self-Healing Cloud Platform architecture">
</p>

**Traffic flow:** AWS EC2 → K3s → Online Boutique frontend → microservices

**Reliability flow:** Pod failure → Kubernetes reconciliation → replacement pod

**Scaling flow:** Synthetic traffic → CPU pressure → HPA → frontend replicas

**Operations flow:** Jenkins CI/CD + Grafana observability

<p align="center"><img src="assets/red-line.svg" width="100%" alt=""></p>

## 🚀 Engineering Highlights

### 🛡️ Kubernetes Self-Healing

Kubernetes declarative desired-state management continuously reconciles the running workload with the configured replica count.

A failed or manually deleted pod is detected by the ReplicaSet controller and a replacement pod is created automatically.

```bash
kubectl delete pod -l app=frontend -n boutique
kubectl get pods -n boutique -l app=frontend -w
```

### 📈 Dynamic HPA Autoscaling

The frontend uses Kubernetes `autoscaling/v2` with:

```text
Target CPU:       80%
Minimum replicas: 1
Maximum replicas: 3
```

Synthetic traffic is used to create CPU pressure and observe the HPA scaling response.

```bash
kubectl get hpa -n boutique -w
```

### 🔄 Jenkins CI/CD

Jenkins runs inside Kubernetes and uses a declarative `Jenkinsfile` for:

- Cluster health checks
- Service connectivity verification
- Smoke testing
- Deployment workflow

### 📊 Grafana Observability

Grafana provides visibility into:

- CPU utilization
- Memory utilization
- Pod status
- Cluster resource consumption

### ♻️ 3-Minute EC2 Rebuild

The project includes deployment files and the `deploy-all.sh` bootstrap script so the Kubernetes environment can be recreated on a fresh EC2 instance.

```bash
git clone https://github.com/moulisiddhu487-svg/k3s-self-healing-cloud-platform.git ~/my-project
cd ~/my-project

chmod +x deploy-all.sh
sudo ./deploy-all.sh
```

<p align="center"><img src="assets/red-line.svg" width="100%" alt=""></p>

## 🧪 Failure & Load Testing

### Test 1 — Pod Failure Recovery

Delete the frontend pod:

```bash
kubectl delete pod -l app=frontend -n boutique
```

Watch Kubernetes recreate it:

```bash
kubectl get pods -n boutique -l app=frontend -w
```

**Expected behavior:** Kubernetes detects the missing replica and creates a replacement pod.

### Test 2 — HPA Scaling

Start the load generator:

```bash
kubectl scale deployment loadgenerator -n boutique --replicas=1
```

Monitor the HPA:

```bash
kubectl get hpa -n boutique -w
```

Stop the load generator:

```bash
kubectl scale deployment loadgenerator -n boutique --replicas=0
```

**Expected behavior:** increased CPU utilization causes the HPA to add replicas within the configured limits.

<p align="center"><img src="assets/red-line.svg" width="100%" alt=""></p>

## 🛠️ Technology Stack

| Area | Technologies |
|---|---|
| ☁️ Cloud | AWS EC2 |
| 🐧 Operating System | Ubuntu 24.04 LTS |
| ☸️ Orchestration | Kubernetes, K3s |
| 📦 Containers | Docker, containerd |
| ⚙️ Automation | Bash |
| 🔄 CI/CD | Jenkins, Jenkinsfile |
| 📈 Autoscaling | Kubernetes HPA v2 |
| 📊 Observability | Grafana |
| 🧪 Load Testing | Locust |

<p align="center"><img src="assets/red-line.svg" width="100%" alt=""></p>

## 🌐 Network & Access

| Application | Namespace | NodePort | Access |
|---|---|---:|---|
| 🛍️ Online Boutique | `boutique` | `30088` | `http://<EC2-PUBLIC-IP>:30088` |
| 📊 Grafana | `monitoring` | `30300` | `http://<EC2-PUBLIC-IP>:30300` |
| ⚙️ Jenkins | `jenkins` | `30808` | `http://<EC2-PUBLIC-IP>:30808` |

<p align="center"><img src="assets/red-line.svg" width="100%" alt=""></p>

## ⚡ Quick Start

### 1. Provision AWS EC2

Recommended environment:

```text
2 vCPU
8 GB RAM
Ubuntu 24.04 LTS
```

Required inbound ports:

```text
22      SSH
30088   Storefront
30300   Grafana
30808   Jenkins
```

### 2. Clone & Deploy

```bash
git clone https://github.com/moulisiddhu487-svg/k3s-self-healing-cloud-platform.git ~/my-project
cd ~/my-project

chmod +x deploy-all.sh
sudo ./deploy-all.sh
```

### 3. Verify

```bash
kubectl get pods -A
kubectl get hpa -n boutique
```

<p align="center"><img src="assets/red-line.svg" width="100%" alt=""></p>

## 📁 Repository Structure

```text
k3s-self-healing-cloud-platform/
│
├── deploy-all.sh          # Cluster bootstrap / rebuild script
├── boutique-patch.yaml    # Storefront NodePort configuration
├── hpa.yaml               # HPA: 80% CPU / 1–3 replicas
├── jenkins.yaml           # Jenkins deployment + NodePort
├── monitoring.yaml        # Grafana deployment + NodePort
├── Jenkinsfile            # Declarative CI/CD pipeline
└── README.md              # Project documentation
```

<p align="center"><img src="assets/red-line.svg" width="100%" alt=""></p>

## 💡 What This Project Demonstrates

**Infrastructure:** AWS EC2 → Linux → K3s → Kubernetes

**Application Platform:** Online Boutique → 11 microservices → Redis → Frontend

**Reliability:** ReplicaSet → Failure detection → Pod recreation

**Scalability:** Load generation → CPU pressure → HPA → Additional replicas

**Delivery:** Jenkins → Pipeline-as-Code → Validation → Deployment

**Operations:** Cluster metrics → Grafana → Resource visibility

<p align="center"><img src="assets/red-line.svg" width="100%" alt=""></p>

<div align="center">

### ⚡ Built to learn. Tested to break. Automated to recover.

**DevOps • Kubernetes • AWS • SRE**

</div>
