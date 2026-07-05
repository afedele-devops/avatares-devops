
---

## Objetivo
Tener flujo simple, auditable y rápido para el examen, minimizando riesgo de romper producción.

---

## Estrategia recomendada
- Rama **main**
- Rama **develop**
- Ramas **feature/***
- Ramas **hotfix/*** opcionales para urgencias desde main

---

## Reglas de uso

### main
- Solo código listo para entregar.
- Siempre protegida.
- Solo merge vía Pull Request.
- Requiere CI en verde.
- Cada merge a main debe dejar un tag de versión.

### develop
- Rama de integración diaria.
- Recibe merge de feature/*.
- También protegida, pero con reglas un poco menos estrictas que main.
- Debe mantenerse estable para staging.

### feature/*
- Se crean desde develop.
- Nombre sugerido: `feature/tema-corto`
- Vida corta, idealmente 1 a 2 días.
- Al terminar, Pull Request a develop con squash merge.

### hotfix/*
- Se crean desde main para correcciones críticas.
- Merge a main y luego back-merge a develop para no perder cambios.

---

## Flujo operativo recomendado
1. Crear develop desde main.
2. Trabajar cada tarea en feature/*.
3. Abrir PR de feature/* a develop.
4. Ejecutar CI y aprobar PR.
5. Merge a develop.
6. Cuando haya corte de entrega, PR de develop a main.
7. Tag en main y despliegue.

---