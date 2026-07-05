terraform {
  backend "s3" {
    bucket         = "REPLACE_ME_TF_STATE_BUCKET"
    key            = "avatares-devops/production/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "REPLACE_ME_TF_LOCKS_TABLE"
    encrypt        = true
  }
}
