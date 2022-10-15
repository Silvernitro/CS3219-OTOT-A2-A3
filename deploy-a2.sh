#!/bin/sh
echo "========Deploying kind cluster========\n"
kind create cluster --name kind-1 --config k8s/kind/cluster-config.yaml
echo "========Verify cluster status=========\n"
docker ps
kubectl cluster-info

echo "========Load custom image into cluster nodes=========\n"
kind load docker-image cs3219-otot-a1.3-app:latest --name kind-1
echo "========Create k8s deployment=========\n"
kubectl apply -f ./k8s/manifests/backend-deployment.yaml
echo "========Create k8s service=========\n"
kubectl apply -f ./k8s/manifests/backend-service.yaml
echo "========Service status=========\n"
kubectl get svc

echo "========Create ingress controller=========\n"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

