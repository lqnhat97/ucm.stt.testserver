var db = require('../Database/db');

exports.loadBacsi = () =>{
    var sql = `select * from dbo.BenhNhan`;
    return db.executeQuery(sql);
}