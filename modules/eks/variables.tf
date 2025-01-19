variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
  description = "List of private subnet IDs where EKS cluster and node groups are deployed."
}

variable "eks_version" {
  type        = string
  description = "Kubernetes version for the EKS cluster."
  default     = "1.31"  
}
variable "node_instance_types" {
  type        = list(string)
  description = "List of EC2 instance types for the EKS node group."
  default     = ["t3.medium"]
}

variable "node_disk_size" {
  type        = number
  description = "Disk size (in GB) for the EKS worker nodes."
  default     = 20
}

variable "node_scaling_config" {
  type = object({
    desired_size = number
    min_size     = number
    max_size     = number
  })
  description = "Scaling configuration for the EKS node group."
  default = {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }
}
