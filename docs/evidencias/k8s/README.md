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

En este entorno, `kubectl` existe pero no hay conexión activa al clúster configurado.

Archivos de salida generados:

- `docs/evidencias/k8s/get-pods.txt`
- `docs/evidencias/k8s/get-svc.txt`
- `docs/evidencias/k8s/get-ingress.txt`
- `docs/evidencias/k8s/dry-run.txt`

Estos archivos muestran rechazo de conexión al API server (`127.0.0.1:33025`), por lo que la validación funcional en clúster queda pendiente.

## Pendiente para cerrar el hito al 100%

1. Conectar `kubectl` a un clúster activo (kind/minikube/k3s o staging).
2. Ejecutar y guardar evidencia de:
   - `kubectl -n avatares get pods`
   - `kubectl -n avatares get svc`
   - `kubectl -n avatares get ingress`
3. Verificar acceso funcional por ingress (curl o navegador).
