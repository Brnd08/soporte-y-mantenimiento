drop database if exists pruebas;
create database pruebas;
use pruebas;

DROP PROCEDURE IF EXISTS debug_msg ;
DELIMITER $$
CREATE PROCEDURE debug_msg(property VARCHAR(50), msg VARCHAR(255))
BEGIN
    select concat('** ', property, ' => ',  msg) AS '** DEBUG:';
END $$
DELIMITER ;

create table prueba1(
	id int 
);
insert into prueba1 values (1), (2), (3), (4);
select * from prueba1;

create table TipoUsuarios(
	tipo varchar(30)
);
INSERT INTO TipoUsuarios values 
	('EDITOR'),
    ('GERENTE_MANTENIMIENTO'),
    ('GERENTE_SOPORTE'),
    ('INGENIERO_SOPORTE'),
    ('INGENIERO_MANTENIMIENTO'),
    ('ASISTENTE');
    
create table Usuarios (
	id_usuario int not null auto_increment primary key,    
	email_usuario varchar(30) not null unique,
	password_usuario varchar(200) not null,    
    nombre_usuario varchar(40) not null,
	tipo_usuario varchar(30) not null default 'EDITOR' references TipoUsuarios(tipo)
);
INSERT INTO Usuarios (nombre_usuario, email_usuario, password_usuario, tipo_usuario) 
	values 
    ('juanito', 'gerente@mantenimiento.com', 'contraseña', 'GERENTE_MANTENIMIENTO'),
    ('panchito', 'gerente@soporte.com', 'contraseña', 'GERENTE_SOPORTE'),
    ('pedrito', 'asistente@asistente.com', 'contraseña', 'ASISTENTE'),
    ('carlitos', 'ingeniero@soporte.com', 'contraseña', 'INGENIERO_SOPORTE'),
    ('kikin', 'ingeniero@mantenimiento.com', 'contraseña', 'INGENIERO_MANTENIMIENTO'),
    ('german', 'editor@editor.com', 'contraseña', 'EDITOR');
    
SELECT * FROM usuarios WHERE email_usuario = 'editor@editor.com' AND password_usuario = 'contraseña';

create table statusReportes(
	status varchar (30) primary key not null,
    tipo_reporte varchar (30) not null
);
INSERT INTO statusReportes values
('ABIERTO_SOPORTE'),
('EN_PROCESO_SOPORTE'),
('SOLUCIONADO_SOPORTE'),
('RECIBIDO_MANTENIMIENTO'),
('PENDIENTE_MANTENIMIENTO'),
('ASIGNADO_MANTENIMIENTO'),
('EN_IMPLEMENTACION_MANTENIMIENTO'),
('IMPLEMENTADO_MANTENIMIENTO');

-- drop table reportes;
create table reportes(
	id_reporte int primary key auto_increment,
    email_usuario varchar(30) not null,
    nombre_reporte varchar(20)not null,
    status_reporte varchar(30) not null default 'ABIERTO_SOPORTE'references statusReportes(status),
    pregunta_reporte varchar(100) not null,
    solucion_reporte varchar(150) default 'Solución Pendiente',
    fecha_reporte timestamp not null default now(),
    tipo_reporte varchar(30) not null default 'MANTENIMIENTO',
    enviado boolean default false   
);
SELECT * FROM reportes WHERE status_reporte = ('ABIERTO_SOPORTE') AND tipo_reporte = 'MANTENIMIENTO';
INSERT INTO reportes (email_usuario, nombre_reporte, status_reporte, pregunta_reporte, tipo_reporte, enviado) values
	('email@usuario.com', 'reporte 1', 'ABIERTO_SOPORTE', 'NO SE MUESTRA NADA EN EL INDICE', 'MANTENIMIENTO', false);
    
SELECT * FROM reportes ; 
SELECT * FROM reportes WHERE tipo_reporte = 'MANTENIMIENTO';
    SELECT * FROM reportes ;
    
create table faqs(
	id_pregunta int primary key auto_increment,
    pregunta varchar(100) not null,
    respuesta varchar(150)not null
);

INSERT INTO faqs (pregunta, respuesta)VALUES('UNA PREGUNTA DE ESAS TONTAS QUE SUELEN HACER LOS USUARIOS', 'UNA RESPUESTA DE PORQUE EL USUARIO NO LE SABE Y PORQUE LA SOLUCION ERA OBVIA Y SIEMPRE FUE CULTA DEL MISMO USUARIO');
SELECT * FROM faqs ;