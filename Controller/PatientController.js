var express = require('express');
var router = express.Router();
var db = require('../Repos/PatientRepos');

//Lay thong tin benh nhan (App)
router.get('/:id', (req, res) => {
    var id = req.params.id;
    db.loadPatientById(id).then(rows => {
        res.json(rows.recordsets[0]);
        res.end(200);
    })
})

//Kiem tra thong tin benh nhan theo CMND_CCCD
router.get('/checkBenhNhan/:id', (req, res) => {
    var id = req.params.id;
    db.checkPatientById(id).then(rows => {
        if (rows.rowsAffected[0] != 0)
            res.status(200).json(rows.recordset[0]);
        else
            res.status(200).json({message:'Không có kết quả tìm kiếm'});
    })
})

//Tạo thông tin bệnh nhân
router.post('/taoThongTin',(req,res)=>{
    db.createNewPatient(req.body).then(rows=>{
        res.status(200).json(rows.recordset[0]).end();
    }).catch(e=>{
        console.log(e);
    })
})

module.exports = router;