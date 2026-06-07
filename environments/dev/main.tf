resource "aws_iam_role" "app_server" {
  name = "${var.project_name}-${var.environment}-app-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRole"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.app_server.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
resource "aws_iam_instance_profile" "app_server" {
  name = "${var.project_name}-${var.environment}-app-profile"
  role = aws_iam_role.app_server.name
}
module "vpc" {
  source = "../../modules/vpc"
  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  enable_nat_gateway   = true
}
module "security_groups" {
  source = "../../modules/security-groups"
  project_name     = var.project_name
  environment      = var.environment
  vpc_id           = module.vpc.vpc_id
  allowed_ssh_cidr = var.allowed_ssh_cidr
}
module "ec2" {
  source = "../../modules/ec2"
  project_name          = var.project_name
  environment           = var.environment
  public_subnet_id      = module.vpc.public_subnet_ids[0]
  private_subnet_id     = module.vpc.private_subnet_ids[0]
  bastion_sg_id         = module.security_groups.bastion_sg_id
  app_sg_id             = module.security_groups.app_sg_id
  iam_instance_profile  = aws_iam_instance_profile.app_server.name
  key_pair_name         = var.key_pair_name
  app_instance_type     = var.app_instance_type
}
module "rds" {
  source = "../../modules/rds"
  project_name       = var.project_name
  environment        = var.environment
  private_subnet_ids = module.vpc.private_subnet_ids
  rds_sg_id          = module.security_groups.rds_sg_id
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  db_instance_class  = var.db_instance_class
  backup_retention    = 0
  multi_az            = false
  deletion_protection = false
  storage_encrypted   = false
}
