variable "project_name" { type = string }
variable "environment"  { type = string }
variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnets for DB subnet group (2+ AZs required)."
}
variable "rds_sg_id" {
  type        = string
  description = "Security group ID for RDS."
}
variable "db_name" {
  type    = string
  default = "appdb"
}
variable "db_username" {
  type    = string
  default = "dbadmin"
}
variable "db_password" {
  type      = string
  sensitive = true
}
variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}
variable "engine_version" {
  type    = string
  default = "16.14"
}
variable "backup_retention" {
  type        = number
  default     = 0
  description = "Days of backups. 0 = disabled (free tier). Set 7 for production."
}
variable "multi_az" {
  type        = bool
  default     = false
  description = "Enable Multi-AZ for production HA."
}
variable "deletion_protection" {
  type        = bool
  default     = false
  description = "Prevent accidental deletion. Set true in production."
}
variable "storage_encrypted" {
  type        = bool
  default     = false
  description = "Encrypt storage. Set true for production (paid accounts)."
}
