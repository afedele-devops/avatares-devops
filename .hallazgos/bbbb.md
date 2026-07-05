Voy a revisar el workflow actual y contrastarlo contra su lógica de ejecución real para decirte si funciona tal como está o si tiene bloqueos de GitHub Actions.

Read [](file:///home/antonio/Codigo%20Facilito/Bootcamp%20de%20DevOps/Clase%207%20-%20Proyecto%20final%20/avatares-devops/.github/workflows/ci-cd.yml)

Voy a corregir el único bloqueo claro de funcionalidad del workflow: la condición del job de despliegue usa `secrets` en `if`, lo que puede romper la evaluación del pipeline. Después revalido la lógica.

Generating patch (25 lines) in [](file:///home/antonio/Codigo%20Facilito/Bootcamp%20de%20DevOps/Clase%207%20-%20Proyecto%20final%20/avatares-devops/.github/workflows/ci-cd.yml)


```

```
Ya corregí el bloqueo principal. Ahora verifico que el YAML siga limpio y te digo con precisión si quedó funcional o si aún depende de variables/secrets externos.

Checked [](file:///home/antonio/Codigo%20Facilito/Bootcamp%20de%20DevOps/Clase%207%20-%20Proyecto%20final%20/avatares-devops/.github/workflows/ci-cd.yml), no problems found

Sí, ahora el workflow está **funcional a nivel de lógica de GitHub Actions** para el flujo que diseñaste, y ya no tiene el bloqueo de sintaxis/expresión que tenía antes.

Lo que validé en ​.github/workflows/ci-cd.yml:
- El job de backend crea `venv`, instala dependencias y corre `pytest`.
- El job de frontend hace `npm ci` y ejecuta pruebas.
- El job de build construye las imágenes Docker.
- El job de publish publica en GHCR solo en `push` a `main`.
- El job de deploy quedó corregido para no usar `secrets` en el `if`, que era el punto inválido.
- El smoke test valida `/health` y `/api/avatar/spec`.
- El archivo quedó sin errores de sintaxis según la validación del editor.

Lo que sigue siendo requisito externo para que corra end-to-end:
- definir el secreto `KUBE_CONFIG` en el repo para despliegue a staging;
- definir la variable `STAGING_URL` para el smoke test;
- tener la carpeta `k8s/` con manifests válidos y apuntando a imágenes correctas;
- ejecutar el workflow en `push` a `main` para activar publish/deploy.

Conclusión práctica:  
- **Sí funciona** para CI, build y publicación en `main`.  
- **Sí funciona** para deploy y smoke test **si** agregas los secrets/vars y los manifests de Kubernetes.  
- En `pull_request` solo correrán tests y build, que es el comportamiento esperado.

Si quieres, el siguiente paso es revisar si los manifests en `k8s/` están listos para que el job de deploy también quede realmente operativo.

Made changes.





----------------------------------


Voy a auditar los manifests k8s específicamente contra lo que exige el job `deploy-staging` del workflow para confirmar si el deploy puede funcionar sin ajustes adicionales.

Read [](file:///home/antonio/Codigo%20Facilito/Bootcamp%20de%20DevOps/Clase%207%20-%20Proyecto%20final%20/avatares-devops/.github/workflows/ci-cd.yml)

Read [](file:///home/antonio/Codigo%20Facilito/Bootcamp%20de%20DevOps/Clase%207%20-%20Proyecto%20final%20/avatares-devops/k8s/kustomization.yaml)

Read [](file:///home/antonio/Codigo%20Facilito/Bootcamp%20de%20DevOps/Clase%207%20-%20Proyecto%20final%20/avatares-devops/k8s/namespace.yaml)

Read [](file:///home/antonio/Codigo%20Facilito/Bootcamp%20de%20DevOps/Clase%207%20-%20Proyecto%20final%20/avatares-devops/k8s/api-deployment.yaml)

Read [](file:///home/antonio/Codigo%20Facilito/Bootcamp%20de%20DevOps/Clase%207%20-%20Proyecto%20final%20/avatares-devops/k8s/web-deployment.yaml)

Read [](file:///home/antonio/Codigo%20Facilito/Bootcamp%20de%20DevOps/Clase%207%20-%20Proyecto%20final%20/avatares-devops/k8s/ingress.yaml)

Read [](file:///home/antonio/Codigo%20Facilito/Bootcamp%20de%20DevOps/Clase%207%20-%20Proyecto%20final%20/avatares-devops/k8s/api-service.yaml)

Read [](file:///home/antonio/Codigo%20Facilito/Bootcamp%20de%20DevOps/Clase%207%20-%20Proyecto%20final%20/avatares-devops/k8s/web-service.yaml)

Read [](file:///home/antonio/Codigo%20Facilito/Bootcamp%20de%20DevOps/Clase%207%20-%20Proyecto%20final%20/avatares-devops/k8s/configmap.yaml)

Read [](file:///home/antonio/Codigo%20Facilito/Bootcamp%20de%20DevOps/Clase%207%20-%20Proyecto%20final%20/avatares-devops/k8s/pvc.yaml)

Read [](file:///home/antonio/Codigo%20Facilito/Bootcamp%20de%20DevOps/Clase%207%20-%20Proyecto%20final%20/avatares-devops/k8s/secret.yaml)

No están listos al 100% para que el job de deploy sea realmente operativo en su estado actual.

**Hallazgos críticos**
1. El workflow aplica manifests con `-f` pero el directorio incluye un kustomization.
- En ​.github/workflows/ci-cd.yml se usa `kubectl -n ... apply -f k8s/`.
- En kustomization.yaml tienes un recurso de tipo `Kustomization`.
- Con `apply -f` ese archivo se intenta aplicar como recurso Kubernetes y suele fallar.
- Para ese layout, debe usarse `kubectl apply -k k8s`.

2. Desalineación de namespace entre workflow y manifests.
- El workflow usa `STAGING_NAMESPACE` (por defecto `avatares-staging`) en ​.github/workflows/ci-cd.yml.
- Los recursos están hardcodeados en namespace `avatares` en:
  - api-deployment.yaml
  - web-deployment.yaml
  - api-service.yaml
  - web-service.yaml
  - configmap.yaml
  - pvc.yaml
  - secret.yaml
  - ingress.yaml
- Resultado: el job puede “pasar” pero consultando pods en un namespace distinto al de los recursos desplegados.

**Lo que sí está bien**
- Manifests requeridos existen y cubren deployment api/web, services, ingress, pvc, configmap y secret.
- api en 1 réplica por SQLite está correcto en api-deployment.yaml.
- Probes `/ready` y `/health` están configurados.

**Recomendación mínima para dejar deploy operativo**
1. Cambiar en ​.github/workflows/ci-cd.yml:
- de `kubectl ... apply -f k8s/`
- a `kubectl apply -k k8s`

2. Unificar namespace:
- Opción A: dejar todo en `avatares` y fijar `STAGING_NAMESPACE=avatares`.
- Opción B: quitar `metadata.namespace` de los manifests namespaced y usar el namespace del workflow.

Si quieres, te lo corrijo ahora mismo en el workflow con la opción A (más rápida para entrega).