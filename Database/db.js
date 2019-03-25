var mssql = require('mssql');

var config = {
    user: 'ucm_fit_stt',
    password: 'Hcmus2019',
    server: 'stt-testdb.database.windows.net',
    database: 'STT_TESTDB',
    options: {
        encrypt: true
    }
}

exports.executeQuery = (sql) => {
    return new Promise((resolve, reject) => {
        try {
            var connect = new mssql.ConnectionPool(config);
            var request = new mssql.Request(connect);
            connect.connect(err => {
                if (err) throw err;
                request.query(sql, (err, rows) => {
                    if (err) {
                        reject(err);
                    } else {
                        resolve(rows);
                    }
                })
            })  
        } catch (err) {
            throw err;
        }
    });
}