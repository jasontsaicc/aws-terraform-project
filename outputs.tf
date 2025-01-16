# VPC Outputs
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = module.vpc.internet_gateway_id
}

output "nat_gateway_ids" {
  description = "NAT Gateway IDs"
  value       = module.vpc.nat_gateway_ids
}

output "vpc_cidr_block" {
  description = "VPC CIDR Block"
  value       = module.vpc.vpc_cidr_block
}

# EC2 Outputs
output "instance_id" {
  value = module.ec2.tableau_ec2
}

output "tableau_ec2_public_ip" {
  value = module.ec2.tableau_ec2_public_ip
}

output "tableau_ec2_private_ip" {
  value = module.ec2.tableau_ec2_private_ip
}

output "tableau_ec2_arn" {
  value = module.ec2.tableau_ec2_arn
}

output "security_group_arn" {
  value = module.ec2.security_group_arn
}
output "security_group_id" {
  value = module.ec2.security_group_id
}


# ECR Outputs
output "ECR_repository_arn" {
  value = module.ecr.repository_arn
}

output "ECR_repository_name" {
  value = module.ecr.repository_name
}

output "ECR_repository_url" {
  value = module.ecr.repository_url
}

# RDS Outputs
output "rds_arn" {
  value = module.rds.rds_arn
}

output "rds_name" {
  value = module.rds.rds_name
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "rds_port" {
  value = module.rds.rds_port
}

# S3 Outputs
output "s3_bucket_arn" {
  value = module.s3.s3_bucket_arn
}

output "s3_bucket_name" {
  value = module.s3.s3_bucket_name
}

output "s3_bucket_url" {
  value = module.s3.s3_bucket_url
}

# EKS Outputs
output "eks_cluster_name" {
  description = "The name of the EKS cluster from the module."
  value       = module.eks.eks_cluster_name
}

output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster from the module."
  value       = module.eks.eks_cluster_endpoint
}

output "eks_node_group_name" {
  description = "The name of the EKS node group from the module."
  value       = module.eks.eks_node_group_name
}
