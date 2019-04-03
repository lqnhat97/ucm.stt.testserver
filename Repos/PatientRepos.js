var db = require('../Database/db');

exports.loadPatientById = (idBn) =>{
    return db.executeProcedure('maBn',idBn,'LayThongTinBenhNhan');
}