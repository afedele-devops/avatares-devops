Cruce realizado entre [Hallazgos.md](Hallazgos.md) y [requerimientos de entrega.md](requerimientos%20de%20entrega.md).  
Con base en eso, este es el checklist de hitos para cerrar el examen de entrega.

**Checklist de hitos (en orden recomendado)**

1. Repositorio y gobernanza
- [x] Repositorio público creado y subido.
- [x] Definir estrategia de ramas (main, develop, feature/*) y documentarla.
- [x] Asegurar commits descriptivos de cada hito de entrega. (Ver [docs/process/commit-conventions.md](../docs/process/commit-conventions.md) y hooks en [scripts/git-hooks/](../scripts/git-hooks/))
- [x] Agregar plantilla mínima de Pull Request y checklist de revisión. (Ver [.github/pull_request_template.md](../.github/pull_request_template.md))

2. CI/CD funcional (requisito crítico)
- [x] Crear workflow de CI/CD en .github/workflows/ci-cd.yml. (Ver [.github/workflows/ci-cd.yml](../.github/workflows/ci-cd.yml))
- [x] Job backend: crear venv, instalar dependencias, correr pruebas.
- [x] Job frontend: npm ci + pruebas.
- [x] Job build: construir imágenes Docker.
- [x] Job publish: subir imágenes a registry.
- [x] Job deploy: desplegar a staging.
- [x] Job smoke test post deploy: validar health y endpoint principal.
- [ ] Guardar evidencia de ejecución exitosa del pipeline (capturas o logs).

3. Contenedores y orquestación
- [x] Dockerfiles y compose existen y están bien orientados.
- [x] Crear carpeta k8s con manifests reales: deployment api/web, service api/web, ingress, pvc, configmap, secret. (Ver [k8s/](../k8s/))
- [x] Mantener api en 1 réplica mientras siga SQLite. (Ver [k8s/api-deployment.yaml](../k8s/api-deployment.yaml))
- [x] Configurar probes con ready y health. (Ver [k8s/api-deployment.yaml](../k8s/api-deployment.yaml) y [k8s/web-deployment.yaml](../k8s/web-deployment.yaml))
- [x] Verificar resolución de nombre api desde web en clúster.
- [x] Guardar evidencia de kubectl get pods, svc, ingress y acceso funcional. (Ver [docs/evidencias/k8s/README.md](../docs/evidencias/k8s/README.md))

4. Infraestructura como código (bonus, pero suma fuerte)
- [x] Crear estructura infra para Terraform (modules + envs staging/production). (Ver [infra/](../infra/))
- [x] Definir backend remoto de estado con locking. (Ver [infra/envs/staging/backend.tf](../infra/envs/staging/backend.tf) y [infra/envs/production/backend.tf](../infra/envs/production/backend.tf))
- [x] Declarar providers versionados. (Ver [infra/modules/eks/versions.tf](../infra/modules/eks/versions.tf) y [infra/envs/staging/versions.tf](../infra/envs/staging/versions.tf))
- [x] Crear outputs útiles (endpoint clúster, datos no sensibles). (Ver [infra/envs/staging/outputs.tf](../infra/envs/staging/outputs.tf) y [infra/envs/production/outputs.tf](../infra/envs/production/outputs.tf))
- [ ] (Opcional) Crear chart Helm de la app con templates y values por entorno. No aplica si `k8s/` es la fuente única de despliegue.
- [ ] (Opcional) Probar helm upgrade --install en entorno local de clúster. No aplica si `k8s/` es la fuente única de despliegue.

5. Observabilidad en clúster
- [ ] Desplegar Prometheus y Grafana en Kubernetes.
- [ ] Habilitar scraping de metrics vía annotations en api.
- [ ] Cargar dashboard de avatars en Grafana desde ConfigMap.
- [ ] Guardar evidencia: targets en Prometheus UP y dashboard con métricas reales.

6. Servicio web funcional
- [ ] Validar acceso externo por Ingress.
- [ ] Probar navegación completa (editor, galería, guardar, eliminar).
- [ ] Ejecutar prueba rápida de carga y verificar respuesta estable.

7. Documentación de entrega
- [x] README base ya es fuerte.
- [ ] Añadir sección final de despliegue real paso a paso (local cluster + staging).
- [ ] Añadir sección de arquitectura final con diagrama de componentes.
- [ ] Añadir sección de troubleshooting (fallas típicas y solución).
- [ ] Añadir tabla de evidencias con links/capturas/logs.

8. Evidencias finales para evaluación
- [ ] Capturas del pipeline en verde.
- [ ] Capturas de pods, services, ingress y pvc.
- [ ] Captura de app funcionando en URL de clúster/staging.
- [ ] Captura de Grafana con dashboard de avatars.
- [ ] Logs o reporte de smoke test post deploy.
- [ ] Entregar todo consolidado en README o carpeta docs/evidencias.

**Conclusión de cruce**
- Sí hay base técnica sólida y bien analizada en [Hallazgos.md](Hallazgos.md).
- El mayor gap actual para aprobar entrega completa está en evidencias de ejecución real (pipeline, staging y observabilidad).
- Si completas los hitos 2, 3 y 7 con evidencia, ya cubres el núcleo del examen; 4 y 5 te elevan nota y madurez de entrega.

Si quieres, en el siguiente paso te preparo un plan de ejecución en 2 días con tiempos estimados por hito.

## Plan de ejecución en 2 días (con margen de seguridad +10%)

### Supuestos de planificación

- Ventana de trabajo objetivo: 2 días.
- Capacidad estimada: 8 horas por día (16 horas base).
- Margen de seguridad aplicado: +10% sobre cada bloque.
- Capacidad total planificada con margen: 17.6 horas.

### Estimación por hito

| Hito | Objetivo | Tiempo base | Tiempo con +10% | Entregable verificable |
|---|---|---:|---:|---|
| H1 | Repositorio y gobernanza | 1.0 h | 1.1 h | Estrategia de ramas + plantilla PR + commits ordenados |
| H2 | CI/CD funcional | 4.0 h | 4.4 h | Workflow ejecutando tests, build, publish, deploy y smoke test |
| H3 | Contenedores y orquestación (K8s) | 3.0 h | 3.3 h | Manifests de api/web, services, ingress, pvc, configmap, secret |
| H4 | Infraestructura como código (Terraform) | 2.5 h | 2.8 h | Estructura infra por entorno y backend remoto |
| H5 | Observabilidad en clúster | 2.0 h | 2.2 h | Prometheus/Grafana activos, scrape de /metrics y dashboard cargado |
| H6 | Validación funcional web | 1.0 h | 1.1 h | App accesible por ingress y flujo editor/galería validado |
| H7 | Documentación final | 1.5 h | 1.7 h | README actualizado con despliegue, arquitectura, troubleshooting |
| H8 | Evidencias de evaluación | 1.0 h | 1.1 h | Capturas/logs de pipeline, k8s, grafana y smoke test |
|  | **Total** | **16.0 h** | **17.7 h** | **Entrega completa y trazable** |

Nota: el total con margen queda en 17.7 h por redondeos. Es consistente con una ventana de 2 días exigente pero alcanzable.

### Agenda recomendada por día

#### Día 1 (objetivo: cerrar base técnica)

1. Bloque 1 (2.2 h): H1 + arranque de H2.
	- Definir ramas y plantilla PR.
	- Crear workflow base con jobs backend/frontend.
2. Bloque 2 (2.2 h): H2 completo (build, publish, deploy, smoke test).
	- Dejar pipeline en verde en rama principal.
3. Bloque 3 (2.2 h): H3 (manifests Kubernetes).
	- Asegurar service api para resolución desde web.
	- Configurar probes y pvc.
4. Bloque 4 (2.2 h): H6 + validación parcial H5.
	- Probar acceso por ingress y flujo funcional.
	- Verificar endpoint /metrics visible para scrape.

**Cierre Día 1 esperado**
- Pipeline funcional en ejecución.
- App desplegable en Kubernetes.
- Flujo funcional validado.

#### Día 2 (objetivo: cerrar madurez de entrega)

1. Bloque 1 (2.8 h): H4 (Terraform mínimo viable).
	- Estructura de módulos/envs.
	- Backend remoto y outputs por entorno.
2. Bloque 2 (2.2 h): H5 completo.
	- Instalar kube-prometheus-stack.
	- Cargar dashboard de avatars y validar targets.
3. Bloque 3 (1.7 h): H7 documentación final.
	- README con guía de despliegue y arquitectura final.
4. Bloque 4 (1.1 h): H8 evidencias.
	- Capturas y logs consolidados en docs/evidencias.
5. Bloque de contingencia (aprox. 1.0 h): correcciones finales.
	- Ajustes de pipeline, manifests o permisos de registry.

**Cierre Día 2 esperado**
- Entrega completa con evidencia técnica.
- Documentación replicable por terceros.
- Riesgo de rechazo significativamente reducido.

### Criterios de aceptación al finalizar las 48 horas

- CI/CD ejecuta pruebas y build sin intervención manual.
- Despliegue en clúster operativo con acceso por ingress.
- Observabilidad funcional (Prometheus + Grafana + dashboard).
- Infraestructura como código presentada (Terraform).
- Evidencias completas y organizadas.

### Riesgos y mitigación rápida

1. Fallas de credenciales de registry en pipeline.
	- Mitigación: validar secrets al inicio de H2.
2. Problemas de ingress o DNS local.
	- Mitigación: usar host temporal y prueba por port-forward si bloquea.
3. Scrape de métricas no detectado.
	- Mitigación: revisar annotations y targets en Prometheus antes de cerrar H5.
4. Tiempo justo en documentación.
	- Mitigación: documentar incrementalmente al cerrar cada hito, no al final.

### Recomendación de ejecución

Priorizar H2, H3 y H7 como núcleo de aprobación. H4 y H5 elevan la calidad final y la nota. Si surge un bloqueo fuerte, preservar primero evidencia de funcionamiento end-to-end (pipeline + despliegue + prueba funcional), luego completar bonus.
