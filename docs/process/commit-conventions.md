# Convención de commits descriptivos

Este documento define cómo redactar commits para que cada hito de entrega sea trazable y fácil de revisar.

## Objetivo

- Mantener historial legible.
- Identificar rápido el alcance de cada cambio.
- Facilitar revisión, auditoría y rollback.

## Formato obligatorio

Usar el siguiente formato en la primera línea del commit:

`tipo(scope): resumen en minúsculas`

Ejemplos válidos:

- `feat(ci): agrega workflow base de pruebas`
- `fix(api): corrige validación de parámetros de avatar`
- `docs(process): documenta estrategia de ramas`
- `chore(repo): agrega plantilla de pull request`

## Tipos permitidos

- `feat`: nueva funcionalidad
- `fix`: corrección de bug
- `docs`: documentación
- `refactor`: mejora interna sin cambiar comportamiento externo
- `test`: cambios en pruebas
- `chore`: tareas de mantenimiento
- `ci`: cambios en CI/CD
- `build`: cambios de build o dependencias
- `perf`: mejora de rendimiento
- `revert`: revert de cambios

## Reglas mínimas

- El resumen debe ser claro y específico.
- Evitar mensajes genéricos como `update`, `fix`, `wip` o `cambios`.
- Un commit debe contener un cambio coherente.
- Preferir commits pequeños por hito funcional.

## Relación con los hitos de entrega

Cada hito del checklist debe quedar reflejado por uno o más commits descriptivos. Ejemplos:

- H1 gobernanza: `docs(process): agrega convención de commits`
- H2 CI/CD: `ci(workflows): agrega pipeline con tests y build`
- H3 Kubernetes: `feat(k8s): agrega manifests de api y web`

## Validación automática

El repositorio incluye un hook `scripts/git-hooks/commit-msg` para validar el formato antes de aceptar commits.

Para instalar hooks localmente:

```bash
./scripts/git-hooks/install-hooks.sh
```
