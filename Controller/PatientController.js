var express = require('express');
var router = express.Router();
var db = require('../Repos/PatientRepos')

router.get('/:id', (req, res) => {
    var id = req.params.id;
    db.loadPatientById(id).then(rows => {
        res.json(rows.recordsets[0]);
        res.end(200);
    })
})

router.get('/thongtinkhambenh/:id', async (req, res) => {
    var id = req.params.id;
    var thongTinKhamBenh = [];
    var lamSang = [];
    var canLamSang = [];

    await db.laySTTPhongKham(id).then(async rows => {
        var maPhong, stt, sttHienTai, thoiGianDuKien;
        //kiem tra co du lieu khong
        if (Object.keys(rows.recordsets[0]).length > 0) {
            for (i = 0; i < Object.keys(rows.recordsets[0]).length; i++) {
                stt = rows.recordsets[0][i].STTPhongKham;
                maPhong = rows.recordsets[0][i].SoPhong;
                thoiGianDuKien = rows.recordsets[0][0].Gio
                await db.loadPhongKhamHienTai(rows.recordsets[0][i].IDPhong).then(rows => {
                    //kiem tra co du lieu khong
                    if (Object.keys(rows.recordsets[0]).length > 0) {
                        sttHienTai = rows.recordsets[0][0].STT;
                    }
                })
                lamSang.push({
                    maPhong,
                    stt,
                    sttHienTai,
                    thoiGianDuKien
                });
            }
        } else {
            thongTinKhamBenh = ['null'];
        }
    })

    await db.laySTTPhongKhamCls(id).then(async rows => {
        var maPhongCls, stt, sttHienTai, thoiGianDuKien, tenPhong;
        //kiem tra co du lieu khong
        if (Object.keys(rows.recordsets[0]).length > 0) {
            for (i = 0; i < Object.keys(rows.recordsets[0]).length; i++) {
                stt = rows.recordsets[0][i].STTPhongCLS;
                maPhongCls = rows.recordsets[0][i].SoPhong;
                thoiGianDuKien = rows.recordsets[0][0].Gio
                tenPhong = rows.recordsets[0][0].TenLoai;
                await db.loadPhongClsHienTai(rows.recordsets[0][i].IDPhong).then(rows => {
                    console.log(rows);
                    //kiem tra co du lieu khong
                    if (Object.keys(rows.recordsets[0]).length > 0) {
                        sttHienTai = rows.recordsets[0][0].STT;
                    }
                })
                canLamSang.push({
                    maPhongCls,
                    tenPhong,
                    stt,
                    sttHienTai,
                    thoiGianDuKien
                });
            }
        }
    })


    thongTinKhamBenh.push(lamSang);
    thongTinKhamBenh.push(canLamSang);

    res.json({
        lamSang: thongTinKhamBenh[0],
        canLamSang: thongTinKhamBenh[1]
    });
})

module.exports = router;