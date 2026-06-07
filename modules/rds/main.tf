locals { name_prefix = "${var.project_name}-${var.environment}" }
resource "aws_db_subnet_group" "this" {
  name        = "${local.name_prefix}-db-subnet-group"
  description = "Subnet group for ${local.name_prefix} RDS - spans private subnets"
  subnet_ids  = var.private_subnet_ids
  tags        = { Name = "${local.name_prefix}-db-subnet-group" }
}
resource "aws_db_instance" "postgres" {
  identifier     = "${local.name_prefix}-db"
  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.db_instance_class
  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp2"
  storage_encrypted     = var.storage_encrypted
  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.rds_sg_id]
  publicly_accessible    = false
  multi_az              = var.multi_az
  availability_zone     = var.multi_az ? null : "us-east-1a"
  backup_retention_period = var.backup_retention
  backup_window           = "03:00-04:00"
  maintenance_window      = "sun:04:00-sun:05:00"
  skip_final_snapshot = true
  deletion_protection = var.deletion_protection
  tags = { Name = "${local.name_prefix}-postgres" }
}
