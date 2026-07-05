# ---------------------------------------------------------------------------
# Step 3: RDS MySQL (single-AZ, private DB subnets, no public access)
# Master password is generated and stored by Secrets Manager (ADR 0007)
# ---------------------------------------------------------------------------

resource "aws_db_subnet_group" "main" {
  name       = "${local.name_prefix}-db-subnet-group"
  subnet_ids = aws_subnet.private_db[*].id

  tags = {
    Name = "${local.name_prefix}-db-subnet-group"
  }
}

resource "aws_db_instance" "main" {
  identifier     = "${local.name_prefix}-db"
  engine         = "mysql"
  engine_version = "8.0"
  instance_class = var.db_instance_class

  allocated_storage = 20
  storage_type      = "gp3"
  storage_encrypted = true

  db_name                     = var.db_name
  username                    = var.db_username
  manage_master_user_password = true

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db.id]
  publicly_accessible    = false
  multi_az               = false # dev: cost over availability (apply -> destroy operation)

  backup_retention_period = 1
  skip_final_snapshot     = true # dev: destroyed after evidence capture
  deletion_protection     = false
  apply_immediately       = true

  tags = {
    Name = "${local.name_prefix}-db"
  }
}
