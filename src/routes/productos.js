const express = require('express');
const router = express.Router();
const pool = require('../database');






router.get('/verProductos', async (req,res) =>{
    res.render('productos/verProductos');
   
 });

 router.get('/listaProductos', async (req,res) =>{
    const productos = await pool.query("SELECT * FROM v_productos  WHERE estado = 1 ORDER BY idProductos");
    res.send(productos);
});



 

 router.get('/agregarProductos', async (req,res) =>{
    const Proveedor = await pool.query('SELECT * FROM proveedor');
    const SubRubro = await pool.query('SELECT * FROM subrubro');
    res.render('productos/AgregarProductos',{Proveedor,SubRubro});
   

});

router.post('/agregarProductos', async (req,res) => {
    try {
     const {Prov,Sub,codigo,descr,gramo,med,precio,stock} = req.body;
     await pool.query('call Agregar_producto(?,?,?,?,?,?,?,?)',[Prov,Sub,codigo,descr,gramo,med,precio,stock]);
     res.redirect('/productos');
        
    } catch (e) {
 
        console.log(e);
    }
 });

 router.get('/editarProductos/:id', async (req,res) =>{
    try {
        const {id} = req.params;  
        const productos = await pool.query('Select * from v_productos where idProductos = ?',[id]);
        const Proveedor = await pool.query('SELECT * FROM proveedor');
        const SubRubro = await pool.query('SELECT * FROM subrubro');
        res.render('productos/editarProductos',{pr : productos[0],Proveedor,SubRubro})
        console.log(productos);
    } catch (e) {
        console.log(e);
    }

});
router.post('/editarProductos/:id', async (req,res) =>{
    try {
        const {Proveedor,SubRubro,Codigo,Descripcion,Gramage,medida,Precio,Stock} = req.body;
        const {id} = req.params;  
        console.log(req.body);
        console.log(id);
        await pool.query('call Actualizar_Productos(?,?,?,?,?,?,?,?,?)',[id,Proveedor,SubRubro,Codigo,Descripcion,Gramage,medida,Precio,Stock]);
        res.redirect('/productos/verProductos');
        
    } catch (e) {
        console.log(e);
    }
});
router.get('/eliminarProductos/:idProductos', async (req,res) =>{
    try {
        const {idProductos} = req.params;
        const productos = await pool.query('call eliminar_Productos (?)',[idProductos]);
        res.send(productos);
        
    } catch (e) {
        console.log(e)
    }
});

module.exports = router;