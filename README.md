# AWS Infrastructure Automation

Automated AWS infrastructure using Terraform + Jenkins CI/CD.

## Architecture
- **VPC** with public/private subnets across 2 AZs
- **Bastion Host** for secure SSH access
- **App Server** in private subnet
- **RDS PostgreSQL** in private subnet
- **Jenkins** CI/CD pipeline with approval gate

## Pipeline Stages
1. Verify Tools (terraform + aws cli)
2. Terraform Init (S3 backend)
3. Terraform Validate
4. Terraform Plan
5. Approval Gate (manual review)
6. Terraform Apply

## Webhook Test
Last triggered: 2026-06-07 22:21 IST

