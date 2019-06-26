var db = require('../Database/db');

exports.loadAllPhieuKham = () => {
    return db.executeQuery('select * from PhieuKham');
}

exports.loadPhongKhamHienTai = (idPk) => {
    return db.executeProcedure('IDPhong', idPk, 'LaySoPhongKhamHienTai');
}

exports.loadPhongClsHienTai = (idPk) => {
    return db.executeProcedure('IDPhong', idPk, 'LaySoPhongCLSHienTai');
}

exports.laySTTPhongKham = (idBn) => {
    return db.executeProcedure('IDBenhNhan', idBn, 'LaySTTPhongKham');
}

exports.laySTTPhongKhamCls = (idBn) => {
    return db.executeProcedure('IDBenhNhan', idBn, 'LaySTTPhongCLS');
}

exports.layPhongKhamHienTai = (idBn) => {
    return db.executeProcedure('IDBenhNhan', idBn, 'LaySTT');
}

exports.layDSChuyenKhoa = () => {
    let sql = 'EXEC XuatDanhSachChuyenKhoa';
    return db.executeQuery(sql);
}

exports.layDSBacSiTheoChuyenKhoa = (idCK) => {
    return db.executeProcedure('ChuyenKhoa', idCK, 'BacSiTheoChuyenKhoa');
}

exports.taoPhieuKham = (data) => {
    return db.executeProcedure2input('IDBenhNhan', 'IDChuyenKhoa', data.idBenhNhan, data.idChuyenKhoa, 'TaoPhieuKham');
}

exports.phatSinhSttPkTheoBS = (data) => {
    let sql = `exec PhatSinhSTTPhongKham_BacSiCa1 '${data.IDPhieuKham}','${data.IDChuyenKhoa}','${data.IDBacSi}'`
    let sql2 = `exec PhatSinhSTTPhongKham_BacSiCa2 '${data.IDPhieuKham}','${data.IDChuyenKhoa}','${data.IDBacSi}'`

    switch (data.CaKham) {
        case '1':
            return db.executeQuery(sql);
        case '2':
            console.log('th2');
            return db.executeQuery(sql2);
        default:
            console.log('th3');
            let d = new Date();
            let n = d.getHours();
            if (n <= 11) {
                return db.executeQuery(sql);
            } else
                return db.executeQuery(sql2);
    }

}

exports.phatSinhSttPkTheoChuyenKhoa = (data) => {
    console.log(data);
    switch (data.CaKham) {
        case '1':
            return db.executeProcedure2input('IDPhieuKham', 'IDChuyenKhoa', data.IDPhieuKham, data.IDChuyenKhoa, 'PhatSinhSTTPhongKhamCa1');
        case '2':
            return db.executeProcedure2input('IDPhieuKham', 'IDChuyenKhoa', data.IDPhieuKham, data.IDChuyenKhoa, 'PhatSinhSTTPhongKhamCa2');
        default:
            let d = new Date();
            let n = d.getHours();
            if (n <= 11) {
                return db.executeProcedure2input('IDPhieuKham', 'IDChuyenKhoa', data.IDPhieuKham, data.IDChuyenKhoa, 'PhatSinhSTTPhongKhamCa1');
            } else
                return db.executeProcedure2input('IDPhieuKham', 'IDChuyenKhoa', data.IDPhieuKham, data.IDChuyenKhoa, 'PhatSinhSTTPhongKhamCa2');
    }
}

//Check phiếu khám
exports.checkPk = (data) => {
    return db.executeProcedure('IDPhieuKham', data, 'CheckPhieuKham');
}

//Sinh số cls cho các dv ngoài xét nghiệm
exports.sinhSoCLS = (idPk, idCls) => {
    let d = new Date();
    let n = d.getHours();
    if (n < 11)
        return db.executeProcedure2input('IDPhieuKham', 'IDDichVuCLS', idPk, idCls, 'PhatSinhSTTCLSCa1');
    return db.executeProcedure2input('IDPhieuKham', 'IDDichVuCLS', idPk, idCls, 'PhatSinhSTTCLSCa2');
}

//Sinh số cls cho các dv xét nghiệm
exports.sinhSoCLSXetNghiem = (idPk) => {
    let d = new Date();
    let n = d.getHours();
    if (n < 11)
        return db.executeProcedure('IDPhieuKham', idPk, 'PhatSinhSTTXetNghiemCa1');
    return db.executeProcedure('IDPhieuKham', idPk, 'PhatSinhSTTXetNghiemCa2');
}

//Tìm & xuất danh sách phòng khám, bàn khám, STT hiện tại, bác sĩ, bệnh nhân  theo chuyên khoa
exports.tinhTrangHienTaiTheoChuyenKhoa = (idChuyenKhoa) => {
    let d = new Date();
    let n = d.getHours();
    if (n < 11) {
        return db.executeProcedure2input('IDChuyenKhoa', 'Cakham', idChuyenKhoa, 1, "TinhTrangPhongKhamHienTaiTheoChuyenKhoa");

    } else {
        return db.executeProcedure2input('IDChuyenKhoa', 'Cakham', idChuyenKhoa, 2, "TinhTrangPhongKhamHienTaiTheoChuyenKhoa");
    }
}

//Tìm &xuất danh sách thông tin, STT hiện tại, bệnh nhân, cuối theo phòng lâm sàng
exports.thongTinLsTheoPhong = (idPhong) => {
    let d = new Date();
    let n = d.getHours();
    return db.executeProcedure2input('IDPhong', 'CaKham', idPhong, n > 11 ? 2 : 1, 'TinhTrangPhongKhamHienTaiTheoPhongKham');
}

//Tìm và suất danh sách phòng khám chi tiết gồm có số còn chờ, tốc độ nhảy số, phòng khám
exports.tinhTrangConChoTheoChuyenKhoa = (idChuyenKhoa) => {
    let d = new Date();
    let n = d.getHours();
    if (n < 11) {
        return db.executeProcedure2input('IDChuyenKhoa', 'Cakham', idChuyenKhoa, 1, "TinhTrangConChoTheoChuyenKhoa");
    } else {
        return db.executeProcedure2input('IDChuyenKhoa', 'Cakham', idChuyenKhoa, 2, "TinhTrangConChoTheoChuyenKhoa");
    }
}

//Qua số lâm sàng
exports.soKeTiepLS = (data) => {
    console.log(data);
    let d = new Date();
    let n = d.getHours();
    let sql = `exec BamSoHienThiPhongKham '${data.idBanKham}','${data.idPhong}',${n>11?2:1}`
    return db.executeQuery(sql);
}

//Check bệnh nhân có khám hay ko (P Khám)
exports.checkBenhNhanKhamBenhLS = (data) => {
    let sql = `exec CheckBenhNhanPhongKham '${data.idPhongKham}','${data.idBanKham}',${data.CaKham},${data.stt}`
    return db.executeQuery(sql);
}

//Check bệnh nhân có khám hay ko (P CLS)
exports.checkBenhNhanKhamBenhCLS = (data) => {
    let sql = `exec CheckBenhNhanPhongCLS '${data.idPhongKham}',${data.CaKham},${data.stt}`
    return db.executeQuery(sql);
}

//Qua số cận lâm sàng
exports.soKeTiepCLS = (data) => {
    let d = new Date();
    let n = d.getHours();
    console.log(data);
    if (!data.isXetNghiem)
        return db.executeProcedure2input('IDPhong', 'Cakham', data.idPhong, n > 11 ? 2 : 1, "BamSoHienThiPhongCLS");
    else
        return db.executeProcedure2input('IDPhong', 'Cakham', data.idPhongKham, n > 11 ? 2 : 1, "CapNhatSTTPhongXetNghiem");
}

//Ds chuyên khoa cls
exports.dsChuyenKhoaCls = () => {
    let sql = 'exec DanhSachChuyenKhoaCLS';
    return db.executeQuery(sql);
}

//Show phân hệ cls
exports.showPhanHe = ()=>{
    return db.executeQuery(`exec ShowPhanHe`);
}

//Ds chuyên khoa cls có lịch khám
exports.dsChuyenKhoaClsCoLich = () => {
    let sql = 'exec DanhSachChuyenKhoaCLS_CoLichKham';
    return db.executeQuery(sql);
}
//Tìm &xuất danh sách phòng CLS, STT hiện tại, bệnh nhân, cuối theo phòng cận lâm sàng
exports.thongTinClsTheoPhong = (idPhong) => {
    let d = new Date();
    let n = d.getHours();
    return db.executeProcedure2input('IDPhong', 'CaKham', idPhong, n > 11 ? 2 : 1, 'TinhTrangPhongCLSHienTaiTheoPhongCLS');
}

//Ds dv cls
exports.dsdvCls = () => {
    let sql = 'exec XuatLoaiDichVuCanLamSang';
    return db.executeQuery(sql);
}

//Ds dv cls theo chuyên khoa
exports.dsdvClsTheoChuyenKhoa = (idChuyenKhoa) => {
    return db.executeProcedure('IDChuyenKhoa', idChuyenKhoa, 'DanhSachDichVuCanLamSangTheoChuyenKhoa');
}

//Ds cls theo dv
exports.dsClsTheoDv = (idDv) => {
    return db.executeProcedure('IDLoaiDichVu', idDv, 'XuatDichVuCanLamSang');
}

//Ds phòng cls theo dv
exports.dsPhongClsTheoChuyenKhoa = (idChuyenKhoa) => {
    return db.executeProcedure('IDChuyenKhoa', idChuyenKhoa, 'DanhSachPhongCanLamSangTheoChuyenKhoa');
}

//Danh sách phòng khám, bàn khám theo chuyên khoa lâm sàng
exports.pkbkTheoChuyenKhoa = (idChuyenKhoa) => {
    return db.executeProcedure('IDChuyenKhoa', idChuyenKhoa, 'DanhSachPhongKhamBanKhamTheoChuyenKhoa');
}

//xuất danh sách bác sĩ thuộc chuyên khoa để phân công
exports.dsBSThuocChuyenKhoa = (idChuyenKhoa) => {
    return db.executeProcedure('IDChuyenKhoa', idChuyenKhoa, 'DanhSachBacSiThuocChuyenKhoa');
}

//Check một cận lâm sàng có phải là test hơi thở hay xét nghiệm hay không
exports.checkCls = (idDichVu, idPhieuKham) => {
    return db.executeProcedure2input('IDDichVu', 'IDPhieuKham', idDichVu, idPhieuKham, 'CheckCanLamSang');
}

//Tìm &xuất danh sách phòng CLS, STT hiện tại, bệnh nhân, số còn chờ theo chuyên khoa
exports.tinhTrangPhongCLSTheoChuyenKhoa = (idChuyenKhoa) => {
    let d = new Date();
    let n = d.getHours();
    return db.executeProcedure2input('IDChuyenKhoa', 'CaKham', idChuyenKhoa, n > 11 ? 2 : 1, 'TinhTrangPhongCLSTheoChuyenKhoa')
}

//Xuất các dịch vụ mà phòng cls đó đã làm
exports.showDvClsDaLamTheoPhong = (idPhong) => {
    return db.executeProcedure('IDPhong', idPhong, 'ShowDichVuPhongCLS');
}

//thêm ngày, phòng ca, thời gian kham vào lịch phòng cận lâm sàng và thực hiện cận lâm sàng
exports.themLichCls1 = (data) => {
    let sql = `exec ThemLichPhongCanLamSang '${data.idPhong}',1,'${data.gioBdCa1}','${data.gioKtCa1}'`;
    return db.executeQuery(sql);
}
exports.themLichCls2 = (data) => {
    let sql = `exec ThemLichPhongCanLamSang '${data.idPhong}',2,'${data.gioBdCa2}','${data.gioKtCa2}'`;
    return db.executeQuery(sql);
}

//chỉ định dịch vụ cho một phòng cận lâm sàng
exports.xoaDvPhongCls = (idPhong) => {
    return db.executeProcedure('IDPhong', idPhong, 'XoaDichVuPhongCanLamSang');
}

//chỉ định dịch vụ cho một phòng cận lâm sàng
exports.chiDinhDvClsChoPhong = (idPhong, idDvCls) => {
    return db.executeProcedure2input('IDPhong', 'IDDichVuCLS', idPhong, idDvCls, 'ThemDichVuPhongCanLamSang');
}

//chỉ định thời gian thực hiện 1 dịch vụ cho một phòng cận lâm sàng
exports.chiDinhThoiGianDvCls = (idDichVu,thoiGian) => {
    return db.executeProcedure2input('IDDichVuCLS', 'ThoiGianThucHien', idDichVu, thoiGian, 'UpdateThoiGianThucHienDichVu');
}

//hiển thi dashboard lâm sàng
exports.dashBoardLs = () => {
    let d = new Date();
    let n = d.getHours();
    let sql = `exec Dashboard_LamSang ${n>11?2:1}`;
    return db.executeQuery(sql);
}

//hiển thi dashboard cận lâm sàng
exports.dashBoardCls = () => {
    let d = new Date();
    let n = d.getHours();
    let sql = `exec Dashboard_CanLamSang ${n>11?2:1}`;
    return db.executeQuery(sql);
}

//hiển thi dashboard xét nghiệm
exports.dashBoardXn = () => {
    let d = new Date();
    let n = d.getHours();
    let sql = `exec DashBoard_XetNghiem ${n>11?2:1}`;
    return db.executeQuery(sql);
}

//---------------------------Thư kí ----------
exports.loadThongTinThuKy = (idThuKy) => {
    let d = new Date();
    let n = d.getHours();
    return db.executeProcedure2input('IDNhanVien', 'CaKham', idThuKy, n > 11 ? 2 : 1, 'DangNhapNhanVien');
}

//Check bệnh nhân theo phiếu khám
exports.checkBenhNhanTheoPhieuKham = (data) => {
    if (data.isCls == 'true') {
        return db.executeProcedure2input('IDPhieuKham', 'IDPhongCLS', data.idPhieuKham, data.idPhong, 'LaySTTCanLamSangDeCheck')
    }
    return db.executeProcedure2input('IDPhieuKham', 'IDPhongKham', data.idPhieuKham, data.idPhong, 'LaySTTLamSangDeCheck')
}

//Thêm bác sĩ
exports.themBacSi = (data)=>{
    let sql = `exec ThemBacSi N'${data.HovaTen}',N'${data.GioiTinh}','${data.NamSinh}',N'${data.QueQuan}','${data.ChuyenKhoa}','${data.ThoiGianTBmin}'`;
    return db.executeQuery(sql);
}

//Thêm nhân viên
exports.themNhanVien = (data)=>{
    let sql = `exec ThemNhanVien N'${data.HovaTen}','${data.CMND_CCCD}','${data.PhanHe}'`;
    return db.executeQuery(sql);
}

//Thêm lịch khám của bác sĩ
exports.themLichKhamBacSi = (data)=>{
    let sql = `exec ThemLichBacSi '${data.BacSi}','${data.Ngay}','${data.Ca}','${data.Ban}','${data.Phong}'`;
    console.log(sql);
    return db.executeQuery(sql);
}

//Thêm lịch trực nhân viên
exports.themLichTrucNhanVien = (data)=>{
    let sql = `exec ThemLichBacSi '${data.BacSi}','${data.Ngay}','${data.Ca}','${data.Ban}','${data.Phong}'`;
    console.log(sql);
    return db.executeQuery(sql);
}