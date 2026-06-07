terraform {
  backend "s3" {
    bucket = "job-tracker-terraform-state-926634327265"
    key = "job-tracker/dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
}
