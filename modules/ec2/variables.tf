variable "project_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "public_subnet_id" {
  type        = string
  description = "Public subnet for Bastion."
}
variable "private_subnet_id" {
  type        = string
  description = "Private subnet for App Server."
}
variable "bastion_sg_id" {
  type        = string
  description = "Security group ID for Bastion."
}
variable "app_sg_id" {
  type        = string
  description = "Security group ID for App Server."
}
variable "iam_instance_profile" {
  type        = string
  description = "IAM instance profile name for App Server."
}
variable "key_pair_name" {
  type        = string
  description = "EC2 Key Pair name for SSH access."
}
variable "app_instance_type" {
  type    = string
  default = "t3.micro"
}
variable "bastion_instance_type" {
  type    = string
  default = "t3.micro"
}
