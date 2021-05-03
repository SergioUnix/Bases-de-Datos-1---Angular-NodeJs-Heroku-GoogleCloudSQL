create database pro2;
use pro2;

-- Habilito la carga masiva en mysql
SET GLOBAL local_infile=1;
SHOW GLOBAL VARIABLES LIKE 'local_infile';
SHOW VARIABLES LIKE "secure_file_priv"; 

--  Primera tabla temporal
CREATE TABLE temp1(
	INVENTO VARCHAR(250),
	INVENTOR VARCHAR(250),
	PROFESIONAL_ASIGANDO_AL_INVENTO VARCHAR(250),
	EL_PROFESIONAL_ES_JEFE_DEL_AREA VARCHAR(250),
	FECHA_CONTRATO_PROFESIONAL VARCHAR(250),
	SALARIO int,
	COMISION int,
	AREA_INVEST_DEL_PROF VARCHAR(250),
	RANKING VARCHAR(250),
	ANIO_DEL_INVENTO  VARCHAR(250),
	PAIS_DEL_INVENTO VARCHAR(250),
	PAIS_DEL_INVENTOR VARCHAR(250),
	REGION_DEL_PAIS VARCHAR(250),
	CAPITAL VARCHAR(250),
	POBLACION_DEL_PAIS VARCHAR(250),
	AREA_EN_KM2 VARCHAR(250),
	FRONTERA_CON VARCHAR(250),
	NORTE CHAR(1) ,
	SUR CHAR(1) ,
	ESTE CHAR(1) ,
	OESTE CHAR(1) 
);

-- select * from temp1;
-- drop table temp1;


-- C:\ProgramData\MySQL\MySQL Server 8.0\Data\pro2\CargaP-I.csv
LOAD DATA INFILE '/var/lib/mysql-files/CargaP-I.csv'  
	into table temp1
	character set latin1
	fields terminated by ';'
	lines terminated by '\n'
	ignore 1 lines
(INVENTO,INVENTOR,PROFESIONAL_ASIGANDO_AL_INVENTO,EL_PROFESIONAL_ES_JEFE_DEL_AREA,  FECHA_CONTRATO_PROFESIONAL,
@SALARIO,@COMISION,AREA_INVEST_DEL_PROF,RANKING,ANIO_DEL_INVENTO,PAIS_DEL_INVENTO,PAIS_DEL_INVENTOR,REGION_DEL_PAIS,
CAPITAL,POBLACION_DEL_PAIS,AREA_EN_KM2,FRONTERA_CON,NORTE,SUR,ESTE,OESTE)
set 
COMISION = nullif(@COMISION, ''),
SALARIO = nullif(@SALARIO, '');



--  Segunda tabla temporal
CREATE TABLE temp2(
	NOMBRE_ENCUESTA VARCHAR(100) NOT NULL,
	PREGUNTA VARCHAR(500) NOT NULL,
	RESPUESTAS_POSIBLES VARCHAR(100) NOT NULL,
	RESPUESTA_CORRECTA VARCHAR(100) NOT NULL,
	PAIS VARCHAR(100) NOT NULL,
	RESPUESTA_PAIS CHAR(1) NOT NULL
);

-- C:\ProgramData\MySQL\MySQL Server 8.0\Data\pro2\CargaP-II.csv
LOAD DATA INFILE '/var/lib/mysql-files/CargaP-II.csv'  
	into table temp2
	character set latin1
	fields terminated by ';'
	lines terminated by '\n'
	ignore 1 lines
(NOMBRE_ENCUESTA,PREGUNTA,RESPUESTAS_POSIBLES,RESPUESTA_CORRECTA,PAIS,RESPUESTA_PAIS);


--  Tercera tabla temporal
CREATE TABLE temp3(
	NOMBRE_REGION VARCHAR(100) NOT NULL,
	REGION_PADRE VARCHAR(100) NOT NULL
);

-- C:\ProgramData\MySQL\MySQL Server 8.0\Data\pro2\CargaP-III.csv
LOAD DATA INFILE '/var/lib/mysql-files/CargaP-III.csv'  
	into table temp3
	character set latin1
	fields terminated by ';'
	lines terminated by '\n'
	ignore 1 lines
(NOMBRE_REGION,REGION_PADRE);





CREATE TABLE usuario(
   id_usuario INT NOT NULL AUTO_INCREMENT,
   nombre VARCHAR(45) NULL,
   apellido VARCHAR(45) NULL,  
   correo VARCHAR(45) NULL,    
   contrasenia VARCHAR(45) NULL,  
   confirmacion VARCHAR(45) NULL, 
   nac DATE,  
   pais VARCHAR(45) NULL, 
   foto VARCHAR(45) NULL,  
   creditos int null,
   fk_tipo INT NULL,
   PRIMARY KEY (`id_usuario`)
); 

insert into usuario (nombre,apellido,correo,contrasenia,confirmacion,nac,pais,foto,creditos,fk_tipo) values('sergio','ramirez',
'sergiounix@gmail.com','1234','Confirmado',STR_TO_DATE('12,8,1990','%d,%m,%Y'),'Guatemala','uploads/default/usuarios/sergio.jpg',10000,1);

