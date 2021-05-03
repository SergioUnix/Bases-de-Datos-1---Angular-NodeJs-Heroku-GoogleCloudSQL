use pro2;

-- Tablas de Entidad Relacion sintaxis mysql
CREATE TABLE Region (
     id int not null auto_increment,
     nombre text NOT NULL , 
     Region_id INT NULL,
     primary key(id),
     FOREIGN KEY (Region_id) REFERENCES Region(id)  
    );

CREATE TABLE Encuesta (
     id int not null auto_increment,
     nombre text NOT NULL,
     primary key (id) 
    );

CREATE TABLE Pregunta (
     id int not null auto_increment,
     pregunta text NOT NULL , 
     Encuesta_id INT NOT NULL,
     primary key(id), 
     FOREIGN KEY (Encuesta_id) REFERENCES Encuesta(id) 
    );

CREATE TABLE Pais (
     id int not null auto_increment,
     nombre text NOT NULL , 
     poblacion INT NOT NULL , 
     area INT NOT NULL , 
     capital text NOT NULL , 
     Region_id INT NOT NULL,
     primary key(id),
     FOREIGN KEY (Region_id) REFERENCES Region(id)  
    );

CREATE TABLE Frontera (
     norte CHAR(1) , 
     sur CHAR(1) , 
     este CHAR(1) , 
     oeste CHAR(1) , 
     Pais_id INT NOT NULL , 
     Pais_id2 INT NOT NULL,
     FOREIGN KEY (Pais_id) REFERENCES Pais(id),
     FOREIGN KEY (Pais_id2) REFERENCES Pais(id) 
    );

CREATE TABLE invento (
     id int not null auto_increment,
     nombre text NOT NULL , 
     anio INT NOT NULL , 
     Pais_id INT NOT NULL,
     primary key (id),
     FOREIGN KEY (Pais_id) REFERENCES Pais(id)  
    );

CREATE TABLE Inventor (
     id int not null auto_increment,
     nombre text NOT NULL , 
     Pais_id INT NOT NULL,
     primary key (id), 
     FOREIGN KEY (Pais_id) REFERENCES Pais(id)  
    );


CREATE TABLE Inventado (
     Inventor_id INT NOT NULL, 
     Invento_id INT NOT NULL,
     FOREIGN KEY (Inventor_id) REFERENCES Inventor(id),
     FOREIGN KEY (Invento_id) REFERENCES Invento(id) 
    );


CREATE TABLE Profesional (
     id int not null auto_increment,
     nombre text NOT NULL , 
     salario int NOT NULL , 
     fecha_contrato DATE NOT NULL , 
     comision int NULL,
     primary key(id)  
    );

CREATE TABLE asig_invento (
     Profesional_id INT NOT NULL , 
     invento_id INT NOT NULL ,
     FOREIGN KEY (Profesional_id) REFERENCES Profesional(id),
     FOREIGN KEY (invento_id) REFERENCES Invento(id)
    );

CREATE TABLE Area (
     id int not null auto_increment,  
     nombre text NOT NULL , 
     ranking INT NULL , 
     Profesional_id INT NULL, 
     primary key (id)
    );

CREATE TABLE Profe_area (
     Profesional_id INT NOT NULL , 
     Area_id INT NOT NULL,
     FOREIGN KEY (Profesional_id) REFERENCES Profesional(id),
     FOREIGN KEY (Area_id) REFERENCES Area(id)  
    );

CREATE TABLE Respuesta (
     id int not null auto_increment,
     respuesta text NOT NULL , 
     letra CHAR(1) NOT NULL , 
     Pregunta_id INT NOT NULL,
     primary key(id),
     FOREIGN KEY (Pregunta_id) REFERENCES Pregunta(id)  
    );

CREATE TABLE Pais_respuesta (
     Pais_id INT NOT NULL , 
     Respuesta_id INT NOT NULL ,
     FOREIGN KEY (Pais_id) REFERENCES Pais(id),
     FOREIGN KEY (Respuesta_id) REFERENCES Respuesta(id) 
    );

CREATE TABLE Respuesta_correcta (
     Respuesta_id INT  NULL , 
     Pregunta_id INT NOT NULL,
     FOREIGN KEY (Respuesta_id) REFERENCES Respuesta(id),
     FOREIGN KEY (Pregunta_id) REFERENCES Pregunta(id)  
    );
    
-- borrando todas las tablas
drop table Respuesta_correcta;
drop table Pais_respuesta;
drop table Respuesta;
drop table Profe_area;
drop table Area;
drop table asig_invento;
drop table Profesional;
drop table Inventado;
drop table Inventor;
drop table Invento;
drop table Frontera;
drop table Pais;
drop table Pregunta;
drop table Encuesta;
drop table Region;

drop table temp1;
drop table temp2;
drop table temp3;













    