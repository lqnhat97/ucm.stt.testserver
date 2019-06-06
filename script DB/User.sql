use TEST;
go
create table PhanHe
( IDPhanHe int not null primary key,
  TenPhanHe nvarchar(30));
  go
create table NhanVien
( IDNV varchar(10) not null primary key,
  HovaTen nvarchar(50),
  CMND_CCCD varchar(11) unique,
  ChucVu int);
 go
alter table NhanVien
add constraint FK_NV_CV
foreign key(ChucVu)
references  PhanHe(IDPhanHe);
go
------------LICH TRUC
create table LichTrucNhanVienPhongKham
( IDPhongKham nvarchar(10),
  IDNhanVien varchar,
  Ca int,
  primary key (IDPhongKham,Ca));
go
  create table LichTrucNhanVienPhongKham
( IDPhongKham nvarchar(10),
  Ca int,
  IDNhanVien varchar(10),
  primary key (IDPhongKham,Ca));
    create table LichTrucNhanVienPhongCLS
( IDPhongCLS nvarchar(10),
  Ca int,
  IDNhanVien varchar(10),
  primary key (IDPhongCLS,Ca));
  go
-----------
insert into PhanHe values(2,N'Tiếp nhận');
insert into PhanHe values(3,N'Thư ký');
insert into PhanHe values(4,N'Chuyên viên cls');

insert into NhanVien values('TN1',N'Lê Mỹ Linh','999568459',2);
insert into NhanVien values('TN2',N'Lê Vy Thư','999568484',2);

insert into NhanVien values('TK1',N'Nguyễn Cao Kỳ','9995685555',3);
insert into NhanVien values('TK2',N'Lê Hoài Nhiên','259568484',3);
insert into NhanVien values('TK3',N'Nguyễn Nho','9997685555',3);
insert into NhanVien values('TK4',N'Lê Hoài ','259565484',3);
insert into NhanVien values('TK5',N'Nguyễn Kỳ','9925685555',3);
insert into NhanVien values('TK6',N'Lê Sơn','259548484',3);
insert into NhanVien values('TK7',N'Đại Hoàng','2395682284',3);
insert into NhanVien values('TK8',N'Phạm Nhu','9995655555',3);
insert into NhanVien values('TK9',N'Alice Groot','2595682284',3);
insert into NhanVien values('TK10',N'Thanh Thảo','9995678555',3);
insert into NhanVien values('TK11',N'Hoài Thị Vinh','259568284',3);
insert into NhanVien values('TK12',N'Lê Ki Ma','9995685535',3);
insert into NhanVien values('TK13',N'Sơn Xuân Lam','2595684843',3);
insert into NhanVien values('TK14',N'Linda Osaka','9995686555',3);


insert into NhanVien values('CV1',N'Nguyễn Cao Kỳ','395685555',4);
insert into NhanVien values('CV2',N'Lê Hoài Nhiên','339568484',4);
insert into NhanVien values('CV3',N'Cao Thảo','4395685555',4);
insert into NhanVien values('CV4',N'Tuấn Tú','539568484',4);
insert into NhanVien values('CV5',N'Tuấn Sơn','6395685555',4);
insert into NhanVien values('CV6',N'Lê Lợi','7395685555',4);
insert into NhanVien values('CV7',N'Tư Nha','839568484',4);
insert into NhanVien values('CV8',N'Mai Giang','5555685555',4);
insert into NhanVien values('CV9',N'Lê Huy Huỳnh','524568484',4);
insert into NhanVien values('CV10',N'Minh Vũ','4435685555',4);
insert into NhanVien values('CV11',N'Quang Nhật','778485555',4);
insert into NhanVien values('CV12',N'Thái Toại','25418484',4);
insert into NhanVien values('CV13',N'My Phương','2556785555',4);
insert into NhanVien values('CV14',N'Hoài Ny','222568484',4);
insert into NhanVien values('CV15',N'Hoa Sang','1195685555',4);
insert into NhanVien values('CV16',N'Nam Vân','378568484',4);
insert into NhanVien values('CV17',N'Thị May','3388685555',4);
insert into NhanVien values('CV18',N'May Nhiên','3129568484',4);
insert into NhanVien values('CV19',N'Tấn Tài','3311685555',4);
insert into NhanVien values('CV20',N'Minh Thái','3395684841',4);
insert into NhanVien values('CV21',N'Sơn Minh','3565685555',4);
insert into NhanVien values('CV22',N'Trần Minh','339568894',4);
insert into NhanVien values('CV23',N'Trần Bòi','3395684845',4);
insert into NhanVien values('CV24',N'Lê Lộc','3219568484',4);
insert into NhanVien values('CV25',N'Lê Mai','3395656484',4);
insert into NhanVien values('CV26',N'Lê Văn Nhiên','3395684842',4);
insert into NhanVien values('CV27',N'Lê Nhân','339868484',4);


--------------lICH PHONG KHAM
insert into LichTrucNhanVienPhongKham values ( '1',1,'TK1');
insert into LichTrucNhanVienPhongKham values ( '117',1,'TK10');
insert into LichTrucNhanVienPhongKham values ( '141',1,'TK11');
insert into LichTrucNhanVienPhongKham values ( '15',1,'TK12');
insert into LichTrucNhanVienPhongKham values ( '154',1,'TK13');
insert into LichTrucNhanVienPhongKham values ( '16',1,'TK14');
insert into LichTrucNhanVienPhongKham values ( '23',1,'TK2');
insert into LichTrucNhanVienPhongKham values ( '24',1,'TK3');
insert into LichTrucNhanVienPhongKham values ( '25',1,'TK4');
insert into LichTrucNhanVienPhongKham values ( '35',1,'TK5');
insert into LichTrucNhanVienPhongKham values ( '44',1,'TK6');
insert into LichTrucNhanVienPhongKham values ( '48',1,'TK7');
insert into LichTrucNhanVienPhongKham values ( '56',1,'TK8');
insert into LichTrucNhanVienPhongKham values ( '98',1,'TK9');
insert into LichTrucNhanVienPhongKham values ( '1',2,'TK1');
insert into LichTrucNhanVienPhongKham values ( '117',2,'TK10');
insert into LichTrucNhanVienPhongKham values ( '141',2,'TK11');
insert into LichTrucNhanVienPhongKham values ( '15',2,'TK12');
insert into LichTrucNhanVienPhongKham values ( '154',2,'TK13');
insert into LichTrucNhanVienPhongKham values ( '16',2,'TK14');
insert into LichTrucNhanVienPhongKham values ( '23',2,'TK2');
insert into LichTrucNhanVienPhongKham values ( '24',2,'TK3');
insert into LichTrucNhanVienPhongKham values ( '25',2,'TK4');
insert into LichTrucNhanVienPhongKham values ( '35',2,'TK5');
insert into LichTrucNhanVienPhongKham values ( '44',2,'TK6');
insert into LichTrucNhanVienPhongKham values ( '48',2,'TK7');
insert into LichTrucNhanVienPhongKham values ( '56',2,'TK8');
insert into LichTrucNhanVienPhongKham values ( '98',2,'TK9');
--------LICH CAN LAM SANG
insert into LichTrucNhanVienPhongCLS values ( '1',2,'CV1');
insert into LichTrucNhanVienPhongCLS values ( '2',2,'CV10');
insert into LichTrucNhanVienPhongCLS values ( 'CT1',2,'CV11');
insert into LichTrucNhanVienPhongCLS values ( 'DSA',2,'CV12');
insert into LichTrucNhanVienPhongCLS values ( 'KSNK1',2,'CV13');
insert into LichTrucNhanVienPhongCLS values ( 'MRI',2,'CV14');
insert into LichTrucNhanVienPhongCLS values ( 'NS1',2,'CV15');
insert into LichTrucNhanVienPhongCLS values ( 'NS2',2,'CV16');
insert into LichTrucNhanVienPhongCLS values ( 'NS3',2,'CV17');
insert into LichTrucNhanVienPhongCLS values ( 'PHCN1',2,'CV18');
insert into LichTrucNhanVienPhongCLS values ( 'PHCN2',2,'CV19');
insert into LichTrucNhanVienPhongCLS values ( 'SA1',2,'CV2');
insert into LichTrucNhanVienPhongCLS values ( 'SA2',2,'CV20');
insert into LichTrucNhanVienPhongCLS values ( 'SA3',2,'CV21');
insert into LichTrucNhanVienPhongCLS values ( 'SA4',2,'CV22');
insert into LichTrucNhanVienPhongCLS values ( 'SPECT',2,'CV23');
insert into LichTrucNhanVienPhongCLS values ( 'TD1',2,'CV24');
insert into LichTrucNhanVienPhongCLS values ( 'TD2',2,'CV25');
insert into LichTrucNhanVienPhongCLS values ( 'TMH1',2,'CV26');
insert into LichTrucNhanVienPhongCLS values ( 'TMH2',2,'CV27');
insert into LichTrucNhanVienPhongCLS values ( 'XN1',2,'CV3');
insert into LichTrucNhanVienPhongCLS values ( 'XN2',2,'CV4');
insert into LichTrucNhanVienPhongCLS values ( 'XN3',2,'CV5');
insert into LichTrucNhanVienPhongCLS values ( 'XNK1',2,'CV6');
insert into LichTrucNhanVienPhongCLS values ( 'XQ1',2,'CV7');
insert into LichTrucNhanVienPhongCLS values ( 'XQ2',2,'CV8');
insert into LichTrucNhanVienPhongCLS values ( 'XQ3',2,'CV9');
insert into LichTrucNhanVienPhongCLS values ( '1',1,'CV1');
insert into LichTrucNhanVienPhongCLS values ( '2',1,'CV10');
insert into LichTrucNhanVienPhongCLS values ( 'CT1',1,'CV11');
insert into LichTrucNhanVienPhongCLS values ( 'DSA',1,'CV12');
insert into LichTrucNhanVienPhongCLS values ( 'KSNK1',1,'CV13');
insert into LichTrucNhanVienPhongCLS values ( 'MRI',1,'CV14');
insert into LichTrucNhanVienPhongCLS values ( 'NS1',1,'CV15');
insert into LichTrucNhanVienPhongCLS values ( 'NS2',1,'CV16');
insert into LichTrucNhanVienPhongCLS values ( 'NS3',1,'CV17');
insert into LichTrucNhanVienPhongCLS values ( 'PHCN1',1,'CV18');
insert into LichTrucNhanVienPhongCLS values ( 'PHCN2',1,'CV19');
insert into LichTrucNhanVienPhongCLS values ( 'SA1',1,'CV2');
insert into LichTrucNhanVienPhongCLS values ( 'SA2',1,'CV20');
insert into LichTrucNhanVienPhongCLS values ( 'SA3',1,'CV21');
insert into LichTrucNhanVienPhongCLS values ( 'SA4',1,'CV22');
insert into LichTrucNhanVienPhongCLS values ( 'SPECT',1,'CV23');
insert into LichTrucNhanVienPhongCLS values ( 'TD1',1,'CV24');
insert into LichTrucNhanVienPhongCLS values ( 'TD2',1,'CV25');
insert into LichTrucNhanVienPhongCLS values ( 'TMH1',1,'CV26');
insert into LichTrucNhanVienPhongCLS values ( 'TMH2',1,'CV27');
insert into LichTrucNhanVienPhongCLS values ( 'XN1',1,'CV3');
insert into LichTrucNhanVienPhongCLS values ( 'XN2',1,'CV4');
insert into LichTrucNhanVienPhongCLS values ( 'XN3',1,'CV5');
insert into LichTrucNhanVienPhongCLS values ( 'XNK1',1,'CV6');
insert into LichTrucNhanVienPhongCLS values ( 'XQ1',1,'CV7');
insert into LichTrucNhanVienPhongCLS values ( 'XQ2',1,'CV8');
insert into LichTrucNhanVienPhongCLS values ( 'XQ3',1,'CV9');
-----------------
go
create proc DangNhapNhanVien @IDNhanVien varchar(10),@CaKham int
as begin
	declare @IDPhong nvarchar(10),@ChucVu int,@temp int;
	set @ChucVu = (select ChucVu from NhanVien where IDNV =@IDNhanVien)
	if(@ChucVu=3)
	begin
	select @IDPhong=IDPhongKham
	from LichTrucNhanVienPhongKham where IDNhanVien=@IDNhanVien;
	exec TinhTrangPhongKhamHienTaiTheoPhongKham @IDPhong,@CaKham;
	set @temp =1;
	end;
	else if(@ChucVu=4)
	begin
	select @IDPhong=IDPhongCLS
	from LichTrucNhanVienPhongCLS where IDNhanVien=@IDNhanVien;
	exec TinhTrangPhongCLSHienTaiTheoPhongCLS @IDPhong,@CaKham;
		if(@IDPhong ='XN1' or @IDPhong ='XN2' or @IDPhong ='XN3')
		begin
		set @temp =3;
		end;
		else
		begin
		set @temp =2;
		end;
	end;
	select HovaTen as TenNhanVien,(case @temp
								when 1 then 'LS'
								when 2 then 'CLS'
								when 3 then 'XN'
								end ) as Loai
	from NhanVien
	where IDNV=@IDNhanVien
end;


