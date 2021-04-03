const express = require('express');
const router = express.Router();
const pool = require('../database');

router.get('/agregarCliente', (req,res) =>{
    res.render('clientes/agregarCliente');
});

router.post('/agregarCliente', async (req,res) => {
    const {RUT,NOMBRE,APELLIDO,CORREO,DIRECCION,PASS,ROL,COMUNA} = req.body;
    await pool.query('call AGREGAR_USUARIO(?,?,?,?,?,?,?,?,?)',[RUT,NOMBRE,APELLIDO,CORREO,DIRECCION,ROL,RUTADM,COMUNA]);
    res.redirect('/index');
});


module.exports = router;