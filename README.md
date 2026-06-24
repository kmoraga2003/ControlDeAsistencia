# Sistema de Registro y Control de Visitas

## 📋 Descripción General

Sistema web completo para gestionar el registro y control de asistencia de visitantes en universidades e instituciones. Construido con **HTML5, CSS3, JavaScript ES6, Bootstrap 5.3 y Chart.js**.

## 🎯 Características Principales

### 1. **Autenticación por Roles**
- **Administrador**: Gestión completa del sistema
- **Usuario (Funcionario)**: Registra eventos y visitantes
- **Guardia**: Control de ingreso de visitantes

### 2. **Base de Datos Relacional**
Implementación en localStorage basada en el script SQL con 9 tablas:
- `UNIDAD` - Unidades/Departamentos
- `ROL` - Roles de usuarios
- `USUARIO` - Usuarios del sistema
- `EVENTO` - Eventos/Reuniones
- `VISITANTE` - Registro de visitantes
- `VISITA` - Registro de visitas
- `ASISTENCIA` - Ingreso de visitantes
- `VEHICULO` - Datos de vehículos
- `ANFITRION_SECUNDARIO` - Anfitriones secundarios (N:M)

### 3. **Funcionalidades por Rol**

#### 👨‍💼 **Administrador**
- Dashboard con estadísticas globales
- Gestión de usuarios (CRUD)
- Gestión de unidades (CRUD)
- Gestión de visitantes
- Gestión de eventos
- Reportes y gráficos
- Filtros por fecha y unidad
- Visualización de asistencias

#### 👤 **Usuario (Funcionario)**
- Dashboard de unidad
- Crear y gestionar eventos
- Registrar nuevos visitantes
- Registrar visitas
- Ver visitas del día
- Información de asistencias de su unidad

#### 🔐 **Guardia**
- Dashboard con visitas del día
- Búsqueda rápida de visitantes
- Registro de ingreso efectivo
- Listado de visitas programadas
- Marcación de asistencias
- Opción para marcar "No asistió"

### 4. **Campos por Tabla**

#### VISITANTE
- Tipo de documento: RUT o Pasaporte
- Número de documento
- Nombre completo
- Teléfono
- Email

#### VISITA
- Visitante
- Evento (opcional)
- Usuario que registra
- Unidad
- Fecha y hora
- Motivo
- Estado (PROGRAMADA, INGRESADO, NO_ASISTIO, CANCELADA)

#### VEHÍCULO (Dinámico)
- Se muestra/oculta automáticamente
- Marca, Modelo, Color, Patente

#### ASISTENCIA
- Registro automático de ingreso
- Guardia responsable
- Fecha y hora de ingreso
- Observaciones

## 🏗️ Estructura del Proyecto

```
ProyectoSoftwareAsistencia/
├── index.html              # Redirección al login
├── login.html              # Página de autenticación
├── dashboard.html          # Panel principal
├── css/
│   └── styles.css          # Estilos personalizados
├── js/
│   ├── app.js              # Lógica de autenticación y BD
│   └── dashboard.js        # Lógica de dashboards y vistas
└── README.md               # Este archivo
```

## 🔐 Credenciales de Prueba

| Email | Contraseña | Rol |
|-------|-----------|-----|
| admin@example.com | password123 | Administrador |
| usuario@example.com | password123 | Usuario |
| guardia@example.com | password123 | Guardia |

## 🎨 Diseño y Estilos

- **Framework**: Bootstrap 5.3
- **Iconos**: Bootstrap Icons
- **Colores**: Tema corporativo profesional
- **Componentes**: Sidebar, Navbar, Cards, Tablas responsivas
- **Gráficos**: Chart.js para visualización de datos
- **Tablas**: DataTables para búsqueda y paginación
- **Alertas**: SweetAlert2 para confirmaciones

## 📊 Gráficos y Reportes

### Dashboard Administrativo
- Tarjetas estadísticas (Total visitantes, Visitas hoy, etc.)
- Gráfico de barras: Visitas por unidad
- Gráfico de dona: Estado de visitas

### Reportes
- Filtros por rango de fechas
- Filtros por unidad
- Gráficos de tendencias
- Exportación potencial (mejora futura)

## ⚙️ Funcionalidades Técnicas

### Almacenamiento
- Datos almacenados en **localStorage** (simula base de datos)
- Sesión manejada en **sessionStorage**
- Datos persisten durante la sesión del navegador

### Validaciones
- Validación de RUT (formato y dígito verificador)
- Validación de emails
- Validación de documentos únicos
- Validación de formularios en cliente

### Responsividad
- ✅ **Optimización completa para móvil**
- Diseño mobile-first
- Breakpoints: 480px, 576px, 768px, 992px, 1200px+
- Sidebar colapsable/toggleable en móvil (< 768px)
- Tablas responsivas con scroll horizontal
- Botones y elementos táctiles (44x44px mínimo)
- Navbar adaptativo con opciones ocultas en móvil
- Soporte para: 320px - 2560px
- Instrucciones rápidas de prueba incluidas más abajo en la sección de pruebas móviles

### Seguridad (Frontend)
- Hash de contraseñas simulado
- Validación de roles
- Control de acceso por rol
- Sesión con timeout (mejora futura)

## 🚀 Cómo Usar

### 1. Abrir en el Navegador
```
Abrir index.html en tu navegador web
o
Servir con un servidor local (http-server, Live Server, etc.)
```

### 2. Acceder al Sistema
- Se redirige automáticamente a `login.html`
- Ingresar con las credenciales de prueba
- Se redirige al dashboard según el rol

### 3. Flujo de Uso

#### Como Administrador:
1. Ver estadísticas globales
2. Crear usuarios y unidades
3. Gestionar eventos
4. Ver reportes con gráficos

#### Como Usuario:
1. Ver eventos de su unidad
2. Registrar nuevos visitantes
3. Crear visitas
4. Ver asistencias del día

#### Como Guardia:
1. Ver visitas programadas para hoy
2. Buscar visitantes
3. Registrar ingreso efectivo
4. Marcar ausencias

## 📱 Características Responsivas

| Dispositivo | Comportamiento |
|-------------|----------------|
| Desktop | Sidebar fijo, contenido completo |
| Tablet | Sidebar colapsable, tablas optimizadas |
| Móvil | Sidebar oculto por defecto, navegación simplificada |

## � Optimización para Dispositivos Móviles

### ✨ Características Móvil Implementadas

- ✅ **Navegación Touch-friendly**
  - Botón hamburguesa (☰) para abrir/cerrar sidebar
  - El sidebar se cierra automáticamente al seleccionar un elemento
  - Cierre automático al hacer clic fuera

- ✅ **Interfaz Adaptativa**
  - 5 puntos de quiebre para diferentes tamaños (320px - 2560px)
  - Tipografía escalable
  - Botones con altura mínima de 44x44px (HIG de Apple)
  - Espaciado optimizado para dedos

- ✅ **Tablas y Datos**
  - Tablas horizontalmente desplazables
  - Fuentes optimizadas para legibilidad
  - Paginación accesible

- ✅ **Formularios**
  - Inputs con altura de 44px
  - Labels claros
  - Teclado virtual amigable
  - Selects y checkboxes grandes

- ✅ **Modales**
  - Se adaptan automáticamente
  - Completamente funcionales en móvil
  - Botones de cierre accesibles

### 📊 Tamaños Soportados

| Tamaño | Rango | Dispositivos |
|--------|-------|-------------|
| Muy Pequeño | 320-480px | iPhone SE, antiguos |
| Pequeño | 481-576px | iPhone 12, Galaxy S21 |
| Mediano | 577-768px | Tablets pequeñas |
| Tablet | 769-992px | iPad, Galaxy Tab |
| Grande | 993px+ | Laptops, Desktop |

### 🧪 Cómo Probar en Móvil

**Opción 1: DevTools del Navegador (Recomendado)**
```
1. Presiona F12
2. Haz clic en el icono de dispositivo (esquina superior izquierda)
3. Selecciona "iPhone 12" o cualquier dispositivo
4. Prueba la interacción
```

**Opción 2: Guía Completa**
Usa esta misma sección como guía de prueba para móvil.

**Opción 3: Referencia Rápida**
Verifica menú lateral, tablas, formularios y navegación en un ancho menor a 768px.

## �🔄 Mejoras Futuras

1. **Backend Real**
   - Implementar con Node.js/Express, Python/Flask, o PHP
   - Base de datos MySQL/PostgreSQL

2. **Autenticación Mejorada**
   - JWT (JSON Web Tokens)
   - Recuperación de contraseña
   - Autenticación en dos factores

3. **Reportes Avanzados**
   - Exportación a PDF
   - Exportación a Excel
   - Gráficos más complejos

4. **Notificaciones**
   - Alertas en tiempo real
   - Email de confirmación
   - Notificaciones push

5. **Integración**
   - QR para escaneo de documentos
   - Cámara para foto de visitantes
   - API REST para terceros

6. **Optimización**
   - Indexación de datos
   - Caché optimizado
   - Compresión de datos

## 🛠️ Tecnologías Utilizadas

- **HTML5**: Semántica web
- **CSS3**: Diseño responsivo
- **JavaScript ES6**: Programación orientada a objetos
- **Bootstrap 5.3**: Framework CSS
- **Bootstrap Icons**: Iconografía
- **Chart.js**: Gráficos
- **DataTables**: Tablas interactivas
- **SweetAlert2**: Modales y alertas
- **jQuery**: Manipulación DOM

## 📄 Licencia

Sistema educativo - Uso libre para propósitos de enseñanza

## 👨‍💻 Autor

Sistema diseñado para demostración de capacidades web fullstack

## 📞 Soporte

Para reportar errores o sugerencias, abrir issue en el repositorio

---

**Última actualización**: Junio 2024
**Versión**: 1.0.0
