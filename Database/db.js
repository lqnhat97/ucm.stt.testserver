var mssql = require('mssql');

var config = {
    user: 'test',
    password: '123456',
    server: 'DESKTOP-RF5QQMJ',
    database: 'TEST',
    options: {
        trustedConnection: true
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

exports.executeProcedure = (param, input, procedureName) => {
    return new Promise((resolve, reject) => {
        try {
            var connect = new mssql.ConnectionPool(config);
            var request = new mssql.Request(connect);
            connect.connect(err => {
                if (err) throw err;
                request.input(param, input).execute(procedureName, (err, rows) => {
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

exports.executeProcedure2input = (param, param2, input, input2, procedureName) => {
    return new Promise((resolve, reject) => {
        try {
            var connect = new mssql.ConnectionPool(config);
            var request = new mssql.Request(connect);
            connect.connect(err => {
                if (err) throw err;
                request.input(param, input).input(param2, input2).execute(procedureName, (err, rows) => {
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