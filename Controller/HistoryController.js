var express = require('express');
var router = express.Router();
var db = require('../Repos/HistoryRepos');
var db_bn = require('../Repos/PatientRepos');

router.get('/:id', async (req, res) => {
    var id = req.params.id;
    var listId = [];
    var idHistory, hoTen, tuoi;
    await db.loadLichSu(id).then(async rows => {
        try {
            if (Object.keys(rows.recordset).length > 0) {
                for (i = 0; i < Object.keys(rows.recordset).length; i++) {
                    idHistory = rows.recordset[i].IDNguoiDuocTim;
                    hoTen = rows.recordset[i].Ho + " " + rows.recordset[i].TenLot + " " + rows.recordset[i].Ten
                    var tuoiTmp = new Date(rows.recordset[i].NgaySinh);
                    var now = new Date();
                    tuoi = now.getFullYear() - tuoiTmp.getFullYear();
                    listId.push({
                        idHistory,
                        hoTen,
                        tuoi
                    });
                }
            }
            res.json(listId);
            res.end(200);
        } catch (err) {
            if (err) throw err;
        }
    })
});

router.post('/', (req, res) => {
    var id = req.query;
    db.themLichSu(id.idBn, id.idBnSearch).then(rows => {
        res.json(rows.recordset);
    })
});

module.exports = router;