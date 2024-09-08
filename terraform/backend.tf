# backend.tf

# Configure the S3 backend for Terraform state and locking
terraform {
  backend "s3" {
    bucket         = "unzer_test-terraform-state-bucket"
    key            = "terraform/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}