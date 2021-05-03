"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const gamesController_1 = require("../controllers/gamesController");
class GamesRoutes {
    constructor() {
        this.router = express_1.Router();
        this.config();
    }
    config() {
        this.router.get('/consulta1', gamesController_1.gamesController.reporte1);
        this.router.get('/consulta2', gamesController_1.gamesController.reporte2);
        this.router.get('/consulta3', gamesController_1.gamesController.reporte3);
        this.router.get('/consulta4', gamesController_1.gamesController.reporte4);
        this.router.get('/consulta5', gamesController_1.gamesController.reporte5);
        this.router.get('/consulta6', gamesController_1.gamesController.reporte6);
        this.router.get('/consulta7', gamesController_1.gamesController.reporte7);
        this.router.get('/consulta8', gamesController_1.gamesController.reporte8);
        this.router.get('/consulta9', gamesController_1.gamesController.reporte9);
        this.router.get('/consulta10', gamesController_1.gamesController.reporte10);
        this.router.get('/consulta11', gamesController_1.gamesController.reporte11);
        this.router.get('/consulta12', gamesController_1.gamesController.reporte12);
        this.router.get('/consulta13', gamesController_1.gamesController.reporte13);
        this.router.get('/consulta14', gamesController_1.gamesController.reporte14);
        this.router.get('/consulta15', gamesController_1.gamesController.reporte15);
        this.router.get('/consulta16', gamesController_1.gamesController.reporte16);
        this.router.get('/consulta17', gamesController_1.gamesController.reporte17);
        this.router.get('/consulta18', gamesController_1.gamesController.reporte18);
        this.router.get('/consulta19', gamesController_1.gamesController.reporte19);
        this.router.get('/consulta20', gamesController_1.gamesController.reporte20);
        this.router.get('/cargarTemporal', gamesController_1.gamesController.cargarTemporal);
        this.router.get('/cargarModelo', gamesController_1.gamesController.cargarModelo);
        this.router.get('/eliminarTemporal', gamesController_1.gamesController.deleteTemporal);
        this.router.get('/eliminarModelo', gamesController_1.gamesController.deleteModelo);
        //this.router.post('/', gamesController.create);       
        //this.router.delete('/:id', gamesController.delete);
    }
}
const gamesRoutes = new GamesRoutes();
exports.default = gamesRoutes.router;
