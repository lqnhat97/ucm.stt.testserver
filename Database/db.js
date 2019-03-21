var mssql = require('mssql');

var config = {
    user:'ucm_fit_stt',
    password:'Hcmus2019',
    server:'sv: stt-testdb.database.windows.net',
    database:'STT_TESTDB',
    options: {
        encrypt: true
    }
}

var createConnection = () =>{
    return mssql.connect(config,(err)=>{

        if (err) throw err;

        console.log("db connected");
    })
}

exports.executeQuery = (sql)=>{
    return new Promise((resolve,reject)=>{
        var connect = createConnection();
        var request = mssql.Request();
        request.query(sql,(err,rows)=>{
            if(err){
                reject(err);
            }
            else {
                resolve(rows);
            }
        })
        connect.close();
    })
}