output "bastion_sg_id" {
  description = "Security group ID for the Bastion host."
  value       = aws_security_group.bastion.id
}
output "app_sg_id" {
  description = "Security group ID for the Application server."
  value       = aws_security_group.app.id
}
output "rds_sg_id" {
  description = "Security group ID for the RDS database."
  value       = aws_security_group.rds.id
}
