output "nlb_dns_name" {
  value = aws_lb.this.dns_name
}
output "nlb_ip" {
  value = aws_eip.nlb_eip[*].public_ip
  description = "The Elastic IPs of the NLB"
}