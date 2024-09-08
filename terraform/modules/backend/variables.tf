variable "s3_bucket_name" {
  description = "The name of the S3 bucket for storing Terraform state."
  type        = string
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table for locking Terraform state."
  type        = string
}
