# terraform-google-cloud
 
# Google Cloud Terraform Project ☁️

This Terraform project automates the provisioning and management of Google Cloud Platform (GCP) resources using Infrastructure as Code (IaC).

## 📌 Table of Contents
1. [Project Overview](#-project-overview)
2. [Prerequisites](#-prerequisites)
3. [Setup & Deployment](#-setup--deployment)
4. [Available Modules](#-available-modules)
5. [Customization](#-customization)
6. [Destroy Resources](#-destroy-resources)

## 🚀 Project Overview
This repository contains Terraform configurations for deploying GCP resources, including:
✔ **Compute Engine** (VMs, Instance Templates)  
✔ **Networking** (VPC, Subnets, Firewall Rules)  
✔ **Storage** (Cloud Storage, Persistent Disks)  
✔ **IAM** (Custom Roles, Service Accounts)  
✔ **Kubernetes Engine (GKE)** (Optional)  

## 📋 Prerequisites
Before deploying, ensure you have:
✅ **Google Cloud Account** ([Sign Up Here](https://cloud.google.com/))  
✅ **Terraform Installed** (≥ v1.5.0) ([Install Guide](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli))  
✅ **Google Cloud SDK (`gcloud`)** ([Install Guide](https://cloud.google.com/sdk/docs/install))  
✅ **Project Billing Enabled**  
✅ **IAM Permissions** (`roles/editor` or custom roles with required privileges)  

## ⚙️ Setup & Deployment

### 1. Clone the Repository
```sh
git clone https://github.com/your-username/your-terraform-gcp-project.git
cd your-terraform-gcp-project
```

### 2. Authenticate with GCP

```sh
gcloud auth application-default login
gcloud config set project YOUR_PROJECT_ID
```

### 3. Initialize Terraform

```sh
terraform init
```

### 4. Apply Configuration

```sh
terraform plan  # Review changes
terraform apply # Deploy infrastructure
```

## 📦 Available Modules

### **Compute Module** (`/modules/compute`)

```hcl
module "compute" {
  source       = "./modules/compute"
  project_id   = var.project_id
  machine_type = "e2-medium"
}
```

Manages:

- ☁️ VM Instances
- 📝 Instance Templates
- 🔄 Instance Groups
- 🖥️ Boot Disks

### **Network Module (/modules/network)

```hcl
module "network" {
  source     = "./modules/network"
  project_id = var.project_id
  region     = "us-central1"
}
```

Manages:

- 🌐 VPC Networks
- 🔗 Subnets
- 🛡️ Firewall Rules
- 🌉 Cloud NAT

### **Storage Module (/modules/storage)

```hcl
module "storage" {
  source          = "./modules/storage"
  project_id      = var.project_id
  storage_buckets = ["app-data", "backups"]
}
```

Manages:

- 🗄️ Cloud Storage Buckets
- 💾 Persistent Disks
- 📦 Storage Classes (Standard, Nearline, Coldline)

## 🔧 Customization
Edit variables.tf or create terraform.tfvars:

```hcl
project_id = "your-project-id"
region = "us-central1"
machine_type = "e2-medium"
network_name = "prod-vpc"
```

## 💥 Destroy Resources
To remove all deployed resources:

```bash
terraform destroy
```


🚀 Happy Infrastructure Building! 🚀
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->