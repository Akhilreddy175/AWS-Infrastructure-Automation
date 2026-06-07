output "vpc_id" {
  description = "ID of the main VPC"
  value       = aws_vpc.main.id
}
output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}
output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}
output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}
output "bastion_public_ip" {
  description = "Public IP of the Bastion Host — use this to SSH"
  value       = aws_instance.bastion.public_ip
}
output "app_server_private_ip" {
  description = "Private IP of the App Server — connect via Bastion"
  value       = aws_instance.app.private_ip
}
output "rds_endpoint" {
  description = "RDS PostgreSQL connection endpoint"
  value       = aws_db_instance.postgres.endpoint
}
output "rds_port" {
  description = "RDS PostgreSQL port"
  value       = aws_db_instance.postgres.port
}
output "database_name" {
  description = "Name of the PostgreSQL database"
  value       = aws_db_instance.postgres.db_name
}
output "app_iam_role_arn" {
  description = "ARN of the IAM role attached to the app server"
  value       = aws_iam_role.app_server.arn
}
output "ssh_to_bastion" {
  description = "Command to SSH into the Bastion Host"
  value       = "ssh -i ~/.ssh/${var.key_pair_name}.pem ec2-user@${aws_instance.bastion.public_ip}"
}
output "ssh_to_app_via_bastion" {
  description = "Command to SSH into App Server via Bastion (SSH proxy jump)"
  value       = "ssh -i ~/.ssh/${var.key_pair_name}.pem -J ec2-user@${aws_instance.bastion.public_ip} ec2-user@${aws_instance.app.private_ip}"
}
