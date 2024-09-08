# Redis Kubernetes CI/CD (redis-k8s-cicd)

## Architecture Diagram
![Image description](./images/redis_cluster.drawio.png)

## Overview
This project automates the deployment of a scalable and resilient Redis cluster on Kubernetes using Helm, along with Terraform for infrastructure provisioning. It integrates a CI/CD pipeline to allow seamless updates and zero downtime for the Redis deployment.

### Key Technologies:
- **Terraform:** Infrastructure as code for managing Kubernetes clusters and cloud resources.
- **Helm:** Package manager for Kubernetes applications.
- **Kubernetes:** Orchestrating containerized applications.
- **Redis:** In-memory data structure store.

---

## Infrastructure Provisioning (Terraform)

### Files:
- `main.tf`: Main configuration to provision the Kubernetes cluster (e.g., EKS, GKE, or AKS).
- `modules/eks`: Defines the resources for the Kubernetes cluster.
- `modules/vpc`: Configures networking.
- `modules/iam`: Manages access control and roles.

### Setup Process:
1. **Backend Configuration (`backend.tf`):** Defines the storage for Terraform state (e.g., S3, Azure Blob).
2. **Infrastructure Components:**
   - The Kubernetes cluster is provisioned with the necessary compute and networking infrastructure.
   - IAM roles and policies ensure secure access to cluster resources.

### Variables:
- Configurable via `variables.tf`, allowing flexibility in setting parameters like region, node size, and replica count.

---

## Kubernetes Deployment (Helm)

### Redis Helm Chart:
- `helm/redis/`: This directory contains the Helm chart for deploying Redis with considerations for high availability, monitoring, and scaling.

### Key Files:
- **`Chart.yaml`**: Metadata for the Redis chart.
- **`values.yaml`**: Configuration settings such as replicas, resource limits, Redis-specific settings.
- **`templates/`:** Contains Kubernetes resource definitions:
  - **StatefulSets** for managing Redis instances.

### Scaling & Resilience:
- Redis is deployed using StatefulSets for persistence and high availability.

---

## CI/CD Pipeline

## CI/CD Pipeline (GitHub Actions)

The project uses GitHub Actions to automate the deployment process. The main workflow is stored in `.github/workflows/deploy.yaml`.

### Workflow Details:

- **File:** `.github/workflows/deploy.yaml`
- **Trigger:** The pipeline runs automatically when code is pushed to the `main` branch.

### Key Steps:

1. **AWS Setup:**
    - Set AWS credentials using secrets stored in the repository (`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`).
    - Create or verify the S3 bucket and DynamoDB table for the Terraform backend.

2. **Terraform Initialization and Application:**
    - Initialize Terraform.
    - Plan and apply the infrastructure using Terraform (`terraform apply`).

3. **Kubernetes Configuration:**
    - Update the `kubeconfig` to interact with the EKS cluster.
    - Verify the cluster nodes using `kubectl`.

4. **Redis Deployment with Helm:**
    - Install Helm.
    - Deploy Redis to the Kubernetes cluster using the Helm chart (`helm upgrade --install redis`).


### Zero-Downtime Features:
- Helm’s rolling update strategy and StatefulSet updates help maintain service availability.

---

## Conclusion
This project successfully deploys a Redis cluster on Kubernetes, fully automated through Helm and Terraform. It leverages CI/CD for efficient and zero-downtime updates.
