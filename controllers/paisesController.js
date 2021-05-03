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
class PaisesController {
    //obtengo todas las respuestas dada un id pregunta
    getAllRespuestas(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const { id } = req.params;
            const respuestas = yield pool.query(`select *  from respuesta where Pregunta_id =?`, [id]);
            if (respuestas.length > 0) {
                return res.json(respuestas);
            }
            else {
                res.status(404).json({ text: 'No existe respuestas' });
            }
        });
    }
    //Obtengo todas las correctas
    getAllCorrectas(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const { id } = req.params;
            const correctas = yield pool.query(`select p1.Pregunta_id, p1.Respuesta_id, p2.pregunta as pregunta, p3.respuesta as respuesta from respuesta_correcta as p1 
    inner join Pregunta as p2 on p1.Pregunta_id = p2.id 
    inner join Respuesta as p3 on p1.Respuesta_id = p3.id 
    where p1.Pregunta_id=?`, [id]);
            if (correctas.length > 0) {
                return res.json(correctas);
            }
            else {
                res.status(404).json({ text: 'No existe correctas' });
            }
        });
    }
    // Creo correctas  
    createCorrecta(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            //console.log(req.body);
            yield pool.query('insert into respuesta_correcta set ?', [req.body]);
            res.json({ message: 'Inventado Guardado' });
        });
    }
    //eliminar correctas
    deleteCorrectas(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            //const {id}=req.params;
            const { pregunta_id } = req.params;
            const { respuesta_id } = req.params;
            pool.query(`DELETE FROM respuesta_correcta WHERE 
    respuesta_correcta.Pregunta_id =? and respuesta_correcta.Respuesta_id = ?`, [pregunta_id, respuesta_id]);
            res.json({ messaage: 'Inventado eliminado' });
        });
    }
    deleteInventado(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            //const {id}=req.params;
            const { invento_id } = req.params;
            const { inventor_id } = req.params;
            pool.query(`DELETE FROM inventado WHERE 
        inventado.Invento_id =? and inventado.Inventor_id = ?`, [invento_id, inventor_id]);
            res.json({ messaage: 'Inventado eliminado' });
        });
    }
    // Creo Inventado  
    createInventado(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            //console.log(req.body);
            yield pool.query('insert into inventado set ?', [req.body]);
            res.json({ message: 'Inventado Guardado' });
        });
    }
    // inventores
    listInventores(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const paises = yield pool.query('select * from inventor;');
            res.json(paises);
        });
    }
    //Inventados
    getAllInventados(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const { id } = req.params;
            const preguntas = yield pool.query(`select p1.Invento_id, p1.Inventor_id, p2.nombre as invento, p3.nombre as inventor from inventado as p1 
    inner join Invento as p2 on p1.Invento_id = p2.id 
    inner join Inventor as p3 on p1.Inventor_id = p3.id 
    where p1.Invento_id=?`, [id]);
            if (preguntas.length > 0) {
                return res.json(preguntas);
            }
            else {
                res.status(404).json({ text: 'No existe inventado' });
            }
        });
    }
    // Actualizar
    updateInventado(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const { id } = req.params;
            yield pool.query('UPDATE', [req.body, id]);
            res.json({ massage: 'Actualizada' });
        });
    }
    listInventos(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const paises = yield pool.query('select * from invento;');
            res.json(paises);
        });
    }
    getOneInvento(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const { id } = req.params;
            const preguntas = yield pool.query('select * from invento where id =?', [id]);
            if (preguntas.length > 0) {
                return res.json(preguntas[0]);
            }
            else {
                res.status(404).json({ text: 'No existe invento' });
            }
        });
    }
    // Actualizar
    updateInvento(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const { id } = req.params;
            yield pool.query('UPDATE invento set ? WHERE  id=?', [req.body, id]);
            res.json({ massage: 'Actualizada' });
        });
    }
    // Obtengo una lista de todos los paises--------------
    list(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const paises = yield pool.query('select Pais.id, Pais.nombre,Pais.poblacion,Pais.area, Pais.capital, region.nombre as Region_id from pais, region where Pais.region_id =region.id  order by Pais.nombre ;');
            res.json(paises);
        });
    }
    // Obtengo una lista de todas las preguntas--------------
    listPreguntas(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const paises = yield pool.query('select pregunta.id, pregunta.pregunta, encuesta.nombre as Encuesta_id from pregunta, Encuesta where Encuesta.id =Pregunta.Encuesta_id;');
            res.json(paises);
        });
    }
    // Obtengo una lista de todas las Regiones--------------
    listEncuestas(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const paises = yield pool.query('select id, nombre from Encuesta;');
            res.json(paises);
        });
    }
    //Obtengo solo uno
    getOnePregunta(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const { id } = req.params;
            const preguntas = yield pool.query('select * from pregunta where id =?', [id]);
            if (preguntas.length > 0) {
                return res.json(preguntas[0]);
            }
            else {
                res.status(404).json({ text: 'No existe Pregunta' });
            }
        });
    }
    // Creo  
    createPregunta(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            //console.log(req.body);
            yield pool.query('insert into Pregunta set ?', [req.body]);
            res.json({ message: 'Usuario Guardado' });
        });
    }
    // Actualizar
    updatePregunta(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const { id } = req.params;
            yield pool.query('UPDATE pregunta set ? WHERE  id=?', [req.body, id]);
            res.json({ massage: 'pregunta Actualizada' });
        });
    }
    // Elimino
    deletePregunta(req, res) {
        const { id } = req.params;
        pool.query('DELETE FROM pregunta WHERE id =?', [id]);
        res.json({ messaage: 'la pregunta fue eliminada' });
    }
    // Obtengo una lista de todas las Regiones--------------
    listRegiones(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const paises = yield pool.query('select id, nombre, Region_id  from region;');
            res.json(paises);
        });
    }
    //Obtengo solo uno
    getOnePais(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const { id } = req.params;
            const paises = yield pool.query('select * from pais where id =?', [id]);
            if (paises.length > 0) {
                return res.json(paises[0]);
            }
            else {
                res.status(404).json({ text: 'No existe Pais' });
            }
        });
    }
    // Creo  
    createPais(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            //console.log(req.body);
            yield pool.query('insert into pais set ?', [req.body]);
            res.json({ message: 'Pais Guardado' });
        });
    }
    // Actualizar
    updatePais(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const { id } = req.params;
            yield pool.query('UPDATE pais set ? WHERE  id=?', [req.body, id]);
            res.json({ massage: 'Pais Actualizado' });
        });
    }
    // Elimino
    deletePais(req, res) {
        const { id } = req.params;
        pool.query('DELETE FROM pais WHERE id =?', [id]);
        res.json({ messaage: 'Pais eliminado' });
    }
}
exports.paisesController = new PaisesController();
