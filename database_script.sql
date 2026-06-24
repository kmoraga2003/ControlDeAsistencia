-- ============================================================
-- SISTEMA DE REGISTRO Y CONTROL DE VISITA - SCRIPT ORIGINAL
-- ============================================================
-- Este archivo contiene el script SQL original que se replica
-- en localStorage para la demostración del sistema.
-- Para producción, adaptar a tu servidor de base de datos.

CREATE DATABASE IF NOT EXISTS control_visitas 
    CHARACTER SET utf8mb4 
    COLLATE utf8mb4_unicode_ci;

USE control_visitas;

-- ============================================================
-- 1. UNIDAD
-- ============================================================
-- Tabla que almacena las unidades/departamentos de la institución
-- Campos:
--   id_unidad: Identificador único (autoincrement)
--   nombre_unidad: Nombre de la unidad (único)
--   descripcion: Descripción de la unidad
--   fecha_creacion: Fecha de creación (automático)
--   activo: Estado de la unidad (true/false)

CREATE TABLE UNIDAD (
    id_unidad INT AUTO_INCREMENT PRIMARY KEY,
    nombre_unidad VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    UNIQUE (nombre_unidad)
) ENGINE=InnoDB;

-- ============================================================
-- 2. ROL
-- ============================================================
-- Tabla que define los roles de usuario en el sistema
-- Roles predefinidos:
--   1. Administrador - Gestiona la plataforma
--   2. Usuario - Funcionario que crea eventos
--   3. Guardia - Registra ingreso de visitantes

CREATE TABLE ROL (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255),
    UNIQUE (nombre_rol)
) ENGINE = InnoDB;

INSERT INTO ROL (nombre_rol, descripcion) VALUES
('Administrador', 'Gestiona la plataforma, crea unidades y usuarios'),
('Usuario', 'Funcionario que crea eventos e invita visitantes'),
('Guardia', 'Registra ingreso de visitantes');

-- ============================================================
-- 3. USUARIO
-- ============================================================
-- Tabla que almacena los usuarios del sistema
-- Campos:
--   id_usuario: Identificador único
--   nombre_completo: Nombre del usuario
--   email: Email único del usuario
--   password_hash: Contraseña hasheada
--   rut: RUT del usuario (único y opcional)
--   id_rol: Referencia a la tabla ROL
--   id_unidad: Referencia a la tabla UNIDAD
--   telefono: Teléfono de contacto
--   activo: Estado del usuario
--   fecha_creacion: Fecha de creación

CREATE TABLE USUARIO (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(150) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    rut VARCHAR(12),
    id_rol INT NOT NULL,
    id_unidad INT NOT NULL,
    telefono VARCHAR(20),
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (email),
    UNIQUE (rut),
    FOREIGN KEY (id_rol) REFERENCES ROL(id_rol),
    FOREIGN KEY (id_unidad) REFERENCES UNIDAD(id_unidad)
) ENGINE=InnoDB;

-- ============================================================
-- 4. EVENTO
-- ============================================================
-- Tabla que almacena los eventos/reuniones
-- Campos:
--   id_evento: Identificador único
--   nombre_evento: Nombre del evento
--   descripcion: Descripción del evento
--   fecha_evento: Fecha del evento
--   hora_inicio: Hora de inicio
--   hora_fin: Hora de finalización (opcional)
--   lugar: Lugar del evento
--   id_anfitrion_principal: Usuario anfitrión principal
--   id_unidad: Unidad responsable del evento
--   estado: Estado del evento (PROGRAMADO, EN_CURSO, CANCELADO, FINALIZADO)
--   activo: Si el evento está activo

CREATE TABLE EVENTO (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    nombre_evento VARCHAR(150) NOT NULL,
    descripcion TEXT,
    fecha_evento DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME,
    lugar VARCHAR(100),
    id_anfitrion_principal INT NOT NULL,
    id_unidad INT NOT NULL,
    estado VARCHAR(20) DEFAULT 'PROGRAMADO',
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_anfitrion_principal) REFERENCES USUARIO(id_usuario),
    FOREIGN KEY (id_unidad) REFERENCES UNIDAD(id_unidad)
) ENGINE=InnoDB;

-- ============================================================
-- 5. ANFITRION_SECUNDARIO (tabla intermedia N:M)
-- ============================================================
-- Tabla intermedia que relaciona múltiples anfitriones con un evento
-- Permite que un evento tenga múltiples anfitriones secundarios

CREATE TABLE ANFITRION_SECUNDARIO (
    id_evento INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha_asignacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_evento, id_usuario),
    FOREIGN KEY (id_evento) REFERENCES EVENTO(id_evento),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
) ENGINE=InnoDB;

-- ============================================================
-- 6. VISITANTE
-- ============================================================
-- Tabla que almacena la información de los visitantes
-- Campos:
--   id_visitante: Identificador único
--   tipo_documento: Tipo de documento (RUT o PASAPORTE)
--   numero_documento: Número del documento (único por tipo)
--   nombre_completo: Nombre completo del visitante
--   telefono: Teléfono de contacto
--   email: Correo electrónico
--   fecha_registro: Fecha de registro en el sistema
--   activo: Si el visitante está activo

CREATE TABLE VISITANTE (
    id_visitante INT AUTO_INCREMENT PRIMARY KEY,
    tipo_documento ENUM('RUT', 'PASAPORTE') NOT NULL,
    numero_documento VARCHAR(20) NOT NULL,
    nombre_completo VARCHAR(150) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    UNIQUE (tipo_documento, numero_documento)
) ENGINE=InnoDB;

-- ============================================================
-- 7. VISITA
-- ============================================================
-- Tabla que registra las visitas de los visitantes
-- Campos:
--   id_visita: Identificador único
--   id_visitante: Referencia al visitante
--   id_evento: Referencia al evento (opcional)
--   id_usuario_registro: Usuario que registra la visita
--   id_unidad_registro: Unidad donde se registra
--   fecha_visita: Fecha programada de la visita
--   hora_visita: Hora programada de la visita
--   motivo_visita: Motivo de la visita
--   estado: Estado (PROGRAMADA, INGRESADO, NO_ASISTIO, CANCELADA)
--   observaciones: Observaciones adicionales

CREATE TABLE VISITA (
    id_visita INT AUTO_INCREMENT PRIMARY KEY,
    id_visitante INT NOT NULL,
    id_evento INT,
    id_usuario_registro INT NOT NULL,
    id_unidad_registro INT NOT NULL,
    fecha_visita DATE NOT NULL,
    hora_visita TIME NOT NULL,
    motivo_visita VARCHAR(255),
    estado ENUM('PROGRAMADA', 'INGRESADO', 'NO_ASISTIO', 'CANCELADA') DEFAULT 'PROGRAMADA',
    fecha_registro_sistema DATETIME DEFAULT CURRENT_TIMESTAMP,
    observaciones TEXT,
    FOREIGN KEY (id_visitante) REFERENCES VISITANTE(id_visitante),
    FOREIGN KEY (id_evento) REFERENCES EVENTO(id_evento),
    FOREIGN KEY (id_usuario_registro) REFERENCES USUARIO(id_usuario),
    FOREIGN KEY (id_unidad_registro) REFERENCES UNIDAD(id_unidad)
) ENGINE=InnoDB;

-- ============================================================
-- 8. VEHICULO
-- ============================================================
-- Tabla que almacena datos de vehículos asociados a visitas
-- Un vehículo corresponde a una visita
-- Campos:
--   id_vehiculo: Identificador único
--   id_visita: Referencia a la visita (relación 1:1)
--   marca: Marca del vehículo
--   modelo: Modelo del vehículo
--   color: Color del vehículo
--   patente: Patente del vehículo

CREATE TABLE VEHICULO (
    id_vehiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_visita INT NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    color VARCHAR(30) NOT NULL,
    patente VARCHAR(15) NOT NULL,
    UNIQUE (id_visita),
    FOREIGN KEY (id_visita) REFERENCES VISITA(id_visita)
) ENGINE=InnoDB;

-- ============================================================
-- 9. ASISTENCIA
-- ============================================================
-- Tabla que registra la asistencia efectiva de visitantes
-- Se crea un registro cuando el guardia confirma el ingreso
-- Campos:
--   id_asistencia: Identificador único
--   id_visita: Referencia a la visita
--   id_guardia: Usuario guardia que registra
--   fecha_ingreso: Fecha efectiva de ingreso
--   hora_ingreso: Hora efectiva de ingreso
--   timestamp_ingreso: Timestamp completo del ingreso
--   observaciones_ingreso: Observaciones del guardia

CREATE TABLE ASISTENCIA (
    id_asistencia INT AUTO_INCREMENT PRIMARY KEY,
    id_visita INT NOT NULL,
    id_guardia INT NOT NULL,
    fecha_ingreso DATE NOT NULL,
    hora_ingreso TIME NOT NULL,
    timestamp_ingreso DATETIME DEFAULT CURRENT_TIMESTAMP,
    observaciones_ingreso TEXT,
    UNIQUE (id_visita),
    FOREIGN KEY (id_visita) REFERENCES VISITA(id_visita),
    FOREIGN KEY (id_guardia) REFERENCES USUARIO(id_usuario)
) ENGINE=InnoDB;

-- ============================================================
-- ÍNDICES PARA OPTIMIZACIÓN
-- ============================================================
CREATE INDEX idx_usuario_rol ON USUARIO(id_rol);
CREATE INDEX idx_usuario_unidad ON USUARIO(id_unidad);
CREATE INDEX idx_evento_anfitrion ON EVENTO(id_anfitrion_principal);
CREATE INDEX idx_evento_unidad ON EVENTO(id_unidad);
CREATE INDEX idx_visita_visitante ON VISITA(id_visitante);
CREATE INDEX idx_visita_evento ON VISITA(id_evento);
CREATE INDEX idx_visita_usuario ON VISITA(id_usuario_registro);
CREATE INDEX idx_visita_unidad ON VISITA(id_unidad_registro);
CREATE INDEX idx_visita_fecha ON VISITA(fecha_visita);
CREATE INDEX idx_asistencia_visita ON ASISTENCIA(id_visita);
CREATE INDEX idx_asistencia_guardia ON ASISTENCIA(id_guardia);

-- ============================================================
-- CONSULTAS ÚTILES PARA ANÁLISIS
-- ============================================================

-- Visitas por unidad
SELECT 
    u.nombre_unidad, 
    COUNT(v.id_visita) as total_visitas
FROM UNIDAD u
LEFT JOIN VISITA v ON u.id_unidad = v.id_unidad_registro
GROUP BY u.id_unidad, u.nombre_unidad;

-- Asistencia por día
SELECT 
    a.fecha_ingreso,
    COUNT(a.id_asistencia) as total_asistencias
FROM ASISTENCIA a
GROUP BY a.fecha_ingreso
ORDER BY a.fecha_ingreso DESC;

-- Eventos por usuario
SELECT 
    usr.nombre_completo,
    COUNT(e.id_evento) as total_eventos
FROM USUARIO usr
LEFT JOIN EVENTO e ON usr.id_usuario = e.id_anfitrion_principal
WHERE usr.id_rol = 2
GROUP BY usr.id_usuario, usr.nombre_completo;

-- Estado de visitas hoy
SELECT 
    v.estado,
    COUNT(v.id_visita) as cantidad
FROM VISITA v
WHERE v.fecha_visita = CURDATE()
GROUP BY v.estado;
