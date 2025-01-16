output "bastion_instance_id" {
  value = aws_instance.ec2_eks_bastion.id
}

output "bastion_instance_public_ip" {
  value = aws_instance.ec2_eks_bastion.public_ip
}

output "bastion_instance_private_ip" {
  value = aws_instance.ec2_eks_bastion.private_ip
}

output "bastion_instance_arn" {
  value = aws_instance.ec2_eks_bastion.arn
}

