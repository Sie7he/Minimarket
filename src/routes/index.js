const express = require('express');
const router = express.Router();
const pool = require('../database');



router.get('/', async (req,res) =>{

    try {
    const productos = await pool.query("Select * from productos where estado = 1");
    res.render('index', {productos});
    } catch (error) {
        console.log(error);
    }
    
 });




module.exports = router;    