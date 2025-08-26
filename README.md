TEKSystems Control Deployment Engineer Challenge — Solution

This repository contains my end-to-end solution for the Controls Deployment Engineer technical assessment. It is structured around the three parts of the challenge and includes documentation, assumptions, Terraform code, container/Kubernetes artifacts, and a runnable Jenkins pipeline.

Repository Structure:

.
├─ part1/                 # Cybersecurity analysis & documentation
│  └─ Cybersecurity_Scenario.md
├─ part2/                 # Container & Kubernetes security
│  ├─ Dockerfile          # Hardened Docker image
│  ├─ app/                # Minimal Node.js demo service
│  │  ├─ package.json
│  │  └─ server.js
│  └─ k8s/
│     └─ deployment.yaml  # Hardened pod spec with securityContext
└─ part3/                 # IaC + CI/CD pipeline
   ├─ terraform/
   │  ├─ main.tf
   │  ├─ variables.tf
   │  ├─ cloud-init.yaml
   │  └─ outputs.tf
   └─ Jenkinsfile         # Build - Test - Scan - Deploy pipeline

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Assumptions:

Cloud Target: Azure is used throughout (Azure VM, AKS, ACR, Azure Firewall, Defender for Cloud).

CI/CD: I’m using Jenkins, configured with a Service Principal that can authenticate to Azure and push images to ACR.

Security Scans: Trivy (container/IaC scanning) and Checkov (Terraform scanning) are included; in a real environment these could be augmented by Defender for DevOps and Defender for Containers.

Kubernetes: A pre-existing AKS cluster and ACR are available. The Jenkins runner has az, kubectl, and trivy installed.

Access Controls: All VM access is via SSH public key. No passwords are used.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Quick Start

Part 1: Read the Cybersecurity_Scenario.md document in part1/ for the Threat Intel Report, Incident Response Plan, and Network Security Measures.

--

Part 2 - Read Container_Security_Implementation.md

Part 2 - Local Docker:

	cd part2
	docker build -t demo-secure-app:local .
	docker run --rm -p 8080:8080 demo-secure-app:local

Part 2 - Kubernetes:

	kubectl apply -f part2/k8s/deployment.yaml

--

Part 3 — Terraform (VM + Nginx):

	cd part3/terraform
	terraform init
	terraform apply -auto-approve \
	  -var resource_group_name="rg-tek-demo" \
	  -var location="eastus" \
	  -var admin_ssh_pubkey="$(cat ~/.ssh/id_rsa.pub)"

Part 3 — Jenkins Pipeline:

	Create a multibranch pipeline job pointed at this repo.

	Add Jenkins credentials for ACR and AKS (acr-service-principal, aks-kubeconfig).

	Jenkins will run through build, test, scan, and deployment automatically.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

Security Notes

Containers: Run as non-root, with a read-only root filesystem and dropped Linux capabilities (securityContext enforced).

Pipeline: Build fails if Trivy/Checkov report high-severity issues.

VM: Only HTTP (80) is exposed; management is via SSH keys, with NSG rules restricting access.

IaC: Terraform enforces reproducibility; outputs provide IPs and VM IDs for traceability.


Author: Sean Stevens
Target Role: Controls Deployment / DevSecOps Engineer







