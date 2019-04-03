var db = require('../Database/db');

exports.themLichSu = (idBn,idBnTimKiem) => {
    return db.executeProcedure2input('IDNgTim','IDNgDuocTim',idBn,idBnTimKiem,'TaoLichSuTimKiem')
};

exports.loadLichSu = (idBn) =>{
    return db.executeProcedure('IDNgTim',idBn,'HienThiLichSuTimKiem');
};