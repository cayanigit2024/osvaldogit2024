CREATE DATABASE bd_TERMINAL;

CREATE TABLE terminal_buses (
id_terminal INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,
direccion VARCHAR(50) NOT NULL,
telefono VARCHAR(12) NOT NULL,
logoterminal TEXT,
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
PRIMARY KEY(id_terminal) 
)ENGINE=INNODB;

CREATE TABLE empresas (
id_empresa INT NOT NULL AUTO_INCREMENT,
id_terminal INT NOT NULL,
razon_social VARCHAR(20) NOT NULL,
nit VARCHAR(15) NOT NULL,
telefono VARCHAR(12)NOT NULL,
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
PRIMARY KEY(id_empresa),
FOREIGN KEY (id_terminal) REFERENCES terminal_buses (id_terminal)
)ENGINE=INNODB;

CREATE TABLE propietarios (
id_propietario INT NOT NULL AUTO_INCREMENT,
id_empresa INT NOT NULL,
nombres VARCHAR(20) NOT NULL,
ap_paterno VARCHAR(12),
ap_materno VARCHAR(12),
ci VARCHAR(15) NOT NULL,
telefono VARCHAR(12)NOT NULL,
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
PRIMARY KEY(id_propietario),
FOREIGN KEY (id_empresa) REFERENCES empresas (id_empresa)
)ENGINE=INNODB;

CREATE TABLE conductores (
id_conductor INT NOT NULL AUTO_INCREMENT,
id_empresa INT NOT NULL,
nombres VARCHAR(20) NOT NULL,
ap_paterno VARCHAR(12),
ap_materno VARCHAR(12),
ci VARCHAR(15) NOT NULL,
telefono VARCHAR(12)NOT NULL,
fecha_nac DATE NOT NULL,
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
PRIMARY KEY(id_conductor),
FOREIGN KEY (id_empresa) REFERENCES empresas (id_empresa)
)ENGINE=INNODB;

CREATE TABLE autobuses (
id_bus INT NOT NULL AUTO_INCREMENT,
id_propietario INT NOT NULL,
marca VARCHAR(20) NOT NULL,
modelo VARCHAR(10) NOT NULL,
capacidad_personas INT NOT NULL,
placa_control VARCHAR(10) NOT NULL,
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
PRIMARY KEY(id_bus),
FOREIGN KEY (id_propietario) REFERENCES propietarios (id_propietario)
)ENGINE=INNODB;

CREATE TABLE conductores_autobuses (
id_condbus INT NOT NULL AUTO_INCREMENT,
id_conductor INT NOT NULL,
id_bus INT NOT NULL,
fecha_inicio DATE NOT NULL,
fecha_final DATE,
hora_inicio TIME NOT NULL,
hora_fin TIME,
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
PRIMARY KEY(id_condbus), 
FOREIGN KEY (id_conductor) REFERENCES conductores (id_conductor),
FOREIGN KEY (id_bus) REFERENCES autobuses (id_bus)
)ENGINE=INNODB;

CREATE TABLE rutas (
id_ruta INT NOT NULL AUTO_INCREMENT,
tipo_ruta VARCHAR(25) NOT NULL,
distancia VARCHAR(10) NOT NULL,
origen VARCHAR(15) NOT NULL,
destino VARCHAR(15) NOT NULL,
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
PRIMARY KEY(id_ruta) 
)ENGINE=INNODB;

CREATE TABLE tarifas (
id_tarifa INT NOT NULL AUTO_INCREMENT,
id_ruta INT NOT NULL,
id_empresa INT NOT NULL,
tipo_bus VARCHAR(20) NOT NULL,
precio FLOAT NOT NULL,
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
PRIMARY KEY(id_tarifa), 
FOREIGN KEY (id_ruta) REFERENCES rutas (id_ruta),
FOREIGN KEY (id_empresa) REFERENCES empresas (id_empresa)
)ENGINE=INNODB;

CREATE TABLE horarios (
id_horario INT NOT NULL AUTO_INCREMENT,
hora_salida TIME NOT NULL,
hora_llegada TIME,
fecha_salida DATE NOT NULL,
fecha_llegada DATE NOT NULL,
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
PRIMARY KEY(id_horario) 
)ENGINE=INNODB;

CREATE TABLE horarios_autobuses (
id_horariobus INT NOT NULL AUTO_INCREMENT,
id_horario INT NOT NULL,
id_ruta INT NOT NULL,
id_condbus INT NOT NULL,
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
PRIMARY KEY(id_horariobus), 
FOREIGN KEY (id_horario) REFERENCES horarios (id_horario),
FOREIGN KEY (id_ruta) REFERENCES rutas (id_ruta),
FOREIGN KEY (id_condbus) REFERENCES conductores_autobuses (id_condbus)
)ENGINE=INNODB;

CREATE TABLE pasajeros (
id_pasajero INT NOT NULL AUTO_INCREMENT,
nombres VARCHAR(20) NOT NULL,
ap_paterno VARCHAR(12),
ap_materno VARCHAR(12),
ci VARCHAR(15) NOT NULL,
nit VARCHAR(15),
telefono VARCHAR(12)NOT NULL,
fecha_nac DATE NOT NULL,
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
PRIMARY KEY(id_pasajero) 
)ENGINE=INNODB;

CREATE TABLE reservas (
id_reserva INT NOT NULL AUTO_INCREMENT,
id_pasajero INT NOT NULL,
id_horariobus INT NOT NULL,
fecha_reserva DATE NOT NULL,
tiempo_reserva TIME NOT NULL,
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
PRIMARY KEY(id_reserva), 
FOREIGN KEY (id_pasajero) REFERENCES pasajeros (id_pasajero),
FOREIGN KEY (id_horariobus) REFERENCES horarios_autobuses (id_horariobus)
)ENGINE=INNODB;

CREATE TABLE equipajes (
id_equipaje INT NOT NULL AUTO_INCREMENT,
id_pasajero INT NOT NULL,
id_horariobus INT NOT NULL,
destino VARCHAR(12),
codigo VARCHAR(10),
fecha_viaje DATE NOT NULL,
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
PRIMARY KEY(id_equipaje), 
FOREIGN KEY (id_pasajero) REFERENCES pasajeros (id_pasajero),
FOREIGN KEY (id_horariobus) REFERENCES horarios_autobuses (id_horariobus)
)ENGINE=INNODB;




CREATE TABLE CURSOS(
id_curso INT NOT NULL AUTO_INCREMENT,
nombre_c VARCHAR (30) NOT NULL,
paralelo char(2) NOT NULL,
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
PRIMARY KEY(id_curso) 
)ENGINE=INNODB;

CREATE TABLE MATERIAS(
id_materia INT NOT NULL AUTO_INCREMENT,
id_curso INT NOT NULL,
nombre_m VARCHAR (25) NOT NULL,
sigla VARCHAR(15) NOT NULL,
horas VARCHAR(30),
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
PRIMARY KEY(id_materia), 
FOREIGN KEY (id_curso) REFERENCES cursos (id_curso)
)ENGINE=INNODB;


/*Utilizando el sistema web responsivo que están desarrollando y la siguiente base de datos:
  1.- Crear el grupo  
  2.- Dentro del grupo TERCER BIMESTRE-DWII crear una opción que se llame HISTORIAL MEDICO 
  3.- Visualizar el listado de PACIENTES CON HISTORIAL MEDICOS (BUSCADOR CON SELECT PARA LA HERENCIA E INPUTS
   PARA LA TABLA HISTORIAL MEDICO)
  4.- Insertar HISTORIAL MEDICO utilizando un buscador para la herencia

Nota.- Enviar lo solicitado (Sistema web y base de datos) en una carpeta comprimida con el nombre Ev_TERCERBI_CAMACHO_DW2.rar
*/

CREATE TABLE Pacientes (
    id_paciente INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50),
    ap VARCHAR(50),
    ci INT NOT NULL,
    fecha_nac DATE NOT NULL,
    dirección VARCHAR(100),
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1)NOT NULL,
    PRIMARY KEY(id_paciente)
)ENGINE=INNODB;



CREATE TABLE HistorialMedico (
    id_historialmedico INT NOT NULL AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    fecha DATE NOT NULL,
    diagnóstico VARCHAR(255) NOT NULL,
    tratamiento VARCHAR(255)NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1)NOT NULL,
    PRIMARY KEY(id_historialmedico),
    FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente)
)ENGINE=INNODB;






CREATE TABLE personas(
id_persona INT NOT NULL AUTO_INCREMENT,
id_terminal INT NOT NULL,
ci VARCHAR(15) NOT NULL,
nombres VARCHAR(25) NOT NULL,
ap VARCHAR(15) NOT NULL,
am VARCHAR(15) NOT NULL,
telefono VARCHAR(15) NOT NULL,
direccion VARCHAR(25) NOT NULL,
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
genero CHAR(1) NOT NULL,
PRIMARY KEY(id_persona),
FOREIGN KEY(id_terminal) REFERENCES terminal_buses(id_terminal)
)ENGINE=INNODB;

CREATE TABLE usuarios(
id_usuario INT NOT NULL AUTO_INCREMENT,
id_persona INT NOT NULL,
usuario1 VARCHAR(30) NOT NULL,
clave VARCHAR(100) NOT NULL,
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
PRIMARY KEY(id_usuario),
FOREIGN KEY(id_persona) REFERENCES personas(id_persona)
)ENGINE=INNODB;

CREATE TABLE roles(
id_rol INT NOT NULL AUTO_INCREMENT,
rol VARCHAR(25) NOT NULL,
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
PRIMARY KEY(id_rol)
)ENGINE=INNODB;

CREATE TABLE usuarios_roles(
id_usuario_rol INT NOT NULL AUTO_INCREMENT,
id_usuario INT NOT NULL,
id_rol INT NOT NULL,
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
PRIMARY KEY(id_usuario_rol),
FOREIGN KEY(id_usuario) REFERENCES usuarios(id_usuario),
FOREIGN KEY(id_rol) REFERENCES roles(id_rol)
)ENGINE=INNODB;

CREATE TABLE grupos(
id_grupo INT NOT NULL AUTO_INCREMENT,
grupo VARCHAR(25) NOT NULL,
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
PRIMARY KEY(id_grupo)
)ENGINE=INNODB;

CREATE TABLE opciones(
id_opcion INT NOT NULL AUTO_INCREMENT,
id_grupo INT NOT NULL,
opcion VARCHAR(30) NOT NULL, 
contenido VARCHAR(100) NOT NULL, 
orden INT NOT NULL,
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
PRIMARY KEY(id_opcion),
FOREIGN KEY(id_grupo) REFERENCES grupos(id_grupo)
)ENGINE=INNODB;

CREATE TABLE accesos(
id_acceso INT NOT NULL AUTO_INCREMENT,
id_opcion INT NOT NULL,
id_rol INT NOT NULL,
fec_insercion TIMESTAMP NOT NULL,
fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
estado CHAR(1) NOT NULL,
usuario INT NOT NULL,
PRIMARY KEY(id_acceso),
FOREIGN KEY(id_opcion) REFERENCES opciones(id_opcion),
FOREIGN KEY(id_rol) REFERENCES roles(id_rol)
)ENGINE=INNODB;








CREATE TABLE rubros(
    id_rubro INT NOT NULL AUTO_INCREMENT,
    rubro VARCHAR(30)NOT NULL,
    vida_util INT NOT NULL,
    porcen_depreciacion FLOAT NOT NULL,
    depreciacion VARCHAR(10)NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY(id_rubro)
)ENGINE=INNODB;

INSERT INTO rubros VALUES (1, 'Terrenos', 10, 10.00, 'NO', NOW(), NOW(), 1, 'A');
INSERT INTO rubros VALUES (2, 'Edificaciones', 40, 2.5, 'SI', NOW(), NOW(), 1, 'A');
INSERT INTO rubros VALUES (3, 'Muebles y Enseres de oficina', 10, 10.00, 'SI',  NOW(), NOW(), 1, 'A');
INSERT INTO rubros VALUES (4, 'Equipos de Computacion', 4, 25.00, 'SI',  NOW(), NOW(), 1, 'A');
INSERT INTO rubros VALUES (5, 'Vehiculo Automotores', 5, 20.00, 'SI',  NOW(), NOW(), 1, 'A');
INSERT INTO rubros VALUES (6, 'Herramientas en Generales', 4, 25.00, 'SI', NOW(), NOW(), 1, 'A');

CREATE TABLE categorias(
    id_categoria INT NOT NULL AUTO_INCREMENT,
    id_rubro INT NOT NULL,
    categoria_rubro VARCHAR(30)NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY(id_categoria),
    FOREIGN KEY(id_rubro)REFERENCES rubros(id_rubro)
)ENGINE=INNODB;

INSERT INTO categorias VALUES (1, 1,'Terreno', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (2, 2,'Edificacion',  NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (3, 2,'Vivienda',  NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (4, 3,'Pupitre', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (5, 3,'Silla', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (6, 3,'Mesa de Escritorio', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (7, 3,'Casillero Metalico', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (8, 3,'Casillero Madera', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (9, 3,'Ventilador', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (11, 4,'Computadora', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (12, 4,'Impresora', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (13, 4,'Proyector', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (14, 5,'Vehiculo', NOW(), NOW(), 1, 'A');
INSERT INTO categorias VALUES (15, 6,'Taladro', NOW(), NOW(), 1, 'A');

CREATE TABLE activos_fijos(
    id_activo_fijo INT NOT NULL AUTO_INCREMENT,
    id_categoria INT NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    fecha_adquisicion DATE NOT NULL, 
    fecha_activacion DATE, 
    fotografia VARCHAR(30),
    nro_documento VARCHAR(50),
    valor FLOAT,
    valor_residual FLOAT,
    responsable VARCHAR(50),
    depreciacion VARCHAR(50), /*del id_categoria 4 al 15*/
    marca_del_activo VARCHAR(25),  /*del id_categoria 9 al 15*/
    nro_serie_placa VARCHAR(20),  /*solo id_categoria 14*/
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY(id_activo_fijo),
    FOREIGN KEY(id_categoria) REFERENCES categorias(id_categoria)
)ENGINE=INNODB;







INSERT INTO terminal_buses VALUES (1,'TERMINAL DE BUSES TARIJA','BARRIO TORRECILLAS','46632452','logo.png',now(),now(),'A',1);

INSERT INTO empresas VALUES (1,1,'COPACABANA', '10003452','6626584', now(),now(),'A',1);
INSERT INTO empresas VALUES (2,1,'TRANS SAN ROQUE', '10036254','6632981', now(),now(),'A',1);
INSERT INTO empresas VALUES (3,1,'EXPRESO DEL SUR', '10000354','6678254', now(),now(),'A',1);
INSERT INTO empresas VALUES (4,1,'LINCE', '10054988','6699452', now(),now(),'A',1);
INSERT INTO empresas VALUES (5,1,'EXPRESO TARIJA', '10326574','6636541', now(),now(),'A',1);
INSERT INTO empresas VALUES (6,1,'TRANS VILLA DEL NORTE', '10965653','6645325', now(),now(),'A',1);
INSERT INTO empresas VALUES (7,1,'SAMA', '10366468','6624364', now(),now(),'A',1);
INSERT INTO empresas VALUES (8,1,'MEXICANO', '10936542','6656324', now(),now(),'A',1);
INSERT INTO empresas VALUES (9,1,'EXPRESO PADCAYA', '10002546','6625412', now(),now(),'A',1);
INSERT INTO empresas VALUES (10,1,'ROYAL CLASS', '10000236','6654236', now(),now(),'A',1);

INSERT INTO propietarios VALUES (1,1,'OSVALDO', 'CAYANI','MAMANI','7162152','72960652', now(),now(),'A',1);
INSERT INTO propietarios VALUES (2,2,'JULIO', 'TOCOCARY','MONTERO','7255642','71654181', now(),now(),'A',1);
INSERT INTO propietarios VALUES (3,3,'OSCAR', 'MAIRE','CASTILLO','5042584','74543760', now(),now(),'A',1);
INSERT INTO propietarios VALUES (4,4,'JUAN', 'ALTAMIRANO','SUAREZ','10452365','72965621', now(),now(),'A',1);
INSERT INTO propietarios VALUES (5,5,'SARAH', 'MANCILLA','GORDILLO','10457896','72965621', now(),now(),'A',1);
INSERT INTO propietarios VALUES (6,6,'THOMAS', 'PEREZ','JURADO','5751262','70230601', now(),now(),'A',1);
INSERT INTO propietarios VALUES (7,7,'ABIGAIL', 'LOPEZ','GARECA','3265874','70221463', now(),now(),'A',1);
INSERT INTO propietarios VALUES (8,8,'NORMA', 'CHOCALA','REYNOSO','188445','71145362', now(),now(),'A',1);
INSERT INTO propietarios VALUES (9,9,'PATRICIA', 'AYARDE','RETAMOSO','18716165','74563252', now(),now(),'A',1);
INSERT INTO propietarios VALUES (10,10,'ANDRES', 'VIDAURRE','ESPINOZA','5423954','71863257', now(),now(),'A',1);

INSERT INTO conductores VALUES (1,1,'FERNANDO', 'LOPEZ','CRUZ','6521654','70225646','1982-02-04', now(),now(),'A',1);
INSERT INTO conductores VALUES (2,2,'ERICH', 'MIRANDA','TOLEDO','3625446','75146925','1985-06-09', now(),now(),'A',1);
INSERT INTO conductores VALUES (3,3,'OMAR', 'RODRIGUEZ','TEJERINA','6335485','76136254','1989-03-05', now(),now(),'A',1);
INSERT INTO conductores VALUES (4,4,'JUAN MANUEL', 'DEL CASTILLO','SERRANO','1863254','70236583','1979-07-15', now(),now(),'A',1);
INSERT INTO conductores VALUES (5,5,'CARLOS', 'TERAN','AIRA','3625545','68686524','1990-11-21', now(),now(),'A',1);
INSERT INTO conductores VALUES (6,6,'DANIEL', 'SALVATIERRA','CHOQUE','9565452','78702527','1986-04-25', now(),now(),'A',1);
INSERT INTO conductores VALUES (7,7,'RICARDO', 'MURILLO','NINA','6425321','63251421','1982-07-19', now(),now(),'A',1);
INSERT INTO conductores VALUES (8,8,'ERLAND', 'CUELLAR','CONDORI','3659852','72965366','1988-12-12', now(),now(),'A',1);
INSERT INTO conductores VALUES (9,9,'JUAN CARLOS', 'SIVILA','SIVILA','7425521','76325418','1981-06-01', now(),now(),'A',1);
INSERT INTO conductores VALUES (10,10,'DEYMER', 'MOLINA','OBLITAS','8965212','71156840','1991-08-08', now(),now(),'A',1);

INSERT INTO autobuses VALUES (1,1,'VOLKSWAGEN', '2005', 65, '2256-KFG', now(),now(),'A',1);
INSERT INTO autobuses VALUES (2,2,'DAIMLER', '2010', 42, '3542-DFG', now(),now(),'A',1);
INSERT INTO autobuses VALUES (3,3,'MARCOPOLO', '1998', 38, '2054-MKL', now(),now(),'A',1);
INSERT INTO autobuses VALUES (4,4,'VOLVO', '1992', 45, '1865-WED', now(),now(),'A',1);
INSERT INTO autobuses VALUES (5,5,'DAIMLER', '2008', 42, '3045-TYU', now(),now(),'A',1);
INSERT INTO autobuses VALUES (6,6,'VOLKSWAGEN', '2000', 40, '2575-JNF', now(),now(),'A',1);
INSERT INTO autobuses VALUES (7,7,'VOLKSWAGEN', '2010', 65, '3512-EFH', now(),now(),'A',1);
INSERT INTO autobuses VALUES (8,8,'DAIMLER', '2015', 65, '4044-SKT', now(),now(),'A',1);
INSERT INTO autobuses VALUES (9,9,'MARCOPOLO', '1992', 51, '2431-DCS', now(),now(),'A',1);
INSERT INTO autobuses VALUES (10,10,'MARCOPOLO', '2018', 70, '5135-FFT', now(),now(),'A',1);

INSERT INTO conductores_autobuses VALUES (1,1,1,'2024-01-01', '2024-06-30', '08:00:00', '19:00:00', now(),now(),'A',1);
INSERT INTO conductores_autobuses VALUES (2,2,2,'2024-01-01', '2024-03-30', '08:00:00', '19:00:00', now(),now(),'A',1);
INSERT INTO conductores_autobuses VALUES (3,3,3,'2024-03-01', '2024-05-31', '08:00:00', '19:00:00', now(),now(),'A',1);
INSERT INTO conductores_autobuses VALUES (4,4,4,'2024-04-10', '2024-10-31', '08:00:00', '19:00:00', now(),now(),'A',1);
INSERT INTO conductores_autobuses VALUES (5,5,5,'2024-05-05', '2024-11-30', '08:00:00', '19:00:00', now(),now(),'A',1);
INSERT INTO conductores_autobuses VALUES (6,6,6,'2024-06-02', '2024-12-31', '08:00:00', '19:00:00', now(),now(),'A',1);
INSERT INTO conductores_autobuses VALUES (7,7,7,'2024-07-01', '2024-12-15', '08:00:00', '19:00:00', now(),now(),'A',1);
INSERT INTO conductores_autobuses VALUES (8,8,8,'2024-01-01', '2024-12-31', '08:00:00', '19:00:00', now(),now(),'A',1);
INSERT INTO conductores_autobuses VALUES (9,9,9,'2024-04-01', '2024-12-31', '08:00:00', '19:00:00', now(),now(),'A',1);
INSERT INTO conductores_autobuses VALUES (10,10,10,'2024-02-03', '2024-11-30', '08:00:00', '19:00:00', now(),now(),'A',1);

INSERT INTO rutas VALUES (1,'ASFALTO', '885', 'TARIJA', 'LA PAZ', now(),now(),'A',1);
INSERT INTO rutas VALUES (2,'ASFALTO/TIERRA', '218', 'TARIJA', 'TUPIZA', now(),now(),'A',1);
INSERT INTO rutas VALUES (3,'ASFALTO', '468', 'TARIJA', 'ORURO', now(),now(),'A',1);
INSERT INTO rutas VALUES (4,'ASFALTO', '885', 'TARIJA', 'LA PAZ', now(),now(),'A',1);
INSERT INTO rutas VALUES (5,'ASFALTO/TIERRA', '231', 'TARIJA', 'YACUIBA', now(),now(),'A',1);
INSERT INTO rutas VALUES (6,'ASFALTO', '244', 'TARIJA', 'POTOSI', now(),now(),'A',1);
INSERT INTO rutas VALUES (7,'ASFALTO', '477', 'TARIJA', 'SUCRE', now(),now(),'A',1);
INSERT INTO rutas VALUES (8,'ASFALTO/TIERRA', '752', 'TARIJA', 'SANTA CRUZ', now(),now(),'A',1);
INSERT INTO rutas VALUES (9,'ASFALTO', '801', 'TARIJA', 'COCHABAMBA', now(),now(),'A',1);
INSERT INTO rutas VALUES (10,'ASFALTO', '885', 'TARIJA', 'LA PAZ', now(),now(),'A',1);

INSERT INTO tarifas VALUES (1,1,1,'CAMA', 200, now(),now(),'A',1);
INSERT INTO tarifas VALUES (2,2,2,'SEMICAMA', 50, now(),now(),'A',1);
INSERT INTO tarifas VALUES (3,3,3,'SEMICAMA', 90, now(),now(),'A',1);
INSERT INTO tarifas VALUES (4,4,4,'SEMICAMA', 120, now(),now(),'A',1);
INSERT INTO tarifas VALUES (5,5,5,'SEMICAMA', 50, now(),now(),'A',1);
INSERT INTO tarifas VALUES (6,6,6,'SEMICAMA', 60, now(),now(),'A',1);
INSERT INTO tarifas VALUES (7,7,7,'SEMICAMA', 70, now(),now(),'A',1);
INSERT INTO tarifas VALUES (8,8,8,'CAMA', 180, now(),now(),'A',1);
INSERT INTO tarifas VALUES (9,9,9,'SEMICAMA', 120, now(),now(),'A',1);
INSERT INTO tarifas VALUES (10,10,10,'CAMA', 250, now(),now(),'A',1);

INSERT INTO horarios VALUES (1,'18:00:00', '2024-05-01', '11:00:00', '2024-05-02', now(),now(),'A',1);
INSERT INTO horarios VALUES (2,'22:00:00', '2024-05-01', '03:00:00', '2024-05-02', now(),now(),'A',1);
INSERT INTO horarios VALUES (3,'17:00:00', '2024-05-01', '04:00:00', '2024-05-02', now(),now(),'A',1);
INSERT INTO horarios VALUES (4,'14:30:00', '2024-05-01', '06:30:00', '2024-05-02', now(),now(),'A',1);
INSERT INTO horarios VALUES (5,'22:00:00', '2024-05-01', '03:00:00', '2024-05-02', now(),now(),'A',1);
INSERT INTO horarios VALUES (6,'22:00:00', '2024-05-01', '02:00:00', '2024-05-02', now(),now(),'A',1);
INSERT INTO horarios VALUES (7,'20:00:00', '2024-05-01', '06:00:00', '2024-05-02', now(),now(),'A',1);
INSERT INTO horarios VALUES (8,'19:00:00', '2024-05-01', '07:00:00', '2024-05-02', now(),now(),'A',1);
INSERT INTO horarios VALUES (9,'16:30:00', '2024-05-01', '10:30:00', '2024-05-02', now(),now(),'A',1);
INSERT INTO horarios VALUES (10,'17:30:00', '2024-05-01', '10:30:00', '2024-05-02', now(),now(),'A',1);

INSERT INTO horarios_autobuses VALUES (1,1,1,1, now(),now(),'A',1);
INSERT INTO horarios_autobuses VALUES (2,2,2,2, now(),now(),'A',1);
INSERT INTO horarios_autobuses VALUES (3,3,3,3, now(),now(),'A',1);
INSERT INTO horarios_autobuses VALUES (4,4,4,4, now(),now(),'A',1);
INSERT INTO horarios_autobuses VALUES (5,5,5,5, now(),now(),'A',1);
INSERT INTO horarios_autobuses VALUES (6,6,6,6, now(),now(),'A',1);
INSERT INTO horarios_autobuses VALUES (7,7,7,7, now(),now(),'A',1);
INSERT INTO horarios_autobuses VALUES (8,8,8,8, now(),now(),'A',1);
INSERT INTO horarios_autobuses VALUES (9,9,9,9, now(),now(),'A',1);
INSERT INTO horarios_autobuses VALUES (10,10,10,10, now(),now(),'A',1);

INSERT INTO pasajeros VALUES (1,'VERONICA', 'SANCHEZ','TOLABA','7162542','7162542010','73451520','1988-05-15', now(),now(),'A',1);
INSERT INTO pasajeros VALUES (2,'CLAUDIA PATRICIA', 'GARECA','LOPEZ','7113652','7113652012','71827682','1989-09-06', now(),now(),'A',1);
INSERT INTO pasajeros VALUES (3,'SARA', 'MACHICADO','ARIAS','5005427','5005427015','77875040','1992-08-15', now(),now(),'A',1);
INSERT INTO pasajeros VALUES (4,'JORGE ALBERTO', 'CASSO','RUIZ','4142646','4142646010','70236541','1999-07-15', now(),now(),'A',1);
INSERT INTO pasajeros VALUES (5,'SERGIO', 'CORRILLO','ARENAS','3625487','3625487010','72958428','1990-11-21', now(),now(),'A',1);
INSERT INTO pasajeros VALUES (6,'RICARDO', 'PEREZ','VALLE','4253564','4253564010','74536451','1998-11-25', now(),now(),'A',1);
INSERT INTO pasajeros VALUES (7,'JULIO', 'CABEZAS','MEALLA','5366248','100015452','75193719','2015-09-21', now(),now(),'A',1);
INSERT INTO pasajeros VALUES (8,'JULIA', 'AYDEE','LEON','8562541','8562541015','70221860','1997-12-30', now(),now(),'A',1);
INSERT INTO pasajeros VALUES (9,'MARIO', 'MOTERO','DIAZ','3254125','3254125015','73469548','1937-06-23', now(),now(),'A',1);
INSERT INTO pasajeros VALUES (10,'MARIELA', 'ARMELLA','PONCE','4528652','1000524587','77171694','2018-03-03', now(),now(),'A',1);

INSERT INTO Reservas VALUES (1,1,1,'2024-05-01', '14:00:00', now(),now(),'A',1);
INSERT INTO Reservas VALUES (2,2,2,'2024-05-01', '18:00:00', now(),now(),'A',1);
INSERT INTO Reservas VALUES (3,3,3,'2024-05-01', '18:00:00', now(),now(),'A',1);
INSERT INTO Reservas VALUES (4,4,4,'2024-05-01', '10:30:00', now(),now(),'A',1);
INSERT INTO Reservas VALUES (5,5,5,'2024-05-01', '18:00:00', now(),now(),'A',1);
INSERT INTO Reservas VALUES (6,6,6,'2024-05-01', '18:00:00', now(),now(),'A',1);
INSERT INTO Reservas VALUES (7,7,7,'2024-05-01', '16:00:00', now(),now(),'A',1);
INSERT INTO Reservas VALUES (8,8,8,'2024-05-01', '15:00:00', now(),now(),'A',1);
INSERT INTO Reservas VALUES (9,9,9,'2024-05-01', '12:30:00', now(),now(),'A',1);
INSERT INTO Reservas VALUES (10,10,10,'2024-05-01','13:30:00', now(),now(),'A',1);

INSERT INTO equipajes VALUES (1,1,1,'LA PAZ', '1305-LPZ', '2024-05-01', now(),now(),'A',1);
INSERT INTO equipajes VALUES (2,2,2,'TUPIZA', '1532-TUP', '2024-05-01', now(),now(),'A',1);
INSERT INTO equipajes VALUES (3,3,3,'ORURO', '0632-ORU', '2024-05-01', now(),now(),'A',1);
INSERT INTO equipajes VALUES (4,4,4,'LA PAZ', '2548-LPZ', '2024-05-01', now(),now(),'A',1);
INSERT INTO equipajes VALUES (5,5,5,'YACUIBA', '0068-YCB', '2024-05-01', now(),now(),'A',1);
INSERT INTO equipajes VALUES (6,6,6,'POTOSI', '9652-POT', '2024-05-01', now(),now(),'A',1);
INSERT INTO equipajes VALUES (7,7,7,'SUCRE', '0895-SUC', '2024-05-01', now(),now(),'A',1);
INSERT INTO equipajes VALUES (8,8,8,'SANTA CRUZ', '7859-SCZ', '2024-05-01', now(),now(),'A',1);
INSERT INTO equipajes VALUES (9,9,9,'COCHABAMBA', '4578-CBBA', '2024-05-01', now(),now(),'A',1);
INSERT INTO equipajes VALUES (10,10,10,'LA PAZ', '6398-LPZ', '2024-05-01', now(),now(),'A',1);

INSERT INTO CURSOS VALUES (1, 'primero', 'A', now(),now(),'A',1);
INSERT INTO CURSOS VALUES (2, 'segundo', 'A', now(),now(),'A',1);
INSERT INTO CURSOS VALUES (3, 'tercero', 'A', now(),now(),'A',1);
INSERT INTO CURSOS VALUES (4, 'cuarto','A', now(),now(),'A',1);
INSERT INTO CURSOS VALUES (5, 'primero','B', now(),now(),'A',1);

INSERT INTO MATERIAS VALUES (1,3,'MATEMATICAS','MAT', '8 horas',now(),now(),'A',1);
INSERT INTO MATERIAS VALUES (2,4,'LENGUAJE','LENG' , '8 horas',now(),now(),'A',1);
INSERT INTO MATERIAS VALUES (3,2,'ESTUDIOS SOCIALES','EST-SOC' , '6 horas',now(),now(),'A',1);
INSERT INTO MATERIAS VALUES (4,3,'RELIGION','REG' ,'3 horas',now(),now(),'A',1);

INSERT INTO Pacientes VALUES(1,'Bere','Naranjo','62641910','1995-01-20','Entre rios',now() ,now() ,1, 'A');
INSERT INTO Pacientes VALUES(2,'Alexis','Campos','62507450','2000-01-21','B.Artesanal',now() ,now() ,1, 'A');
INSERT INTO Pacientes VALUES(3,'Sergio','Campos','93073324','2004-01-22','B.Morros blancos',now() ,now() ,1, 'A');
INSERT INTO Pacientes VALUES(4,'Diego','Barumen','11248353','2012-01-23','B.San bernardo',now() ,now() ,1, 'A');
INSERT INTO Pacientes VALUES(5,'Francisco','Escalante','74558064','2015-01-24','B.Catedral',now() ,now() ,1, 'A');
INSERT INTO Pacientes VALUES(6,'Aurora','Estrada','41719041','1987-01-25','Juan XXXIII',now() ,now() ,1,'A');
INSERT INTO Pacientes VALUES(7,'Fabiola','Estrada','98694644','2009-01-26','Los Chapacos',now() ,now() ,1, 'A');
INSERT INTO Pacientes VALUES(8,'Leonardo','Farias','76636932','2010-01-27','Senac',now() ,now() ,1, 'A');
INSERT INTO Pacientes VALUES(9,'Julio','Gallardo','46378129','2000-01-28','San Mateo',now() ,now() ,1, 'A');
INSERT INTO Pacientes VALUES(10,'Oscar','Jimenez','63444566','1998-01-29','San Lorenzo',now() ,now() ,1, 'A');

INSERT INTO HistorialMedico VALUES(1,1,'2024-01-12','Gripe','Reposo relativo',now() ,now() ,1, 'A');
INSERT INTO HistorialMedico VALUES(2,2,'2024-02-05','Hipertension','Dieta baja en sodio',now() ,now() ,1, 'A');
INSERT INTO HistorialMedico VALUES(3,3,'2024-03-01','Diabetes tipo 2','Control de la dieta',now() ,now() ,1, 'A');
INSERT INTO HistorialMedico VALUES(4,4,'2024-03-25','Infeccion de garganta','Analgesicos',now() ,now() ,1, 'A');
INSERT INTO HistorialMedico VALUES(5,5,'2024-04-18','Neumonia','Antibioticos',now() ,now() ,1, 'A');
INSERT INTO HistorialMedico VALUES(6,6,'2024-05-12','Dolor de espalda','Reposo relativo',now() ,now() ,1, 'A');
INSERT INTO HistorialMedico VALUES(7,7,'2024-01-05','Asma','Innaladores',now() ,now() ,1, 'A');
INSERT INTO HistorialMedico VALUES(8,8,'2024-05-29','Infeccion de tracto urinario','Antibioticos',now() ,now() ,1, 'A');
INSERT INTO HistorialMedico VALUES(9,9,'2024-02-23','Dermatitis atopica','Hidratantes',now() ,now() ,1, 'A');
INSERT INTO HistorialMedico VALUES(10,10,'2024-01-16','Gastritis','Dieta Suave',now() ,now() ,1, 'A');

INSERT INTO personas VALUES (1,1,7162152,'OSVALDO CESAR','CAYANI','MAMANI','72960652','B/15 DE ABRIL',now(),now(),'A',1,'M');
INSERT INTO personas VALUES (2,1,1241245,'ANTONIO','ROMERO','RUA','7298888','BARRIO ROSEDAL',now(),now(),'A',1,'M');
INSERT INTO personas VALUES (3,1,7785466,'ROBERTO','ERQUICIA','ROBLES','72956231','BARRIO AEROPUERTO',now(),now(),'A',1,'M');
INSERT INTO personas VALUES (4,1,7145247,'JOSE LUIS','CHUQUIMIA','PERALES','70220601','BARRIO PALMARCITO',now(),now(),'A',1,'M');
INSERT INTO personas VALUES (5,1,78705258,'LUIS ALBERTO','YURQUINA','DIAZ','70238542','BARRIO PANOSAS',now(),now(),'A',1,'M');
INSERT INTO personas VALUES (6,1,76145240,'FELIX ALDO','ACEBEY','ACEBEY','75147560','BARRIO PETROLERO',now(),now(),'A',1,'M');
INSERT INTO personas VALUES (7,1,70785677,'CARLOS','TEJERINA','RUBIALES','72945851','BARRIO CENTRAL',now(),now(),'A',1,'M');
INSERT INTO personas VALUES (8,1,75147855,'JORGE ALBERTO','ARBITA','JUVENAL','7510000','BARRIO CATEDRAL',now(),now(),'A',1,'M');
INSERT INTO personas VALUES (9,1,72985422,'RICHARD','FERNANDEZ','TORREZ','78568426','BARRIO PORTILLO',now(),now(),'A',1,'M');
INSERT INTO personas VALUES (10,1,78545425,'JULIAN','MARTINEZ','GOMEZ','70238545','BARRIO ANDALUZ',now(),now(),'A',1,'M');

INSERT INTO usuarios VALUES (1,1,'admin','$2y$10$HxB1sZ3p/ok/Aa3cyATcsuGZoUrZzW5.TtmaiYh61S38axFgKVmXK',now(),now(),'A',1);
INSERT INTO usuarios VALUES (2,2,'user','$2y$10$HxB1sZ3p/ok/Aa3cyATcsuGZoUrZzW5.TtmaiYh61S38axFgKVmXK',now(),now(),'A',1);
INSERT INTO usuarios VALUES (3,3,'cesar','$2y$10$HxB1sZ3p/ok/Aa3cyATcsuGZoUrZzW5.TtmaiYh61S38axFgKVmXK',now(),now(),'A',1);

INSERT INTO roles VALUES (1,'ADMINISTRADOR',now(),now(),'A',1);
INSERT INTO roles VALUES (2,'INVITADO',now(),now(),'A',1);
INSERT INTO roles VALUES (3,'TECNICO',now(),now(),'A',1);

INSERT INTO usuarios_roles VALUES (1,1,1,now(),now(),'A',1);
INSERT INTO usuarios_roles VALUES (2,2,2,now(),now(),'A',1);
INSERT INTO usuarios_roles VALUES (3,3,3,now(),now(),'A',1);

INSERT INTO grupos VALUES (1,'HERRAMIENTAS',now(),now(),'A',1);
INSERT INTO grupos VALUES (2,'TERMINAL DE BUSES',now(),now(),'A',1);
INSERT INTO grupos VALUES (3,'REPORTES',now(),now(),'A',1);
INSERT INTO grupos VALUES (4,'TERCER BIMESTRE-DWII ',now(),now(),'A',1);
INSERT INTO grupos VALUES (5,'CUARTO BIMESTRE-DWII ',now(),now(),'A',1);

INSERT INTO opciones VALUES (1,1,'Personas','../privada/personas/personas.php',10,now(),now(),'A',1);
INSERT INTO opciones VALUES (2,1,'Usuarios','../privada/usuarios/usuarios.php',20,now(),now(),'A',1);
INSERT INTO opciones VALUES (3,1,'Grupos','../privada/grupos/grupos.php',30,now(),now(),'A',1);
INSERT INTO opciones VALUES (4,1,'Roles','../privada/roles/roles.php',40,now(),now(),'A',1);
INSERT INTO opciones VALUES (5,1,'Usuarios Roles','../usuarios_roles/usuarios_roles.php',50,now(),now(),'A',1);
INSERT INTO opciones VALUES (6,1,'Opciones','../privada/opciones/opciones.php',60,now(),now(),'A',1);
INSERT INTO opciones VALUES (7,1,'Accesos','../accesos/accesos.php',70,now(),now(),'A',1);
INSERT INTO opciones VALUES (8,2,'Terminal de Buses','../privada/terminal_buses/terminal_modificar.php',10,now(),now(),'A',1);
INSERT INTO opciones VALUES (9,2,'Empresas','../privada/empresas/empresas.php',20,now(),now(),'A',1);
INSERT INTO opciones VALUES (10,2,'Propietarios','../privada/propietarios/propietarios.php',30,now(),now(),'A',1);
INSERT INTO opciones VALUES (11,2,'Conductores','../privada/conductores/conductores.php',40,now(),now(),'A',1);
INSERT INTO opciones VALUES (12,2,'Autobuses','../privada/autobuses/autobuses.php',50,now(),now(),'A',1);
INSERT INTO opciones VALUES (13,2,'Conductores Autobuses','../privada/conductores_autobuses/conductores_autobuses.php',60,now(),now(),'A',1);
INSERT INTO opciones VALUES (14,2,'Rutas','../privada/rutas/rutas.php',70,now(),now(),'A',1);
INSERT INTO opciones VALUES (15,2,'Tarifas','../privada/tarifas/tarifas.php',80,now(),now(),'A',1);
INSERT INTO opciones VALUES (16,2,'Horarios','../privada/horarios/horarios.php',90,now(),now(),'A',1);
INSERT INTO opciones VALUES (17,2,'Horarios Autobuses','../privada/horarios_autobuses/horarios_autobuses.php',90,now(),now(),'A',1);
INSERT INTO opciones VALUES (18,2,'Pasajeros','../privada/pasajeros/pasajeros.php',100,now(),now(),'A',1);
INSERT INTO opciones VALUES (19,2,'Reservas','../privada/reservas/reservas.php',100,now(),now(),'A',1);
INSERT INTO opciones VALUES (20,2,'Equipajes','../privada/equipajes/equipajes.php',110,now(),now(),'A',1);
INSERT INTO opciones VALUES (21,3,'Rpt Personas con Usuarios','../privada/reportes_personas/personas_usuarios.php',10,now(),now(),'A',1);
INSERT INTO opciones VALUES (22,3,'Rpt Personas con Fechas','../privada/reportes_personas/personas_fechas.php',20,now(),now(),'A',1);
INSERT INTO opciones VALUES (23,3,'Rpt Propietarios','../privada/reportes_propietarios/empresas_propietarios.php',30,now(),now(),'A',1);
INSERT INTO opciones VALUES (24,3,'Rpt Conductores','../privada/reportes_conductores/empresas_conductores.php',40,now(),now(),'A',1);
INSERT INTO opciones VALUES (25,3,'Rpt Genero','../privada/personas/personas_genero.php',50,now(),now(),'A',1);
INSERT INTO opciones VALUES (26,3,'Rpt Rutas','../privada/rutas/rutas_rt.php',60,now(),now(),'A',1);
INSERT INTO opciones VALUES (27,3,'Ficha Tecnica Personas','../privada/ficha_tec_personas/ficha_tec_personas.php',70,now(),now(),'A',1);
INSERT INTO opciones VALUES (28,4,'Materias','../privada/materias/materias.php',10,now(),now(),'A',1);
INSERT INTO opciones VALUES (29,4,'Historial Medico','../privada/historial_medico/historial_medico.php',20,now(),now(),'A',1);
INSERT INTO opciones VALUES (30,5,'API - HOTELES','../privada/Apis/api.php',10,now(),now(),'A',1);
INSERT INTO opciones VALUES (31,5,'FORMULARIO DINAMICO','../privada/formu_dinamic/formu_dinamic.php',20,now(),now(),'A',1);


INSERT INTO accesos VALUES (1,1,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (2,2,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (3,3,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (4,4,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (5,5,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (6,6,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (7,7,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (8,8,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (9,9,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (10,10,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (11,11,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (12,12,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (13,13,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (14,14,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (15,15,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (16,16,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (17,17,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (18,18,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (19,19,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (20,20,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (21,21,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (22,22,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (23,23,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (24,24,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (25,25,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (26,26,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (27,27,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (28,28,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (29,29,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (30,30,1,now(),now(),'A',1);
INSERT INTO accesos VALUES (31,31,1,now(),now(),'A',1);

