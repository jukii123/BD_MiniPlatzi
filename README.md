# 🎓 Mini Platzi - Plataforma Educativa

**Mini Platzi** es una plataforma de enseñanza online que permite a estudiantes aprender mediante cursos y rutas de aprendizaje. Los instructores crean contenido, los estudiantes siguen su progreso, rinden evaluaciones y reciben certificados digitales. El sistema gestiona roles, pagos y lógica académica de forma automatizada y segura.

---

## 📘 Tabla de Contenido

- [🏫 Descripción del Proyecto](#-descripción-del-proyecto)
- [🧩 Estructura de la Base de Datos](#-estructura-de-la-base-de-datos)
- [🔐 Roles y Seguridad](#-roles-y-seguridad)
- [⚙️ Funcionalidades Clave](#️-funcionalidades-clave)
- [🔄 Procedimientos y Transacciones](#-procedimientos-y-transacciones)
- [💡 Funciones y Disparadores](#-funciones-y-disparadores)
- [🚀 Consultas y Ejecuciones Comunes](#-consultas-y-ejecuciones-comunes)
- [📌 Conclusiones](#-conclusiones)

---

## 🏫 Descripción del Proyecto

Mini Platzi permite:

- Registro de estudiantes, instructores y administradores.
- Creación de cursos, módulos y lecciones por instructores.
- Inscripción de estudiantes y seguimiento del progreso.
- Evaluaciones finales y emisión de certificados automáticos.
- Gestión de pagos con bitácora de auditoría.

---

## 🧩 Estructura de la Base de Datos

📌 El modelo cumple la **Tercera Forma Normal (3FN)**.  
📁 Incluye más de 15 tablas relacionales con claves foráneas, índices y procedimientos.

### 🗂️ Modelo Relacional (Esquema Conceptual)
![Modelo Relacional](/img/modelo-relacional.png)

### 🏗️ Esquema físico (SQL - Diagrama ER)
![Esquema de Base de Datos](/img/esquema-bd.png)

---

## 🔐 Roles y Seguridad

| Usuario             | Permisos Clave                                                                 |
|---------------------|--------------------------------------------------------------------------------|
| `admin_platzi`       | Total control: `ALL PRIVILEGES`                                                |
| `profesor_platzi`    | `SELECT`, `INSERT`, `UPDATE` sobre `curso` y `leccion`                         |
| `estudiante_platzi`  | `SELECT` en `curso`, `comentario`; `INSERT/UPDATE` en `progreso` y `comentario`|

---

## ⚙️ Funcionalidades Clave

- Registrar usuarios por rol.
- Crear cursos, lecciones y evaluaciones.
- Inscribir estudiantes con validación de pago.
- Emitir certificados automáticamente.
- Actualizar progreso y controlar estado de inscripción.
- Ver historial, certificados y comentarios por curso.

---

## 🔄 Procedimientos y Transacciones

### Procedimientos destacados:
- `inscribir_en_curso(usuario_id, curso_id)`
- `actualizar_estado_inscripcion(usuario_id, curso_id)`
- `registrar_inscripcion_completa(usuario_id, curso_id, monto)`
- `finalizar_curso_con_certificado(usuario_id, curso_id, nota)`

### Transacciones importantes:
- Inscripción + registro de pago + progreso inicial.
- Evaluación final + validación de estado + emisión de certificado.

Ejemplo:
```sql
CALL registrar_inscripcion_completa(5, 101, 49.99);
