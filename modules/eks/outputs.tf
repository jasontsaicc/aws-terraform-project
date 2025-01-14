output "eks_cluster_name" {
  value = aws_eks_cluster.this.name
}

output "eks_cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}

output "eks_node_group_name" {
  description = "The name of the EKS node group."
  value       = aws_eks_node_group.this.node_group_name
}