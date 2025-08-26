**Part 3 — CI/CD Pipeline Setup**

**Context**



Our organization builds and deploys cloud-native applications at speed. A secure, automated pipeline is critical to reduce human error, catch vulnerabilities early, and maintain trust in deployments. For this exercise I’ll show how I’d combine Infrastructure as Code (IaC) with a Jenkins pipeline to build, test, scan, and deploy an application to Azure.



**1. Configuration Management with IaC**

**Tool of Choice: Terraform**



Terraform allows us to define infrastructure declaratively, track it in version control, and reproduce environments consistently. This reduces drift, enforces standards, and makes recovery fast after incidents.



Example: part3\\Terraform



This spins up a VM in Azure with Nginx installed and ready to serve web traffic, fully reproducible and easily extended.





**2. Jenkins CI/CD Pipeline**



I’m using Jenkins for automation, with a Jenkinsfile that runs through build, test, security scanning, and deployment stages.





**Example: part3\\Jenkensfile**



**Key Features**



Build \& Test: Ensures code compiles and passes tests before moving forward.



Security Scan: Runs Trivy (image scan) and Checkov (IaC scan) to catch vulnerabilities and misconfigurations before deployment.



Push \& Deploy: Pushes signed images to Azure Container Registry, then updates AKS with zero-downtime rolling deployment.



Observability: Rollout status check and failure notifications.



**Why This Matters**



CI/CD pipelines aren’t just about speed, they’re about consistency and safety. Without IaC and automated scanning, every deploy risks introducing vulnerabilities or drift. This setup ensures:



Reproducibility (Terraform-managed infra).



Security baked in (scanning at build time).



Automated recovery (IaC + Jenkins redeploy from clean state).



Visibility (logs, test reports, rollout checks).



In short, the pipeline becomes the first line of defense against bad code and misconfigurations reaching production.

