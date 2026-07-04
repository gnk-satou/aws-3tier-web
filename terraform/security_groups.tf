# ---------------------------------------------------------------------------
# Step 1: Web SG (HTTP from anywhere — temporary, will be restricted to ALB in Step 2)
# ---------------------------------------------------------------------------

resource "aws_security_group" "web" {
  name        = "${local.name_prefix}-web-sg"
  description = "Web tier security group"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${local.name_prefix}-web-sg"
  }
}

# Step 1 only: allow HTTP directly for verification.
# Step 2 will replace this with an ALB-SG-sourced rule.
resource "aws_vpc_security_group_ingress_rule" "web_http" {
  security_group_id = aws_security_group.web.id
  description       = "HTTP for Step 1 verification"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "web_all" {
  security_group_id = aws_security_group.web.id
  description       = "Allow all outbound"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
