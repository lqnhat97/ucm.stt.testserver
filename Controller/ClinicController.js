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
            var maPhong, tenPhong, tenChuyenKhoa, maPhongCls, stt, sttHienTai, thoiGianDuKien, tinhTrang;
            if (Object.keys(rows.recordsets).length > 0) {
                for (let i = 0; i < Object.keys(rows.recordsets[0]).length; i++) {
                    tenChuyenKhoa = rows.recordsets[0][i].TenChuyenKhoa;
                    maPhong = rows.recordsets[0][i].SoPhong;
                    stt = rows.recordsets[0][i].STTPhongKham;
                    timeTemp = new Date(rows.recordsets[0][i].ThoiGianDuKien);
                    thoiGianDuKien = timeTemp.getHours().toString() + ":" + timeTemp.getMinutes();
                    tinhTrang = rows.recordsets[0][i].TinhTrang;
                    sttHienTai = rows.recordsets[0][i].SoHienTaiCuaPhong;
                    lamSang.push({
                        maPhong,
                        tenChuyenKhoa,
                        stt,
                        sttHienTai,
                        thoiGianDuKien,
                        tinhTrang
                    });
                }

                var clsLength = Object.keys(rows.recordsets[1]).length;
                for (let k = 0; k < clsLength; k++) {
                    maPhongCls = rows.recordsets[1][k].SoPhong;
                    tenPhong = rows.recordsets[1][k].TenCanLamSang;
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

//Lấy danh sách chuyên khoa
router.get('/dsChuyenKhoa', (req, res) => {
    db.layDSChuyenKhoa().then(rows => {
        res.status(200).json(rows.recordset);
    })
})

//Lấy bác sĩ theo chuyên khoa
router.get('/dsBacSi/:idCK', (req, res) => {
    db.layDSBacSiTheoChuyenKhoa(req.params.idCK).then(rows => {
        res.status(200).json(rows.recordset);
    })
})

//Tạo phiếu khám
router.post('/taoPhieuKham', (req, res) => { 
        console.log(req.body);
        db.taoPhieuKham(req.body).then(rows => {
            console.log(rows.recordset);
            res.status(200).json(rows.recordset[0]);
        })
    
})

//Kích hoạt Phát sinh STT phòng khám lâm sàng theo chuyên khoa
router.post('/phatSinhStt', (req, res) => {
    let data = req.body;
    db.phatSinhSttPkTheoChuyenKhoa(data).then(rows => {
        res.status(200).json(rows.recordset);
    }).catch(err => {
        if (err) throw err;
    })
})

//Kích hoạt Phát sinh STT phòng khám lâm sàng theo bác sĩ
router.post('/phatSinhSttTheoBS', (req, res) => {
    let data = req.body;
    db.phatSinhSttPkTheoBS(data).then(rows => {
        res.status(200).json(rows.recordset);
    }).catch(err => console.log(err))
})

//Load danh sách cận lâm sàng
router.get('/loadCLS', (req, res) => {
    db.loadAllCLS().then(rows => {
        res.status(200).json(rows.recordset);
    })
})

//Check phiếu khám
router.get('/checkPK/:idPk', (req, res) => {
    db.checkPk(req.params.idPk).then(rows => {
        res.status(200).json(rows.recordset[0]);
    })
})

//Kích hoạt phát sinh STT CLS
router.post('/phatSinhCLS', async (req, res) => {
    let data = req.body;
    let dsCLS = [...data.CLS];
    await dsCLS.forEach((value) => {
        console.log(value);
        db.sinhSoCLS(data.IDPhieuKham, value.idCLS).catch(err => {
            if (err) throw err
        })
    })
    res.status(200).end();
})

//Tìm & xuất danh sách phòng khám, bàn khám, STT hiện tại, bác sĩ, bệnh nhân  theo chuyên khoa
router.get('/tinhTrangTheoChuyenKhoa/:idChuyenKhoa', (req, res) => {
    let data = req.params.idChuyenKhoa;
    try {
        db.tinhTrangHienTaiTheoChuyenKhoa(data).then(rows => {
            let resData = handlingDsPhong(rows.recordsets);
            res.status(200).json(resData);
        })
    } catch (err) {
        if (err) throw err;
    }
})

function separateData(data) {
    let sepData = [];
    data.forEach(roomType => {
        roomType.forEach(banKham => {
            sepData.push(banKham);
        });
    });
    return sepData;
}

function handlingDsPhong(data) {
    let ketQua = [];
    let dataRes = separateData(data);
    let arrSoPhong = dataRes.map((data) => {
        return data.SoPhong;
    });
    
    let rightArraySoPhong = arrSoPhong.filter((v, i) => arrSoPhong.indexOf(v) === i);
    rightArraySoPhong.forEach((soPhong, index) => {
        let data = dataRes.filter((dataInside) => {
            return dataInside.SoPhong === soPhong;
        });
    console.log(data);

        ketQua.push({
            phongKham:soPhong,
            thongTin:data
        });
    });
    return ketQua;
}

//Tìm và suất danh sách phòng khám chi tiết gồm có số còn chờ, tốc độ nhảy số, phòng khám
router.get('/tinhTrangConChoTheoChuyenKhoa/:idChuyenKhoa', (req, res) => {
    let data = req.params.idChuyenKhoa;
    db.tinhTrangConChoTheoChuyenKhoa(data).then(async rows => {
        let resData = handlingDsPhong(rows.recordsets);
        res.status(200).json(resData).end();
    })
})

//Bấm qua số kế tiếp phòng lâm sàng( khám)
router.post('/soKeTiepLamSang',(req,res)=>{
    let data = req.body;
    db.soKeTiepLS(data).then((rows)=>{
        res.status(200).json(rows.recordset[0]).end();
    })
})

module.exports = router;