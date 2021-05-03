"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const pool = require('../database');
class GamesController {
    cargarTemporal(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            yield pool.query("");
            res.json({ message: 'Datos Cargados' });
        });
    }
    cargarModelo(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            yield pool.query(`	


    `);
            res.json({ message: 'Datos Cargados' });
        });
    }
    deleteTemporal(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            yield pool.query('');
            res.json({ messaage: 'Tabla temporal Borrada' });
        });
    }
    deleteModelo(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            yield pool.query('    ');
            res.json({ messaage: 'Tabla Prueba Borrada' });
        });
    }
    //reporte 1
    reporte1(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const games = yield pool.query(`
--  Consulta 1  ----   12 Registros
select Profesional.nombre, count(Invento.id) as No_inventos from  asig_invento, Profesional, invento
where asig_invento.Profesional_id = Profesional.id and asig_invento.invento_id = invento.id
group by profesional.nombre order by No_inventos DESC;
     `);
            res.json(games);
        });
    }
    reporte2(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const games = yield pool.query(`
    -- consulta 2
    select pais.nombre, count(respuesta.id) as contestado
    from pais_respuesta
    right join pais on pais_respuesta.pais_id
    = pais.id
    left join respuesta on pais_respuesta.respuesta_id = respuesta.id
    group by pais.nombre
    order by contestado DESC;
         `);
            res.json(games);
        });
    }
    reporte3(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const games = yield pool.query(`
    -- CONSULTA 3
    SELECT DISTINCT frontera_pais.nombre FROM invento
    RIGHT JOIN 
    (
    SELECT pais.id, pais.nombre FROM frontera
    Right JOIN pais ON frontera.pais_id = pais.id
    WHERE NORTE IS NULL AND SUR IS NULL AND ESTE IS NULL AND OESTE IS NULL
    AND frontera.pais_id2 IS NULL
    ) AS frontera_pais         ON invento.pais_id = frontera_pais.id
    WHERE invento.pais_id IS NULL
    order by frontera_pais.nombre;
         `);
            res.json(games);
        });
    }
    reporte4(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const games = yield pool.query(`
            
            `);
            res.json(games);
        });
    }
    reporte5(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const games = yield pool.query(`
    -- CONSULTA 5
    SELECT profesional.nombre, areas.nombre as area, profesional.salario, areas.salario_prom FROM profe_area
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
         `);
            res.json(games);
        });
    }
    reporte6(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const games = yield pool.query(`
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
         `);
            res.json(games);
        });
    }
    reporte7(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const games = yield pool.query(`
    -- CONSULTA 7
    SELECT invento.nombre as invento, profesional.nombre as profesional FROM asig_invento
    INNER JOIN invento
    ON asig_invento.invento_id= invento.id
    INNER JOIN profesional
    ON asig_invento.profesional_id = profesional.id
    INNER JOIN profe_area
    ON profesional.id = profe_area.profesional_id
    INNER JOIN area
    ON profe_area.area_id = area.id
    WHERE area.nombre = 'Óptica';
         `);
            res.json(games);
        });
    }
    reporte8(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const games = yield pool.query(`
-- CONSULTA 8
SELECT substr(nombre,1,1) AS letra_Inicial, sum(area) as area FROM pais
GROUP BY letra_Inicial;  
         `);
            res.json(games);
        });
    }
    reporte9(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const games = yield pool.query(`
   -- CONSULTA 9
SELECT DISTINCT inventor.nombre as nombre, invento.nombre as invento FROM inventado
INNER JOIN invento
ON inventado.invento_id = invento.id
INNER JOIN inventor
ON inventado.invento_id = inventor.id
AND inventor.nombre LIKE 'BE%';
         `);
            res.json(games);
        });
    }
    reporte10(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const games = yield pool.query(`
    -- CONSULTA 10
    SELECT DISTINCT inventor.nombre, invento.nombre as invento, invento.anio FROM inventado
    INNER JOIN invento
    ON inventado.invento_id = invento.id
    AND invento.anio > 1801 AND invento.anio <= 1900
    INNER JOIN inventor
    ON inventado.inventor_id = inventor.id
    AND inventor.nombre LIKE 'B%r';
         `);
            res.json(games);
        });
    }
    reporte11(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const games = yield pool.query(`
    -- CONSULTA 11 ---fall
    SELECT pais.id, pais.nombre, count(*) AS total FROM frontera
    INNER JOIN pais as pais
    ON frontera.pais_id = pais.id
    AND frontera.Pais_id2 is NOT NULL
    GROUP BY frontera.pais_id
    HAVING (count(*) > 7)
    ORDER BY total DESC;
         `);
            res.json(games);
        });
    }
    reporte12(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const games = yield pool.query(`
    -- CONSULTA 12
    SELECT * FROM invento
    WHERE char_length(nombre) < 4 AND nombre LIKE 'L%';
         `);
            res.json(games);
        });
    }
    reporte13(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const games = yield pool.query(`
    -- CONSULTA 13
    SELECT id, nombre, salario as salario_base, comision, (salario + comision) as salario_total FROM profesional
    WHERE comision > (0.24 * salario);
         `);
            res.json(games);
        });
    }
    reporte14(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const games = yield pool.query(`
-- CONSULTA 14
SELECT encuesta.nombre, count(*) as total FROM pais_respuesta
INNER JOIN respuesta ON pais_respuesta.respuesta_id = respuesta.id
INNER JOIN pregunta ON respuesta.pregunta_id = pregunta.id
INNER JOIN encuesta ON pregunta.encuesta_id = encuesta.id
INNER JOIN pais ON pais_respuesta.pais_id = pais.id
INNER JOIN region ON pais.region_id = region.id
GROUP BY encuesta.nombre;
         `);
            res.json(games);
        });
    }
    reporte15(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const games = yield pool.query(`
    -- CONSUTLA 15
    SELECT id, nombre, poblacion FROM pais
    WHERE pais.poblacion >
    (
    SELECT sum(pais.poblacion) FROM pais
    INNER JOIN region
    ON pais.region_id = region.id
    AND region.nombre = 'Centro America'
    );
         `);
            res.json(games);
        });
    }
    reporte16(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const games = yield pool.query(`
   
-- CONSULTA 16
SELECT profesional.nombre as profesional, area.nombre as area, area.ranking as ranking FROM area
INNER JOIN profesional
ON area.Profesional_id = profesional.id
AND area.nombre NOT IN 
(
SELECT DISTINCT area.nombre AS AREA
FROM asig_invento
INNER JOIN profesional ON asig_invento.profesional_id = profesional.id
INNER JOIN profe_area ON profesional.id = profe_area.profesional_id
INNER JOIN area ON profe_area.area_id = area.id
INNER JOIN invento ON asig_invento.invento_id = invento.id
INNER JOIN inventado ON invento.id = inventado.invento_id
INNER JOIN inventor
ON inventado.inventor_id = inventor.id
AND inventor.nombre = 'Pasteur'
)
AND area.nombre != 'TODAS'
AND area.Profesional_id IS NOT NULL;
         `);
            res.json(games);
        });
    }
    reporte17(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const games = yield pool.query(`
   -- CONSULTA 17
SELECT nombre, anio FROM invento
WHERE anio in
(
SELECT anio FROM inventado
INNER JOIN invento ON inventado.invento_id = invento.id
INNER JOIN inventor ON inventado.inventor_id = inventor.id
AND inventor.nombre = 'BENZ'
);
         `);
            res.json(games);
        });
    }
    reporte18(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const games = yield pool.query(`
    -- CONSULTA 18
    SELECT pais.id, pais.nombre, pais.poblacion FROM frontera
    right JOIN pais
    ON frontera.pais_id = pais.id
    WHERE NORTE IS NULL AND SUR IS NULL AND ESTE IS NULL AND OESTE IS NULL
    AND frontera.pais_id2 IS NULL
    AND pais.area >=
    (SELECT area FROM pais WHERE nombre = 'Japon');
         `);
            res.json(games);
        });
    }
    reporte19(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const games = yield pool.query(`
   -- CONSULTA 19
SELECT DISTINCT pais1.nombre AS pais, pais2.nombre AS frontera FROM frontera
INNER JOIN pais pais1 ON frontera.pais_id = pais1.id
INNER JOIN pais pais2 ON frontera.pais_id2 = pais2.id
order by pais, frontera;
         `);
            res.json(games);
        });
    }
    reporte20(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const games = yield pool.query(`
    -- CONSULTA 20
    SELECT id, nombre, salario as salario_base, comision, (salario + comision) as salario_total FROM profesional
    WHERE salario > (2 * comision);
         `);
            res.json(games);
        });
    }
}
exports.gamesController = new GamesController();
