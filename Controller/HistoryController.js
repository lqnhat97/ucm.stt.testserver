var express = require('express');
var router = express.Router();
var db = require('../Repos/HistoryRepos');

router.get('/:id', (req, res) => {
    var id = req.params.id;
    db.loadLichSu(id).then(rows => {
        res.json(rows.recordsets[0]);
    })
});

router.post('/', (req, res) => {
    var id = req.query;
    db.themLichSu(id.idBn,id.idBnSearch).then(rows=>{
        res.json(rows.recordset);
    })
});

module.exports = router;