var express = require('express');
var router = express.Router();
var db = require('../Repos/ClinicRepos');

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
            //thongTinKhamBenh = ['null'];
        }
    })

    await db.laySTTPhongKhamCls(id).then(async rows => {
        var maPhongCls, stt, sttHienTai, thoiGianDuKien, tenPhong;
        //kiem tra co du lieu khong
        if (Object.keys(rows.recordsets[0]).length > 0) {
            for (i = 0; i < Object.keys(rows.recordsets[0]).length; i++) {
                stt = rows.recordsets[0][i].STTPhongCLS;
                maPhongCls = rows.recordsets[0][i].SoPhong;
                thoiGianDuKien = rows.recordsets[0][i].Gio
                tenPhong = rows.recordsets[0][i].TenLoai;
                await db.loadPhongClsHienTai(rows.recordsets[0][i].IDPhong).then(rows => {
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

    if (thongTinKhamBenh[0] == 'null') {
        res.json({
            thongTinKhamBenh: 'null'
        });
        res.end(200);
    } else {
        res.json({
            lamSang: thongTinKhamBenh[0],
            canLamSang: thongTinKhamBenh[1]
        });
        res.end(200);
    }
})

module.exports = router;