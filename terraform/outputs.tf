output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "web_instance_id" {
  description = "Web EC2 instance ID (use with: aws ssm start-session --target <id>)"
  value       = aws_instance.web.id
}

output "web_public_ip" {
  description = "Web EC2 public IP (Step 1 verification: http://<ip>/)"
  value       = aws_instance.web.public_ip
}
