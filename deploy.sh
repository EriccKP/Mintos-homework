#!/bin/bash
set -e
# Start minikube if not running
minikube start 
# minikube start --driver=docker # for docker desktop

# Enable ingress addon
minikube addons enable ingress

# Initialize Terraform
terraform init

# Apply Terraform configuration
terraform apply -auto-approve

# Wait for pods to be ready
echo "Waiting for pods to be ready..."
kubectl wait --for=condition=ready pod -l app=sonarqube -n sonarqube --timeout=300s

echo "Add the following entry to your /etc/hosts file:"
echo "$(minikube ip) sonarqube.local"
echo "Then You can access Sonarqube at: http://sonarqube.local"