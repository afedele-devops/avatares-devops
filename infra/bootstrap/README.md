# Terraform bootstrap (backend remoto)

Este stack crea los recursos base para backend remoto de Terraform:

- Bucket S3 para state.
- Tabla DynamoDB para locking.

## Uso

1. Ir al directorio:

```bash
cd infra/bootstrap
```

2. Preparar variables:

```bash
cp terraform.tfvars.example terraform.tfvars
```

3. Inicializar y aplicar:

```bash
terraform init
terraform plan
terraform apply
```

4. Tomar outputs y usarlos en init de staging/production:

```bash
cd ../envs/staging
terraform init -reconfigure \
  -backend-config="bucket=<STATE_BUCKET>" \
  -backend-config="key=avatares-devops/staging/terraform.tfstate" \
  -backend-config="region=<AWS_REGION>" \
  -backend-config="dynamodb_table=<LOCKS_TABLE>" \
  -backend-config="encrypt=true"
```

Nota: este stack usa backend local por diseno para resolver el bootstrap.

Los archivos `infra/envs/*/backend.tf` solo contienen `backend "s3" {}`.
No se usan `tfvars` para configurar el backend remoto; Terraform requiere pasar esos valores durante `terraform init`.
