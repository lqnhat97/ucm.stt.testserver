exec BamSoHienThiPhongKham 'Bk1','1';
exec BamSoHienThiPhongKham 'Bk2','1';
exec PhatSinhSTTPhongKham 'PK66665','PH';
exec PhatSinhSTTPhongKham 'PK66666','PH';
exec PhatSinhSTTPhongKham 'PK66667','PH';
exec PhatSinhSTTPhongKham 'PK66668','PH';
exec PhatSinhSTTPhongKham 'PK66669','P@';
exec PhatSinhSTTPhongKham 'PK66670','P@';
exec PhatSinhSTTPhongKham 'PK66671','P@';
exec PhatSinhSTTPhongKham 'PK66672','P@';




-------------------------------------
CREATE PROC DanhSachCLS 
@IDChuyenKhoa nvarchar(50)
AS
BEGIN
select cls.TenDichVu, ck.TenChuyenKhoa
from DichVuCanLamSang cls
inner join LoaiDichVu ldv
on cls.LoaiDichVu=ldv.IDLoaiDichVu
inner join ChuyenKhoa ck
on ldv.ChuyenKhoa=ck.IDChuyenKhoa
where ck.IDChuyenKhoa=@IDChuyenKhoa
END;
GO

EXEC DanhSachCLS "DH"
----------------------------------
CREATE PROC HienThiThongTinBN
@ID nvarchar(10)
AS
BEGIN
select (BN.Ho + ' ' +BN.TenLot + ' ' + BN.Ten) AS HoVaTen, BN.GioiTinh, BN.NgaySinh, datediff(year,BN.NgaySinh,getdate()) AS Tuoi, BN.QueQuan, BN.CMND_CCCD, BN.DiaChi, BN.NgheNghiep, BN.SDT, null as NguoiThan
from BenhNhan BN
where BN.ID=@ID
END;
GO
EXEC HienThiThongTinBN "BN21114"
----------------------------------
CREATE PROC XuatDanhSachChuyenKhoa
AS
BEGIN
select ck.TenChuyenKhoa
from ChuyenKhoa ck
END;
GO

EXEC XuatDanhSachChuyenKhoa
----------------------------------
CREATE PROC XuatDanhSachPhongKhamTheoChuyenKhoa
@IDChuyenKhoa nvarchar(10)
AS
BEGIN
select pkck.ID, pkck.SoPhong
from ChuyenKhoa ck
inner join PhongKhamChuyenKhoa pkck on pkck.ChuyenKhoa=ck.IDChuyenKhoa
where ck.IDChuyenKhoa=@IDChuyenKhoa
END;
GO

EXEC XuatDanhSachPhongKhamTheoChuyenKhoa "PH"
----------------------------------
CREATE PROC TinhTrangHienTaiTheoChuyenKhoa
@IDchuyenKhoa nvarchar(10)
AS
BEGIN
select  B.PhongKham, bk.SoBan, B.BanKham,  A.stt AS STTHienTai, B.GioMax, bs.ID as IDBacSi, bs.HoVaTen as BacSi,BN.ID as IDBenhNhan, (BN.Ho + ' ' +BN.TenLot + ' ' + BN.Ten) AS BenhNhan
from ( select sht.PhongKham, sht.BanKham, max(sht.Gio) as GioMax
		from SoHienThiPhongKham sht
		group by sht.PhongKham, sht.BanKham ) as B
inner join SoHienThiPhongKham as A on A.BanKham=B.BanKham and A.PhongKham=b.PhongKham and A.Gio=B.GioMax
inner join PhieuKham pk on pk.IDPhieuKham= A.IDPhieuKham
inner join BenhNhan BN on IDBenhNhan=BN.ID
inner join BanKham bk on bk.IDBan=B.BanKham and bk.Phong=B.PhongKham
inner join LichKhamBacSi lk on lk.IDBan=B.BanKham and lk.Phong=B.PhongKham
inner join BacSi bs on bs.ID=lk.IDBacSi
inner join PhongKhamChuyenKhoa pkck on pkck.ID= bk.Phong
where pkck.ChuyenKhoa=@IDchuyenKhoa
END;
GO

EXEC TinhTrangHienTaiTheoChuyenKhoa "PH"
---------------------------------------------
CREATE PROC TinhTrangHienTaiTheoPhongKhamThuocChuyenKhoa
@IDPhong nvarchar(10)
AS
BEGIN
select  B.PhongKham, bk.SoBan, B.BanKham,  A.stt AS STTHienTai, B.GioMax, bs.ID as IDBacSi, bs.HoVaTen as BacSi,BN.ID as IDBenhNhan, (BN.Ho + ' ' +BN.TenLot + ' ' + BN.Ten) AS BenhNhan
from ( select sht.PhongKham, sht.BanKham, max(sht.Gio) as GioMax
		from SoHienThiPhongKham sht
		group by sht.PhongKham, sht.BanKham ) as B
inner join SoHienThiPhongKham as A on A.BanKham=B.BanKham and A.PhongKham=b.PhongKham and A.Gio=B.GioMax
inner join PhieuKham pk on pk.IDPhieuKham= A.IDPhieuKham
inner join BenhNhan BN on IDBenhNhan=BN.ID
inner join BanKham bk on bk.IDBan=B.BanKham and bk.Phong=B.PhongKham
inner join LichKhamBacSi lk on lk.IDBan=B.BanKham and lk.Phong=B.PhongKham
inner join BacSi bs on bs.ID=lk.IDBacSi
inner join PhongKhamChuyenKhoa pkck on pkck.ID= bk.Phong
where pkck.ID=@IDPhong
END;
GO

EXEC TinhTrangHienTaiTheoPhongKhamThuocChuyenKhoa "1"
----------------------------------------------
CREATE PROC TinhTrangConChoTheoChuyenKhoa
@IDchuyenKhoa nvarchar(10)
AS
BEGIN
select  B.BanKham,B.PhongKham, tk.SoLuongDoi as SoConCho, tk.ThoiGianKhamTB as TocDoNhaySo,B.GioMax as ThoiGianKhamSoCuoi
from ( select stt.PhongKham, stt.BanKham, stt.CaKham, max(stt.Gio) as GioMax
		from SoThuTuPhongKham stt
		group by stt.PhongKham, stt.BanKham, stt.CaKham ) as B
inner join ThongKePhongKham tk on tk.IDBan=B.BanKham and tk.Phong=B.PhongKham and tk.CaKham=B.CaKham
where tk.ChuyenKhoa=@IDchuyenKhoa
END;
GO

EXEC TinhTrangConChoTheoChuyenKhoa "PH"