


--  Consulta 1  ----   12 Registros
select Profesional.nombre, count(Invento.id) as No_inventos from  asig_invento, Profesional, invento
where asig_invento.Profesional_id = Profesional.id and asig_invento.invento_id = invento.id
group by profesional.nombre order by No_inventos DESC;


-- consulta 2
select pais.nombre, count(respuesta.id) as contestado
from pais_respuesta
right join pais on pais_respuesta.pais_id
= pais.id
left join respuesta on pais_respuesta.respuesta_id = respuesta.id
group by pais.nombre
order by contestado DESC;


-- CONSULTA 3
SELECT DISTINCT frontera_pais.nombre, frontera_pais.area FROM invento
RIGHT JOIN 
(
SELECT pais.id, pais.nombre, pais.area, pais.poblacion FROM frontera
Right JOIN pais ON frontera.pais_id = pais.id
WHERE NORTE IS NULL AND SUR IS NULL AND ESTE IS NULL AND OESTE IS NULL
AND frontera.pais_id2 IS NULL
) AS frontera_pais         ON invento.pais_id = frontera_pais.id
WHERE invento.pais_id IS NULL
order by frontera_pais.area, frontera_pais.nombre;

-- CONSULTA 4
select consul.profe as jefe, consul.area as area, profesional.nombre as sub
from profe_area, profesional, area, 
(
select area.nombre as area,profesional.nombre as profe
from area, profesional
where area.Profesional_id = Profesional.id
) as consul
where profe_area.Profesional_id = profesional.id and area.nombre=consul.area and profe_area.Area_id= Area.id
order by jefe, area ASC;


-- CONSULTA 5
SELECT profesional.nombre, areas.nombre, profesional.salario, areas.salario_prom FROM profe_area
INNER JOIN profesional
ON profe_area.profesional_id = profesional.id
INNER JOIN area
ON profe_area.area_id = area.id
INNER JOIN 
(
	SELECT area.id, area.nombre, avg(salario) AS salario_prom FROM profe_area
	INNER JOIN profesional
	ON profe_area.profesional_id = profesional.id
	INNER JOIN area
	ON profe_area.area_id = area.id
	WHERE area.nombre is not null
	GROUP BY area.nombre
) areas
ON profe_area.area_id = areas.id
WHERE profesional.salario > areas.salario_prom;




-- CONSULTA 6
SELECT pais.nombre, count(*) as aciertos FROM pais
INNER JOIN pais_respuesta
ON pais_respuesta.pais_id = pais.id
INNER JOIN respuesta
ON pais_respuesta.respuesta_id = respuesta.id
INNER JOIN pregunta
ON respuesta.pregunta_id = pregunta.id
INNER JOIN encuesta
ON pregunta.encuesta_id = encuesta.id
INNER JOIN respuesta_correcta
ON respuesta_correcta.respuesta_id = respuesta.id
AND respuesta_correcta.pregunta_id = pregunta.id
GROUP BY pais.nombre
ORDER BY aciertos DESC;


-- CONSULTA 7
SELECT invento.nombre, profesional.nombre FROM asig_invento
INNER JOIN invento
ON asig_invento.invento_id= invento.id
INNER JOIN profesional
ON asig_invento.profesional_id = profesional.id
INNER JOIN profe_area
ON profesional.id = profe_area.profesional_id
INNER JOIN area
ON profe_area.area_id = area.id
WHERE area.nombre = 'Óptica';




-- CONSULTA 8
SELECT substr(nombre,1,1) AS Inicial, sum(area) FROM pais
GROUP BY Inicial;


-- CONSULTA 9
SELECT DISTINCT inventor.nombre, invento.nombre FROM inventado
INNER JOIN invento
ON inventado.invento_id = invento.id
INNER JOIN inventor
ON inventado.invento_id = inventor.id
AND inventor.nombre LIKE 'BE%';

-- CONSULTA 10
SELECT DISTINCT inventor.nombre, invento.nombre, invento.anio FROM inventado
INNER JOIN invento
ON inventado.invento_id = invento.id
AND invento.anio > 1801 AND invento.anio <= 1900
INNER JOIN inventor
ON inventado.inventor_id = inventor.id
AND inventor.nombre LIKE 'B%r';


-- CONSULTA 11 ---fall
SELECT pais.id, pais.nombre, count(*) AS total FROM frontera
INNER JOIN pais as pais
ON frontera.pais_id = pais.id
AND frontera.Pais_id2 is NOT NULL
GROUP BY frontera.pais_id
HAVING (count(*) > 7)
ORDER BY total DESC;


-- CONSULTA 12
SELECT * FROM invento
WHERE char_length(nombre) < 4 AND nombre LIKE 'L%';

-- CONSULTA 13
SELECT id, nombre, salario as salario_base, comision, (salario + comision) as salario_total FROM profesional
WHERE comision > (0.24 * salario);


-- CONSULTA 14
SELECT total_encuestas.nombre as nombre, count(*) AS total FROM 
(
	SELECT DISTINCT encuesta.nombre, pais_respuesta.Pais_id FROM pais_respuesta
	INNER JOIN respuesta ON pais_respuesta.Respuesta_id = Respuesta.id
	INNER JOIN pregunta ON respuesta.Pregunta_id = Pregunta.id
	INNER JOIN encuesta ON pregunta.Encuesta_id = Encuesta.id
) AS total_encuestas
GROUP BY total_encuestas.nombre
ORDER BY total DESC;

-- CONSUTLA 15
SELECT id, nombre, poblacion FROM pais
WHERE pais.poblacion >
(
SELECT sum(pais.poblacion) FROM pais
INNER JOIN region
ON pais.region_id = region.id
AND region.nombre = 'Centro America'
);



-- CONSULTA 16
SELECT profesional.nombre, area.nombre, area.ranking FROM area
INNER JOIN profesional
ON area.Profesional_id = profesional.id
AND area.nombre NOT IN 
(
SELECT DISTINCT area.nombre AS AREA
FROM asig_invento
INNER JOIN profesional
ON asig_invento.profesional_id = profesional.id
INNER JOIN profe_area
ON profesional.id = profe_area.profesional_id
INNER JOIN area
ON profe_area.area_id = area.id
INNER JOIN invento
ON asig_invento.invento_id = invento.id
INNER JOIN inventado
ON invento.id = inventado.invento_id
INNER JOIN inventor
ON inventado.inventor_id = inventor.id
AND inventor.nombre = 'Pasteur'
)
AND area.nombre != 'TODAS'
AND area.Profesional_id IS NOT NULL;



-- CONSULTA 17
SELECT nombre, anio FROM invento
WHERE anio in
(
SELECT anio FROM inventado
INNER JOIN invento
ON inventado.invento_id = invento.id
INNER JOIN inventor
ON inventado.inventor_id = inventor.id
AND inventor.nombre = 'BENZ'
);


-- CONSULTA 18
SELECT pais.id, pais.nombre, pais.poblacion FROM frontera
right JOIN pais
ON frontera.pais_id = pais.id
WHERE NORTE IS NULL AND SUR IS NULL AND ESTE IS NULL AND OESTE IS NULL
AND frontera.pais_id2 IS NULL
AND pais.area >=
(SELECT area FROM pais WHERE nombre = 'Japon');


-- CONSULTA 19
SELECT DISTINCT pais1.nombre AS pais, pais2.nombre AS frontera_con FROM frontera
INNER JOIN pais pais1
ON frontera.pais_id = pais1.id
INNER JOIN pais pais2
ON frontera.pais_id2 = pais2.id
order by pais, frontera_con;


-- CONSULTA 20
SELECT id, nombre, salario as salario_base, comision, (salario + comision) as salario_total FROM profesional
WHERE salario > (2 * comision);
