output "aws_region" {
  description = "AWS region in use"
  value       = var.aws_region
}

output "state_bucket_name" {
  description = "S3 bucket name for remote state"
  value       = aws_s3_bucket.tf_state.id
}

output "locks_table_name" {
  description = "DynamoDB table for state locks"
  value       = aws_dynamodb_table.tf_locks.name
}
