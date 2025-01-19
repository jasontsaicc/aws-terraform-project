output "alb_dns_name" {
  value = aws_lb.this.dns_name
}
output "alb_arn" {
  value = aws_lb.this.arn
  description = "The ARN of the Application Load Balancer"
}

output "alb_target_group_arn" {
  value = aws_lb_target_group.tableau_ec2_tg.arn
}