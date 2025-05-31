# 🎓 Mini Platzi - Plataforma Educativa

**Mini Platzi** es una plataforma de educación online que permite a estudiantes aprender mediante rutas de aprendizaje, lecciones, evaluaciones y certificados. Los instructores gestionan los contenidos, y el sistema controla el progreso, los pagos y la emisión de certificados de forma automatizada.

---

## 📘 Tabla de Contenido

- [📘 Tabla de Contenido](#-tabla-de-contenido)
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

Mini Platzi es una plataforma educativa donde:

- Los **instructores** crean cursos, módulos y lecciones.
- Los **estudiantes** se inscriben, avanzan en lecciones y reciben **certificados automáticos**.
- Los **administradores** supervisan todo el sistema y controlan los usuarios.

Está orientada a soportar **alta concurrencia**, **consultas intensivas** y **automatización de procesos académicos**.

---

## 🧩 Estructura de la Base de Datos

### 🔹 Principales tablas:

- `usuario` → estudiantes, instructores, administradores
- `curso`, `modulo`, `leccion` → estructura académica
- `inscripcion`, `progreso`, `evaluacion`, `certificado`
- `pagos`, `log_pagos`, `comentario`, `ruta_aprendizaje`

### ✅ Cumple con la **Tercera Forma Normal (3FN)**  
Evita redundancias y dependencias transitivas.

---

## 🔐 Roles y Seguridad

### 👤 Usuarios:

- `admin_platzi`: Control total de la BD.
- `profesor_platzi`: Puede crear/modificar cursos y lecciones.
- `estudiante_platzi`: Accede a cursos, progresa y comenta.

### 🔒 Ejemplo de permisos:
```sql
GRANT SELECT, INSERT ON platzi_db.Comentario TO 'estudiante_platzi'@'%';
GRANT ALL PRIVILEGES ON platzi_db.* TO 'admin_platzi'@'%';
