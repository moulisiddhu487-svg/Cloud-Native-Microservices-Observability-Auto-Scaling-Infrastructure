<div align="center">

# ⚡ Automated K3s Cloud Platform & CI/CD Infrastructure

### *Production-Grade Kubernetes (K3s) Environment on AWS EC2 Orchestrating Google Boutique Microservices, HPA Autoscaling, Jenkins CI/CD & Grafana Observability*

[![Kubernetes](https://img.shields.io/badge/Kubernetes-K3s-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)](https://k3s.io/)
[![AWS EC2](https://img.shields.io/badge/AWS-EC2%20(m7i--flex.large)-FF9900?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/ec2/)
[![Jenkins](https://img.shields.io/badge/CI%2FCD-Jenkins%20LTS-D24939?style=for-the-badge&logo=jenkins&logoColor=white)](https://www.jenkins.io/)
[![Grafana](https://img.shields.io/badge/Observability-Grafana%20v10-F46800?style=for-the-badge&logo=grafana&logoColor=white)](https://grafana.com/)
[![Ubuntu](https://img.shields.io/badge/OS-Ubuntu%2024.04%20LTS-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)](https://ubuntu.com/)

</div>

<hr style="background-color: #FF0000; height: 3px; border: none; border-radius: 2px; margin: 25px 0;" />

## 📌 Executive Summary

This repository contains the infrastructure code, declarative Kubernetes manifests, and automated provisioning scripts for a **resilient cloud-native microservices platform**. 

Built from scratch on an **AWS EC2 compute instance**, this project demonstrates how to provision lightweight **K3s Kubernetes**, manage multi-tier enterprise workloads (**Google Cloud's 11 Online Boutique microservices**), implement real-time **Horizontal Pod Autoscaling (HPA)**, automate workflows via a **Jenkins CI/CD pipeline**, and establish live cluster observability through **Grafana**.

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

</div>

<hr style="background-color: #FF0000; height: 3px; border: none; border-radius: 2px; margin: 25px 0;" />

## 🏛️ System Architecture

```mermaid
flowchart TD
    subgraph AWS["AWS Cloud Infrastructure (EC2 m7i-flex.large)"]
        Ingress["Public Traffic & AWS Security Group Rules"]
        
        subgraph Ports["Ingress NodePort Routing"]
            P1["Port :30088 (Storefront)"]
            P2["Port :30300 (Grafana)"]
            P3["Port :30808 (Jenkins)"]
        end
        
        Ingress --> P1
        Ingress --> P2
        Ingress --> P3

        subgraph K3s["K3s Lightweight Kubernetes Cluster Runtime"]
            
            subgraph BoutiqueNS["Namespace: boutique (11 Google Microservices)"]
                Frontend["Frontend Service\n(Target: HPA 1-3 Pods @ 80% CPU)"]
                Cart["Cart Service"]
                Redis[("Redis Cart Cache")]
                Catalog["Product Catalog Service"]
                Payment["Payment Service"]
                Shipping["Shipping Service"]
                Email["Email Service"]
                Checkout["Checkout Service"]
                Recommend["Recommendation Service"]
                Ad["Ad Service"]
                Currency["Currency Service"]
                LoadGen["Locust Load Generator\n(Traffic Simulation Engine)"]
                
                P1 --> Frontend
                Frontend --> Cart --> Redis
                Frontend --> Catalog
                Frontend --> Payment
                Frontend --> Shipping
                Frontend --> Email
                Frontend --> Checkout
                Frontend --> Recommend
                Frontend --> Ad
                Frontend --> Currency
                LoadGen -.->|Simulated Shopper Surge| Frontend
            end

            subgraph MonitoringNS["Namespace: monitoring"]
                Grafana["Grafana Observability Engine\n(Cluster & Node Telemetry UI)"]
                P2 --> Grafana
            end

            subgraph JenkinsNS["Namespace: jenkins"]
                Jenkins["Jenkins CI/CD Automation Controller\n(Declarative Pipeline Engine)"]
                P3 --> Jenkins
            end

            subgraph SRE["Cluster Resilience & Control Loop"]
                Metrics["Metrics Server API"]
                HPACtrl["Horizontal Pod Autoscaler (HPA v2)"]
                Reconciler["K3s ReplicaSet Controller (Auto-Healing)"]
                
                Metrics --> HPACtrl
                HPACtrl -.->|Dynamic Replicas 1-3| Frontend
                Reconciler -.->|Instant Pod Recreation < 2s| BoutiqueNS
            end
        end
    end
🌐 Network & Ingress Routing MatrixApplication / ConsoleNamespaceTarget Container PortExposed NodePortAccess Endpoint URLProtocol / Status🛍️ Boutique Storefrontboutique808030088http://<EC2-PUBLIC-IP>:30088HTTP / Active📊 Grafana Observabilitymonitoring300030300http://<EC2-PUBLIC-IP>:30300HTTP / Active⚙️ Jenkins Automationjenkins808030808http://<EC2-PUBLIC-IP>:30808HTTP / Active🔍 Engineering Highlights & SRE Capabilities1. Google Online Boutique OrchestrationDeploys Google Cloud's official 11-tier microservices architecture within a dedicated boutique namespace. The deployment includes stateful caching (redis-cart), inter-service communication, and an edge web layer (frontend) serving simulated e-commerce operations.2. High-Availability & Self-Healing ResilienceLeveraging Kubernetes continuous state reconciliation loops, if any microservice pod experiences an unexpected crash, out-of-memory error, or manual deletion, the ReplicaSet controller detects the drift and schedules a replacement pod in $< 2$ seconds, ensuring zero downtime.3. Dynamic Horizontal Pod Autoscaling (HPA)Configured using the autoscaling/v2 API:Target Metric: 80% Average CPU UtilizationScale Boundaries: Min: 1 Pod | Max: 3 PodsKeeps resource consumption minimal during baseline usage (1 pod) and elastically scales up to 3 pods during traffic surges to maintain latency SLAs.4. Containerized Jenkins CI/CD AutomationJenkins LTS runs natively inside the cluster (jenkins namespace) with a persistent workspace. The declarative pipeline automates health checks, verifies service availability across NodePorts, and coordinates zero-downtime rolling updates.5. Centralized Observability & TelemetryGrafana is deployed inside the monitoring namespace to provide real-time visibility into node health, pod resource limits, and cluster performance metrics.🧪 Chaos Testing & Live Verification🔬 Test 1: Simulating Pod Failure & Self-HealingDemonstrate zero-downtime container self-healing:Bash# Force delete an active frontend pod
kubectl delete pod -l app=frontend -n boutique

# Observe instant reconciliation and pod rebirth in real time
kubectl get pods -n boutique -l app=frontend -w
🔬 Test 2: Simulating Traffic Surge & HPA Auto-ScalingGenerate synthetic load using the Locust engine to trigger autoscaling:Bash# Scale up the load generator to simulate traffic
kubectl scale deployment loadgenerator -n boutique --replicas=1

# Watch the HPA controller detect high CPU and scale from 1 to 3 pods
kubectl get hpa -n boutique -w

# Cool down and observe automatic scale-down back to 1 pod
kubectl scale deployment loadgenerator -n boutique --replicas=0
⚡ 1-Click Spin-Up & Rebuild Guide (3 Minutes)This entire platform can be rebuilt on a clean AWS EC2 instance using the automated bootstrap script:Step 1: Provision the AWS EC2 InstanceInstance Type: m7i-flex.large or t3.large (2 vCPU, 8 GB RAM recommended)OS: Ubuntu 24.04 LTSSecurity Group Inbound Rules:SSH: Port 22Storefront: Port 30088Grafana: Port 30300Jenkins: Port 30808Step 2: Clone and BootstrapRun these commands on your EC2 instance:Bash# 1. Clone repository
git clone [https://github.com/moulisiddhu487-svg/k3s-self-healing-cloud-platform.git](https://github.com/moulisiddhu487-svg/k3s-self-healing-cloud-platform.git) ~/my-project
cd ~/my-project

# 2. Make script executable and execute
chmod +x deploy-all.sh
sudo ./deploy-all.sh
Step 3: Verify Running ServicesBash# Check all cluster pods across namespaces
kubectl get pods -A

# Confirm Horizontal Pod Autoscaler status
kubectl get hpa -n boutique
Step 4: Access Your EndpointsE-Commerce Web Storefront: http://<YOUR_EC2_PUBLIC_IP>:30088Grafana Dashboard: http://<YOUR_EC2_PUBLIC_IP>:30300Jenkins Automation Server: http://<YOUR_EC2_PUBLIC_IP>:30808📁 Repository BlueprintPlaintext.
├── deploy-all.sh          # 1-Click Master Infrastructure Bootstrapping Script
├── boutique-patch.yaml    # NodePort service patch exposing Storefront on :30088
├── hpa.yaml               # Horizontal Pod Autoscaler manifest (80% CPU target, 1-3 replicas)
├── jenkins.yaml           # Deployment & NodePort manifest for Jenkins Controller (:30808)
├── monitoring.yaml        # Deployment & NodePort manifest for Grafana (:30300)
├── Jenkinsfile            # Declarative Jenkins CI/CD Pipeline definition
└── README.md              # Production architectural documentation

---

### How to apply this directly in your EC2 terminal:

```bash
cd ~/my-project
git pull origin main
