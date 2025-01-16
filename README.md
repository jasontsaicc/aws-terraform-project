# aws-terraform-project
# Infrastructure Setup with Terraform

This repository provides Terraform modules to deploy a scalable and secure infrastructure on AWS. The setup includes VPC, S3, ECR, RDS, EC2, EKS, and more, following best practices.

## Architecture Overview

The infrastructure consists of:
- **VPC**: A custom Virtual Private Cloud with public and private subnets.
- **S3**: Bucket creation for storage needs.
- **ECR**: Elastic Container Registry for container images.
- **Secrets Manager**: Securely manage secrets for applications.
- **RDS**: Relational Database Service for persistent data storage.
- **EC2**: Instances for various compute needs, including a bastion host.
- **EKS**: Kubernetes cluster for container orchestration.
- **ALB/NLB**: Load balancers for routing traffic.
- **Redshift**: Data warehousing for analytics.
