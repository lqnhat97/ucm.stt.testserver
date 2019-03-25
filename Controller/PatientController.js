var express = require('express');
var router = express.Router();
var db = require('../Repos/PatientRepos')

router.get('/:id',(req,res)=>{
    var id = req.params.id;
    console.log(id);
    db.loadPatientById(id).then(rows=>{
        res.json(rows);
    })
})

module.exports = router;