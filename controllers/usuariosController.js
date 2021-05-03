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
class UsuariosController {
    // Obtengo una lista menos el usuario administrador --------------
    list(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const usuarios = yield pool.query('SELECT cod_usuario, usuario.nombre, carne, correo, pasword, cod_rol_fk, rol.nombre as rol FROM proyecto_ionic.usuario inner join rol on rol.cod_rol = usuario.cod_rol_fk where usuario.cod_rol_fk !=1');
            res.json(usuarios);
        });
    }
    // Obtengo una lista de Auxiliares
    list_auxiliar(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const usu = yield pool.query('SELECT * FROM usuario where cod_rol_fk=2');
            res.json(usu);
        });
    }
    //Obtengo solo uno
    getOne(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const { id } = req.params;
            const usuarios = yield pool.query('SELECT * FROM usuario WHERE cod_usuario =?', [id]);
            if (usuarios.length > 0) {
                return res.json(usuarios[0]);
            }
            else {
                res.status(404).json({ text: 'El usuario no existe ' });
            }
        });
    }
    // Creo  
    create(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            //console.log(req.body);
            yield pool.query('INSERT INTO usuario set ?', [req.body]);
            res.json({ message: 'Usuario Guardado' });
        });
    }
    // Elimino
    delete(req, res) {
        const { id } = req.params;
        pool.query('DELETE FROM usuario WHERE cod_usuario =?', [id]);
        res.json({ messaage: 'El usuario fue eliminado' });
    }
    // Actualizar
    update(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const { id } = req.params;
            yield pool.query('UPDATE usuario set ? WHERE  cod_usuario=?', [req.body, id]);
            res.json({ massage: 'El usuario se ha sido actualizado' });
        });
    }
    // encontrar usuario para el login
    login(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            //const {id}=req.params;
            const { correo } = req.params;
            const { pass } = req.params;
            const usuarios = yield pool.query("Select * from usuario where correo=? and contrasenia=?", [correo, pass]);
            if (usuarios.length > 0) {
                return res.json(usuarios[0]);
            }
            else {
                res.status(404).json({ text: 'El usuario no encontrado' });
            }
        });
    }
}
exports.usuariosController = new UsuariosController();
