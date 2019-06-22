var express = require('express');
var router = express.Router();
var db = require('../Repos/ClinicRepos');

router.get('/thongtinkhambenh/:id', async (req, res) => {
    // db.layPhongKhamHienTai(req.params.id).then(rows=>{
    //     res.json(rows)
    // });
    try {
        var id = req.params.id;
        var thongTinKhamBenh = [];
        var lamSang = [];
        var canLamSang = [];
        await db.layPhongKhamHienTai(id).then(rows => {
            if (rows.recordsets.length == 0) {
                res.status(404).end();
            } else {
                var maPhong, maPhieuKham, tenKhu, tenLau, tenPhong, ban, tenChuyenKhoa, maPhongCls, stt, sttHienTai, sttXetNghiem, thoiGianDuKien, tinhTrang;
                if (Object.keys(rows.recordsets).length > 0) {
                    for (let i = 0; i < Object.keys(rows.recordsets[0]).length; i++) {
                        maPhieuKham = rows.recordsets[0][i].IDPhieuKham;
                        tenChuyenKhoa = rows.recordsets[0][i].TenChuyenKhoa;
                        maPhong = rows.recordsets[0][i].SoPhong;
                        tenKhu = rows.recordsets[0][i].TenKhuVuc;
                        tenLau = rows.recordsets[0][i].TenLau;
                        ban = rows.recordsets[0][i].SoBan.toString();
                        stt = rows.recordsets[0][i].STTPhongKham;
                        timeTemp = new Date(rows.recordsets[0][i].ThoiGianDuKien);
                        thoiGianDuKien = ((timeTemp.getHours() - 7) >= 10 ? (timeTemp.getHours() - 7).toString() : ("0" + (timeTemp.getHours() - 7))) + ":" + (timeTemp.getMinutes() >= 10 ? timeTemp.getMinutes() : ("0" + timeTemp.getMinutes()));
                        switch (rows.recordsets[0][i].TinhTrang) {
                            case "Đang khám":
                                if (rows.recordsets[0][i].TinhTrangBenhNhan == "Chưa có") {
                                    tinhTrang = "Đã tới lượt khám";
                                } else {
                                    tinhTrang = "Đang khám";
                                }
                                break;
                            case "Đã qua":
                                if (rows.recordsets[0][i].TinhTrangBenhNhan == "Chưa có") {
                                    tinhTrang = "Qua số nhưng chưa khám";
                                } else {
                                    tinhTrang = "Đã khám";
                                }
                                break;
                            default:
                                tinhTrang = "Chưa khám";
                                break;
                        }
                        sttHienTai = rows.recordsets[0][i].SoHienTaiCuaPhong;
                        lamSang.push({
                            maPhieuKham,
                            maPhong,
                            tenKhu,
                            tenLau,
                            ban,
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
                        tenKhu = rows.recordsets[1][k].TenKhuVuc;
                        tenLau = rows.recordsets[1][k].TenLau;
                        tenPhong = rows.recordsets[1][k].TenCanLamSang;
                        stt = rows.recordsets[1][k].STTPhongCLS;
                        timeTemp = new Date(rows.recordsets[1][k].ThoiGianDuKien);
                        thoiGianDuKien = ((timeTemp.getHours() - 7) >= 10 ? (timeTemp.getHours() - 7).toString() : ("0" + (timeTemp.getHours() - 7))) + ":" + (timeTemp.getMinutes() >= 10 ? timeTemp.getMinutes() : ("0" + timeTemp.getMinutes()));
                        switch (rows.recordsets[1][k].TinhTrang) {
                            case "Đang khám":
                                if (rows.recordsets[1][k].TinhTrangBenhNhan == "Chưa có") {
                                    tinhTrang = "Đã tới lượt khám";
                                } else {
                                    tinhTrang = "Đang khám";
                                }
                                break;
                            case "Đã qua":
                                if (rows.recordsets[1][k].TinhTrangBenhNhan == "Chưa có") {
                                    tinhTrang = "Qua số nhưng chưa khám";
                                } else {
                                    tinhTrang = "Đã khám";
                                }
                                break;
                            default:
                                tinhTrang = "Chưa tới lượt khám";
                                break;
                        };
                        sttHienTai = rows.recordsets[1][k].SoHienTaiCuaPhong + '';
                        canLamSang.push({
                            maPhongCls,
                            tenKhu,
                            tenLau,
                            sttXetNghiem: "null",
                            tenPhong,
                            stt,
                            sttHienTai,
                            thoiGianDuKien,
                            tinhTrang
                        });
                    }

                    var clsLength = Object.keys(rows.recordsets[2]).length;
                    if (clsLength > 0) {
                        var xnRange = rows.recordsets[2][0].STTCheckedCuoi;
                        tenPhong = rows.recordsets[2][0].SoPhong;
                        tenKhu = rows.recordsets[2][0].TenKhuVuc;
                        tenLau = rows.recordsets[2][0].TenLau;
                        stt = rows.recordsets[2][0].STTXetNghiem;
                        timeTemp = new Date(rows.recordsets[2][0].Gio);
                        thoiGianDuKien = ((timeTemp.getHours() - 7) >= 10 ? (timeTemp.getHours() - 7).toString() : ("0" + (timeTemp.getHours() - 7))) + ":" + (timeTemp.getMinutes() >= 10 ? timeTemp.getMinutes() : ("0" + timeTemp.getMinutes()));
                        tinhTrang = rows.recordsets[2][0].TinhTrang;
                        sttXetNghiem = (xnRange - xnRange % 10 + 1) + " -> " + (xnRange - xnRange % 10 + 10);
                        canLamSang.push({
                            maPhongCls: "Xét nghiệm",
                            tenPhong,
                            tenKhu,
                            tenLau,
                            stt,
                            sttHienTai: "0",
                            sttXetNghiem,
                            thoiGianDuKien,
                            tinhTrang
                        });
                    }
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
                canLamSang: thongTinKhamBenh[1],
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
    db.taoPhieuKham(req.body).then(rows => {
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

//Check phiếu khám
router.get('/checkPK/:idPk', (req, res) => {
    db.checkPk(req.params.idPk).then(rows => {
        res.status(200).json(rows.recordset[0]);
    })
})

async function phanLoaiCls(data, dsCLS) {
    let xetNghiem = [];
    let len = dsCLS.length;
    for (let i = 0; i < len; i++) {
        let value = data.idDichVuCls[i];
        result = await db.checkCls(value, data.idPhieuKham);
        if (result.recordset[0].KetQua == 1) {
            xetNghiem.push(dsCLS.splice(dsCLS.indexOf(value), 1)[0]);
        }
    }
    return xetNghiem;
};

//Kích hoạt phát sinh STT CLS
router.post('/phatSinhCLS', async (req, res) => {
    let data = req.body;
    var dsCLS = [...data.idDichVuCls];
    let msg = {
        CLS: [],
        XetNghiem: []
    };
    phanLoaiCls(data, dsCLS).then(async (xetNghiem) => {
        console.log(xetNghiem);
        let s_len = dsCLS.length;
        if (dsCLS.length != 0) {
            for (let i = 0; i < s_len; i++) {
                let cls_result = await db.sinhSoCLS(data.idPhieuKham, dsCLS[i]);
                msg.CLS.push(cls_result.recordset[0])
            }
        } else
            delete msg.CLS;
        if (xetNghiem.length != 0) {
            let xn_result = await db.sinhSoCLSXetNghiem(data.idPhieuKham);
            msg.XetNghiem.push(xn_result.recordset[0]);
        } else
            delete msg.XetNghiem;
        res.status(200).json(msg).end();
    })
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
        ketQua.push({
            phongKham: soPhong,
            thongTin: data
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

//Tìm và suất danh sách thông tin theo phòng khám
router.get('/thongTinLsTheoPhong/:idPhong', (req, res) => {
    let data = req.params.idPhong;
    db.thongTinLsTheoPhong(data).then(async rows => {
        let resData = handlingDsPhong(rows.recordsets);
        res.status(200).json(resData[0]).end();
    })
})

//Bấm qua số kế tiếp phòng lâm sàng( khám)
router.post('/soKeTiepLamSang', (req, res) => {
    let data = req.body;
    db.soKeTiepLS(data).then((rows) => {
        //global.io.sockets.emit('next-number', rows.recordset[0]);
        res.status(200).json(rows.recordset[0]).end();
    })
})


//Check bệnh nhân có khám hay ko (P Khám)
router.post('/checkBenhNhanDangKham', (req, res) => {
    let data = req.body;
    db.checkBenhNhanKhamBenhLS(data).then((rows) => {
        res.status(200).json(rows.rowsAffected[0]).end();
    })
})

//Check bệnh nhân có khám hay ko (P CLS)
router.post('/checkBenhNhanDangKhamCls', (req, res) => {
    let data = req.body;
    console.log(data);
    db.checkBenhNhanKhamBenhCLS(data).then((rows) => {
        res.status(200).json(rows.rowsAffected[0]).end();
    })
})

//Bấm qua số kế tiếp phòng cận lâm sàng
router.post('/soKeTiepCanLamSang', (req, res) => {
    let data = req.body;
    db.soKeTiepCLS(data).then((rows) => {
        // global.io.sockets.emit('next-number', rows.recordset[0]);
        res.status(200).json(rows.recordset[0]).end();
    })
})

//Xuất danh sách chuyên khoa cận lâm sàng
router.get('/dsChuyenKhoaCls', (req, res) => {
    db.dsChuyenKhoaCls().then(rows => {
        res.status(200).json(rows.recordset);
    })
})

//Xuất danh sách chuyên khoa cận lâm sàng có lịch
router.get('/dsChuyenKhoaClsCoLich', (req, res) => {
    db.dsChuyenKhoaClsCoLich().then(rows => {
        res.status(200).json(rows.recordset);
    })
})

//Xuất danh sách dịch vụ cận lâm sàng
router.get('/dsCls', (req, res) => {
    db.dsdvCls().then(rows => {
        res.status(200).json(rows.recordset);
    })
})

//Xuất danh sách dịch vụ cận lâm sàng theo chuyên khoa
router.get('/dsCls/:idChuyenKhoa', (req, res) => {
    db.dsdvClsTheoChuyenKhoa(req.params.idChuyenKhoa).then(rows => {
        res.status(200).json(rows.recordset);
    })
})

//Xuất danh sách cận lâm sàng theo dịch vụ
router.get('/dsClsTheoDv/:idDv', (req, res) => {
    db.dsClsTheoDv(req.params.idDv).then(rows => {
        res.status(200).json(rows.recordset);
    })
})

//Danh sách phòng khám, bàn khám theo chuyên khoa lâm sàng
router.get('/dspkbkTheoChuyenKhoa/:idChuyenKhoa', (req, res) => {
    let ketQua = [];
    let data = req.params.idChuyenKhoa;
    db.pkbkTheoChuyenKhoa(data).then(rows => {
        let dataRes = rows.recordset;
        let arrSoPhong = dataRes.map((data) => {
            return data.IDPhong;
        })
        let rightArraySoPhong = arrSoPhong.filter((v, i) => arrSoPhong.indexOf(v) === i);
        rightArraySoPhong.forEach((soPhong, index) => {
            let data = dataRes.filter((dataInside) => {
                return dataInside.IDPhong === soPhong;
            });
            ketQua.push({
                phongKham: data[0].SoPhong,
                thongTin: data
            });
        });
        res.status(200).json(ketQua).end();
    })
})

//Thông tin CLS theo chuyên phòng cận lâm sàng
router.get('/thongTinClsTheoPhong/:idPhong', (req, res) => {
    db.thongTinClsTheoPhong(req.params.idPhong).then(rows => {
        res.status(200).json(rows.recordset[0]);
    })
})

//xuất danh sách bác sĩ thuộc chuyên khoa để phân công (chỉ có id,họ tên)
router.get('/dsBsTheoChuyenKhoa/:idChuyenkhoa', (req, res) => {
    let data = req.params.idChuyenkhoa;
    db.dsBSThuocChuyenKhoa(data).then(rows => {
        let dataRes = rows.recordset;
        res.status(200).json(dataRes).end();
    })
})

//Danh sách phòng cận lâm sàng theo chuyên khoa
router.get('/dsPhongClsTheoChuyenKhoa/:idChuyenKhoa', (req, res) => {
    let data = req.params.idChuyenKhoa;
    db.dsPhongClsTheoChuyenKhoa(data).then(rows => {
        res.status(200).json(rows.recordset);
    })
})
module.exports = router;

//Tìm &xuất danh sách phòng CLS, STT hiện tại, bệnh nhân, số còn chờ theo chuyên khoa
router.get('/tinhTrangPhongClsTheoChuyenKhoa/:idChuyenKhoa', (req, res) => {
    let data = req.params.idChuyenKhoa;
    db.tinhTrangPhongCLSTheoChuyenKhoa(data).then(rows => {
        res.json(rows.recordset);
    })
})

// ->>>>>>>>>>>>>>>>>>> Phân công CLS
//Xuất các dịch vụ mà phòng cls đó đã làm
router.get('/dvClsDaThucHien/:idPhong', (req, res) => {
    let data = req.params.idPhong;
    db.showDvClsDaLamTheoPhong(data).then(rows => {
        res.status(200).json(rows.recordset);
    })
})

router.post('/chiDinhDvClsChoPhong', (req, res) => {
    let data = req.body;
    let promise = [];
    console.log(data);
    for (const value of data) {
        promise.push(db.themLichCls1(value));
        promise.push(db.themLichCls2(value));
        promise.push(db.xoaDvPhongCls(value.idPhong));
        Promise.all(promise).then(() => {
            let dv = value.dsDvCls;
            promiseChiDinh = [];
            for (const dv of dv) {
                promiseChiDinh.push(db.chiDinhDvClsChoPhong(value.idPhong, dv))
            };
            Promise.all(promiseChiDinh).then(()=>{
                res.status(200).end();
            }).catch(err=>{throw err;})
        })
    }
})

//Chỉ định giờ cận lâm sàng
router.post('/chiDinhThoiGianChoDv', async (req, res) => {
    let data = req.body;
    console.log(data);
    let promise = [];
    for (const [index, value] of data.thoiGian.entries()) {
        if (data.idDichVu[index] != '')
            promise.push(db.chiDinhThoiGianDvCls(data.idDichVu[index], value))
        continue;
    }
    Promise.all(promise).then(() => {
        res.status(200).end();
    }).catch(err => {
        throw err;
    })
})

//----------------Dashboardddddddddd----------------------
//Dashboard Lâm sàng
router.get('/dashBoardLs', (req, res) => {
    db.dashBoardLs().then(rows => {
        res.status(200).json(handlingDsPhongDashboard(rows.recordset));
    })
})

function handlingDsPhongDashboard(data) {
    let ketQua = [];
    let dataRes = data;
    let arrSoPhong = dataRes.map((data) => {
        return data.TenKhuVuc;
    });

    let rightArraySoPhong = arrSoPhong.filter((v, i) => arrSoPhong.indexOf(v) === i);
    rightArraySoPhong.forEach((khuVuc, index) => {
        let data = dataRes.filter((dataInside) => {
            return dataInside.TenKhuVuc === khuVuc;
        });
        ketQua.push({
            khuVuc: khuVuc,
            thongTin: handlingPhongDashboard(data)
        });
    });
    return ketQua;
}

function handlingPhongDashboard(data) {
    let ketQua = [];
    let dataRes = (data);
    let arrSoPhong = dataRes.map((data) => {
        return data.SoPhong;
    });

    let rightArraySoPhong = arrSoPhong.filter((v, i) => arrSoPhong.indexOf(v) === i);
    rightArraySoPhong.forEach((soPhong, index) => {
        let data = dataRes.filter((dataInside) => {
            return dataInside.SoPhong === soPhong;
        });
        ketQua.push({
            phongKham: soPhong,
            lau: data[0].Lau,
            chuyenKhoa: data[0].TenChuyenKhoa,
            thongTin: data
        });
    });
    return ketQua;
}

//Dashboard Cận lâm sàng
router.get('/dashBoardCls', (req, res) => {
    db.dashBoardCls().then(rows => {
        res.status(200).json(handlingDsPhongDashboard(rows.recordset));
    })
})

//Dashboard xét nghiệm
router.get('/dashBoardXn', (req, res) => {
    db.dashBoardXn().then(rows => {
        let dataRes = rows.recordsets;
        let tmp = [];
        let len = dataRes.length;
        for (let i = 0; i < len; i++) {
            dataRes[i][0].KhoangSTT = (dataRes[i][0].STTHientai - dataRes[i][0].STTHientai % dataRes[i][0].SoNhay + 1) + " --> " + (dataRes[i][0].STTHientai - dataRes[i][0].STTHientai % dataRes[i][0].SoNhay + dataRes[i][0].SoNhay);
            tmp.push(dataRes[i][0]);
        }
        dataRes = handlingDsPhongDashboard(tmp);
        res.status(200).json(dataRes);
    })
})


//Đăng nhập bằng thư kí y khoa
router.get('/thuKi/:idThuKy', (req, res) => {
    let dataReq = req.params.idThuKy;
    let dataRes = {};
    db.loadThongTinThuKy(dataReq).then(rows => {
        if (rows.recordsets.length != 2) {
            res.status(404).end();
        }
        try {
            let data = rows.recordsets;
            dataRes.tenChuyenKhoa = data[0][0].TenChuyenKhoa == undefined ? 'Xét nghiệm' : data[0][0].TenChuyenKhoa;
            dataRes.tenKhuVuc = data[0][0].TenKhuVuc;
            dataRes.Lau = data[0][0].Lau.toString();
            dataRes.IDPhong = data[0][0].IDPhong.toString();
            dataRes.soPhong = data[0][0].SoPhong;
            dataRes.caKham = data[0][0].CaKham.toString();
            dataRes.tenThuKi = data[1][0].TenNhanVien;
            dataRes.danhSachBan = [];
            if (data[1][0].Loai == 'LS') {
                dataRes.isCLS = false;
                dataRes.isXetNghiem = false;
                for (const value of data[0]) {
                    dataRes.danhSachBan.push({
                        IDBan: value.IDBan,
                        soBan: value.SoBan.toString(),
                        bacSi: value.BacSi,
                        BenhNhan: value.BenhNhan,
                        STTHienTai: value.hasOwnProperty('STTHientai') ? ((value.STTHientai - value.STTHientai % value.SoNhay + 1) + " -> " + (value.STTHientai - value.STTHientai % value.SoNhay + value.SoNhay)) : value.STTHienTai.toString(),
                        STTCuoi: value.STTCuoi.toString()
                    })
                }
            } else {
                dataRes.isCLS = true;
                data[0][0].hasOwnProperty('STTHientai') ? dataRes.isXetNghiem = true : dataRes.isXetNghiem = false;
                dataRes.danhSachBan.push({
                    IDBan: "null",
                    soBan: "null",
                    bacSi: "null",
                    BenhNhan: data[0][0].hasOwnProperty('STTHientai') ? ("Bệnh nhân có STT " + (data[0][0].STTHientai - data[0][0].STTHientai % data[0][0].SoNhay + 1) + " -> " + (data[0][0].STTHientai - data[0][0].STTHientai % data[0][0].SoNhay + data[0][0].SoNhay)) : data[0][0].BenhNhan,
                    STTHienTai: data[0][0].hasOwnProperty('STTHientai') ? ((data[0][0].STTHientai - data[0][0].STTHientai % data[0][0].SoNhay + 1) + " -> " + (data[0][0].STTHientai - data[0][0].STTHientai % data[0][0].SoNhay + data[0][0].SoNhay)) : data[0][0].STTHienTai.toString(),
                    STTCuoi: data[0][0].STTCuoi.toString()
                })
            }
            res.status(200).json(dataRes).end();
        } catch (error) {
            throw error;
        }
    })

})

//Check bệnh nhân theo phiếu khám
router.post('/checkBenhNhanPhieuKham?', (req, res) => {
    let data = req.body;
    db.checkBenhNhanTheoPhieuKham(data).then(rows => {
        try {
            if (rows.recordset[0].hasOwnProperty('KetQua')) {
                res.status(204).end();
            }
            dataRes = {};
            dataRes.idPhongKham = rows.recordset[0].IDPhong;
            dataRes.idBanKham = rows.recordset[0].hasOwnProperty('IDBan') ? rows.recordset[0].IDBan : null;
            dataRes.CaKham = rows.recordset[0].CaKham;
            dataRes.stt = rows.recordset[0].STTPhongKham;
            if (data.isCls == 'false') {
                db.checkBenhNhanKhamBenhLS(dataRes);
            } else {
                db.checkBenhNhanKhamBenhCLS(dataRes);
            }
            res.status(200).json(rows.recordset[0]).end();
        } catch (error) {
            res.json(error);
        }
    })
})