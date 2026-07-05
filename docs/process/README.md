# Documentación de proceso del proyecto
Este directorio agrupa la documentación de proceso del proyecto.

# 1. Repositorio y gobernanza
Estrategia de ramas, flujo de trabajo y reglas de gobernanza del repositorio.

- Definir estrategia de ramas (main, develop, feature/*) y documentarla.
- Plantilla minima de Pull Request y checklist de revisión.

### Referencia principal

- [Estrategia de ramas](./branching-strategy.md)
- [Convención de commits descriptivos](./commit-conventions.md)
- [Plantilla mínima de Pull Request](../../.github/pull_request_template.md)
- [Plantilla de bug report](../../.github/ISSUE_TEMPLATE/bug_report.md)
- [Plantilla de feature request](../../.github/ISSUE_TEMPLATE/feature_request.md)

# 2. CI/CD funcional (requisito crítico)

- Crear workflow de CI/CD

### Referencia principal
- [Workflow CI/CD](../../.github/workflows/ci-cd.yml)

# 3. Contenedores y orquestación

- Crear carpeta k8s con manifests reales: deployment api/web, service api/web, ingress, pvc, configmap, secret. 
- Mantener api en 1 réplica mientras siga SQLite.
- Configurar probes con ready y health.
- Verificar resolución de nombre api desde web en clúster.
- Guardar evidencia de kubectl get pods, svc, ingress y acceso funcional.

### Referencia principal

- [Deployment API](../../k8s/api-deployment.yaml)
- [Deployment Web](../../k8s/web-deployment.yaml)
- [Service API](../../k8s/api-service.yaml)
- [Service Web](../../k8s/web-service.yaml)
- [Ingress](../../k8s/ingress.yaml)
- [PVC](../../k8s/pvc.yaml)
- [ConfigMap](../../k8s/configmap.yaml)
- [Secret](../../k8s/secret.yaml)
- [Kustomization](../../k8s/kustomization.yaml)
- [Evidencia kubectl (dry-run, pods, svc, ingress)](../../docs/evidencias/k8s/README.md)