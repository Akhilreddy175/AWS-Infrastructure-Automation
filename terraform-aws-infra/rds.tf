resource "aws_db_subnet_group" "main" {
  name        = "${var.project_name}-${var.environment}-db-subnet-group"
  description = "Subnet group for RDS - spans all private subnets"
  subnet_ids  = aws_subnet.private[*].id
  tags = {
    Name = "${var.project_name}-${var.environment}-db-subnet-group"
  }
}
resource "aws_db_instance" "postgres" {
  identifier = "${var.project_name}-${var.environment}-db"
  engine         = "postgres"
  engine_version = "16.14"
  instance_class = var.db_instance_class
  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp2"
  storage_encrypted     = false
  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false
  multi_az          = false
  availability_zone = var.availability_zones[0]
  backup_retention_period = 0
  backup_window           = "03:00-04:00"
  maintenance_window      = "sun:04:00-sun:05:00"
  skip_final_snapshot = true
  deletion_protection = false
  performance_insights_enabled = false
  tags = {
    Name = "${var.project_name}-${var.environment}-postgres"
  }
}
