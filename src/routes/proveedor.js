const express = require('express');
const router = express.Router();
const pool = require('../database');


router.get('/listaProveedor', async (req, res) => {
    res.render('proveedor/listaProveedor');
});
router.get('/listaProveedorAjax', async (req, res) => {
    try {
        const proveedor = await pool.query("Select * from proveedor where estado = 1");
        res.send(proveedor);

    } catch (error) {
        console.log(error);

    }
});

router.get('/agregarProveedor', async (req, res) => {
    const regiones = await pool.query('SELECT * FROM REGION');
    res.render('proveedor/agregarProveedor', { regiones });
});



router.get('/regiones/:id', async (req, res) => {
    const comunas = await pool.query('Select * from comunas where Id_Region = ?', req.params.id);
    res.send(comunas);
});

router.post('/agregarProveedor', async (req, res) => {
    try {
        const { RUT, COMUNA, NOMBRE, TELEFONO, DIRECCION, NUMERO, CORREO } = req.body;
        await pool.query('call Agregar_Proveedor(?,?,?,?,?,?,?)', [RUT, COMUNA, NOMBRE, TELEFONO, DIRECCION, NUMERO, CORREO]);
        res.redirect('/proveedor/agregarProveedor');

    } catch (e) {

        console.log(e);
    }
});

router.get('/detalle/:rut', async (req,res) =>{
    try {
        const {rut} = req.params;
        const detalle = await pool.query("Select * from proveedor where Rut = ? ",rut);
        res.json(detalle);
  
        
    } catch (e) {
        
    }
   
  
  });

router.get('/editarProveedor/:rut', async (req, res) => {
    try {
        const { rut } = req.params;
        const proveedor = await pool.query('Select * from v_proveedor where idProveedor = ?', [rut]);
        const regiones = await pool.query('SELECT * FROM REGION');
        console.log(proveedor);
        res.render('proveedor/editarProveedor', { pv: proveedor[0], regiones })
    } catch (e) {
        console.log(e);
    }

});

router.post('/editarProveedor/:id', async (req,res) =>{
    try {
        const {COMUNA, NOMBRE, TELEFONO, DIRECCION, NUMERO, CORREO} = req.body;
        const {id} = req.params;  
        console.log(req.body);  
        await pool.query('call Actualizar_Proveedor(?,?,?,?,?,?,?)',[id, COMUNA, NOMBRE, TELEFONO, DIRECCION, NUMERO, CORREO]);
        res.redirect('/');
        
    } catch (e) {
        console.log(e);
    }
});

router.post('/eliminarProveedor/:id', async (req,res) =>{
    try {
        const {id} = req.params;
        const proveedor = await pool.query('call eliminar_Proveedor (?)',[id]);
        res.send(proveedor);
        console.log(proveedor);
        console.log(id);
    } catch (e) {
        console.log(e)
    }
});

module.exports = router;