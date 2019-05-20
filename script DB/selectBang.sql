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

exec TinhTrangHienTaiTheoChuyenKhoa'ph'
----------------------------------
select * from SoThuTuPhongKham as STT left join SoHienThiPhongKham as SHT on STT.BanKham=SHT.BanKham and SHT.PhongKham= STT.PhongKham

CREATE PROC [dbo].[TinhTrangHienTaiTheoChuyenKhoa]
@IDchuyenKhoa nvarchar(10)
AS
BEGIN
declare @temp int,@temp2 int
set @temp=(select distinct count(*) from SoHienThiPhongKham sht inner join PhongKhamChuyenKhoa pkck on pkck.ID= sht.PhongKham
			where pkck.ChuyenKhoa=@IDchuyenKhoa);
set @temp2 =(select count(*)
			from (select distinct pkck.ChuyenKhoa,lk.Phong ,LK.IDBan from SoThuTuPhongKham as STT join LichKhamBacSi as LK 
							 on STT.BanKham=LK.IDBan and LK.Phong= STT.PhongKham 
							 inner join PhongKhamChuyenKhoa pkck on pkck.ID= STT.PhongKham
							 where pkck.ChuyenKhoa=@IDchuyenKhoa) as A);
if(@temp=0)
begin
select  distinct pkck.ChuyenKhoa,lk.Phong as PhongKham ,bk.SoBan,bs.ID as IDBacSi,  bs.HovaTen as BacSi,0 as SoHienTai, N'Chưa có bệnh nhân' AS BenhNhan
	from LichKhamBacSi lk 
	inner join SoThuTuPhongKham as STT on STT.BanKham=lk.IDBan and STT.PhongKham=lk.Phong
	inner join BanKham bk on bk.IDBan=lk.IDBan
	inner join BacSi bs on bs.ID=lk.IDBacSi
	inner join PhongKhamChuyenKhoa pkck on pkck.ID= bk.Phong
	where pkck.ChuyenKhoa=@IDchuyenKhoa
	order by  pkck.ChuyenKhoa,lk.Phong ,bk.SoBan;
end;
else if(@temp2=0)
begin
select  pkck.ChuyenKhoa,B.PhongKham,bk.SoBan, bs.ID as IDBacSi, bs.HoVaTen as BacSi,  A.stt AS SoHienTai, (BN.Ho + ' ' +BN.TenLot + ' ' + BN.Ten) AS BenhNhan, B.GioMax
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
where pkck.ChuyenKhoa=@IDchuyenKhoa;
end;
else if(((@temp2 >@temp ) and @temp!=0) or ((@temp2<@temp ) and @temp2!=0))
begin
select  pkck.ChuyenKhoa,B.PhongKham,bk.SoBan, bs.ID as IDBacSi, bs.HoVaTen as BacSi,  A.stt AS SoHienTai, (BN.Ho + ' ' +BN.TenLot + ' ' + BN.Ten) AS BenhNhan, B.GioMax
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
where pkck.ChuyenKhoa=@IDchuyenKhoa;
select  distinct pkck.ChuyenKhoa,lk.Phong as PhongKham ,bk.SoBan,bs.ID as IDBacSi,  bs.HovaTen as BacSi,0 as SoHienTai, N'Chưa có bệnh nhân' AS BenhNhan
	from LichKhamBacSi lk 
	inner join SoThuTuPhongKham as STT on STT.BanKham=lk.IDBan and STT.PhongKham=lk.Phong
	inner join BanKham bk on bk.IDBan=lk.IDBan
	inner join BacSi bs on bs.ID=lk.IDBacSi
	inner join PhongKhamChuyenKhoa pkck on pkck.ID= bk.Phong
	where pkck.ChuyenKhoa=@IDchuyenKhoa and bs.ID not in (select lich.IDBacSi from SoHienThiPhongKham as HT join BanKham as ban 
																		on HT.BanKham=ban.IDBan and HT.PhongKham=ban.Phong
																		join PhongKhamChuyenKhoa as phong on phong.ID=ban.Phong
																		join LichKhamBacSi as lich on lich.IDBan=HT.BanKham and lich.Phong=HT.PhongKham
																		join BacSi as bs on bs.ID=lich.IDBacSi
																	 where phong.ChuyenKhoa =@IDchuyenKhoa)
	order by  pkck.ChuyenKhoa,lk.Phong ,bk.SoBan;
end;
else if(@temp =@temp2)
begin
select  pkck.ChuyenKhoa,B.PhongKham,bk.SoBan, bs.ID as IDBacSi, bs.HoVaTen as BacSi,  A.stt AS SoHienTai, (BN.Ho + ' ' +BN.TenLot + ' ' + BN.Ten) AS BenhNhan, B.GioMax
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
where pkck.ChuyenKhoa=@IDchuyenKhoa;
end
end
GO

/****** Object:  StoredProcedure [dbo].[TinhTrangHienTaiTheoPhongKhamThuocChuyenKhoa]    Script Date: 5/16/2019 1:09:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TinhTrangHienTaiTheoPhongKhamThuocChuyenKhoa]
@IDPhong nvarchar(10),
@IDChuyenKhoa nvarchar(10)
AS
BEGIN
declare @temp nvarchar(10)
set @temp=(select distinct sht.PhongKham from SoHienThiPhongKham sht where sht.PhongKham=@IDPhong);
if(@temp is not NULL)
begin
select  pkck.ChuyenKhoa, B.PhongKham, bk.SoBan, B.BanKham,  A.stt AS STTHienTai, B.GioMax, bs.ID as IDBacSi, bs.HoVaTen as BacSi,BN.ID as IDBenhNhan, (BN.Ho + ' ' +BN.TenLot + ' ' + BN.Ten) AS BenhNhan

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
where pkck.ID=@IDPhong and pkck.ChuyenKhoa=@IDChuyenKhoa
end;
else if(@temp is  NULL)
begin
select    pkck.ChuyenKhoa,bk.SoBan,lk.Phong, bs.HoVaTen as BacSi, 0 as SoHienTai, N'Không có bệnh nhân' AS BenhNhan
from LichKhamBacSi lk 
inner join BanKham bk on bk.IDBan=lk.IDBan
inner join BacSi bs on bs.ID=lk.IDBacSi
inner join PhongKhamChuyenKhoa pkck on pkck.ID= bk.Phong
where pkck.ID=@IDPhong and pkck.ChuyenKhoa=@IDChuyenKhoa;
end;
END;
GO



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

EXEC TinhTrangConChoTheoChuyenKhoa "P@"
---------------------------------------
create proc BacSiTheoChuyenKhoa
@ChuyenKhoa nvarchar(10)
as
begin
select bs.ID, bs.HovaTen, bs.GioiTinh, bs.NamSinh, bs.QueQuan, bs.ChuyenKhoa,ck.TenChuyenKhoa,lk.IDBan as BanKham,lk.phong as PhongKham ,bs.ThoiGianKhamTB_min
from BacSi bs
inner join ChuyenKhoa ck on bs.ChuyenKhoa=ck.IDChuyenKhoa
inner join LichKhamBacSi lk on lk.IDBacSi=bs.ID
where bs.ChuyenKhoa=@ChuyenKhoa
end;
go


exec BacSiTheoChuyenKhoa "PH"