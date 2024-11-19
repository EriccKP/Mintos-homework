# Mintos Homework Project

This project is designed to deploy SonarQube with PostgreSQL database using Terraform and Helm on a Kubernetes cluster.

## Prerequisites

* Minikube installed
* Terraform installed
* Helm installed

## Deployment Steps

1. Clone this repository to your local machine.
2. Navigate to the project directory.
3. Run the `deploy.sh` script to start the deployment process.

The script will:
* Start Minikube if it's not already running.
* Enable the ingress addon in Minikube.
* Initialize and apply the Terraform configuration to deploy PostgreSQL and SonarQube.
* Wait for the pods to be ready.

## Accessing SonarQube

After the deployment is complete, you can access SonarQube by adding an entry to your `/etc/hosts` file as instructed by the script. Then, navigate to `http://sonarqube.local` in your web browser.

