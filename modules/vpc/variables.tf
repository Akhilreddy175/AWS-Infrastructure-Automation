variable "project_name" {
  description = "Project name used in all resource names and tags."
  type        = string
}
variable "environment" {
  description = "Environment name: dev, staging, or production."
  type        = string
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC (e.g. 10.0.0.0/16)."
  type        = string
  default     = "10.0.0.0/16"
}
variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets — one per AZ."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets — one per AZ."
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}
variable "availability_zones" {
  description = "List of AZs to deploy subnets into."
  type        = list(string)
}
variable "enable_nat_gateway" {
  description = "Set to false to skip NAT Gateway creation (saves cost in dev/test)."
  type        = bool
  default     = true
}
