"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const paisesController_1 = require("../controllers/paisesController");
class PaisesRoutes {
    constructor() {
        this.router = express_1.Router();
        this.config();
    }
    config() {
        //para respuestas correctas
        this.router.get('/inventos/solo/uno/get/obtener/inventado/correcta/:id', paisesController_1.paisesController.getAllCorrectas);
        this.router.get('/inventos/solo/uno/get/obtener/inventado/correcta/co/:id', paisesController_1.paisesController.getAllRespuestas);
        this.router.delete('/p/in/ventado/correcta/:pregunta_id/:respuesta_id', paisesController_1.paisesController.deleteCorrectas);
        this.router.post('/p/p/crear/objeto/invent/inventado/correcta', paisesController_1.paisesController.createCorrecta);
        //para inventores
        this.router.get('/inventos/solo/uno/get/obtener/inventado/all/', paisesController_1.paisesController.listInventores);
        this.router.delete('/p/in/ventado/:invento_id/:inventor_id', paisesController_1.paisesController.deleteInventado);
        //Para Inventados
        this.router.post('/p/p/crear/objeto/invent/inventado', paisesController_1.paisesController.createInventado);
        this.router.get('/inventos/solo/uno/get/obtener/inventado/:id', paisesController_1.paisesController.getAllInventados);
        this.router.put('/inventos/actual/put/inventado/:id', paisesController_1.paisesController.updateInventado);
        // para inventos
        this.router.get('/inventos/list/get/', paisesController_1.paisesController.listInventos);
        this.router.get('/inventos/solo/uno/get/obtener/:id', paisesController_1.paisesController.getOneInvento);
        this.router.put('/inventos/actual/put/:id', paisesController_1.paisesController.updateInvento);
        //Para paises
        this.router.get('/', paisesController_1.paisesController.list);
        this.router.get('/p/', paisesController_1.paisesController.listRegiones);
        this.router.get('/pa/pa/get/obtener/:id', paisesController_1.paisesController.getOnePais);
        this.router.post('/p/p/crear/objeto/', paisesController_1.paisesController.createPais);
        this.router.put('/p/:id', paisesController_1.paisesController.updatePais);
        this.router.delete('/p/:id', paisesController_1.paisesController.deletePais);
        this.router.get('/preguntas', paisesController_1.paisesController.listPreguntas);
        this.router.get('/encuestas/all', paisesController_1.paisesController.listEncuestas);
        // para las preguntas
        this.router.get('/pregunta/obtener/:id', paisesController_1.paisesController.getOnePregunta);
        this.router.post('/pregunta/crear/objeto/', paisesController_1.paisesController.createPregunta);
        this.router.put('/:id', paisesController_1.paisesController.updatePregunta);
        this.router.delete('/:id', paisesController_1.paisesController.deletePregunta);
    }
}
const paisesRoutes = new PaisesRoutes();
exports.default = paisesRoutes.router;
