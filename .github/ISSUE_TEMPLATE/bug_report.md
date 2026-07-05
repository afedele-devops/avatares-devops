# Titulo del bug

Describe el error en una frase corta y especifica.

## Resumen

Explica el bug y su impacto en la aplicacion o en la entrega.

## Comportamiento actual

Que sucede hoy cuando aparece el problema.

- Resultado actual:
- Impacto tecnico:
- Impacto para usuario o evaluacion:

## Comportamiento esperado

Describe como deberia funcionar correctamente.

## Pasos para reproducir

1. 
2. 
3. 

## Entorno

- Rama:
- Commit:
- Entorno de ejecucion (local, docker, k8s, ci):
- Versiones relevantes (python/node/docker/k8s):

## Evidencia del bug

- [ ] Logs
- [ ] Captura de pantalla
- [ ] Salida de error
- [ ] Video corto (opcional)

Adjunta aqui la evidencia o enlaces.

## Analisis inicial

- Causa probable:
- Componentes afectados (api, web, k8s, ci/cd, docs):
- Severidad estimada (alta/media/baja):

## Propuesta de solucion

Describe el cambio sugerido para corregir el bug.

- Ajuste principal:
- Riesgos del ajuste:
- Plan de rollback:

## Criterios de aceptacion

- [ ] El bug deja de reproducirse.
- [ ] Se valida que no hay regresion en funcionalidades relacionadas.
- [ ] Se agregan o ejecutan pruebas de verificacion.
- [ ] Se actualiza documentacion si aplica.

## Estrategia de rama (obligatorio)

Segun la estrategia del repositorio, un bug se corrige en una rama especifica y luego se integra por PR.

### Caso normal

- Rama sugerida: `feature/fix-<tema-corto>`
- Rama base del PR: `develop`
- Politica de merge esperada: `squash`

### Caso critico (hotfix)

- Rama sugerida: `hotfix/<tema-corto>`
- Rama base del PR: `main`
- Accion posterior: back-merge a `develop`

## Plan tecnico sugerido

1. Crear rama segun severidad (`feature/fix-*` o `hotfix/*`).
2. Aplicar correccion con commits descriptivos.
3. Ejecutar pruebas relevantes.
4. Abrir PR y adjuntar evidencia.
5. Hacer merge segun politica definida.

## Checklist de entrega

- [ ] El bug esta claramente reproducido y documentado.
- [ ] La solucion propuesta es verificable.
- [ ] Se incluye evidencia antes y despues del fix.
- [ ] El PR respeta la estrategia de ramas del proyecto.
