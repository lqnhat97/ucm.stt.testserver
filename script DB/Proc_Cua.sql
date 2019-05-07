USE TEST
go 

create proc TinhTrangConChoTheoPhongThuocChuyenKhoa @IDPhong nvarchar(10)
as 
begin
select  B.BanKham,B.PhongKham, tk.SoLuongDoi as SoConCho, tk.ThoiGianKhamTB as TocDoNhaySo,B.GioMax as ThoiGianKhamSoCuoi
from ( select stt.PhongKham, stt.BanKham, stt.CaKham, max(stt.Gio) as GioMax
		from SoThuTuPhongKham stt
		group by stt.PhongKham, stt.BanKham, stt.CaKham ) as B
inner join ThongKePhongKham tk on tk.IDBan=B.BanKham and tk.Phong=B.PhongKham and tk.CaKham=B.CaKham
where tk.Phong=@IDPhong
END;
GO

exec TinhTrangConChoTheoPhongThuocChuyenKhoa "1"
drop TinhTrangConChoTheoPhongThuocChuyenKhoa

create proc ChiTietCanLamSangTheoChuyenKhoa @IDChuyenKhoa nvarchar(10)
as
begin
	select P.SoPhong as Phong,SH.STT as SoHienTai, (BN.Ho + ' ' + BN.TenLot + ' ' + BN.Ten) as BenhNhan, TK.SoLuongDoi as SoConCho, DV.ThoiGianNhaySoTB as TocDoNhaySo, SM.GioMax as ThoiGianKhamSoCuoi
	from (select SHT.IDPhongCanLamSang, max(SHT.Gio) as GioMax 
			from SoHienThiPhongCanLamSang SHT
			group by SHT.IDPhongCanLamSang) as SM
	inner join SoHienThiPhongCanLamSang SH on SH.IDPhongCanLamSang = SM.IDPhongCanLamSang
	inner join PhieuKham PK on PK.IDPhieuKham = SH.IDPhieuKham
	inner join PhongCanLamSang P on P.ID = SH.IDPhongCanLamSang
	inner join ThucHienCLS TH on TH.IDPhongCLS = P.ID
	inner join DichVuCanLamSang DV on DV.IDDichVu = TH.DichVuCLSThucHien
	inner join LoaiDichVu LDV on LDV.IDLoaiDichVu = DV.LoaiDichVu
	inner join ThongKePhongCLS TK on TK.IDPhongCLS = SH.IDPhongCanLamSang
	inner join BenhNhan BN on BN.ID = PK.IDBenhNhan
where @IDChuyenKhoa = LDV.ChuyenKhoa
end;
go

exec ChiTietCanLamSangTheoChuyenKhoa "DL"
drop proc ChiTietCanLamSangTheoChuyenKhoa

create proc ChiTietCanLamSangTheoLoaiDichVu @IDLoaiDichVu nvarchar(10)
as
begin
	select P.SoPhong as Phong, SH.STT as SoHienTai, (BN.Ho + ' ' + BN.TenLot + ' ' + BN.Ten) as BenhNhan, TK.SoLuongDoi as SoConCho, DV.ThoiGianNhaySoTB as TocDoNhaySo, SM.GioMax as ThoiGianKhamSoCuoi
	from (select SHT.IDPhongCanLamSang, max(SHT.Gio) as GioMax 
			from SoHienThiPhongCanLamSang SHT
			group by SHT.IDPhongCanLamSang) as SM
	inner join SoHienThiPhongCanLamSang SH on SH.IDPhongCanLamSang = SM.IDPhongCanLamSang
	inner join PhieuKham PK on PK.IDPhieuKham = SH.IDPhieuKham
	inner join PhongCanLamSang P on P.ID = SH.IDPhongCanLamSang
	inner join ThucHienCLS TH on TH.IDPhongCLS = P.ID
	inner join DichVuCanLamSang DV on DV.IDDichVu = TH.DichVuCLSThucHien
	inner join LoaiDichVu LDV on LDV.IDLoaiDichVu = DV.LoaiDichVu
	inner join ThongKePhongCLS TK on TK.IDPhongCLS = SH.IDPhongCanLamSang
	inner join BenhNhan BN on BN.ID = PK.IDBenhNhan
where @IDLoaiDichVu = LDV.IDLoaiDichVu
end;
go

exec ChiTietCanLamSangTheoLoaiDichVu "MM"
drop proc ChiTietCanLamSangTheoLoaiDichVu


create proc ChiTietCanLamSangTheoTenDichVu @IDDichVu nvarchar(10)
as
begin
	select P.SoPhong as Phong, SH.STT as SoHienTai, (BN.Ho + ' ' + BN.TenLot + ' ' + BN.Ten) as BenhNhan, TK.SoLuongDoi as SoConCho, DV.ThoiGianNhaySoTB as TocDoNhaySo, SM.GioMax as ThoiGianKhamSoCuoi
	from (select SHT.IDPhongCanLamSang, max(SHT.Gio) as GioMax 
			from SoHienThiPhongCanLamSang SHT
			group by SHT.IDPhongCanLamSang) as SM
	inner join SoHienThiPhongCanLamSang SH on SH.IDPhongCanLamSang = SM.IDPhongCanLamSang and SH.Gio=SM.GioMax
	inner join PhieuKham PK on PK.IDPhieuKham = SH.IDPhieuKham
	inner join PhongCanLamSang P on P.ID = SH.IDPhongCanLamSang
	inner join ThucHienCLS TH on TH.IDPhongCLS = P.ID
	inner join DichVuCanLamSang DV on DV.IDDichVu = TH.DichVuCLSThucHien
	inner join LoaiDichVu LDV on LDV.IDLoaiDichVu = DV.LoaiDichVu
	inner join ThongKePhongCLS TK on TK.IDPhongCLS = SH.IDPhongCanLamSang
	inner join BenhNhan BN on BN.ID = PK.IDBenhNhan
where @IDDichVu = DV.IDDichVu
end;
go

exec ChiTietCanLamSangTheoTenDichVu "TZ07"
drop proc ChiTietCanLamSangTheoTenDichVu











		 
