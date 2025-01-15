output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "s3_bucket_name" {
  value = module.s3.s3_bucket_name
}
# EC2
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

output "security_group_id" {
  value = module.ec2.security_group_id
}

output "security_group_arn" {
  value = module.ec2.security_group_arn
}

# ECR
output "ECR_repository_url" {
  value = module.ecr.repository_url
}

output "ECR_repository_name" {
  value = module.ecr.repository_name
}

output "ECR_repository_arn" {
  value = module.ecr.repository_arn
}

# EKS
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

output "repository_url" {
  value = module.ecr.repository_url
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}
output "secret_id" {
  value = module.rds.secret_id
}