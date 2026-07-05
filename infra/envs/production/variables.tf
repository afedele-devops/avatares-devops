variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "avatares-production"
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.30"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "node_instance_types" {
  description = "Node instance types"
  type        = list(string)
  default     = ["t3.large"]
}

variable "node_desired_size" {
  description = "Node desired size"
  type        = number
  default     = 3
}

variable "node_min_size" {
  description = "Node min size"
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Node max size"
  type        = number
  default     = 6
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    project     = "avatares-devops"
    environment = "production"
    managed_by  = "terraform"
  }
}
