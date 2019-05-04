var express = require('express');
var router = express.Router();
var db = require('../Repos/PatientRepos');

router.get('/:id', (req, res) => {
    var id = req.params.id;
    db.loadPatientById(id).then(rows => {
        
        res.json(rows.recordsets[0]);
        res.end(200);
    })
})

module.exports = router;