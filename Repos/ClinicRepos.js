var db = require('../Database/db');

exports.loadPhongKhamHienTai = (idPk) =>{
    return db.executeProcedure('IDPhong',idPk,'LaySoPhongKhamHienTai');
}

exports.loadPhongClsHienTai = (idPk) =>{
    return db.executeProcedure('IDPhong',idPk,'LaySoPhongCLSHienTai');
}

exports.laySTTPhongKham = (idBn) =>{
    return db.executeProcedure('IDBenhNhan',idBn,'LaySTTPhongKham');
}

exports.laySTTPhongKhamCls = (idBn) =>{
    return db.executeProcedure('IDBenhNhan',idBn,'LaySTTPhongCLS');
}

exports.layPhongKhamHienTai = (idBn) =>{
    return db.executeProcedure('IDBenhNhan',idBn,'LaySTT');
}

exports.layDSChuyenKhoa = ()=>{
    let sql = 'EXEC XuatDanhSachChuyenKhoa';
    return db.executeQuery(sql);
}

exports.layDSBacSiTheoChuyenKhoa = (idCK)=>{
    return db.executeProcedure('ChuyenKhoa',idCK,'BacSiTheoChuyenKhoa');
}

exports.taoPhieuKham = (data) =>{
    console.log(data);
    return db.executeProcedure2input('IDBenhNhan','IDChuyenKhoa',data.idBenhNhan,data.idChuyenKhoa,'TaoPhieuKham');
}

exports.phatSinhSttPkTheoBS = (data) =>{
    let sql =`exec PhatSinhSTTPhongKham_BacSi '${data.IDPhieuKham}','${data.IDChuyenKhoa}','${data.IDBacSi}'`
    return db.executeQuery(sql);
}

exports.phatSinhSttPkTheoChuyenKhoa = (data) =>{
    console.log(data);

    return db.executeProcedure2input('IDPhieuKham','IDChuyenKhoa',data.IDPhieuKham,data.IDChuyenKhoa,'PhatSinhSTTPhongKham');
}