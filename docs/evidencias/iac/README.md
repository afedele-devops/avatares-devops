# Evidencias IaC (Terraform)

## Terraform

Se validaron ambos entornos con backend desactivado para pruebas locales:

- `infra/envs/staging`: `terraform init -backend=false` y `terraform validate`.
- `infra/envs/production`: `terraform init -backend=false` y `terraform validate`.

Archivos de evidencia:

- `docs/evidencias/iac/terraform-fmt.txt`
- `docs/evidencias/iac/terraform-validate-staging.txt`
- `docs/evidencias/iac/terraform-validate-production.txt`

## Estado

- Terraform: valido en staging y production.
