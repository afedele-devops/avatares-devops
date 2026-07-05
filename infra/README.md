# Infraestructura como codigo (Terraform)

Estructura:

- `infra/bootstrap`: stack Terraform para crear backend remoto (S3 + DynamoDB).
- `infra/modules/eks`: modulo reusable para cluster EKS.
- `infra/envs/staging`: entorno staging.
- `infra/envs/production`: entorno production.

Despliegue Kubernetes:

- `k8s/`: fuente unica de manifiestos para entorno local y despliegue en EKS.

## Backend remoto con locking

Cada entorno define un bloque minimo `backend "s3" {}` en `backend.tf`.
Los valores reales del backend remoto se inyectan en `terraform init` con `-backend-config=...`.

Flujo recomendado:

1. Ejecutar `infra/bootstrap` para crear bucket y tabla de locking.
2. Inicializar cada entorno con `terraform init -reconfigure -backend-config=...`.
3. Ejecutar plan/apply del entorno (`staging` o `production`).

## Uso rapido

```bash
cd infra/bootstrap
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply

cd infra/envs/staging
cp terraform.tfvars.example terraform.tfvars
terraform init -reconfigure \
	-backend-config="bucket=<STATE_BUCKET>" \
	-backend-config="key=avatares-devops/staging/terraform.tfstate" \
	-backend-config="region=<AWS_REGION>" \
	-backend-config="dynamodb_table=<LOCKS_TABLE>" \
	-backend-config="encrypt=true"
terraform plan
terraform apply
```

El mismo patron aplica a `production`, cambiando solo la key del state.

Repetir en `infra/envs/production` con los valores del entorno.

Para desplegar la aplicacion en el clúster EKS de staging:

```bash
kubectl get ns avatares-staging >/dev/null 2>&1 || kubectl create ns avatares-staging
kubectl -n avatares-staging apply -k k8s/
```
