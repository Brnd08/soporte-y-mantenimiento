drop database if exists pruebas;
create database pruebas;
use pruebas;
show databases;
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
	email_usuario varchar(50) not null unique,
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
    ('brandon', 'ingeniero2@soporte.com', 'contraseña', 'INGENIERO_SOPORTE'),
    ('kikin', 'ingeniero@mantenimiento.com', 'contraseña', 'INGENIERO_MANTENIMIENTO'),
    ('german', 'editor@editor.com', 'contraseña', 'EDITOR');
    
SELECT * FROM usuarios WHERE email_usuario = 'editor@editor.com' AND password_usuario = 'contraseña';
SELECT * FROM usuarios;

create table statusReportes(
	status varchar (40) primary key not null
);
INSERT INTO  statusReportes (status) values
('ABIERTO'),
('EN_PROCESO'),
('SOLUCIONADO'),
('CERRADO'),
('ABIERTO'),
('EN_PROCESO'),
('ASIGNADO_MANTENIMIENTO'),
('SOLUCIONADO'),
('IMPLEMENTADO_MANTENIMIENTO');

-- drop table reportes;
create table reportes(
	id_reporte int primary key auto_increment,
    email_usuario varchar(30) not null,
    nombre_reporte varchar(40)not null,
    status_reporte varchar(100) not null default 'ABIERTO'references statusReportes(status),
    pregunta_reporte varchar(100) not null,
    solucion_reporte varchar(150) default 'Solución Pendiente',
    fecha_reporte timestamp not null default now(),
    tipo_reporte varchar(30) not null default 'MANTENIMIENTO',
    enviado boolean default false   
);
SELECT * FROM reportes WHERE status_reporte = ('ABIERTO') AND tipo_reporte = 'MANTENIMIENTO';
    
SELECT * FROM reportes ; 
SELECT * FROM reportes WHERE tipo_reporte = 'MANTENIMIENTO';
    SELECT * FROM reportes order by tipo_reporte, status_reporte;
    
create table faqs(
	id_pregunta int primary key auto_increment,
    pregunta varchar(100) not null,
    respuesta varchar(150)not null
);

create table usuario_reporte(
	id_usuario int not null references Usuarios(id_usuario),
    id_reporte int not null references reportes(id_reporte)
);
select distinct * from usuario_reporte;
SELECT DISTINCT id_reporte FROM usuario_reporte WHERE id_usuario = (2);



        INSERT INTO faqs (pregunta, respuesta) 
        SELECT pregunta_reporte, solucion_reporte
        FROM reportes
        WHERE id_reporte = 2;
SELECT * FROM faqs ;

select distinct * from reportes;
SELECT usuario_reporte.id_reporte, reportes.status_reporte FROM usuario_reporte, reportes WHERE usuario_reporte.id_usuario = 2 and usuario_reporte.id_reporte=reportes.id_reporte AND reportes.status_reporte = 'EN_PROCESO';
SELECT distinct usuario_reporte.id_reporte, reportes.status_reporte FROM usuario_reporte, reportes WHERE usuario_reporte.id_usuario = 4 and usuario_reporte.id_reporte=reportes.id_reporte AND reportes.status_reporte = 'EN_PROCESO';
SELECT DISTINCT * from reportes WHERE reportes.status_reporte = 'EN_PROCESO';
select * from reportes;
-- UPDATE reportes SET status_reporte = 'ABIERTO' where id_reporte = (?);