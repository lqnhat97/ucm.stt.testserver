var db = require('../Database/db');

exports.loadPatientById = (id) =>{
    var sql = `select * from dbo.BenhNhan where ID ='${id}'`;
    return db.executeQuery(sql);
}