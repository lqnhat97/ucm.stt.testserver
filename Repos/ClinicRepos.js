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
    let d = new Date();
    let n = d.getHours();
    if (n <= 11) {
        let sql = `exec PhatSinhSTTPhongKham_BacSiCa1 '${data.IDPhieuKham}','${data.IDChuyenKhoa}','${data.IDBacSi}'`
        return db.executeQuery(sql);
    } else {
        let sql = `exec PhatSinhSTTPhongKham_BacSiCa2 '${data.IDPhieuKham}','${data.IDChuyenKhoa}','${data.IDBacSi}'`
        return db.executeQuery(sql);
    }
}

exports.phatSinhSttPkTheoChuyenKhoa = (data) => {
    console.log(data);
    switch (data.CaKham) {
        case '1':
            console.log('th1');
            return db.executeProcedure2input('IDPhieuKham', 'IDChuyenKhoa', data.IDPhieuKham, data.IDChuyenKhoa, 'PhatSinhSTTPhongKhamCa1');
            break;
        case '2':
            console.log('th2');

            return db.executeProcedure2input('IDPhieuKham', 'IDChuyenKhoa', data.IDPhieuKham, data.IDChuyenKhoa, 'PhatSinhSTTPhongKhamCa2');
            break;
        default:
            console.log('th3');

            let d = new Date();
            let n = d.getHours();
            if (n <= 11) {
                return db.executeProcedure2input('IDPhieuKham', 'IDChuyenKhoa', data.IDPhieuKham, data.IDChuyenKhoa, 'PhatSinhSTTPhongKhamCa1');
            } else
                return db.executeProcedure2input('IDPhieuKham', 'IDChuyenKhoa', data.IDPhieuKham, data.IDChuyenKhoa, 'PhatSinhSTTPhongKhamCa2');
            break;
    }
}

//Lấy danh sách dịch vụ CLS
exports.loadAllCLS = () => {
    let sql = `select * from DichVuCanLamSang`;
    return db.executeQuery(sql);
}

//Check phiếu khám
exports.checkPk = (data) => {
    return db.executeProcedure('IDPhieuKham', data, 'CheckPhieuKham');
}

//Sinh số cls
exports.sinhSoCLS = (idPk, idCls) => {
    console.log(idPk, idCls);
    return db.executeProcedure2input('IDPhieuKham', 'IDDichVuCLS', idPk, idCls, 'PhatSinhSTTCLS');
}

//Tìm & xuất danh sách phòng khám, bàn khám, STT hiện tại, bác sĩ, bệnh nhân  theo chuyên khoa
exports.tinhTrangHienTaiTheoChuyenKhoa = (idChuyenKhoa) => {
    return db.executeProcedure('IDChuyenKhoa', idChuyenKhoa, "TinhTrangHienTaiTheoChuyenKhoa");
}

//Tìm và suất danh sách phòng khám chi tiết gồm có số còn chờ, tốc độ nhảy số, phòng khám
exports.tinhTrangConChoTheoChuyenKhoa = (idChuyenKhoa) => {
    return db.executeProcedure('IDChuyenKhoa', idChuyenKhoa, "TinhTrangConChoTheoChuyenKhoa");
}

//Qua số lâm sàng
exports.soKeTiepLS = (data) => {
    return db.executeProcedure2input('IDBanKham', 'IDPhong', data.idBanKham, data.idPhong, 'BamSoHienThiPhongKham');
}