

variable "vpc_id" {
  type = string
}

variable "project_name" {
    type = string
}

variable "ami_id" {
  type = string
  default = "ami-07469e8b9deb9b996" 
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "subnet_id" {
  type = list(string)
}

variable "ssh_key_name" {
  default = "tableau_ec2_bastion"
}

variable "ec2_user_data" {
  description = "User data script to install kubectl and configure EKS"
  default = <<-EOT
    #!/bin/bash
    sudo su
    # Update system and install dependencies
    yum update -y

    # Install kubectl
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    mv kubectl /usr/local/bin/

    # Verify kubectl installation
    kubectl version --client

    # Update kubeconfig for EKS
    aws eks update-kubeconfig --region ap-southeast-1 --name tableau-dev-eks

    # Test kubectl commands
    kubectl config view
    kubectl get nodes
  EOT
}
