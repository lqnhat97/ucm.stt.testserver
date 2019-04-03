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