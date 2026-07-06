# Resumen del cambio

Describe de forma breve qué cambia este PR y cuál es su objetivo.

## Tipo de cambio

Marca las opciones que apliquen:

- [ ] Nueva funcionalidad
- [ ] Corrección de error
- [ ] Refactorización
- [ ] Cambio de infraestructura
- [ ] Cambio en CI/CD
- [ ] Cambio de documentación
- [ ] Hotfix

## Evidencia de pruebas

Detalla qué validaciones realizaste para comprobar el cambio.

### Pruebas ejecutadas

- [ ] Tests de backend
- [ ] Tests de frontend
- [ ] Build de imágenes Docker
- [ ] Validación manual local
- [ ] Despliegue en entorno de prueba
- [ ] Smoke test post-deploy

### Resultados

Incluye comandos ejecutados, salida relevante, capturas o enlaces a logs.

```bash
# Ejemplo
make test-backend
make test-frontend
make build
```

## Checklist de riesgos

Revisa los siguientes puntos antes de solicitar aprobación:

- [ ] El cambio no rompe compatibilidad conocida
- [ ] El impacto en producción fue evaluado
- [ ] Se revisaron variables de entorno, secretos o credenciales
- [ ] Se evaluó impacto en base de datos, almacenamiento o red
- [ ] Se revisó impacto en observabilidad, métricas o alertas
- [ ] Existe plan de reversión si el cambio falla

## Checklist de documentación

- [ ] Actualicé README si el cambio lo requiere
- [ ] Actualicé documentación técnica o de despliegue si aplica
- [ ] Documenté nuevos comandos, variables o dependencias
- [ ] Adjunté evidencias necesarias para la entrega

## Notas para revisión

Agrega aquí contexto adicional que ayude a revisar el PR más rápido.
