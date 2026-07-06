output "cluster_name" {
  description = "Production cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Production cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_version" {
  description = "Production cluster Kubernetes version"
  value       = module.eks.cluster_version
}

output "oidc_provider_arn" {
  description = "Production OIDC provider ARN"
  value       = module.eks.oidc_provider_arn
}
