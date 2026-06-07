output "bastion_public_ip" {
  description = "Public IP of the Bastion host."
  value       = aws_instance.bastion.public_ip
}
output "app_private_ip" {
  description = "Private IP of the App server."
  value       = aws_instance.app.private_ip
}
output "bastion_instance_id" {
  description = "Instance ID of the Bastion host."
  value       = aws_instance.bastion.id
}
output "app_instance_id" {
  description = "Instance ID of the App server."
  value       = aws_instance.app.id
}
output "ssh_to_bastion" {
  description = "Ready-to-use SSH command for Bastion."
  value       = "ssh -i ~/.ssh/${var.key_pair_name}.pem ec2-user@${aws_instance.bastion.public_ip}"
}
output "ssh_to_app" {
  description = "SSH via Bastion jump to App server."
  value       = "ssh -i ~/.ssh/${var.key_pair_name}.pem -J ec2-user@${aws_instance.bastion.public_ip} ec2-user@${aws_instance.app.private_ip}"
}
