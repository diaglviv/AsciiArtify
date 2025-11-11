#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME=asciiartify

echo "🧩 Creating kind cluster: ${CLUSTER_NAME}"
kind create cluster --name "${CLUSTER_NAME}"

echo "🚀 Applying demo manifest..."
kubectl apply -f k8s/hello-deploy.yaml

echo "⏳ Waiting for deployment..."
kubectl wait --for=condition=available --timeout=60s deployment/hello || true
kubectl get pods -l app=hello

echo "🔗 Port-forwarding svc/hello-svc 8080:80"
kubectl port-forward svc/hello-svc 8080:80 >/dev/null 2>&1 &
PF_PID=$!

sleep 2
echo "🌐 Testing endpoint..."
curl -s http://127.0.0.1:8080 || echo "Request failed"

echo "✅ Done. To stop port-forward, run: kill ${PF_PID}"
echo "�� To delete cluster: kind delete cluster --name ${CLUSTER_NAME}"
