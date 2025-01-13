output "tableau_ec2" {
  value = aws_instance.this.id
}

output "security_group_id" {
  value = aws_security_group.tableau_ec2_sg.id
}

