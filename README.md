<div align="center">

# ⚡ K3s Self-Healing Cloud Platform

### Production-Style Kubernetes & SRE Infrastructure on AWS EC2

<p>
<img src="https://img.shields.io/badge/AWS-EC2-FF9900?style=for-the-badge&logo=amazon-aws&logoColor=white">
<img src="https://img.shields.io/badge/Kubernetes-K3s-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white">
<img src="https://img.shields.io/badge/Jenkins-CI%2FCD-D24939?style=for-the-badge&logo=jenkins&logoColor=white">
<img src="https://img.shields.io/badge/Prometheus-Metrics-E6522C?style=for-the-badge&logo=prometheus&logoColor=white">
<img src="https://img.shields.io/badge/Grafana-Observability-F46800?style=for-the-badge&logo=grafana&logoColor=white">
<img src="https://img.shields.io/badge/Ubuntu-24.04-E95420?style=for-the-badge&logo=ubuntu&logoColor=white">
<img src="https://img.shields.io/badge/Bash-Automation-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white">
</p>

</div>

🔴 ─────────────────────────────────────────────────────────────

## 🎯 PROJECT OVERVIEW

I built a lightweight **Kubernetes/SRE platform from scratch on AWS EC2 using K3s**, deploying Google's **Online Boutique 11-microservice e-commerce application**.

The platform combines:

- ☸️ **K3s Kubernetes orchestration**
- 🛍️ **11 Online Boutique microservices**
- 🛡️ **Kubernetes self-healing**
- 📈 **HPA-based frontend autoscaling**
- 🔄 **Jenkins CI/CD**
- 📊 **Prometheus, Node Exporter & Grafana observability**
- 🧪 **Pod-failure and load-testing validation**
- ♻️ **Automated environment recovery**

The project demonstrates how a microservices workload can be **deployed, monitored, scaled, tested under failure, and recovered using Kubernetes and SRE practices**.

🔴 ─────────────────────────────────────────────────────────────

## 🏗️ SYSTEM ARCHITECTURE

```text
                         ┌───────────────────────┐
                         │    USER / ADMIN       │
                         │       BROWSER         │
                         └───────────┬───────────┘
                                     │
                                     ▼
                         ┌───────────────────────┐
                         │       AWS EC2         │
                         │   Ubuntu 24.04 LTS    │
                         │                       │
                         │  AWS Security Group   │
                         │  22 / 30088 / 30300   │
                         │       / 30808         │
                         └───────────┬───────────┘
                                     │
                                     ▼
                         ┌───────────────────────┐
                         │    K3s Kubernetes     │
                         │        Cluster        │
                         └───────────┬───────────┘
                                     │
             ┌───────────────────────┼────────────────────────┐
             │                       │                        │
             ▼                       ▼                        ▼
   ┌─────────────────┐     ┌─────────────────┐      ┌─────────────────┐
   │ boutique        │     │ default         │      │ jenkins         │
   │ namespace       │     │ namespace       │      │ namespace       │
   │                 │     │                 │      │                 │
   │ Online Boutique │     │ Prometheus      │      │ Jenkins         │
   │ 11 services     │     │ Node Exporter   │      │ Jenkinsfile     │
   │ + Redis         │     │ Grafana         │      │ CI/CD pipeline  │
   │ + Loadgenerator │     │                 │      │                 │
   └───────┬─────────┘     └─────────────────┘      └─────────────────┘
           │
           ├──────────────► Self-Healing
           │                Failed pod → replacement pod
           │
           └──────────────► HPA
                            CPU target: 80%
                            Frontend: 1 → 3 replicas

       30088 → Online Boutique
       30300 → Grafana
       30808 → Jenkins
```

**Core flow:** AWS EC2 → K3s → Kubernetes namespaces → application + CI/CD + observability.

🔴 ─────────────────────────────────────────────────────────────

## 🚀 ENGINEERING HIGHLIGHTS

### 🛡️ Kubernetes Self-Healing

The application runs with Kubernetes desired-state reconciliation. When a running application pod is deleted or fails, Kubernetes detects the missing replica and creates a replacement automatically.

### 📈 Dynamic HPA Autoscaling

The frontend uses Kubernetes `autoscaling/v2` with an **80% CPU target**, scaling between **1 and 3 replicas** according to workload pressure.

### 🔄 Jenkins CI/CD

Jenkins runs inside the `jenkins` namespace and uses a declarative `Jenkinsfile` for pipeline execution, health verification, endpoint checks, and deployment workflow / rolling updates.

### 📊 Grafana Observability

The monitoring layer combines **Prometheus** for time-series metrics, **Node Exporter** for host-level metrics, and **Grafana** for operational visualization.

### 🧩 11-Microservice Platform

Google's Online Boutique workload is deployed as **11 Kubernetes services** in the `boutique` namespace:

```text
frontend
cartservice
redis-cart
productcatalogservice
currencyservice
paymentservice
shippingservice
emailservice
checkoutservice
recommendationservice
loadgenerator
```

🔴 ─────────────────────────────────────────────────────────────

## 🧪 VALIDATION & FAILURE TESTING

The engineering capabilities are validated separately through controlled failure and workload scenarios.

### Test 1 — Pod Failure & Self-Healing

A running frontend pod is intentionally removed:

```bash
kubectl delete pod -l app=frontend -n boutique
```

The workload is then watched:

```bash
kubectl get pods -n boutique -l app=frontend -w
```

**Expected behavior:** Kubernetes detects the missing replica and creates a replacement pod.

### Test 2 — HPA Scaling Under Load

The Online Boutique load generator is enabled:

```bash
kubectl scale deployment loadgenerator -n boutique --replicas=1
```

HPA behavior is monitored:

```bash
kubectl get hpa -n boutique -w
```

After the scaling test, the load generator is stopped:

```bash
kubectl scale deployment loadgenerator -n boutique --replicas=0
```

**Expected behavior:** workload pressure causes the frontend to scale within the configured replica limits, followed by scale-down after the load is removed.

🔴 ─────────────────────────────────────────────────────────────

## 🛠️ TECHNOLOGY STACK

| Layer | Technologies |
|---|---|
| ☁️ Cloud | **AWS EC2** |
| 🐧 Operating System | **Ubuntu 24.04 LTS** |
| ☸️ Orchestration | **K3s / Kubernetes** |
| 🛍️ Application | **Google Online Boutique — 11 microservices** |
| 🔄 CI/CD | **Jenkins / Jenkinsfile** |
| 📈 Autoscaling | **Kubernetes HPA** |
| 📊 Metrics | **Prometheus / Node Exporter** |
| 📉 Observability | **Grafana** |
| 🧪 Load Testing | **Online Boutique Loadgenerator** |
| ⚙️ Automation | **Bash** |

🔴 ─────────────────────────────────────────────────────────────

## 🌐 NETWORK & ACCESS

| Service | Namespace | NodePort | Purpose |
|---|---|---:|---|
| 🛍️ Online Boutique | `boutique` | **30088** | E-commerce storefront |
| 📊 Grafana | `default` | **30300** | Monitoring dashboard |
| ⚙️ Jenkins | `jenkins` | **30808** | CI/CD web interface |
| 📈 Prometheus | `default` | Internal | Metrics collection |
| 🖥️ Node Exporter | `default` | Internal | Host metrics |

🔴 ─────────────────────────────────────────────────────────────

## ⚡ DEPLOYMENT & RECOVERY

The platform is deployed on an AWS EC2 instance and can be recreated from the project repository and deployment automation.

### 1. AWS EC2 Environment

The project environment uses:

```text
Cloud:          AWS EC2
Instance:       c7i-flex.large
CPU:            2 vCPU
Memory:         4 GiB
Operating OS:   Ubuntu 24.04 LTS
Orchestrator:   K3s
```

### 2. AWS Security Group

Required inbound access:

```text
22      → SSH
30088   → Online Boutique
30300   → Grafana
30808   → Jenkins
```

### 3. Clone the Repository

On the fresh EC2 instance:

```bash
git clone https://github.com/moulisiddhu487-svg/k3s-self-healing-cloud-platform.git ~/my-project
cd ~/my-project
```

### 4. Spin Up the Platform

Run the project's deployment automation:

```bash
chmod +x deploy-all.sh
sudo ./deploy-all.sh
```

The automation prepares the K3s environment and applies the project's Kubernetes configuration for the application, autoscaling, monitoring, and Jenkins components.

### 5. Verify

```bash
kubectl get nodes
kubectl get pods -A
kubectl get hpa -n boutique
```

### 6. Access the Services

```text
Online Boutique → http://<EC2-PUBLIC-IP>:30088
Grafana          → http://<EC2-PUBLIC-IP>:30300
Jenkins          → http://<EC2-PUBLIC-IP>:30808
```

### ♻️ 7. 3-Minute Environment Recovery

If the EC2 instance or environment is lost, the same repository and deployment automation provide a recovery path.

From a fresh EC2 instance, the platform can be recreated in approximately **3 minutes** using the repository files and `deploy-all.sh`.

> **The 3-minute capability is the recovery benefit of the deployment automation — the core project is the K3s self-healing, autoscaling, CI/CD, and observability platform.**

🔴 ─────────────────────────────────────────────────────────────

## 📁 REPOSITORY STRUCTURE

```text
k3s-self-healing-cloud-platform/
│
├── deploy-all.sh          # Platform deployment automation
├── boutique-patch.yaml    # Online Boutique NodePort configuration
├── hpa.yaml               # HPA configuration
├── jenkins.yaml           # Jenkins deployment and service
├── monitoring.yaml        # Monitoring / Grafana configuration
├── Jenkinsfile            # Declarative CI/CD pipeline
└── README.md              # Project documentation
```

🔴 ─────────────────────────────────────────────────────────────

## 🎯 PROJECT OUTCOME

This project demonstrates practical **DevOps and SRE engineering** across the complete platform lifecycle:

```text
AWS EC2
   │
   ▼
K3s Kubernetes
   │
   ▼
11-Service Online Boutique
   │
   ├──────────────► Self-Healing
   │
   ├──────────────► HPA Autoscaling
   │
   ├──────────────► Jenkins CI/CD
   │
   └──────────────► Prometheus + Node Exporter + Grafana
                         │
                         ▼
                 Failure & Load Validation
                         │
                         ▼
                 Automated Recovery
```

### What this demonstrates

**Infrastructure** → AWS EC2 + K3s

**Orchestration** → Kubernetes workloads and namespaces

**Reliability** → Self-healing through desired-state reconciliation

**Scalability** → HPA from 1 to 3 frontend replicas

**Delivery** → Jenkins + Jenkinsfile

**Observability** → Prometheus + Node Exporter + Grafana

**Resilience** → Controlled pod-failure and load testing

**Recovery** → Reproducible environment rebuild

<div align="center">

### ⚡ Built from scratch. Tested under failure. Designed to recover.

**AWS • K3s • Kubernetes • Jenkins • Prometheus • Grafana • SRE**

</div>
