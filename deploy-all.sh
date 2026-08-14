#!/bin/bash
set -e

echo "=== 1. Installing K3s Cluster ==="
curl -sfL https://get.k3s.io | sh -
mkdir -p ~/.kube
cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
chmod 600 ~/.kube/config

echo "=== 2. Deploying Microservices (Google Boutique) ==="
kubectl create namespace boutique --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -n boutique -f https://raw.githubusercontent.com/GoogleCloudPlatform/microservices-demo/main/release/kubernetes-manifests.yaml

# Patch Boutique Storefront to port 30088
kubectl patch svc frontend-external -n boutique -p '{"spec": {"type": "NodePort", "ports": [{"port": 80, "targetPort": 8080, "nodePort": 30088}]}}'
kubectl scale deployment loadgenerator -n boutique --replicas=0

echo "=== 3. Deploying Grafana & Jenkins ==="
kubectl apply -f monitoring.yaml
kubectl apply -f jenkins.yaml

echo "=== Setup Done! Checking Pods ==="
kubectl get pods -A
