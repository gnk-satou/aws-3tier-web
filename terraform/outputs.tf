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

output "private_app_subnet_ids" {
  description = "Private app subnet IDs"
  value       = aws_subnet.private_app[*].id
}

output "private_db_subnet_ids" {
  description = "Private DB subnet IDs"
  value       = aws_subnet.private_db[*].id
}

output "nat_gateway_public_ip" {
  description = "NAT Gateway EIP (source IP for outbound traffic from private subnets)"
  value       = aws_eip.nat.public_ip
}

output "alb_dns_name" {
  description = "ALB DNS name (verification: http://<dns>/)"
  value       = aws_lb.main.dns_name
}

output "rds_endpoint" {
  description = "RDS endpoint (reachable only from the web tier)"
  value       = aws_db_instance.main.endpoint
}

output "db_master_secret_arn" {
  description = "Secrets Manager ARN of the RDS master password (managed by RDS)"
  value       = aws_db_instance.main.master_user_secret[0].secret_arn
}
