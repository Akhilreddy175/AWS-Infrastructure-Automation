variable "project_name" {
  description = "Name of the project. Used in resource naming and tags."
  type        = string
  default     = "job-tracker"
}
variable "environment" {
  description = "Deployment environment. Controls sizing, count, and settings."
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "production"], var.environment)
    error_message = "Environment must be one of: dev, staging, production."
  }
}
variable "aws_region" {
  description = "AWS region to deploy all resources."
  type        = string
  default     = "us-east-1"
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC. Must be /16 for our subnet layout."
  type        = string
  default     = "10.0.0.0/16"
}
variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (one per AZ). Houses bastion and NAT GW."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets (one per AZ). Houses app and DB."
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}
variable "availability_zones" {
  description = "List of AZs to deploy subnets. Must match subnet CIDR count."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
variable "app_instance_type" {
  description = "EC2 instance type for the application server."
  type        = string
  default     = "t3.micro"
}
variable "key_pair_name" {
  description = "Name of the EC2 Key Pair for SSH access. Must exist in AWS already."
  type        = string
  default     = "devops-key"
}
variable "db_name" {
  description = "Name of the PostgreSQL database to create."
  type        = string
  default     = "jobtracker"
}
variable "db_username" {
  description = "Master username for the RDS instance."
  type        = string
  default     = "dbadmin"
}
variable "db_password" {
  description = "Master password for the RDS instance. Use a secrets manager in production."
  type        = string
  sensitive   = true
}
variable "db_instance_class" {
  description = "RDS instance class. db.t3.micro is free tier eligible."
  type        = string
  default     = "db.t3.micro"
}
variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH into the bastion host."
  type        = string
  default     = "0.0.0.0/0"
}
