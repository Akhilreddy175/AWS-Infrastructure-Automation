output "vpc_id"              { value = module.vpc.vpc_id }
output "bastion_public_ip"   { value = module.ec2.bastion_public_ip }
output "app_private_ip"      { value = module.ec2.app_private_ip }
output "rds_endpoint"        { value = module.rds.db_endpoint }
output "ssh_to_bastion"      { value = module.ec2.ssh_to_bastion }
output "ssh_to_app"          { value = module.ec2.ssh_to_app }
