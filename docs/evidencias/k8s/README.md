# Evidencias Kubernetes (avance de orquestación)

## Estado actual

Se creó la carpeta `k8s/` con manifests reales para:

- `api` Deployment
- `web` Deployment
- `api` Service
- `web` Service
- `Ingress`
- `PersistentVolumeClaim`
- `ConfigMap`
- `Secret`
- `kustomization.yaml`

Además, se agregó el overlay `k8s/observability/` con:

- Prometheus en Kubernetes.
- Grafana en Kubernetes.
- Scrape de pods vía annotations `prometheus.io/scrape`, `prometheus.io/path` y `prometheus.io/port`.
- Provisioning de datasource de Prometheus en Grafana.
- Carga del dashboard `avatars` desde ConfigMap.

## Validaciones implementadas en manifests

- `api` se define con `replicas: 1` por uso de SQLite.
- `api` usa probes:
  - readiness: `/ready`
  - liveness: `/health`
- `web` usa probes sobre endpoints proxiados por nginx:
  - readiness: `/ready`
  - liveness: `/health`
- `web` resuelve a `api` por nombre de service (`api`) para el proxy reverso.

## Evidencia de ejecución de comandos kubectl

`kubectl` ya está conectado al clúster de staging.

Archivos de salida generados:

- `docs/evidencias/k8s/get-pods.txt`
- `docs/evidencias/k8s/get-svc.txt`
- `docs/evidencias/k8s/get-ingress.txt`
- `docs/evidencias/k8s/dry-run.txt`
- `docs/evidencias/k8s/get-ingressclass.txt`
- `docs/evidencias/k8s/get-ingress-nginx-controller-svc.txt`
- `docs/evidencias/k8s/get-ingress-staging.txt`
- `docs/evidencias/k8s/get-nodes-staging.txt`
- `docs/evidencias/k8s/get-pods-staging.txt`
- `docs/evidencias/k8s/get-svc-staging.txt`
- `docs/evidencias/k8s/get-pvc-staging.txt`
- `docs/evidencias/k8s/get-observability-pods.txt`
- `docs/evidencias/k8s/curl-health-staging.txt`
- `docs/evidencias/k8s/curl-avatar-spec-staging.txt`
- `docs/evidencias/k8s/describe-api-pod.txt`
- `docs/evidencias/k8s/describe-web-pod.txt`
- `docs/evidencias/k8s/describe-pvc-api-data.txt`
- `docs/evidencias/k8s/describe-ebs-csi-controller.txt`
- `docs/evidencias/k8s/logs-ebs-csi-ebs-plugin.txt`
- `docs/evidencias/k8s/logs-ebs-csi-provisioner.txt`

Observación:

- En `-n avatares` no hay recursos (namespace vacío).
- El despliegue actual se realizó en `-n avatares-staging` (como define el pipeline con `STAGING_NAMESPACE`).
- Ya existe `IngressClass nginx` y `Service ingress-nginx-controller` tipo `LoadBalancer`.
- El Ingress de la app ya tiene `ADDRESS` (hostname de ELB).
- `prometheus` y `grafana` ya corren en el namespace `avatares-staging`.
- Add-on `aws-ebs-csi-driver` instalado y activo en EKS.
- `api-data-pvc` ya está `Bound` con `storageClassName: gp2`.
- `prometheus` y `grafana` están `Running`.
- `api` y `web` siguen en `ImagePullBackOff`, pero ahora el error principal es `NotFound` del tag `latest` en GHCR (ya no es `403`).
- El secret `ghcr-secret` ya existe en `avatares-staging` y los deployments ya lo referencian.
- Imágenes referenciadas:
  - `ghcr.io/afedele-devops/avatares-api:latest`
  - `ghcr.io/afedele-devops/avatares-web:latest`

## Validación de observabilidad

Con clúster disponible, ejecutar y guardar evidencia de:

- `kubectl -n avatares-staging get pods | grep -E 'prometheus|grafana|api'`
- `kubectl -n avatares-staging get svc`
- `kubectl -n avatares-staging get ingress`
- Prometheus con targets en estado `UP`.
- Grafana con el dashboard de Avatares mostrando métricas reales.

## Pendiente para cerrar el hito al 100%

1. Mantener `STAGING_URL` con el hostname del ELB del Ingress (ya existe), pero actualmente responde `503`.
2. Desbloquear imágenes privadas en GHCR:
  - Publicar (o volver a publicar) los tags `latest` de:
    - `ghcr.io/afedele-devops/avatares-api`
    - `ghcr.io/afedele-devops/avatares-web`
  - Alternativa: cambiar los deployments a un tag existente (`sha-...`) si no usarás `latest`.
3. Verificar acceso funcional por ingress (curl o navegador):
   - `GET $STAGING_URL/health`
   - `GET $STAGING_URL/api/avatar/spec`
4. Validar observabilidad:
   - `kubectl -n avatares-staging get pods | grep -E 'prometheus|grafana|api'`
   - Prometheus targets en `UP`.
   - Dashboard de Avatares mostrando métricas reales.

## Desbloqueo GHCR con imagePullSecrets

Se agregó `imagePullSecrets` en los deployments `api` y `web` apuntando a `ghcr-secret`.

Estado actual del pull:

- `403` resuelto.
- Error vigente: `ghcr.io/...:latest: not found`.

Crear el secret en staging (reemplaza valores):

```bash
kubectl -n avatares-staging create secret docker-registry ghcr-secret \
  --docker-server=ghcr.io \
  --docker-username=<GITHUB_USER> \
  --docker-password=<GITHUB_TOKEN_CON_READ_PACKAGES> \
  --docker-email=<EMAIL>
```

Aplicar manifests y reiniciar pods:

```bash
kubectl -n avatares-staging apply -k k8s/
kubectl -n avatares-staging rollout restart deployment/api deployment/web
kubectl -n avatares-staging rollout status deployment/api
kubectl -n avatares-staging rollout status deployment/web
```
