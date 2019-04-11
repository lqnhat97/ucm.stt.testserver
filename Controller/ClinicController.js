var express = require('express');
var router = express.Router();
var db = require('../Repos/ClinicRepos');

router.get('/thongtinkhambenh/:id', async (req, res) => {
    try {
        var id = req.params.id;
        var thongTinKhamBenh = [];
        var lamSang = [];
        var canLamSang = [];

        await db.layPhongKhamHienTai(id).then(rows => {
            var maPhong, tenPhong, maPhongCls, stt, sttHienTai, thoiGianDuKien, tinhTrang;
            if (Object.keys(rows.recordsets).length > 0) {
                for (i = 0; i < Object.keys(rows.recordsets[0]).length; i++) {
                    maPhong = rows.recordsets[0][i].SoPhong
                    stt = rows.recordsets[0][i].STTPhongKham;
                    timeTemp = new Date(rows.recordsets[0][i].ThoiGianDuKien);
                    thoiGianDuKien = timeTemp.getHours().toString() + ":" + timeTemp.getMinutes();
                    tinhTrang = rows.recordsets[0][i].TinhTrang;
                    sttHienTai = rows.recordsets[0][i].SoHienTaiCuaPhong;
                    lamSang.push({
                        maPhong,
                        stt,
                        sttHienTai,
                        thoiGianDuKien,
                        tinhTrang
                    });
                }
                
                var clsLength = Object.keys(rows.recordsets[1]).length;
                for (k = 0; k < clsLength; k++) {
                    maPhongCls = rows.recordsets[1][k].SoPhong;
                    tenPhong = rows.recordsets[1][k].TenLoai;
                    stt = rows.recordsets[1][k].STTPhongCLS;
                    timeTemp = new Date(rows.recordsets[1][k].ThoiGianDuKien);
                    thoiGianDuKien = timeTemp.getHours().toString() + ":" + timeTemp.getMinutes();
                    tinhTrang = rows.recordsets[1][k].TinhTrang;
                    sttHienTai = rows.recordsets[1][k].SoHienTaiCuaPhong;
                    canLamSang.push({
                        maPhongCls,
                        tenPhong,
                        stt,
                        sttHienTai,
                        thoiGianDuKien,
                        tinhTrang
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

    } catch (err) {
        throw err;
    }
})

router.get('/test/:id', (req, res) => {
    var id = req.params.id;
    db.layPhongKhamHienTai(id).then(rows => {
        res.json(rows);
    })
})

module.exports = router;