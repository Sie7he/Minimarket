const express = require('express');
const router = express.Router();
const pool = require('../database');

router.get('/agregarCliente', async (req,res) =>{
    const regiones = await pool.query('SELECT * FROM REGION');
    res.render('clientes/agregarCliente',{regiones});
   

});

router.get('/regiones/:id', async (req,res) =>{
    const comunas =  await pool.query('Select * from comunas where Id_Region = ?',req.params.id);
    console.log(comunas)
    res.json(comunas);
});


router.post('/agregarCliente', async (req,res) => {
    const {RUT,NOMBRE,APELLIDO,CORREO,DIRECCION,PASS,ROL,COMUNA} = req.body;
    await pool.query('call AGREGAR_USUARIO(?,?,?,?,?,?,?,?,?)',[RUT,NOMBRE,APELLIDO,CORREO,DIRECCION,ROL,RUTADM,COMUNA]);
    res.redirect('/index');
});


module.exports = router;