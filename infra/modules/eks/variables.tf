variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.30"
}

variable "vpc_id" {
  description = "VPC ID where EKS will be deployed"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for EKS control plane and node groups"
  type        = list(string)
}

variable "node_instance_types" {
  description = "Managed node group instance types"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_desired_size" {
  description = "Managed node desired size"
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Managed node min size"
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Managed node max size"
  type        = number
  default     = 4
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
