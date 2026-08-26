#!/bin/bash
set -e

echo "🚀 [1/5] Installing K3s Kubernetes & Helm..."
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
sleep 10

echo "📦 [2/5] Creating namespaces..."
kubectl create namespace boutique --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace jenkins --dry-run=client -o yaml | kubectl apply -f -

echo "🛍️ [3/5] Deploying Google Online Boutique & HPA..."
kubectl apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/microservices-demo/main/release/kubernetes-manifests.yaml -n boutique
kubectl apply -f boutique-patch.yaml -n boutique
kubectl apply -f hpa.yaml -n boutique

echo "📊 [4/5] Deploying Observability Stack via Helm (Prometheus & Grafana)..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

# Standard install without extra YAML files
helm upgrade --install my-prometheus prometheus-community/prometheus
helm upgrade --install my-grafana grafana/grafana --set service.type=NodePort --set service.nodePort=30300

echo "⚙️ [5/5] Deploying Jenkins Controller..."
kubectl apply -f jenkins.yaml -n jenkins

echo ""
echo "========================================================"
echo "✅ Full Platform Successfully Deployed via Helm & K3s!"
echo "• Boutique Storefront : http://<EC2-PUBLIC-IP>:30088"
echo "• Grafana Dashboard   : http://<EC2-PUBLIC-IP>:30300"
echo "• Jenkins Controller  : http://<EC2-PUBLIC-IP>:30808"
echo "========================================================"
