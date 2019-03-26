var db = require('../Database/db');

exports.loadBacsi = () =>{
    var sql = `select ID from dbo.BenhNhan`;
    return db.executeQuery(sql);
}