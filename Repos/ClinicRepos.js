var db = require('../Database/db');

exports.loadPhongKhamHienTai = (idPk) => {
    return db.executeProcedure('IDPhong', idPk, 'LaySoPhongKhamHienTai');
}

exports.loadPhongClsHienTai = (idPk) => {
    return db.executeProcedure('IDPhong', idPk, 'LaySoPhongCLSHienTai');
}

exports.laySTTPhongKham = (idBn) => {
    return db.executeProcedure('IDBenhNhan', idBn, 'LaySTTPhongKham');
}

exports.laySTTPhongKhamCls = (idBn) => {
    return db.executeProcedure('IDBenhNhan', idBn, 'LaySTTPhongCLS');
}

exports.layPhongKhamHienTai = (idBn) => {
    return db.executeProcedure('IDBenhNhan', idBn, 'LaySTT');
}

exports.layDSChuyenKhoa = () => {
    let sql = 'EXEC XuatDanhSachChuyenKhoa';
    return db.executeQuery(sql);
}

exports.layDSBacSiTheoChuyenKhoa = (idCK) => {
    return db.executeProcedure('ChuyenKhoa', idCK, 'BacSiTheoChuyenKhoa');
}

exports.taoPhieuKham = (data) => {
    return db.executeProcedure2input('IDBenhNhan', 'IDChuyenKhoa', data.idBenhNhan, data.idChuyenKhoa, 'TaoPhieuKham');
}

exports.phatSinhSttPkTheoBS = (data) => {
    let sql = `exec PhatSinhSTTPhongKham_BacSiCa1 '${data.IDPhieuKham}','${data.IDChuyenKhoa}','${data.IDBacSi}'`
    let sql2 = `exec PhatSinhSTTPhongKham_BacSiCa2 '${data.IDPhieuKham}','${data.IDChuyenKhoa}','${data.IDBacSi}'`

    switch (data.CaKham) {
        case '1':
            return db.executeQuery(sql);
        case '2':
            console.log('th2');
            return db.executeQuery(sql2);
        default:
            console.log('th3');
            let d = new Date();
            let n = d.getHours();
            if (n <= 11) {
                return db.executeQuery(sql);
            } else
                return db.executeQuery(sql2);
    }

}

exports.phatSinhSttPkTheoChuyenKhoa = (data) => {
    console.log(data);
    switch (data.CaKham) {
        case '1':
            console.log('th1');
            return db.executeProcedure2input('IDPhieuKham', 'IDChuyenKhoa', data.IDPhieuKham, data.IDChuyenKhoa, 'PhatSinhSTTPhongKhamCa1');
        case '2':
            console.log('th2');

            return db.executeProcedure2input('IDPhieuKham', 'IDChuyenKhoa', data.IDPhieuKham, data.IDChuyenKhoa, 'PhatSinhSTTPhongKhamCa2');
        default:
            console.log('th3');

            let d = new Date();
            let n = d.getHours();
            if (n <= 11) {
                return db.executeProcedure2input('IDPhieuKham', 'IDChuyenKhoa', data.IDPhieuKham, data.IDChuyenKhoa, 'PhatSinhSTTPhongKhamCa1');
            } else
                return db.executeProcedure2input('IDPhieuKham', 'IDChuyenKhoa', data.IDPhieuKham, data.IDChuyenKhoa, 'PhatSinhSTTPhongKhamCa2');
    }
}

//Check phiếu khám
exports.checkPk = (data) => {
    return db.executeProcedure('IDPhieuKham', data, 'CheckPhieuKham');
}

//Sinh số cls cho các dv ngoài xét nghiệm
exports.sinhSoCLS = (idPk, idCls) => {
    let d = new Date();
    let n = d.getHours();
    if (n < 11)
        return db.executeProcedure2input('IDPhieuKham', 'IDDichVuCLS', idPk, idCls, 'PhatSinhSTTCLSCa1');
    return db.executeProcedure2input('IDPhieuKham', 'IDDichVuCLS', idPk, idCls, 'PhatSinhSTTCLSCa2');
}

//Sinh số cls cho các dv xét nghiệm
exports.sinhSoCLSXetNghiem = (idPk) => {
    let d = new Date();
    let n = d.getHours();
    if (n < 11)
        return db.executeProcedure('IDPhieuKham', idPk, 'PhatSinhSTTXetNghiemCa1');
    return db.executeProcedure('IDPhieuKham', idPk, 'PhatSinhSTTXetNghiemCa2');
}

//Tìm & xuất danh sách phòng khám, bàn khám, STT hiện tại, bác sĩ, bệnh nhân  theo chuyên khoa
exports.tinhTrangHienTaiTheoChuyenKhoa = (idChuyenKhoa) => {
    let d = new Date();
    let n = d.getHours();
    if (n < 11) {
        return db.executeProcedure2input('IDChuyenKhoa', 'Cakham', idChuyenKhoa, 1, "TinhTrangHienTaiTheoChuyenKhoa");

    } else {
        return db.executeProcedure2input('IDChuyenKhoa', 'Cakham', idChuyenKhoa, 2, "TinhTrangHienTaiTheoChuyenKhoa");
    }
}

//Tìm và suất danh sách phòng khám chi tiết gồm có số còn chờ, tốc độ nhảy số, phòng khám
exports.tinhTrangConChoTheoChuyenKhoa = (idChuyenKhoa) => {
    let d = new Date();
    let n = d.getHours();
    if (n < 11) {
        return db.executeProcedure2input('IDChuyenKhoa', 'Cakham', idChuyenKhoa, 1, "TinhTrangConChoTheoChuyenKhoa");
    } else {
        return db.executeProcedure2input('IDChuyenKhoa', 'Cakham', idChuyenKhoa, 2, "TinhTrangConChoTheoChuyenKhoa");
    }
}

//Qua số lâm sàng
exports.soKeTiepLS = (data) => {
    let d = new Date();
    let n = d.getHours();
    let sql = `exec BamSoHienThiPhongKham '${data.idBanKham}','${data.idPhong}','${n>11?2:1}'`
    return db.executeQuery(sql);
}

//Ds dv cls
exports.dsChuyenKhoaCls = () => {
    let sql = 'exec DanhSachChuyenKhoaCLS';
    return db.executeQuery(sql);
}

//Ds dv cls
exports.dsdvCls = () => {
    let sql = 'exec XuatLoaiDichVuCanLamSang';
    return db.executeQuery(sql);
}

//Ds dv cls theo chuyên khoa
exports.dsdvClsTheoChuyenKhoa = (idChuyenKhoa) => {
    return db.executeProcedure('IDChuyenKhoa',idChuyenKhoa,'DanhSachDichVuCanLamSangTheoChuyenKhoa');
}

//Ds cls theo dv
exports.dsClsTheoDv = (idDv) => {
    return db.executeProcedure('IDLoaiDichVu', idDv, 'XuatDichVuCanLamSang');
}

//Ds phòng cls theo dv
exports.dsPhongClsTheoChuyenKhoa = (idChuyenKhoa) => {
    return db.executeProcedure('IDChuyenKhoa', idChuyenKhoa, 'DanhSachPhongCanLamSangTheoChuyenKhoa');
}

//Danh sách phòng khám, bàn khám theo chuyên khoa lâm sàng
exports.pkbkTheoChuyenKhoa = (idChuyenKhoa) => {
    return db.executeProcedure('IDChuyenKhoa', idChuyenKhoa, 'DanhSachPhongKhamBanKhamTheoChuyenKhoa');
}

//xuất danh sách bác sĩ thuộc chuyên khoa để phân công
exports.dsBSThuocChuyenKhoa = (idChuyenKhoa) => {
    return db.executeProcedure('IDChuyenKhoa', idChuyenKhoa, 'DanhSachBacSiThuocChuyenKhoa');
}

//Check một cận lâm sàng có phải là test hơi thở hay xét nghiệm hay không
exports.checkCls = (idDichVu, idPhieuKham) => {
    return db.executeProcedure2input('IDDichVu', 'IDPhieuKham', idDichVu, idPhieuKham, 'CheckCanLamSang');
}

//Tìm &xuất danh sách phòng CLS, STT hiện tại, bệnh nhân, số còn chờ theo chuyên khoa
exports.tinhTrangPhongCLSTheoChuyenKhoa = (idChuyenKhoa)=>{
    let d = new Date();
    let n = d.getHours();
    return db.executeProcedure2input('IDChuyenKhoa','CaKham',idChuyenKhoa,n>11?2:1,'TinhTrangPhongCLSTheoChuyenKhoa')
}