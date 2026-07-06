output "cluster_name" {
  description = "Staging cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Staging cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_version" {
  description = "Staging cluster Kubernetes version"
  value       = module.eks.cluster_version
}

output "oidc_provider_arn" {
  description = "Staging OIDC provider ARN"
  value       = module.eks.oidc_provider_arn
}
