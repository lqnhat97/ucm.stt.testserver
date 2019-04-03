var express = require('express');
var router = express.Router();
var db = require('../Repos/HistoryRepos');

router.get('/:id', (req, res) => {
    var id = req.params.id;
    var listId = [];
    var idHistory;
    db.loadLichSu(id).then(rows => {
        if (Object.keys(rows.recordset).length > 0) {
            for (i=0;i<Object.keys(rows.recordset).length;i++){
                idHistory = rows.recordset[i].IDNguoiDuocTim;
                listId.push({idHistory});
            }
        }
        res.json(listId);
    })
});

router.post('/', (req, res) => {
    var id = req.query;
    db.themLichSu(id.idBn,id.idBnSearch).then(rows=>{
        res.json(rows.recordset);
    })
});

module.exports = router;