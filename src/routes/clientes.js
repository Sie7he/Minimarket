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
   try {
    const {RUT,NOMBRE,APELLIDOP,APELLIDOM,TELEFONO,CORREO,CALLE,NUMERO,COMUNA,TIPO,SEXO} = req.body;
    await pool.query('call AGREGAR_CLIENTE(?,?,?,?,?,?,?,?,?,?,?)',[RUT,NOMBRE,APELLIDOP,APELLIDOM,TELEFONO,CORREO,CALLE,NUMERO,COMUNA,TIPO,SEXO]);
    res.redirect('/');
       
   } catch (e) {
       console.log(e);
   }
});

router.get('/editarCliente/:rut', async (req,res) =>{
    try {
        const {rut} = req.params;  
        const cliente = await pool.query('Select * from clientes where Rut = ?',[rut]);
        const regiones = await pool.query('SELECT * FROM REGION');
        res.render('clientes/editarCliente',{cl : cliente[0], regiones})
    } catch (e) {
        console.log(e);
    }

});

router.post('/editarCliente/:rut', async (req,res) =>{
    try {
        const {NOMBRE,APELLIDOP,APELLIDOM,TELEFONO,CORREO,CALLE,NUMERO,COMUNA,TIPO,SEXO} = req.body;
        const {rut} = req.params;  
        console.log(req.body);
        console.log(rut);
        await pool.query('call ACTUALIZAR_CLIENTE(?,?,?,?,?,?,?,?,?,?,?)',[rut,NOMBRE,APELLIDOP,APELLIDOM,TELEFONO,CORREO,CALLE,NUMERO,COMUNA,TIPO,SEXO]);
        res.redirect('/');
        
    } catch (e) {
        console.log(e);
    }
});


router.get('/eliminarCliente/:rut', async (req,res) =>{
    try {
        const {rut} = req.params;
        await pool.query('call ELIMINAR_CLIENTE (?)',[rut]);
        res.redirect('/');
        
    } catch (e) {
        console.log(e)
    }
});

module.exports = router;