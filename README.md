<div align="center">

# ⚡ Automated K3s Cloud Platform & SRE Self-Healing Infrastructure

### *Production-Grade Kubernetes (K3s) Environment on AWS EC2 with Google Boutique Microservices, Dynamic HPA Autoscaling, Jenkins CI/CD & Grafana Observability*

</div>

<hr style="background-color: #FF0000; height: 3px; border: none; border-radius: 2px; margin: 30px 0;" />

## 📌 Executive Summary

An enterprise-grade, automated **DevOps & Site Reliability Engineering (SRE)** platform built from scratch on **AWS EC2** using lightweight Kubernetes (**K3s**). 

The platform delivers an automated, zero-touch infrastructure lifecycle orchestrating **Google Cloud's 11-tier Online Boutique microservices**, automated **Horizontal Pod Autoscaling (HPA)** triggered by real-time CPU telemetry, containerized **Jenkins CI/CD automation**, and cluster-wide **Grafana observability**.

### 🌟 Key Engineering Highlights
* 🚀 **Zero-Touch Infrastructure Bootstrapping:** A single shell script (`deploy-all.sh`) provisions K3s Kubernetes, configures namespace isolation (`boutique`, `monitoring`, `jenkins`), and launches all 11 microservices in **under 3 minutes**.
* 🛡️ **Sub-2-Second Self-Healing Architecture:** Continuous Kubernetes ReplicaSet reconciliation loops automatically detect pod failures, panics, or node disruptions and restart healthy replacement containers in **$< 2$ seconds** with zero user downtime.
* 📈 **Dynamic Horizontal Pod Autoscaling (HPA):** Configured via Kubernetes `autoscaling/v2` API to dynamically scale the edge frontend from **1 to 3 pods** when traffic spikes exceed the **80% CPU target utilization threshold**.
* 🔄 **Declarative CI/CD Automation:** Containerized **Jenkins LTS** automation engine executing pipeline-as-code (`Jenkinsfile`) for automated endpoint verification, smoke tests, and zero-downtime microservice rollouts.
* 📊 **Full-Stack Telemetry & Observability:** Real-time **Grafana** monitoring dashboard deployed in a dedicated namespace for cluster metrics, pod health, and resource utilization tracking.

<hr style="background-color: #FF0000; height: 3px; border: none; border-radius: 2px; margin: 30px 0;" />

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

</div>

<hr style="background-color: #FF0000; height: 3px; border: none; border-radius: 2px; margin: 30px 0;" />

## 🏛️ System Architecture

```mermaid
flowchart TD
    subgraph AWS ["AWS Cloud Infrastructure (EC2 Compute Instance)"]
        Traffic["Public Ingress Traffic & AWS Security Groups"]
        
        subgraph Ports ["NodePort Ingress Routing"]
            P1["Port :30088 (Storefront UI)"]
            P2["Port :30300 (Grafana Telemetry)"]
            P3["Port :30808 (Jenkins CI/CD)"]
        end

        Traffic --> P1
        Traffic --> P2
        Traffic --> P3

        subgraph K3s ["K3s Lightweight Kubernetes Cluster Runtime"]
            
            subgraph Boutique ["Namespace: boutique (11 Microservices)"]
                Frontend["Frontend Web Gateway (HPA Managed)"]
                CartService["Cart Service"]
                RedisCache[("Redis In-Memory Cache")]
                ProductCatalog["Product Catalog Service"]
                PaymentService["Payment Service"]
                ShippingService["Shipping Service"]
                EmailService["Email Service"]
                CheckoutService["Checkout Service"]
                RecommendService["Recommendation Service"]
                AdService["Ad Service"]
                CurrencyService["Currency Service"]
                LocustEngine["Locust Synthetic Traffic Generator"]
                
                Frontend --> CartService --> RedisCache
                Frontend --> ProductCatalog
                Frontend --> PaymentService
                Frontend --> ShippingService
                Frontend --> EmailService
                Frontend --> CheckoutService
                Frontend --> RecommendService
                Frontend --> AdService
                Frontend --> CurrencyService
                LocustEngine -.->|Generates Traffic Spikes| Frontend
            end

            subgraph JenkinsNS ["Namespace: jenkins"]
                JenkinsServer["Jenkins CI/CD Automation Master"]
            end

            subgraph MonitoringNS ["Namespace: monitoring"]
                GrafanaDashboard["Grafana Metrics & Observability Console"]
            end

            subgraph ControlPlane ["Resilience & Autoscaling Controllers"]
                HPALoop["HPA v2 Autoscaler (80% CPU Target)"]
                K8sHealer["ReplicaSet Self-Healing Controller"]
                
                HPALoop -.->|Scales 1 to 3 Replicas| Frontend
                K8sHealer -.->|Instant Pod Recreation < 2s| Boutique
            end

            P1 --> Frontend
            P2 --> GrafanaDashboard
            P3 --> JenkinsServer
        end
    end
🌐 Network & Ingress Routing Matrix
Application / Console	Namespace	Target Container Port	Exposed NodePort	Access Endpoint URL	Protocol / Status
🛍️ Boutique Storefront	boutique	8080	30088	http://<EC2-PUBLIC-IP>:30088	HTTP / Active
📊 Grafana Dashboard	monitoring	3000	30300	http://<EC2-PUBLIC-IP>:30300	HTTP / Active
⚙️ Jenkins Automation	jenkins	8080	30808	http://<EC2-PUBLIC-IP>:30808	HTTP / Active
🔍 How the Platform Works: Core SRE & DevOps Mechanics
1. Zero-Touch Orchestration (deploy-all.sh)
The master orchestration engine handles cluster lifecycle automation end-to-end:

Detects and removes conflicting runtime processes.

Installs the lightweight K3s Kubernetes control plane with an embedded SQLite engine and containerd.

Creates logical tenant isolation using dedicated namespaces (boutique, monitoring, jenkins).

Fetches and applies Google Cloud's 11-tier microservice architecture, applies custom NodePort overlays, configures dynamic autoscaling, and launches telemetry services automatically.

2. Microservices Architecture (Google Online Boutique)
An enterprise 11-tier microservices platform running isolated workloads:

Frontend Web Layer: Aggregates data from downstream services and serves user sessions.

State Management: Fast session caching handled by Redis In-Memory and consumed by cartservice.

Business Logic: Independent microservices handling checkout, payment processing, shipping calculation, recommendations, and multi-currency conversions.

3. Self-Healing & Continuous Fault Recovery
The platform uses Kubernetes declarative desired-state management. If any microservice crashes due to an unhandled exception, fatal memory spike, or manual container deletion, the K3s ReplicaSet controller immediately detects state drift and spawns an operational replacement pod in <2 seconds, ensuring complete application availability.

4. Dynamic Horizontal Pod Autoscaling (HPA)
Configured using Kubernetes autoscaling/v2:

Target Metric: 80% Average CPU Utilization

Scale Boundaries: Min: 1 Pod | Max: 3 Pods

Under baseline load, the frontend runs on a single pod to conserve cloud compute costs. When simulated shopping traffic surges, the HPA controller elastically scales the frontend deployment to 3 replicas within seconds.

5. CI/CD Pipeline & Observability
Jenkins Automation: Deployed as a Kubernetes-native controller executing declarative Jenkinsfile pipelines to automate cluster health audits, service connectivity tests, and rolling updates.

Grafana Telemetry: Provides visual telemetry monitoring node resource consumption, CPU/RAM utilization curves, and pod operational status in real time.

🧪 Chaos Testing & Live Verification
🔬 Test 1: Simulating Pod Crash & Instant Self-Healing
Demonstrate zero-downtime container self-healing:

Bash
# Delete a running frontend pod
kubectl delete pod -l app=frontend -n boutique

# Observe instant reconciliation and pod rebirth in real time
kubectl get pods -n boutique -l app=frontend -w
🔬 Test 2: Simulating Traffic Surge & HPA Dynamic Scaling
Generate synthetic shopper traffic to test Horizontal Pod Autoscaling:

Bash
# Spin up the Locust traffic load generator
kubectl scale deployment loadgenerator -n boutique --replicas=1

# Watch the HPA controller detect high CPU and scale from 1 to 3 pods
kubectl get hpa -n boutique -w

# Cool down and observe automatic scale-down back to 1 pod
kubectl scale deployment loadgenerator -n boutique --replicas=0
⚡ 3-Minute Quickstart & Full Cluster Rebuild Guide
This entire platform can be rebuilt on a clean AWS EC2 instance using the automated bootstrap script:

Step 1: Provision the AWS EC2 Instance
Instance Type: m7i-flex.large or t3.large (2 vCPU, 8 GB RAM recommended)

OS: Ubuntu 24.04 LTS

Security Group Inbound Rules:

SSH: Port 22

Storefront: Port 30088

Grafana: Port 30300

Jenkins: Port 30808

Step 2: Clone and Bootstrap
Run these commands on your EC2 instance:

Bash
# 1. Clone repository
git clone [https://github.com/moulisiddhu487-svg/k3s-self-healing-cloud-platform.git](https://github.com/moulisiddhu487-svg/k3s-self-healing-cloud-platform.git) ~/my-project
cd ~/my-project

# 2. Make script executable and execute
chmod +x deploy-all.sh
sudo ./deploy-all.sh
Step 3: Verify Running Services
Bash
# Check all cluster pods across namespaces
kubectl get pods -A

# Confirm Horizontal Pod Autoscaler status
kubectl get hpa -n boutique
Step 4: Access Your Endpoints
E-Commerce Web Storefront: http://<YOUR_EC2_PUBLIC_IP>:30088

Grafana Dashboard: http://<YOUR_EC2_PUBLIC_IP>:30300

Jenkins Automation Server: http://<YOUR_EC2_PUBLIC_IP>:30808

📁 Repository Blueprint
Plaintext
.
├── deploy-all.sh          # 1-Click Master Infrastructure Bootstrapping Script
├── boutique-patch.yaml    # NodePort service patch exposing Storefront on :30088
├── hpa.yaml               # Horizontal Pod Autoscaler manifest (80% CPU target, 1-3 replicas)
├── jenkins.yaml           # Deployment & NodePort manifest for Jenkins Controller (:30808)
├── monitoring.yaml        # Deployment & NodePort manifest for Grafana (:30300)
├── Jenkinsfile            # Declarative Jenkins CI/CD Pipeline definition
└── README.md              # Production architectural documentation

---

2. Click on `README.md`, then click the **pencil icon (✏️)** in the top right corner to edit.
3. Select everything, press **Backspace/Delete**, and **Paste** the code block above.
4. Click the green **Commit changes...** button at the top right $\rightarrow$ click **Commit changes**.
