<div align="center">

# ⚡ Cloud-Native Microservices Observability & Auto-Scaling Infrastructure

### Production-Inspired Kubernetes & SRE Platform on AWS EC2

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

I built a Kubernetes/SRE platform on AWS EC2 using K3s to deploy and operate Google’s 11-microservice Online Boutique application. The platform demonstrates Kubernetes orchestration, self-healing configuration, HPA-based auto-scaling, Jenkins CI/CD, and Prometheus/Grafana observability with email alerts, with failure and scaling behavior validated through controlled tests.

The platform combines:

- ☸️ **K3s Kubernetes orchestration**
- 🛍️ **11 Online Boutique microservices**
- 🛡️ **Kubernetes self-healing**
- 📈 **HPA-based frontend autoscaling**
- 🔄 **Jenkins CI/CD**
- 📊 **Prometheus, Node Exporter, Kube-State-Metrics & Grafana observability**
- 🧪 **Pod-failure and load-testing validation**

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
   │                 │     │ Grafana         │      │ CI/CD pipeline  │
   │+ Loadgenerator  │     │                 │      │                 │
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

### 🛡️ Self-Healing Configuration

The application runs with Kubernetes desired-state reconciliation. When a running application pod is deleted or fails, Kubernetes detects the missing replica and creates a replacement automatically.

### 📈 Elastic HPA Autoscaling

HPA uses CPU utilization to scale the selected bottleneck services:

```text
Frontend                 1 → 3 replicas
Cartservice              1 → 3 replicas
Recommendationservice    1 → 2 replicas
CPU target                  80%
```

### 🔄 Jenkins CI/CD

Jenkins runs inside the `jenkins` namespace and uses a declarative `Jenkinsfile` for pipeline execution, health verification, endpoint checks, and deployment workflow / rolling updates.

### 📊 Full-Stack Observability

The monitoring layer combines:

- **Prometheus** — time-series metrics
- **Node Exporter** — host-level metrics
- **Kube-State-Metrics** — Kubernetes object/state metrics
- **Grafana** — dashboards and manually configured threshold alerts with email notifications

### ⚙️ Resource Management

Container **resource requests and limits** are configured for workloads to provide predictable scheduling and reduce CPU/memory contention.

### 🧩 11-Microservice Platform

Google's Online Boutique workload is deployed as **11 Kubernetes services** in the `boutique` namespace:

```text
frontend
cartservice
productcatalogservice
currencyservice
paymentservice
shippingservice
emailservice
checkoutservice
recommendationservice
adservice
loadgenerator
```

🔴 ─────────────────────────────────────────────────────────────

## 🧪 VALIDATION & FAILURE TESTING

The engineering capabilities are validated separately through controlled failure and workload scenarios.

### Test 1 — Pod Failure Recovery

```text
Delete pod
   ↓
Kubernetes detects desired-state mismatch
   ↓
Replacement pod
   ↓
Replica state restored
```

**Run:**

```bash
kubectl get pods -n boutique -l app=frontend
```

```bash
kubectl delete pod -l app=frontend -n boutique
```

```bash
kubectl get pods -n boutique -l app=frontend -w
```

**Expected:** the deleted frontend pod is replaced automatically.

### Test 2 — HPA Scaling Under Load

```text
Load generator
      ↓
CPU increases
      ↓
HPA detects threshold
      ↓
Replica count increases
      ↓
Load removed
      ↓
Replica count decreases
```

**Start the load generator:**

```bash
kubectl scale deployment loadgenerator -n boutique --replicas=3
```

**Watch HPA:**

```bash
kubectl get hpa -n boutique -w
```

**Watch replicas:**

```bash
kubectl get pods -n boutique -w
```

**Inspect HPA details:**

```bash
kubectl describe hpa -n boutique
```

**Stop the load generator:**

```bash
kubectl scale deployment loadgenerator -n boutique --replicas=0
```

**Expected:** configured HPA targets scale up under sustained CPU pressure and scale down after load is removed.

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
| 📊 Metrics | **Prometheus / Node Exporter / Kube-State-Metrics** |
| 📉 Observability | **Grafana dashboards + email alerts** |
| 🔔 Alerting | **Grafana Alerting + Email** |
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

## 💡 WHY K3S ON AWS EC2?

This is intentionally a **single-node lab platform**, not a highly available production cluster. K3s provides a lightweight Kubernetes environment suited to the EC2 resource constraints while retaining standard Kubernetes workloads, HPA, and observability tooling.

| | This Project | Enterprise Production |
|---|---|---|
| Kubernetes | **K3s** | **Managed Kubernetes / EKS** |
| Infrastructure | **Single AWS EC2** | **Multi-node / Multi-AZ** |
| Purpose | **DevOps/SRE portfolio lab** | **Production workloads** |
| Workload model | **Standard Kubernetes** | **Standard Kubernetes** |

The project demonstrates production-relevant Kubernetes/SRE patterns without claiming that a single-node lab provides production HA.

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

### What This Demonstrates

**Infrastructure** → AWS EC2 + K3s

**Orchestration** → Kubernetes workloads and namespaces

**Reliability** → Self-healing through desired-state reconciliation

**Scalability** → HPA from 1 to 3 frontend replicas

**Delivery** → Jenkins + Jenkinsfile

**Observability** → Prometheus + Node Exporter + Kube-State-Metrics + Grafana

**Resilience** → Controlled pod-failure and load testing


<div align="center">

### ⚡ Cloud-Native. Observable. Scalable.

**AWS • K3s • Kubernetes • Jenkins • Prometheus • Grafana • SRE**

</div>
