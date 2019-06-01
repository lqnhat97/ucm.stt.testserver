-------------------DROP CONSTRAINT
alter table ThongKePhongCLS  drop constraint FK_TK_CKham;
alter table PhieuKham drop constraint FK_PK_CK ;
alter table ThongKePhongCLS drop constraint FK_TK_PCLS;
alter table SoThuTuPhongCLS drop constraint FK_STTCLS_DV;
alter table ThucHienCLS drop constraint FK_THCLS_PCLS;
alter table ThucHienCLS drop constraint FK_THCLS_DV;
alter table SoThuTuPhongKham drop constraint FK_STT_BanKham;
alter table SoThuTuPhongCLS drop constraint FK_STTCLS_CKham;
alter table SoThuTuPhongKham drop constraint FK_STTPK_CKham;
alter table LichSuTraCuu drop constraint FK_LichSu_NgDuocTim;
alter table LichSuTraCuu drop constraint FK_LichSu_NgTim;
alter table SoHienThiPhongCanLamSang drop constraint FK_HienThi_STTPhongCanLamSang;
alter table SoHienThiPhongKham drop constraint FK_HienThi_STTPhongKham;
alter table SoThuTuPhongKham drop constraint Fk_STT_PKPhongKham;
alter table SoThuTuPhongCLS drop constraint FK_STT_PhongCanLamSang;
alter table SoThuTuPhongCLS drop constraint Fk_STT_PKCLS;
alter table PhieuKham drop constraint FK_PK_BN;
alter table DichVuCanLamSang drop constraint FK_DV_LDV;
alter table LoaiDichVu drop constraint FK_LDV_CK;
alter table BanKham drop constraint FK_Ban_PK;
alter table PhongKhamChuyenKhoa drop constraint FK_PK_ChuyenKhoa;
alter table BacSi drop constraint FK_BacSi_ChuyenKhoa;
alter table ChuyenKhoa drop constraint FK_CK_DVCN;
alter table ChuyenKhoa drop constraint FK_CK_KhuVuc;
alter table LichKhamBacSi drop constraint FK_LK_Ban;
alter table LichKhamBacSi drop constraint FK_LK_Ca;
alter table LichKhamBacSi drop constraint FK_LK_BacSi;

------------------------TRUNCATE BẢNG
update ThongKePhongKham set SoLuongDoi=0 where SoLuongDoi>0;
update ThongKePhongCLS set SoLuongDoi=0 where SoLuongDoi>0;
delete SoHienThiPhongKham where STT !=0;
delete SoHienThiPhongCanLamSang where  STT !=0;
delete SoHienThiPhongXetNghiem where STT !=0;

delete SoThuTuPhongKham where STT !=0;
delete SoThuTuPhongCLS where STT !=0;
delete SoThuTuPhongXetNghiem where STT !=0;

delete PhieuKham where IDPhieuKham !='TEMP1' and IDPhieuKham!='TEMP2';

truncate table BenhNhanXetNghiem;




------------------ ADD CONSTRAINT
alter table ThongKePhongCLS
add constraint FK_TK_CKham
foreign key (CaKham)
references CaKham(IDCa)

alter table ThongKePhongCLS
add constraint FK_TK_PCLS
foreign key(IDPhongCLS)
references PhongCanLamSang(ID)

alter table PhieuKham
add constraint FK_PK_CK 
foreign key (CHuyenKhoa)
references ChuyenKhoa(IDChuyenKhoa)

alter table LichKhamBacSi
add constraint FK_LK_Ban
foreign key (IDBan,Phong)
references BanKham(IDBan,Phong)

alter table LichKhamBacSi
add constraint FK_LK_Ca
foreign key (CaKham)
references CaKham(IDCa)

alter table LichKhamBacSi
add constraint FK_LK_BacSi
foreign key (IDBacSi)
references BacSi(ID)

alter table SoThuTuPhongCLS
add constraint FK_STTCLS_DV
foreign key(CanLamSang)
references DichVuCanLamSang(IDDichVu)



/*alter table PhongCanLamSang
add constraint FK_PCLS_PCK
foreign key (TrucThuoc)
references PhongKhamChuyenKhoa(ID)*/

alter table ChuyenKhoa
add constraint FK_CK_DVCN
foreign key (IDDonViChucNang)
references DonViChucNang(IDDonViChucNang)

alter table ChuyenKhoa
add constraint FK_CK_KhuVuc
foreign key (IDKhuVuc)
references KhuVuc(IDKhuVuc)

alter table DichVuCanLamSang
add constraint FK_DV_LDV
foreign key (LoaiDichVu)
references LoaiDichVu(IDLoaiDichVu)

alter table LoaiDichVu
add constraint FK_LDV_CK
foreign key (ChuyenKhoa)
references ChuyenKhoa(IDChuyenKhoa)

alter table BanKham
add constraint FK_Ban_PK
foreign key(Phong)
references PhongKhamChuyenKhoa(ID)

alter table BacSi
add constraint FK_BacSi_ChuyenKhoa
foreign key(ChuyenKhoa)
references ChuyenKhoa(IDChuyenKhoa)

alter table PhongKhamChuyenKhoa
add constraint FK_PK_ChuyenKhoa
foreign key(ChuyenKhoa)
references ChuyenKhoa(IDChuyenKhoa)

alter table PhieuKham
add constraint FK_PK_BN
foreign key (IDBenhNhan)
references BenhNhan(ID);

alter table SoThuTuPhongCLS
add constraint Fk_STT_PKCLS
foreign key(IDPhieuKham)
references PhieuKham(IDPhieuKham);

alter table SoThuTuPhongCLS
add constraint FK_STT_PhongCanLamSang
foreign key(PhongCanLamSang)
references PhongCanLamSang(ID);

alter table SoThuTuPhongKham
add constraint Fk_STT_PKPhongKham
foreign key(IDPhieuKham)
references PhieuKham(IDPhieuKham);

/*alter table SoHienThiPhongCanLamSang
add constraint FK_HienThi_PhongCanLamSang
foreign key(IDPhongCanLamSang)
references PhongCanLamSang(ID)*/

alter table SoHienThiPhongKham
add constraint FK_HienThi_STTPhongKham
foreign key(IDPhieuKham,STT,BanKham,PhongKham)
references SoThuTuPhongKham(IDPhieuKham,STT,BanKham,PhongKham)

alter table SoHienThiPhongCanLamSang
add constraint FK_HienThi_STTPhongCanLamSang
foreign key(IDPhieuKham,STT,CanLamSang,IDPhongCanLamSang)
references SoThuTuPhongCLS(IDPhieuKham,STT,CanLamSang,PhongCanLamSang)

alter table LichSuTraCuu
add constraint FK_LichSu_NgTim
foreign key (IDNguoiTim)
references BenhNhan(ID)

alter table LichSuTraCuu
add constraint FK_LichSu_NgDuocTim
foreign key (IDNguoiDuocTim)
references BenhNhan(ID)

alter table SoThuTuPhongKham
add constraint FK_STT_BanKham
foreign key(BanKham,PhongKham)
references BanKham(IDBan,Phong);


alter table SoThuTuPhongCLS
add constraint FK_STTCLS_CKham
foreign key (CaKham)
references CaKham(IDCa)

alter table SoThuTuPhongKham
add constraint FK_STTPK_CKham
foreign key (CaKham)
references CaKham(IDCa)

alter table ThucHienCLS
add constraint FK_THCLS_PCLS
foreign key (IDPhongCLS)
references  PhongCanLamSang(ID)

alter table ThucHienCLS
add constraint FK_THCLS_DV
foreign key (DichVuCLSThucHien)
references  DichVuCanLamSang(IDDichVu)


