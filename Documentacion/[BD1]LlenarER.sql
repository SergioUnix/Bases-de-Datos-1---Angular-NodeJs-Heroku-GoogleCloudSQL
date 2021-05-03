
use pro2;

   -- 1 -- Llenar las Regiones
insert into Region(nombre)
select DISTINCT NOMBRE_REGION from temp3 WHERE REGION_PADRE = "\r" OR  REGION_PADRE = '' order by REGION_PADRE;



insert into Region(nombre,Region_id)
select DISTINCT NOMBRE_REGION, Region.id from temp3, Region
WHERE replace(REGION_PADRE, '\r','') = Region.nombre order by NOMBRE_REGION;


-- 2 -- Llenar Encuestas
INSERT INTO Encuesta(nombre)
select Distinct NOMBRE_ENCUESTA from temp2 order by NOMBRE_ENCUESTA;

-- 3 -- Llenar Pregunta
insert into Pregunta(pregunta, Encuesta_id)
select trim(temp2.PREGUNTA), Encuesta.id from Encuesta, temp2
 WHERE temp2.NOMBRE_ENCUESTA = Encuesta.nombre group by temp2.PREGUNTA, Encuesta.id;


-- 4 -- Llenar los paises  
insert into Pais(nombre,poblacion,area,capital,Region_id)
select  tab1.pais, tab1.poblacion, tab1.area, tab1.capital, region.id from Region,
(
select distinct PAIS_DEL_INVENTOR as pais, REGION_DEL_PAIS as region,
 CAPITAL as capital, POBLACION_DEL_PAIS as poblacion, AREA_EN_KM2 as area  
from temp1  order by PAIS_DEL_INVENTOR
) as tab1
where tab1.region = Region.nombre;



-- 5 -- Llenar Frontera

insert into Frontera(norte,sur,este,oeste, Pais_id, Pais_id2)
Select tab1.NORTE,tab1.SUR,tab1.ESTE,  tab1.OEST,    tab1.id1, Pais.id as id2   FROM Pais,
(
select Pais.id as id1, temp1.PAIS_DEL_INVENTOR as pais1 , temp1.FRONTERA_CON as pais2, temp1.NORTE as NORTE, temp1.SUR as SUR, temp1.ESTE as ESTE,  Replace(temp1.OESTE, '\r','') as OEST
from temp1, Pais where  temp1.PAIS_DEL_INVENTOR = Pais.nombre  group by id1, temp1.PAIS_DEL_INVENTOR , temp1.FRONTERA_CON, temp1.NORTE, temp1.SUR, temp1.ESTE,  OESTE order by id1, temp1.PAIS_DEL_INVENTOR ASC
) AS tab1
where tab1.pais2 = Pais.nombre;


-- 6 -- Llenar Invento
insert into Invento(nombre,anio,Pais_id)
Select tab1.nombre , tab1.anio, Pais.id from Pais,
(Select distinct INVENTO as nombre, ANIO_DEL_INVENTO as anio, PAIS_DEL_INVENTO as pais FROM temp1 where INVENTO !='') as tab1
where tab1.pais = Pais.nombre;

-- 7 -- Llenar la tabla Inventor
-- ----------------------    solamente un parametro

insert into Inventor(nombre,Pais_id)
select trim(tab1.nombre), trim(Pais.id) from Pais,
(Select distinct INVENTOR as nombre, PAIS_DEL_INVENTOR as pais FROM temp1 where INVENTOR !='') as tab1
where tab1.nombre Not LIKE '%,%' and Pais.nombre = tab1.pais;


-- --------------------  Solamente tres parametros
insert into Inventor(nombre,Pais_id)
select trim(part1),id from
(select tab1.nombre, tab1.pais, Pais.id,
SUBSTRING_INDEX(tab1.nombre,',',1) AS part1,
SUBSTRING_INDEX(SUBSTRING_INDEX(tab1.nombre,',',2),',',-1) AS part2, 
SUBSTRING_INDEX(tab1.nombre,',',-1) AS part3 from  Pais,
(Select distinct INVENTOR as nombre, PAIS_DEL_INVENTOR as pais FROM temp1 where INVENTOR !='') as tab1
where tab1.nombre LIKE '%,%,%' and Pais.nombre = tab1.pais   ) sub;

insert into Inventor(nombre,Pais_id)
select trim(part2),id from
(select tab1.nombre, tab1.pais, Pais.id,
SUBSTRING_INDEX(tab1.nombre,',',1) AS part1,
SUBSTRING_INDEX(SUBSTRING_INDEX(tab1.nombre,',',2),',',-1) AS part2, 
SUBSTRING_INDEX(tab1.nombre,',',-1) AS part3 from  Pais,
(Select distinct INVENTOR as nombre, PAIS_DEL_INVENTOR as pais FROM temp1 where INVENTOR !='') as tab1
where tab1.nombre LIKE '%,%,%' and Pais.nombre = tab1.pais   ) sub;

insert into Inventor(nombre,Pais_id)
select trim(part3),id from
(select trim(tab1.nombre), trim(tab1.pais), Pais.id,
SUBSTRING_INDEX(tab1.nombre,',',1) AS part1,
SUBSTRING_INDEX(SUBSTRING_INDEX(tab1.nombre,',',2),',',-1) AS part2, 
SUBSTRING_INDEX(tab1.nombre,',',-1) AS part3 from  Pais,
(Select distinct INVENTOR as nombre, PAIS_DEL_INVENTOR as pais FROM temp1 where INVENTOR !='') as tab1
where tab1.nombre LIKE '%,%,%' and Pais.nombre = tab1.pais   ) sub;

-- ----------------------------  sin tres parametros solamante dos parametros
insert into Inventor(nombre,Pais_id)
select trim(sub.part1), trim(Pais.id) from Pais, 
(select nom,pais,  part1, part2 from 
(select nombre as nom, pais as pais,
SUBSTRING_INDEX(nombre,',',1) AS part1,
SUBSTRING_INDEX(SUBSTRING_INDEX(nombre,',',2),',',-1) AS part2 from 
(Select distinct INVENTOR as nombre, PAIS_DEL_INVENTOR as pais FROM temp1 where INVENTOR !='') as tab1
where nombre NOT LIKE '%,%,%')  as tab2
where tab2.nom like '%,%' ) as sub
where sub.pais = Pais.nombre;

insert into Inventor(nombre,Pais_id)
select trim(sub.part2), trim(Pais.id) from Pais, 
(select nom,pais,  part1, part2 from 
(select nombre as nom, pais as pais,
SUBSTRING_INDEX(nombre,',',1) AS part1,
SUBSTRING_INDEX(SUBSTRING_INDEX(nombre,',',2),',',-1) AS part2 from 
(Select distinct INVENTOR as nombre, PAIS_DEL_INVENTOR as pais FROM temp1 where INVENTOR !='') as tab1
where nombre NOT LIKE '%,%,%')  as tab2
where tab2.nom like '%,%' ) as sub
where sub.pais = Pais.nombre;



-- 8 --  Inventado

-- ----------------------    solamente un parametro Inventor ---  para inventado
insert into Inventado(Inventor_id, Invento_id)
select id1, id2 from
(select sub.id1 as id1, sub.pais as pais, sub.invento as invento, sub.pais_i as pais_i , Invento.id as id2 from Invento,Pais,
(select  Inventor.id as id1,tab1.pais as pais, tab1.inventor as inventor, tab1.invento as invento, tab1.pais_i as pais_i 
from Inventor, pais,
(Select distinct PAIS_DEL_INVENTOR AS pais, INVENTOR as inventor, INVENTO as invento, PAIS_DEL_INVENTO AS pais_i FROM temp1 where INVENTOR !='') as tab1
where tab1.inventor Not LIKE '%,%'  and Inventor.nombre =tab1.inventor and Pais.nombre = tab1.pais and Pais.id = Inventor.Pais_id
order by tab1.inventor ASC) as sub
where Invento.nombre = sub.invento and Pais.nombre = sub.pais_i and Pais.id=Invento.Pais_id) as sub2
;



-- --------------------  Solamente tres parametros de Inventor  --- para la tabla Inventado
insert into Inventado(Inventor_id, Invento_id)
select id1, id2 from
(select sub2.id1 as id1, sub2.pais as pais, sub2.invento as invento, sub2.pais_i as pais_i , Invento.id as id2 from Invento,Pais,
(select  Inventor.id as id1, sub.pais as pais, sub.part1 as inventor1, sub.invento as invento, sub.pais_i as pais_i 
from Inventor, pais,
(select  tab1.pais as pais, tab1.inventor as inventor, tab1.invento as invento, tab1.pais_i as pais_i 
,trim(SUBSTRING_INDEX(tab1.inventor,',',1)) AS part1,
trim(SUBSTRING_INDEX(SUBSTRING_INDEX(tab1.inventor,',',2),',',-1)) AS part2, 
trim(SUBSTRING_INDEX(tab1.inventor,',',-1)) AS part3
from
(Select distinct PAIS_DEL_INVENTOR AS pais, INVENTOR as inventor, INVENTO as invento, PAIS_DEL_INVENTO AS pais_i FROM temp1 where INVENTOR !='') as tab1
where tab1.inventor LIKE '%,%,%'  
order by tab1.inventor ASC) as sub
where  Inventor.nombre =sub.part1 and Pais.nombre = sub.pais and Pais.id = Inventor.Pais_id
order by sub.inventor ASC) as sub2
where Invento.nombre = sub2.invento and Pais.nombre = sub2.pais_i and Pais.id=Invento.Pais_id) as sub3;


insert into Inventado(Inventor_id, Invento_id)
select id1, id2 from
(select sub2.id1 as id1, sub2.pais as pais, sub2.invento as invento, sub2.pais_i as pais_i , Invento.id as id2 from Invento,Pais,
(select  Inventor.id as id1, sub.pais as pais, sub.part2 as inventor2, sub.invento as invento, sub.pais_i as pais_i 
from Inventor, pais,
(select  tab1.pais as pais, tab1.inventor as inventor, tab1.invento as invento, tab1.pais_i as pais_i 
,trim(SUBSTRING_INDEX(tab1.inventor,',',1)) AS part1,
trim(SUBSTRING_INDEX(SUBSTRING_INDEX(tab1.inventor,',',2),',',-1)) AS part2, 
trim(SUBSTRING_INDEX(tab1.inventor,',',-1)) AS part3
from
(Select distinct PAIS_DEL_INVENTOR AS pais, INVENTOR as inventor, INVENTO as invento, PAIS_DEL_INVENTO AS pais_i FROM temp1 where INVENTOR !='') as tab1
where tab1.inventor LIKE '%,%,%'  
order by tab1.inventor ASC) as sub
where  Inventor.nombre =sub.part2 and Pais.nombre = sub.pais and Pais.id = Inventor.Pais_id
order by sub.inventor ASC) as sub2
where Invento.nombre = sub2.invento and Pais.nombre = sub2.pais_i and Pais.id=Invento.Pais_id) as sub3;


insert into Inventado(Inventor_id, Invento_id)
select id1, id2 from
(select sub2.id1 as id1, sub2.pais as pais, sub2.invento as invento, sub2.pais_i as pais_i , Invento.id as id2 from Invento,Pais,
(select  Inventor.id as id1, sub.pais as pais, sub.part3 as inventor3, sub.invento as invento, sub.pais_i as pais_i 
from Inventor, pais,
(select  tab1.pais as pais, tab1.inventor as inventor, tab1.invento as invento, tab1.pais_i as pais_i 
,trim(SUBSTRING_INDEX(tab1.inventor,',',1)) AS part1,
trim(SUBSTRING_INDEX(SUBSTRING_INDEX(tab1.inventor,',',2),',',-1)) AS part2, 
trim(SUBSTRING_INDEX(tab1.inventor,',',-1)) AS part3
from
(Select distinct PAIS_DEL_INVENTOR AS pais, INVENTOR as inventor, INVENTO as invento, PAIS_DEL_INVENTO AS pais_i FROM temp1 where INVENTOR !='') as tab1
where tab1.inventor LIKE '%,%,%'  
order by tab1.inventor ASC) as sub
where  Inventor.nombre =sub.part3 and Pais.nombre = sub.pais and Pais.id = Inventor.Pais_id
order by sub.inventor ASC) as sub2
where Invento.nombre = sub2.invento and Pais.nombre = sub2.pais_i and Pais.id=Invento.Pais_id) as sub3;

-- ----------------------------  sin tres parametros solamante dos parametros de Inventor -- para la tabla Inventado

insert into Inventado(Inventor_id, Invento_id)
select id1, id2 from
(select sub2.id1 as id1, sub2.pais as pais, sub2.invento as invento, sub2.pais_i as pais_i , Invento.id as id2 from Invento,Pais,
(select  Inventor.id as id1, sub.pais as pais, sub.part1 as inventor1, sub.invento as invento, sub.pais_i as pais_i 
from Inventor, pais,
(select tab2.pais as pais, tab2.inventor as inventor, tab2.invento as invento, tab2.pais_i as pais_i,
tab2.part1 as part1, tab2.part2 as part2  from
(select  tab1.pais as pais, tab1.inventor as inventor, tab1.invento as invento, tab1.pais_i as pais_i 
,trim(SUBSTRING_INDEX(tab1.inventor,',',1)) AS part1,
trim(SUBSTRING_INDEX(SUBSTRING_INDEX(tab1.inventor,',',2),',',-1)) AS part2
from
(Select distinct PAIS_DEL_INVENTOR AS pais, INVENTOR as inventor, INVENTO as invento, PAIS_DEL_INVENTO AS pais_i FROM temp1 where INVENTOR !='') as tab1
where tab1.inventor NOT LIKE '%,%,%'  
order by tab1.inventor ASC)as tab2
where tab2.inventor like '%,%' ) as sub
where  Inventor.nombre =sub.part1 and Pais.nombre = sub.pais and Pais.id = Inventor.Pais_id
order by sub.inventor ASC) as sub2
where Invento.nombre = sub2.invento and Pais.nombre = sub2.pais_i and Pais.id=Invento.Pais_id) as sub3;



insert into Inventado(Inventor_id, Invento_id)
select id1, id2 from
(select sub2.id1 as id1, sub2.pais as pais, sub2.invento as invento, sub2.pais_i as pais_i , Invento.id as id2 from Invento,Pais,
(select  Inventor.id as id1, sub.pais as pais, sub.part2 as inventor2, sub.invento as invento, sub.pais_i as pais_i 
from Inventor, pais,
(select tab2.pais as pais, tab2.inventor as inventor, tab2.invento as invento, tab2.pais_i as pais_i,
tab2.part1 as part1, tab2.part2 as part2  from
(select  tab1.pais as pais, tab1.inventor as inventor, tab1.invento as invento, tab1.pais_i as pais_i 
,trim(SUBSTRING_INDEX(tab1.inventor,',',1)) AS part1,
trim(SUBSTRING_INDEX(SUBSTRING_INDEX(tab1.inventor,',',2),',',-1)) AS part2
from
(Select distinct PAIS_DEL_INVENTOR AS pais, INVENTOR as inventor, INVENTO as invento, PAIS_DEL_INVENTO AS pais_i FROM temp1 where INVENTOR !='') as tab1
where tab1.inventor NOT LIKE '%,%,%'  
order by tab1.inventor ASC)as tab2
where tab2.inventor like '%,%' ) as sub
where  Inventor.nombre =sub.part2 and Pais.nombre = sub.pais and Pais.id = Inventor.Pais_id
order by sub.inventor ASC) as sub2
where Invento.nombre = sub2.invento and Pais.nombre = sub2.pais_i and Pais.id=Invento.Pais_id) as sub3;




-- 9 -- Llenar Profesional  
insert into Profesional(nombre,salario,fecha_contrato,comision)
select distinct temp1.PROFESIONAL_ASIGANDO_AL_INVENTO as prof,
temp1.SALARIO AS salario , STR_TO_DATE (temp1.FECHA_CONTRATO_PROFESIONAL, '%d/%m/%Y') as fecha , temp1.COMISION AS comision
from temp1 WHERE temp1.PROFESIONAL_ASIGANDO_AL_INVENTO != '';

-- 10 -- Llenar Tabla Asigna_invento
INSERT INTO asig_invento(Profesional_id, Invento_id)
select Profesional.id, Invento.id  from Pais,Invento,Profesional,
(select INVENTO as invento, PAIS_DEL_INVENTO as pais, PROFESIONAL_ASIGANDO_AL_INVENTO as prof FROM temp1
group by INVENTO, PAIS_DEL_INVENTO, PROFESIONAL_ASIGANDO_AL_INVENTO 
HAVING INVENTO !='' AND PAIS_DEL_INVENTO !='' AND PROFESIONAL_ASIGANDO_AL_INVENTO !=''  
ORDER BY INVENTO) as tab1
where Pais.id = Invento.Pais_id and Pais.nombre = tab1.pais and Invento.nombre =tab1.invento
and Profesional.nombre = tab1.prof;

-- 11 -- Llenar Tabla Area

-- SI HAY JEFE DE AREA LO INGRESA DE UNA VEZ
insert INTO Area(nombre, RANKING, Profesional_id)
select sub.area, sub.ranking, sub2.id_prof from 
(select distinct TRIM(AREA_INVEST_DEL_PROF) as area, RANKING as ranking   
FROM temp1 where AREA_INVEST_DEL_PROF !='') as sub,
(
select Profesional.id as id_prof,  
sub.prof as prof,  sub.area_jefe as area from Profesional,
 (select distinct PROFESIONAL_ASIGANDO_AL_INVENTO AS prof, TRIM(EL_PROFESIONAL_ES_JEFE_DEL_AREA) as area_jefe  
 FROM temp1 where EL_PROFESIONAL_ES_JEFE_DEL_AREA !=''and EL_PROFESIONAL_ES_JEFE_DEL_AREA !='TODAS') as sub
 where Profesional.nombre= sub.prof 
) as sub2
where sub.area=sub2.area;

-- -----------------SI NO HAY FEJE DE AREA SOLO LO INGRESA
insert INTO Area(nombre, RANKING)
select sub.area, sub.ranking from Area
RIGHT JOIN
(select distinct TRIM(AREA_INVEST_DEL_PROF) as area, RANKING as ranking   
FROM temp1 where AREA_INVEST_DEL_PROF !='') as sub
ON sub.area = Area.nombre where Area.id is null;



-- -------------------ingreso TOTODAS LAS AREAS
insert INTO Area(nombre,Profesional_id)
select sub.area,  sub2.id_prof from 
(select distinct TRIM(EL_PROFESIONAL_ES_JEFE_DEL_AREA) as area   
FROM temp1 where EL_PROFESIONAL_ES_JEFE_DEL_AREA !='' and EL_PROFESIONAL_ES_JEFE_DEL_AREA='TODAS') as sub,
(
select Profesional.id as id_prof,  
sub.prof as prof,  sub.area_jefe as area from Profesional, 
 (select distinct PROFESIONAL_ASIGANDO_AL_INVENTO AS prof, TRIM(EL_PROFESIONAL_ES_JEFE_DEL_AREA) as area_jefe  
 FROM temp1 where EL_PROFESIONAL_ES_JEFE_DEL_AREA !='') as sub
 where Profesional.nombre= sub.prof 
) as sub2
where sub.area=sub2.area;



-- 12 Llenar Profe_Area

insert profe_area(Profesional_id, Area_id)
select Profesional.id , Area.id from Profesional, Area,
(select distinct PROFESIONAL_ASIGANDO_AL_INVENTO AS prof,TRIM(AREA_INVEST_DEL_PROF) as area   
FROM temp1 where AREA_INVEST_DEL_PROF !='') as sub
where sub.prof =Profesional.nombre and sub.area = Area.nombre;


-- 13  Llenar Respuesta 
insert into Respuesta(respuesta,letra, Pregunta_id)
select respuestas, letra, Pregunta.id from Pregunta,
(Select distinct trim(SUBSTRING(temp2.RESPUESTAS_POSIBLES,LOCATE('.',temp2.RESPUESTAS_POSIBLES)+1, length(temp2.RESPUESTAS_POSIBLES))) as respuestas ,
SUBSTRING(temp2.RESPUESTAS_POSIBLES,1,1) AS letra, trim(temp2.PREGUNTA) as pregunta 
FROM temp2
where RESPUESTAS_POSIBLES !='' ) as sub
where Pregunta.pregunta = sub.pregunta;




-- 14 Llenar Pais_respuesta
insert into Pais_respuesta(Pais_id,Respuesta_id)
select Pais.id, Respuesta.id from Pais, Respuesta, Pregunta,
(select trim(temp2.PAIS) as pais, trim(temp2.RESPUESTA_PAIS) as respuesta , trim(temp2.PREGUNTA) as pre 
FROM temp2 group by temp2.PAIS, temp2.RESPUESTA_PAIS, temp2.PREGUNTA) as sub
where sub.pais =Pais.nombre and sub.respuesta= Respuesta.letra and Pregunta.pregunta =sub.pre
and Pregunta.id = Respuesta.Pregunta_id;






-- 15 Llenar Respuesta_Correcta

insert into Respuesta_correcta(Respuesta_id,Pregunta_id)
Select Respuesta.id, Pregunta.id from Pregunta, Respuesta,
(select trim(temp2.PREGUNTA) as pregunta, 
trim(SUBSTRING(temp2.RESPUESTA_CORRECTA,LOCATE('.',temp2.RESPUESTA_CORRECTA)+1, length(temp2.RESPUESTA_CORRECTA))) as correcta
FROM temp2  
group by  temp2.PREGUNTA, temp2.RESPUESTA_CORRECTA 
HAVING RESPUESTA_CORRECTA != '' ) as subconsulta
where Pregunta.pregunta = subconsulta.pregunta and Respuesta.respuesta = subconsulta.correcta 
and Pregunta.id = Respuesta.Pregunta_id;


insert into Respuesta_correcta(Pregunta_id)
Select Pregunta.id from Pregunta,
(select trim(temp2.PREGUNTA) as pregunta, 
trim(SUBSTRING(temp2.RESPUESTA_CORRECTA,LOCATE('.',temp2.RESPUESTA_CORRECTA)+1, length(temp2.RESPUESTA_CORRECTA))) as correcta
FROM temp2  
group by  temp2.PREGUNTA, temp2.RESPUESTA_CORRECTA 
HAVING RESPUESTA_CORRECTA = '' ) as subconsulta
where Pregunta.pregunta = subconsulta.pregunta;
