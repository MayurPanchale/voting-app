# Example Voting App

A simple distributed application running across multiple Docker containers.

## Getting started

Download [Docker Desktop](https://www.docker.com/products/docker-desktop) for Mac or Windows. [Docker Compose](https://docs.docker.com/compose) will be automatically installed. On Linux, make sure you have the latest version of [Compose](https://docs.docker.com/compose/install/).

This solution uses Python, Node.js, .NET, with Redis for messaging and Postgres for storage.

Run in this directory to build and run the app:

```shell
docker compose up
```

The `vote` app will be running at [http://localhost:8080](http://localhost:8080), and the `results` will be at [http://localhost:8081](http://localhost:8081).

Alternately, if you want to run it on a [Docker Swarm](https://docs.docker.com/engine/swarm/), first make sure you have a swarm. If you don't, run:

```shell
docker swarm init
```

Once you have your swarm, in this directory run:

```shell
docker stack deploy --compose-file docker-stack.yml vote
```

## Run the app in Kubernetes

The folder k8s-specifications contains the YAML specifications of the Voting App's services.

Run the following command to create the deployments and services. Note it will create these resources in your current namespace (`default` if you haven't changed it.)

```shell
kubectl create -f k8s-specifications/
```

The `vote` web app is then available on port 31000 on each host of the cluster, the `result` web app is available on port 31001.

To remove them, run:

```shell
kubectl delete -f k8s-specifications/
```

## Architecture

![Architecture diagram](architecture.excalidraw.png)

* A front-end web app in [Python](/vote) which lets you vote between two options
* A [Redis](https://hub.docker.com/_/redis/) which collects new votes
* A [.NET](/worker/) worker which consumes votes and stores them in…
* A [Postgres](https://hub.docker.com/_/postgres/) database backed by a Docker volume
* A [Node.js](/result) web app which shows the results of the voting in real time

## Notes

The voting application only accepts one vote per client browser. It does not register additional votes if a vote has already been submitted from a client.

This isn't an example of a properly architected perfectly designed distributed app... it's just a simple
example of the various types of pieces and languages you might see (queues, persistent data, etc), and how to
deal with them in Docker at a basic level.

🔧 End-to-End Automation with Azure DevOps CI/CD Pipelines & GitOps
This project demonstrates an end-to-end CI/CD pipeline automation leveraging Azure DevOps to deploy applications using GitOps principles. It automates the process from code commits to production deployment with minimal manual intervention, ensuring a streamlined and secure deployment pipeline.

🚀 Project Overview
The goal of this project is to automate the build, testing, and deployment process of an application using Azure DevOps Pipelines and GitOps practices. This includes setting up repositories, creating pipelines, integrating source control, and using infrastructure as code for seamless deployments.

🛠️ Technologies & Tools
Tool/Service	Description
Azure DevOps	CI/CD automation, Pipelines, Repos
GitOps	Managing Infrastructure and Deployments using Git
Docker	Containerization of applications
Kubernetes (AKS)	Deployment and orchestration of containers
Terraform	Infrastructure as Code for Azure resources
Azure Kubernetes Service (AKS)	Managed Kubernetes Cluster
Helm	Package manager for Kubernetes
Azure Container Registry (ACR)	Storing container images securely
Azure Key Vault	Secret management for pipelines
Git	Source control system
Kubectl	Command-line tool for Kubernetes

🗂️ Project Structure



azure-devops-gitops/
├── devops/
│   ├── azure-pipelines.yml   # YAML definition for Azure Pipelines
│   ├── helm-chart/           # Helm chart for app deployment
│   └── terraform/            # Terraform files for Azure resource creation
├── k8s/                     # Kubernetes manifests
│   └── deployment.yaml       # Kubernetes deployment configuration
└── README.md                # Project Documentation (you're here!)
🔧 Setup and Installation
1. Azure DevOps Setup
Create a new Azure DevOps organization and Project.

Set up a Git Repository to store your source code.

Create the CI Pipeline using azure-pipelines.yml from the devops/ directory.

2. Pipeline Configuration
Ensure that the pipeline is set to trigger on changes to the repository:

yaml
trigger:
  branches:
    include:
      - main
The pipeline will:

Build the container image using Docker.

Push the image to Azure Container Registry (ACR).

Deploy the application to Azure Kubernetes Service (AKS) using Helm.

3. Terraform Infrastructure Setup
Configure Terraform to manage Azure resources like AKS, ACR, and Azure Key Vault.

Deploy the infrastructure with the following:


terraform init
terraform plan
terraform apply
4. Deploying with GitOps
The project follows GitOps by ensuring the deployment is fully managed by Git. The deployment configuration is stored in the repository, and any change to the Git repository automatically triggers the deployment to AKS via Helm.

5. Application Deployment
Deploy your app using Helm by running the following:

helm upgrade --install my-app ./helm-chart
🎬 How It Works
Code Commit: A developer pushes code to the Git repository.

CI Pipeline: On every commit to the main branch, the Azure DevOps pipeline is triggered, which:

Builds the Docker image.

Pushes the image to ACR.

GitOps Deployment: Once the image is in ACR, the GitOps pipeline automatically updates the Helm chart and deploys the app to AKS.

Automated Scaling: The Kubernetes Horizontal Pod Autoscaler ensures the app is scaled based on traffic.

💡 Key Features
CI/CD Pipelines: Automated build, test, and deployment process using Azure DevOps.

GitOps: Application deployment fully controlled by Git, ensuring traceable and predictable deployment processes.

Infrastructure as Code: Terraform automates the provisioning of Azure infrastructure resources like AKS and ACR.

Containerization: The application is containerized using Docker, enabling easy portability and scaling in Kubernetes.

📈 CI/CD Pipeline Steps
Build Docker Image: Using Dockerfile to create an image for your app.

Push Image to ACR: After a successful build, the image is pushed to Azure Container Registry.

Helm Deployment: The image is deployed to AKS using a Helm Chart stored in the Git repository.

Automated Rollout: The deployment process ensures the application is always up to date with the latest commit.


