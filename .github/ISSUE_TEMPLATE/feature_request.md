# Titulo de la feature

Describe la funcionalidad en una frase corta y clara.

## Resumen

Que se quiere lograr con esta feature y por que es importante para el proyecto o para la entrega.

## Problema actual

Explica que limitacion existe hoy.

- Situacion actual:
- Impacto:
- Riesgo de no resolverlo:

## Solucion propuesta

Describe la implementacion esperada en terminos funcionales y tecnicos.

- Cambio principal:
- Componentes afectados (api, web, k8s, ci/cd, docs):
- Resultado esperado:

## Alcance

### Incluye

-

### No incluye

-

## Criterios de aceptacion

- [ ] La funcionalidad cumple el objetivo descrito.
- [ ] No rompe funcionalidades existentes.
- [ ] Tiene pruebas o validacion manual documentada.
- [ ] Incluye actualizacion de documentacion si aplica.

## Estrategia de rama (obligatorio)

Segun la estrategia definida en `main/develop/feature/*`, esta feature debe trabajarse en una rama `feature/*` creada desde `develop`.

- Rama sugerida: `feature/<tema-corto>`
- Rama base del PR: `develop`
- Politica de merge esperada: `squash`

## Plan tecnico sugerido

1. Crear rama desde `develop`.
2. Implementar cambios en commits pequenos y descriptivos.
3. Abrir Pull Request a `develop`.
4. Ejecutar CI y corregir fallos.
5. Hacer merge con squash cuando el PR sea aprobado.

## Evidencia de pruebas esperada

- [ ] Backend tests
- [ ] Frontend tests
- [ ] Build Docker
- [ ] Validacion funcional
- [ ] Logs o capturas adjuntas

## Riesgos y mitigacion

- Riesgo principal:
- Mitigacion propuesta:
- Plan de rollback:

## Dependencias

Relaciona issues, PRs o tareas bloqueantes.

- Bloquea a:
- Bloqueado por:
- Relacionado con:

## Checklist de entrega

- [ ] Se definio rama `feature/*` y alcance.
- [ ] Se identificaron pruebas requeridas.
- [ ] Se considero impacto en CI/CD o despliegue.
- [ ] Se definio evidencia para validar cierre.
