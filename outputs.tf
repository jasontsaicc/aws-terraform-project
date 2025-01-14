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

output "instance_id" {
  value = module.ec2.tableau_ec2
}

output "security_group_id" {
  value = module.ec2.security_group_id
}

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