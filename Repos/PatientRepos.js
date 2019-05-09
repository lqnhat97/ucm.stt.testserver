var db = require('../Database/db');

exports.loadPatientById = (idBn) => {
    return db.executeProcedure('maBn', idBn, 'LayThongTinBenhNhan');
}

exports.checkPatientById = (id) => {
    return db.executeProcedure('CMND_CCCD', id, 'CheckBenhNhan');
}

exports.createNewPatient = (input) => {
    patient = input.body;
    let sql = `exec TaoHoSoBenhNhan N'${patient.firstName}',N'${patient.middleName}',
    N'${patient.lastName}','${patient.cmnd_cccd}',N'${patient.sex}','${patient.dob}',
    N'${patient.town}',N'${patient.job}',${patient.phone},N'${patient.address}'`;
    return db.executeQuery(sql);
}