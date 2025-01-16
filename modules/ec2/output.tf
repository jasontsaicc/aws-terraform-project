output "tableau_ec2" {
  value = aws_instance.this.id
}

output "security_group_id" {
  value = aws_security_group.tableau_ec2_sg.id
}

output "security_group_arn" {
  value = aws_security_group.tableau_ec2_sg.arn
}

output "tableau_ec2_public_ip" {
  value = aws_instance.this.public_ip
}

output "tableau_ec2_private_ip" {
  value = aws_instance.this.private_ip
}

output "tableau_ec2_arn" {
  value = aws_instance.this.arn
}

