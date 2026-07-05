variable "aws_region" {
  description = "AWS region for Terraform backend resources"
  type        = string
  default     = "us-east-1"
}

variable "state_bucket_name" {
  description = "S3 bucket name for Terraform state"
  type        = string
}

variable "locks_table_name" {
  description = "DynamoDB table name for Terraform state locking"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    project    = "avatares-devops"
    managed_by = "terraform"
    scope      = "bootstrap"
  }
}
