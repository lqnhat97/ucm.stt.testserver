

 

/****** Object:  UserDefinedFunction [dbo].[AUTO_IDTraCuu]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AUTO_IDTraCuu]()
returns nvarchar(10)
AS begin
	DECLARE @ID NVARCHAR(10)
	IF (SELECT COUNT(IDTraCuu) FROM LichSuTraCuu) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID =  max(right(IDTraCuu, 7)) FROM LichSuTraCuu
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'LS0000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'LS000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
		return @ID
END;
GO
/****** Object:  UserDefinedFunction [dbo].[CongThoiGian]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[CongThoiGian](@A time,@B datetime)
returns datetime
as begin
	declare @C datetime;
	set @C=(select dateadd(MINUTE,datepart(minute,@A),dateadd(second,datepart(SECOND,@A),@B)));
	return @C;
end;
GO
/****** Object:  Table [dbo].[BacSi]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BacSi](
	[ID] [nvarchar](10) NOT NULL,
	[HovaTen] [nvarchar](40) NULL,
	[GioiTinh] [nvarchar](3) NULL,
	[NamSinh] [nvarchar](4) NULL,
	[QueQuan] [nvarchar](20) NULL,
	[ChuyenKhoa] [nvarchar](10) NULL,
	[ThoiGianKhamTB_min] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BanKham]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BanKham](
	[IDBan] [nvarchar](10) NOT NULL,
	[Phong] [nvarchar](10) NOT NULL,
	[SoBan] [int] NULL,
	[TinhTrang] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDBan] ASC,
	[Phong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BenhNhan]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BenhNhan](
	[ID] [nvarchar](10) NOT NULL,
	[Ho] [nvarchar](6) NULL,
	[TenLot] [nvarchar](20) NULL,
	[Ten] [nvarchar](5) NULL,
	[CMND_CCCD] [nvarchar](20) NOT NULL,
	[GioiTinh] [nvarchar](3) NULL,
	[NgaySinh] [date] NULL,
	[QueQuan] [nvarchar](20) NULL,
	[NgheNghiep] [nvarchar](20) NULL,
	[SDT] [nvarchar](15) NULL,
	[Diachi] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CaKham]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CaKham](
	[IDCa] [int] NOT NULL,
	[TenCa] [nvarchar](5) NULL,
	[GioBatDau] [nvarchar](10) NULL,
	[GioKetThuc] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDCa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChuyenKhoa]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChuyenKhoa](
	[IDChuyenKhoa] [nvarchar](10) NOT NULL,
	[TenChuyenKhoa] [nvarchar](50) NULL,
	[IDDonViChucNang] [int] NULL,
	[IDKhuVuc] [int] NULL,
	[NgungSuDung] [int] NULL,
	[IDLoaiDonVi] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDChuyenKhoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DichVuCanLamSang]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DichVuCanLamSang](
	[IDDichVu] [nvarchar](10) NOT NULL,
	[TenDichVu] [nvarchar](150) NULL,
	[LoaiDichVu] [nvarchar](10) NULL,
	[TinhTrang] [int] NULL,
	[ThoiGianNhaySoTB] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDDichVu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DonViChucNang]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonViChucNang](
	[IDDonViChucNang] [int] NOT NULL,
	[TenDonViChucNang] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDDonViChucNang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhuVuc]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhuVuc](
	[IDKhuVuc] [int] NOT NULL,
	[TenKhuVuc] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDKhuVuc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LichKhamBacSi]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LichKhamBacSi](
	[IDBan] [nvarchar](10) NOT NULL,
	[Phong] [nvarchar](10) NOT NULL,
	[Ngay] [date] NOT NULL,
	[CaKham] [int] NOT NULL,
	[IDBacSi] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDBan] ASC,
	[Phong] ASC,
	[Ngay] ASC,
	[CaKham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LichSuTraCuu]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LichSuTraCuu](
	[IDTraCuu] [nvarchar](10) NOT NULL,
	[IDNguoiTim] [nvarchar](10) NOT NULL,
	[IDNguoiDuocTim] [nvarchar](10) NOT NULL,
	[ThoiGian] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDTraCuu] ASC,
	[IDNguoiTim] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiDichVu]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiDichVu](
	[IDLoaiDichVu] [nvarchar](10) NOT NULL,
	[TenLoaiDichVu] [nvarchar](50) NULL,
	[ChuyenKhoa] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDLoaiDichVu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuKham]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuKham](
	[IDPhieuKham] [nvarchar](10) NOT NULL,
	[IDBenhNhan] [nvarchar](10) NULL,
	[Ngay] [datetime] NULL,
	[ChuyenKhoa] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPhieuKham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhongCanLamSang]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhongCanLamSang](
	[ID] [nvarchar](10) NOT NULL,
	[SoPhong] [nvarchar](50) NULL,
	[TrucThuoc] [nvarchar](10) NULL,
	[KhuVuc] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhongKhamChuyenKhoa]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhongKhamChuyenKhoa](
	[ID] [nvarchar](10) NOT NULL,
	[SoPhong] [nvarchar](20) NULL,
	[ChuyenKhoa] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuyDinhPhongCLS]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuyDinhPhongCLS](
	[IDPhongCLS] [nvarchar](10) NOT NULL,
	[NgayCT] [date] NOT NULL,
	[CaKham] [int] NOT NULL,
	[SoSTTmax] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPhongCLS] ASC,
	[NgayCT] ASC,
	[CaKham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SoHienThiPhongCanLamSang]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SoHienThiPhongCanLamSang](
	[IDPhongCanLamSang] [nvarchar](10) NOT NULL,
	[STT] [int] NOT NULL,
	[IDPhieuKham] [nvarchar](10) NOT NULL,
	[Gio] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPhongCanLamSang] ASC,
	[IDPhieuKham] ASC,
	[STT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SoHienThiPhongKham]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SoHienThiPhongKham](
	[STT] [int] NOT NULL,
	[BanKham] [nvarchar](10) NOT NULL,
	[PhongKham] [nvarchar](10) NULL,
	[IDPhieuKham] [nvarchar](10) NOT NULL,
	[Gio] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[BanKham] ASC,
	[IDPhieuKham] ASC,
	[STT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SoThuTuPhongCLS]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SoThuTuPhongCLS](
	[IDPhieuKham] [nvarchar](10) NOT NULL,
	[STT] [int] NOT NULL,
	[PhongCanLamSang] [nvarchar](10) NULL,
	[CaKham] [int] NULL,
	[Gio] [datetime] NULL,
	[TinhTrang] [nvarchar](5) NULL,
	[CanLamSang] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPhieuKham] ASC,
	[STT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SoThuTuPhongKham]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SoThuTuPhongKham](
	[IDPhieuKham] [nvarchar](10) NOT NULL,
	[STT] [int] NOT NULL,
	[BanKham] [nvarchar](10) NULL,
	[PhongKham] [nvarchar](10) NULL,
	[CaKham] [int] NULL,
	[Gio] [datetime] NULL,
	[TinhTrang] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPhieuKham] ASC,
	[STT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Temp]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Temp](
	[Status] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThongKePhongKham]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongKePhongKham](
	[IDBan] [nvarchar](10) NOT NULL,
	[Phong] [nvarchar](10) NOT NULL,
	[CaKham] [int] NOT NULL,
	[SoLuongDoi] [int] NULL,
	[ChuyenKhoa] [nvarchar](10) NULL,
	[ThoiGianKhamTB] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDBan] ASC,
	[Phong] ASC,
	[CaKham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThucHienCLS]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThucHienCLS](
	[IDPhongCLS] [nvarchar](10) NOT NULL,
	[DichVuCLSThucHien] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPhongCLS] ASC,
	[DichVuCLSThucHien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ThongKeGioDuKien]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ThongKeGioDuKien] as
select STT.BanKham,STT.PhongKham,STT.CaKham,max(STT.Gio) as GioDuKienSoCuoi,PK.ChuyenKhoa
from SoThuTuPhongKham as STT join PhongKhamChuyenKhoa as PK on PK.ID=STT.PhongKham
group by STT.BanKham,STT.PhongKham,STT.CaKham,PK.ChuyenKhoa
GO
/****** Object:  View [dbo].[ThongKeChiTiet]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ThongKeChiTiet] as
select DK.BanKham,Dk.PhongKham,DK.CaKham,DK.GioDuKienSoCuoi,SL.SoLuongDoi,SL.ThoiGianKhamTB,DK.ChuyenKhoa 
from ThongKeGioDuKien as DK join ThongKePhongKham as SL 
on Dk.BanKham=SL.IDBan and Dk.PhongKham=SL.Phong and DK.ChuyenKhoa=SL.ChuyenKhoa
where SL.ThoiGianKhamTB<=all( select SL.ThoiGianKhamTB
from ThongKeGioDuKien as DK join ThongKePhongKham as SL 
on Dk.BanKham=SL.IDBan and Dk.PhongKham=SL.Phong and DK.ChuyenKhoa=SL.ChuyenKhoa
where SL.SoLuongDoi<=all(select SL.SoLuongDoi
from ThongKeGioDuKien as DK join ThongKePhongKham as SL 
on Dk.BanKham=SL.IDBan and Dk.PhongKham=SL.Phong and DK.ChuyenKhoa=SL.ChuyenKhoa
where DK.GioDuKienSoCuoi<=all(select DK.GioDuKienSoCuoi
from ThongKeGioDuKien as DK join ThongKePhongKham as SL 
on Dk.BanKham=SL.IDBan and Dk.PhongKham=SL.Phong and DK.ChuyenKhoa=SL.ChuyenKhoa))) and Sl.SoLuongDoi  in (select SL.SoLuongDoi
from ThongKeGioDuKien as DK join ThongKePhongKham as SL 
on Dk.BanKham=SL.IDBan and Dk.PhongKham=SL.Phong and DK.ChuyenKhoa=SL.ChuyenKhoa
where SL.SoLuongDoi<=all(select SL.SoLuongDoi
from ThongKeGioDuKien as DK join ThongKePhongKham as SL 
on Dk.BanKham=SL.IDBan and Dk.PhongKham=SL.Phong and DK.ChuyenKhoa=SL.ChuyenKhoa
where DK.GioDuKienSoCuoi<=all(select DK.GioDuKienSoCuoi
from ThongKeGioDuKien as DK join ThongKePhongKham as SL 
on Dk.BanKham=SL.IDBan and Dk.PhongKham=SL.Phong and DK.ChuyenKhoa=SL.ChuyenKhoa)))
GO
/****** Object:  View [dbo].[ThongKeChiTiet_Null]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ThongKeChiTiet_Null] as
select BK.IDBan,BK.Phong,LK.CaKham,BS.ChuyenKhoa, BS.ThoiGianKhamTB_min
from BanKham as BK join LichKhamBacSi as LK on LK.IDBan=BK.IDBan and LK.Phong=BK.Phong join BacSi as BS on BS.ID=LK.IDBacSi
GO
/****** Object:  View [dbo].[ThongKeSoLuong]    Script Date: 5/4/2019 1:52:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS004', N'Hà Ngọc Tuyết Trinh', N'Nam', N'1965', N'Hưng Yên', N'EEG', CAST(N'00:07:09' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS011', N'Nguyễn Tuấn Đạt', N'Nam', N'1977', N'Vĩnh Long', N'DB', CAST(N'00:06:59' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS014', N'Phan Nguyễn Thành Tài', N'Nam', N'1978', N'Lâm Đồng', N'PY', CAST(N'00:04:11' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS018', N'Hoàng Bảo Hân', N'Nam', N'1966', N'Hải Dương', N'P!', CAST(N'00:04:57' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS019', N'Phạm Thu An', N'Nữ', N'1988', N'Lai Châu', N'DY', CAST(N'00:06:45' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS020', N'Trương Phú Hưng', N'Nam', N'1976', N'An Giang', N'DB', CAST(N'00:07:53' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS021', N'Lê Trần Khánh Đoan', N'Nữ', N'1965', N'Bình Định', N'UB', CAST(N'00:04:06' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS033', N'Đặng Thuỳ Trâm', N'Nam', N'1976', N'Tây Ninh', N'KTN', CAST(N'00:07:10' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS036', N'Phạm Bảo Huy', N'Nam', N'1958', N'Yên Bái', N'PQ', CAST(N'00:04:56' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS042', N'Phạm Thu An', N'Nam', N'1967', N'Nghệ An', N'UB', CAST(N'00:05:40' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS051', N'Nguyễn Hoàng Ngọc Lan', N'Nữ', N'1978', N'Bình Phước', N'D$', CAST(N'00:07:38' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS057', N'Lê Thị Như Quỳnh', N'Nam', N'1976', N'Hà Giang	', N'PI', CAST(N'00:06:40' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS062', N'Phạm Văn Đại Dương', N'Nữ', N'1978', N'Cao Bằng', N'LM', CAST(N'00:05:30' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS066', N'Nguyễn Thụy Thanh Vân', N'Nam', N'1986', N'Kon Tum', N'D(', CAST(N'00:05:46' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS067', N'Nguyễn Giang Sơn', N'Nam', N'1978', N'Tuyên Quang', N'DH', CAST(N'00:05:04' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS069', N'Lê Minh Trí', N'Nữ', N'1977', N'Ninh Thuận', N'P!', CAST(N'00:05:09' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS071', N'Lê Trần Bảo Khanh', N'Nam', N'1955', N'Bắc Ninh', N'D&', CAST(N'00:05:02' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS078', N'Nguyễn Thị Diễm My', N'Nam', N'1955', N'Hải Phòng', N'D*', CAST(N'00:07:32' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS090', N'Phạm Ngọc Phương Anh', N'Nữ', N'1956', N'Bắc Ninh', N'P2', CAST(N'00:03:53' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS091', N'Nguyễn Quốc Phát', N'Nam', N'1965', N'Ninh Bình', N'P9', CAST(N'00:04:21' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS093', N'Trần Đoàn Tuấn Kiệt', N'Nam', N'1958', N'Bạc Liêu', N'DN', CAST(N'00:07:03' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS094', N'Nguyễn Đức Trường Phát', N'Nam', N'1986', N'Kon Tum', N'P!', CAST(N'00:08:58' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS096', N'Trương Hoàng Thu Thảo', N'Nam', N'1955', N'Ninh Thuận', N'PR', CAST(N'00:08:02' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS099', N'Vũ Hoàng Phúc', N'Nữ', N'1958', N'Bạc Liêu', N'CKQT', CAST(N'00:05:54' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS1', N'Vy Thị Thư', N'Nữ', N'1985', N'TP.HCM', N'PO', CAST(N'00:08:26' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS100', N'Đặng Gia Kiệt', N'Nam', N'1987', N'Bình Thuận', N'DT', CAST(N'00:06:10' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS101', N'Nguyễn Tấn Lợi', N'Nữ', N'1958', N'Thừa Thiên Huế', N'D0', CAST(N'00:05:21' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS105', N'Nguyễn Ngọc Bảo Hân', N'Nam', N'1986', N'Hà Nội', N'P!', CAST(N'00:07:40' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS107', N'Lê Thị Ngọc Phượng', N'Nữ', N'1977', N'Yên Bái', N'DU', CAST(N'00:04:58' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS108', N'Lê Nguyễn Gia Nghi', N'Nam', N'1958', N'Hòa Bình', N'PJ', CAST(N'00:07:47' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS118', N'Nguyễn Đặng Khánh Vy', N'Nữ', N'1958', N'Lai Châu', N'D5', CAST(N'00:03:04' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS123', N'Trịnh Duy Bảo', N'Nam', N'1975', N'Bắc Giang', N'NHCN', CAST(N'00:06:22' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS127', N'Trần Nguyễn Nhật Trâm', N'Nữ', N'1975', N'Hưng Yên', N'EMG', CAST(N'00:03:28' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS134', N'Dương Quốc Anh', N'Nam', N'1966', N'Sơn La', N'D&', CAST(N'00:06:52' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS135', N'Trần Nguyễn Hoài Anh', N'Nữ', N'1985', N'Tiền Giang', N'D^', CAST(N'00:05:34' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS138', N'Dương Minh Chiến', N'Nam', N'1975', N'Bắc Ninh', N'PV', CAST(N'00:08:09' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS139', N'Nguyễn Hữu Anh Tuấn', N'Nữ', N'1976', N'Thừa Thiên Huế', N'DL', CAST(N'00:08:24' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS141', N'Đinh Lan Hương', N'Nữ', N'1976', N'Hà Tĩnh', N'DI', CAST(N'00:03:17' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS145', N'Trần Văn Phú', N'Nam', N'1978', N'Hải Dương', N'DB', CAST(N'00:04:08' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS149', N'Huỳnh Lê Yến Nhi', N'Nam', N'1968', N'Khánh Hòa', N'0UGM', CAST(N'00:05:12' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS154', N'Nguyễn Hùng Thắng', N'Nam', N'1957', N'Đồng Nai', N'PK', CAST(N'00:08:23' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS155', N'Nguyễn Thị Thanh Uyên', N'Nữ', N'1976', N'Phú Thọ', N'0D03', CAST(N'00:06:47' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS159', N'Lê Thị Phương Thùy', N'Nữ', N'1985', N'Vĩnh Phúc', N'P@', CAST(N'00:04:06' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS162', N'Nguyễn Hồng Thủy Tiên', N'Nam', N'1966', N'Sóc Trăng', N'PHCN', CAST(N'00:06:26' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS164', N'Nguyễn Thị Hà Tiên', N'Nam', N'1986', N'Bắc Ninh', N'DX', CAST(N'00:04:24' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS165', N'Nguyễn  Thị Ái Linh', N'Nam', N'1955', N'Gia Lai', N'P6', CAST(N'00:08:50' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS166', N'Lê Ngọc Thịnh', N'Nam', N'1985', N'Phú Thọ', N'DQ', CAST(N'00:03:21' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS167', N'Bùi Ngọc Ánh Dương', N'Nam', N'1967', N'Sóc Trăng', N'PHCN', CAST(N'00:08:44' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS168', N'Phạm Lê Đoan Hân', N'Nữ', N'1977', N'Đồng Nai', N'ND', CAST(N'00:03:45' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS180', N'Nguyễn Nhựt Cảnh', N'Nam', N'1955', N'Bình Thuận', N'DH', CAST(N'00:03:54' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS181', N'Trần Nguyễn Khả Vy', N'Nam', N'1958', N'Cà Mau', N'UB', CAST(N'00:08:04' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS186', N'Lương Khánh Luân', N'Nữ', N'1967', N'Vĩnh Phúc', N'NHI2', CAST(N'00:08:25' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS187', N'Trần Lê Tuấn Kiệt', N'Nam', N'1956', N'Kon Tum', N'D3', CAST(N'00:05:03' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS188', N'Tôn Nguyễn Thuỳ Trang', N'Nam', N'1976', N'Quảng Trị', N'PI', CAST(N'00:03:19' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS189', N'Lê Trọng Bảo Khang', N'Nam', N'1956', N'Đắk Nông', N'PI', CAST(N'00:06:30' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS193', N'Trần Thị Như Quỳnh', N'Nam', N'1988', N'Sóc Trăng', N'PI', CAST(N'00:06:20' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS2', N'Vy Thị Thư', N'Nữ', N'1985', N'TP.HCM', N'PO', CAST(N'00:07:50' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS203', N'Lê Sỹ Hào', N'Nữ', N'1966', N'Bạc Liêu', N'D]', CAST(N'00:04:12' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS204', N'Trần Vũ Uyên Chi', N'Nam', N'1977', N'Hòa Bình', N'DE', CAST(N'00:04:30' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS206', N'Nguyễn Hoàng Trọng Hiệp', N'Nam', N'1978', N'Phú Thọ', N'D!', CAST(N'00:04:06' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS207', N'Lương Trọng Minh Phương', N'Nữ', N'1987', N'Long An', N'DR', CAST(N'00:05:19' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS213', N'Trần Nguyễn Hoài Anh', N'Nam', N'1978', N'Hà Nam', N'PU', CAST(N'00:06:02' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS219', N'Lê Hoàng Nam', N'Nữ', N'1956', N'Bắc Kạn', N'DE', CAST(N'00:05:24' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS223', N'Lê Huỳnh Anh Thư', N'Nam', N'1956', N'Yên Bái', N'DZ', CAST(N'00:03:37' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS224', N'Đỗ Thu Hà', N'Nam', N'1957', N'Hưng Yên', N'D1', CAST(N'00:06:19' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS227', N'Nguyễn Trần Anh Thư', N'Nam', N'1975', N'Quảng Nam', N'D8', CAST(N'00:03:27' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS230', N'Vương Đức Hiếu', N'Nam', N'1985', N'Quảng Ngãi', N'P(', CAST(N'00:08:48' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS233', N'Bùi Ngọc Trâm', N'Nam', N'1988', N'Hà Giang	', N'ND', CAST(N'00:05:04' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS239', N'Thái Nguyệt Minh', N'Nữ', N'1977', N'Bắc Ninh', N'DB', CAST(N'00:06:19' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS241', N'Lê Ngọc Yến Vy', N'Nam', N'1988', N'Bình Thuận', N'PK', CAST(N'00:05:53' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS242', N'Bùi Phượng Vy', N'Nam', N'1957', N'Lạng Sơn', N'PG', CAST(N'00:08:46' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS243', N'Võ Đại Giàu', N'Nam', N'1966', N'Bến Tre', N'DT', CAST(N'00:04:34' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS245', N'Nguyễn Thị Hà Tiên', N'Nữ', N'1968', N'Sóc Trăng', N'PF', CAST(N'00:03:02' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS247', N'Lâm Thanh Quốc Thắng', N'Nam', N'1977', N'Vĩnh Phúc', N'P(', CAST(N'00:03:23' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS253', N'Đặng Gia Kiệt', N'Nữ', N'1976', N'TP HCM', N'D]', CAST(N'00:08:14' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS255', N'Lê Trần Đăng Khoa', N'Nữ', N'1965', N'Kiên Giang', N'PP', CAST(N'00:06:19' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS256', N'Phạm Lục Phú Quí', N'Nữ', N'1985', N'Tiền Giang', N'P7', CAST(N'00:07:31' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS261', N'Hoàng Đông Hải', N'Nữ', N'1988', N'Vĩnh Long', N'D+', CAST(N'00:04:06' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS262', N'Trần Thị Tú Trinh', N'Nữ', N'1976', N'Lai Châu', N'D&', CAST(N'00:07:49' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS265', N'Đỗ Minh Chương', N'Nam', N'1957', N'TP HCM', N'P(', CAST(N'00:04:50' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS269', N'Nguyễn Trọng Hân', N'Nam', N'1978', N'Yên Bái', N'YHGD', CAST(N'00:08:21' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS278', N'Nguyễn Phú Khang', N'Nữ', N'1957', N'Nghệ An', N'VT01', CAST(N'00:03:08' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS286', N'Trịnh Gia Linh', N'Nam', N'1966', N'Quảng Bình	', N'DG', CAST(N'00:05:22' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS288', N'Phan Thị Thanh Danh', N'Nam', N'1986', N'Cà Mau', N'UB', CAST(N'00:03:32' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS289', N'Nguyễn Ngô Quỳnh Giang', N'Nữ', N'1976', N'Bình Định', N'KBTS', CAST(N'00:07:35' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS290', N'Trịnh Tâm Như', N'Nam', N'1986', N'Nghệ An', N'D#', CAST(N'00:05:22' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS298', N'Phạm Thị Dịu', N'Nam', N'1975', N'Bắc Kạn', N'PH', CAST(N'00:03:47' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS299', N'Phạm Tường Vân', N'Nữ', N'1978', N'Hà Tĩnh', N'PY', CAST(N'00:06:15' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS3', N'Vy Thị Thư', N'Nữ', N'1985', N'TP.HCM', N'PO', CAST(N'00:05:35' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS300', N'Trần Kim Ngân', N'Nữ', N'1967', N'Đắk Nông', N'D!', CAST(N'00:06:03' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS302', N'Lê Ngọc Yến Vy', N'Nữ', N'1978', N'Tuyên Quang', N'D2', CAST(N'00:04:58' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS303', N'Trần Khánh Ngọc', N'Nữ', N'1967', N'Tiền Giang', N'VT01', CAST(N'00:08:34' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS314', N'Phùng Ngọc Bích Trâm', N'Nam', N'1986', N'Hà Tĩnh', N'TN', CAST(N'00:03:54' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS315', N'Lê Minh Hiếu', N'Nam', N'1956', N'Lạng Sơn', N'PT', CAST(N'00:05:07' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS321', N'Hoàng Thị Mai Phương', N'Nữ', N'1965', N'Bạc Liêu', N'PT', CAST(N'00:07:42' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS329', N'Dương Thị Yến Nhi', N'Nam', N'1986', N'Hà Nam', N'P7', CAST(N'00:03:39' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS330', N'Lê Song Toàn', N'Nam', N'1985', N'Hà Nội', N'P@', CAST(N'00:03:58' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS333', N'Lê Trần Xuân Quỳnh', N'Nữ', N'1958', N'Hà Giang	', N'PR', CAST(N'00:05:52' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS334', N'BùI Quang Trung', N'Nam', N'1956', N'Hà Tĩnh', N'DZ', CAST(N'00:04:42' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS337', N'Nguyễn Châu Trúc My', N'Nữ', N'1958', N'Hà Giang	', N'DK', CAST(N'00:03:34' AS Time))
GO
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS341', N'Đới Thị Ngọc Điệp', N'Nam', N'1985', N'Cà Mau', N'P$', CAST(N'00:04:42' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS343', N'Đặng Phan Trà My', N'Nữ', N'1957', N'Quảng Nam', N'DV', CAST(N'00:08:31' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS345', N'Nguyễn Anh Duy', N'Nam', N'1965', N'Hải Dương', N'PB', CAST(N'00:03:28' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS346', N'Trần Thị Kiều Linh', N'Nam', N'1955', N'Yên Bái', N'ND', CAST(N'00:05:36' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS348', N'Nguyễn Tú Hoa', N'Nam', N'1978', N'Ninh Thuận', N'D#', CAST(N'00:03:18' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS351', N'Nguyễn Minh Hiếu', N'Nam', N'1955', N'Bình Phước', N'PZ', CAST(N'00:04:07' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS352', N'Lê   Ngọc  Huyền Trân', N'Nam', N'1976', N'Tuyên Quang', N'PD', CAST(N'00:07:31' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS358', N'Trần Huỳnh Gia Bảo', N'Nam', N'1987', N'Quảng Ngãi', N'DS', CAST(N'00:03:24' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS360', N'Võ Minh Tâm', N'Nam', N'1966', N'Thái Bình', N'DV', CAST(N'00:04:02' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS365', N'Ngô Hoàng Khải Nguyên', N'Nữ', N'1977', N'Lào Cai', N'D0', CAST(N'00:07:52' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS380', N'Cao Hoàng Minh Tâm', N'Nam', N'1955', N'Bình Thuận', N'P2', CAST(N'00:08:14' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS381', N'Nguyễn Thanh Xuân', N'Nữ', N'1958', N'Cà Mau', N'PB', CAST(N'00:08:07' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS386', N'Lê Phạm Linh Chi', N'Nam', N'1986', N'Quảng Bình	', N'VT01', CAST(N'00:03:58' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS394', N'Võ Văn Sơn', N'Nam', N'1987', N'Bắc Giang', N'PS', CAST(N'00:04:34' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS4', N'Vy Thị Thư', N'Nữ', N'1985', N'TP.HCM', N'PO', CAST(N'00:03:48' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS408', N'Hồ Anh Duy', N'Nam', N'1987', N'Hà Nam', N'CKQT', CAST(N'00:04:36' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS411', N'Lê Thị Phương Thảo', N'Nam', N'1975', N'Bến Tre', N'PG', CAST(N'00:06:25' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS412', N'Giao Thái Nguyên', N'Nữ', N'1976', N'Phú Thọ', N'P$', CAST(N'00:03:42' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS414', N'Lê Ngọc Thế Hoa', N'Nam', N'1965', N'Hà Nội', N'D?', CAST(N'00:08:39' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS425', N'Nguyễn Thanh Trọng', N'Nữ', N'1976', N'Bà Rịa - Vũng Tàu', N'PR', CAST(N'00:03:19' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS427', N'Trần Hoài Yên Nhi', N'Nữ', N'1988', N'An Giang', N'D(', CAST(N'00:04:01' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS446', N'Nguyễn Trương Thanh Huyền', N'Nam', N'1985', N'Gia Lai', N'D_', CAST(N'00:07:50' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS447', N'Vũ Nguyễn Minh Châu', N'Nữ', N'1956', N'Điện Biên', N'D7', CAST(N'00:08:21' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS448', N'Trần Quang Khải', N'Nữ', N'1975', N'Bình Thuận', N'D#', CAST(N'00:05:08' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS454', N'Lại Vũ Phúc Duy', N'Nam', N'1966', N'Đồng Nai', N'PN', CAST(N'00:06:34' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS463', N'Võ Hoàng Nam', N'Nữ', N'1968', N'Tây Ninh', N'DH', CAST(N'00:03:00' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS474', N'Trần Dương Thảo Uyên', N'Nữ', N'1957', N'Đắk Nông', N'DH', CAST(N'00:07:53' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS480', N'Lưu Phước Mạnh', N'Nữ', N'1976', N'Sơn La', N'PB', CAST(N'00:05:09' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS483', N'Nguyễn Bảo Nguyên', N'Nam', N'1967', N'Hà Tĩnh', N'EEG', CAST(N'00:05:48' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS484', N'Trần Ngọc Triều Vĩ', N'Nam', N'1967', N'Bến Tre', N'P$', CAST(N'00:03:09' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS489', N'Phạm Doãn Hoàng Dân', N'Nam', N'1976', N'Long An', N'DZ', CAST(N'00:03:42' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS495', N'Nguyễn Kông Nguyên', N'Nam', N'1975', N'Vĩnh Phúc', N'PC', CAST(N'00:06:51' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS498', N'Ngô Đình Tuấn', N'Nữ', N'1988', N'Phú Thọ', N'D*', CAST(N'00:06:52' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS5', N'Vy Thị Thư', N'Nữ', N'1985', N'TP.HCM', N'PO', CAST(N'00:06:04' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS503', N'Nguyễn Nhựt Cảnh', N'Nữ', N'1956', N'Bình Dương', N'DTTL', CAST(N'00:04:34' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS510', N'Nguyễn Trương Thanh Huyền', N'Nữ', N'1967', N'Quảng Bình	', N'D5', CAST(N'00:04:09' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS511', N'Lê Hoàng Nam', N'Nữ', N'1956', N'Hà Nội', N'D1', CAST(N'00:05:53' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS512', N'Nguyễn Minh Toàn', N'Nam', N'1968', N'An Giang', N'D<', CAST(N'00:08:43' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS513', N'Trần Nguyễn Ngọc Hân', N'Nam', N'1958', N'Lâm Đồng', N'D5', CAST(N'00:08:41' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS515', N'Nguyễn Thị Thu Minh', N'Nữ', N'1957', N'Vĩnh Phúc', N'DQ', CAST(N'00:04:26' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS522', N'Nguyễn Thị Tuyết Hân', N'Nam', N'1986', N'Vĩnh Phúc', N'EEG', CAST(N'00:06:54' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS527', N'Đỗ Gia Huy', N'Nam', N'1986', N'Lạng Sơn', N'GN', CAST(N'00:07:06' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS529', N'Phạm Lục Phú Quí', N'Nữ', N'1986', N'Tiền Giang', N'KTN', CAST(N'00:03:46' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS531', N'Cao Hoàng Minh Nguyệt', N'Nam', N'1955', N'Đắk Nông', N'DA', CAST(N'00:03:02' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS540', N'Lê Trọng Bảo Khang', N'Nam', N'1988', N'Hà Nội', N'D@', CAST(N'00:05:50' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS541', N'Nguyễn Thị Hoài Thương', N'Nữ', N'1965', N'Long An', N'DK', CAST(N'00:04:26' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS543', N'Phạm Văn Đại Dương', N'Nam', N'1967', N'Hà Tĩnh', N'D6', CAST(N'00:04:35' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS544', N'Senthil Kumar Goutham', N'Nam', N'1975', N'Đà Nẵng', N'PJ', CAST(N'00:04:52' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS546', N'Phạm Hoàng Quỳnh Anh', N'Nam', N'1967', N'Bình Phước', N'P9', CAST(N'00:08:05' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS554', N'Phạm Phú Quang', N'Nam', N'1975', N'Quảng Ngãi', N'CKQT', CAST(N'00:06:59' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS555', N'Lưu Mỹ Tâm', N'Nam', N'1958', N'Ninh Bình', N'D4', CAST(N'00:03:54' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS559', N'Tạ Thu Hằng', N'Nữ', N'1975', N'Bến Tre', N'EEG', CAST(N'00:07:56' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS562', N'Tôn Nữ Quỳnh Như', N'Nam', N'1985', N'Đà Nẵng', N'PM', CAST(N'00:04:14' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS563', N'Phạm Thu An', N'Nam', N'1968', N'Sơn La', N'DK', CAST(N'00:05:46' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS565', N'Nguyễn Thảo An', N'Nam', N'1987', N'Bình Định', N'DM', CAST(N'00:05:24' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS570', N'Phạm Tường Vân', N'Nữ', N'1985', N'Phú Thọ', N'DA', CAST(N'00:06:12' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS571', N'Phan Thanh Tấn', N'Nữ', N'1987', N'Quảng Nam', N'DM', CAST(N'00:07:44' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS575', N'Nguyễn Tấn Hoàng Thy', N'Nữ', N'1975', N'Lào Cai', N'DA', CAST(N'00:03:43' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS582', N'Tô Thị Diễm Quỳnh', N'Nữ', N'1957', N'Quảng Ngãi', N'D)', CAST(N'00:07:06' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS587', N'Huỳnh Lê Thảo Nguyên', N'Nam', N'1986', N'Nam Định', N'P2', CAST(N'00:07:18' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS589', N'Nguyễn Vũ Minh Phương', N'Nữ', N'1955', N'Hà Giang	', N'D+', CAST(N'00:05:11' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS597', N'Bùi Nguyễn Bảo Châu', N'Nữ', N'1975', N'Bạc Liêu', N'PT', CAST(N'00:04:01' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS6', N'Vy Thị Thư', N'Nữ', N'1985', N'TP.HCM', N'PO', CAST(N'00:05:41' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS603', N'Nguyễn Hương Giang', N'Nam', N'1977', N'Bắc Giang', N'PG', CAST(N'00:06:12' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS605', N'Lê Minh Quân', N'Nữ', N'1986', N'Quảng Ngãi', N'PN', CAST(N'00:04:07' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS613', N'Lê Sỹ Hào', N'Nam', N'1985', N'Bắc Giang', N'PR', CAST(N'00:08:23' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS616', N'Nguyễn Tuấn Anh', N'Nam', N'1975', N'Nghệ An', N'DTTL', CAST(N'00:08:58' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS618', N'Phạm Gia My', N'Nam', N'1977', N'Hậu Giang', N'P#', CAST(N'00:08:21' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS620', N'Trần Thị Thanh Tâm', N'Nữ', N'1968', N'Đồng Tháp', N'PU', CAST(N'00:03:01' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS622', N'Phạm Cao Hoàng My', N'Nữ', N'1967', N'Bình Định', N'PR', CAST(N'00:04:07' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS624', N'Nguyễn Phúc Vinh', N'Nam', N'1976', N'Bình Thuận', N'P$', CAST(N'00:03:58' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS631', N'Dương Vĩ Hào', N'Nam', N'1968', N'Quảng Ninh', N'DS', CAST(N'00:06:53' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS635', N'Lê Dương Chí Bảo', N'Nữ', N'1957', N'Quảng Ngãi', N'DI', CAST(N'00:06:58' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS641', N'Trần Hoài Tân', N'Nữ', N'1958', N'Bình Thuận', N'PQ', CAST(N'00:04:21' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS646', N'Diệp Ngô Gia Phát', N'Nam', N'1955', N'Trà Vinh', N'HH', CAST(N'00:03:44' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS650', N'Nguyễn Ngọc Thanh Trâm', N'Nữ', N'1955', N'Sơn La', N'D3', CAST(N'00:07:25' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS651', N'Võ Văn Đương', N'Nam', N'1957', N'Thái Nguyên', N'D0', CAST(N'00:06:03' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS652', N'Phan Vũ Nam Thi', N'Nữ', N'1957', N'Tây Ninh', N'DH', CAST(N'00:07:09' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS655', N'Nguyễn Linh Chi', N'Nữ', N'1988', N'Thái Nguyên', N'DD', CAST(N'00:04:37' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS661', N'Huỳnh Bảo Minh Trí', N'Nam', N'1955', N'Tiền Giang', N'PI', CAST(N'00:03:27' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS666', N'Phạm Thị Kim Phượng', N'Nam', N'1976', N'Thái Bình', N'GN', CAST(N'00:06:17' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS674', N'Phan Nguyễn Thành Tài', N'Nam', N'1975', N'Ninh Bình', N'DX', CAST(N'00:04:19' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS675', N'Nguyễn Thị Ngọc Huyền', N'Nam', N'1975', N'Phú Thọ', N'YHGD', CAST(N'00:06:02' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS677', N'Nguyễn Thảo An', N'Nam', N'1977', N'Yên Bái', N'D#', CAST(N'00:03:34' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS685', N'Bùi Ngọc Ánh Dương', N'Nam', N'1955', N'Lào Cai', N'PK', CAST(N'00:08:40' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS689', N'Dương Nguyễn Anh Thy', N'Nam', N'1957', N'Hải Dương', N'PI', CAST(N'00:04:38' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS692', N'Trần Thanh Bình', N'Nam', N'1966', N'Sơn La', N'D&', CAST(N'00:08:50' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS695', N'Phan Ngọc Hiệu', N'Nữ', N'1957', N'Quảng Trị', N'DD', CAST(N'00:08:31' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS697', N'Lê Huỳnh Anh Thư', N'Nam', N'1955', N'Quảng Bình	', N'P!', CAST(N'00:08:22' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS706', N'Lê Huỳnh Anh Thư', N'Nữ', N'1977', N'Kon Tum', N'PA', CAST(N'00:07:33' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS707', N'Phạm Thị Quỳnh Anh', N'Nam', N'1976', N'Hà Tĩnh', N'D4', CAST(N'00:05:13' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS709', N'Tôn Nữ Quỳnh Như', N'Nam', N'1987', N'Đồng Tháp', N'PJ', CAST(N'00:04:03' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS712', N'Hà Minh Tấn', N'Nam', N'1978', N'An Giang', N'PHCN', CAST(N'00:03:16' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS721', N'Nguyễn Trịnh Minh Hằng', N'Nam', N'1968', N'Quảng Trị', N'PK', CAST(N'00:03:09' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS735', N'Nguyễn Hoàng Tú', N'Nam', N'1965', N'Khánh Hòa', N'D?', CAST(N'00:08:14' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS739', N'Nguyễn Thị Thảo Uyên', N'Nam', N'1956', N'Hải Phòng', N'PL', CAST(N'00:03:45' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS750', N'Nguyễn Bảo Ly', N'Nam', N'1968', N'Đồng Tháp', N'PI', CAST(N'00:06:46' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS751', N'Nguyễn Đình Thắng', N'Nam', N'1977', N'Kon Tum', N'D4', CAST(N'00:04:50' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS752', N'Lê Đình Lâm', N'Nữ', N'1985', N'Thái Nguyên', N'D[', CAST(N'00:07:17' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS755', N'Ngô Thị Như Quỳnh', N'Nữ', N'1986', N'Bình Dương', N'D8', CAST(N'00:05:29' AS Time))
GO
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS756', N'Tống Ngọc Vân Anh', N'Nữ', N'1965', N'Ninh Bình', N'D6', CAST(N'00:03:19' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS758', N'Võ Đình Thiên Phú', N'Nam', N'1985', N'Lào Cai', N'D+', CAST(N'00:08:33' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS759', N'Lê Thị Ngọc Phượng', N'Nam', N'1986', N'TP HCM', N'UB', CAST(N'00:08:12' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS760', N'Nguyễn Bá Gia Khánh', N'Nam', N'1975', N'Bình Dương', N'EMG', CAST(N'00:05:18' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS762', N'Vũ Đức Gia Bảo', N'Nữ', N'1966', N'Tiền Giang', N'A0', CAST(N'00:07:00' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS764', N'Nguyễn Đức Thắng', N'Nữ', N'1956', N'Gia Lai', N'P!', CAST(N'00:03:02' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS769', N'Nguyễn Quốc Cường', N'Nữ', N'1978', N'Bình Dương', N'P!', CAST(N'00:05:20' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS772', N'Nguyễn Phạm Hà My', N'Nam', N'1976', N'Tiền Giang', N'D?', CAST(N'00:04:53' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS774', N'Huỳnh Phương Vinh', N'Nữ', N'1976', N'Tiền Giang', N'D<', CAST(N'00:07:47' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS776', N'Nguyễn Lê Tuấn Thành', N'Nam', N'1987', N'Lạng Sơn', N'D@', CAST(N'00:05:17' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS777', N'Lê Đình Phú', N'Nam', N'1967', N'Bình Phước', N'D8', CAST(N'00:08:12' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS778', N'Nguyễn Bùi Tuấn Đạt', N'Nữ', N'1956', N'Đồng Tháp', N'D&', CAST(N'00:06:25' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS787', N'Lê Song Tiêu', N'Nam', N'1985', N'Hà Nội', N'P@', CAST(N'00:05:08' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS794', N'Từ Duy Khang', N'Nam', N'1966', N'Nghệ An', N'D^', CAST(N'00:05:31' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS795', N'Đỗ Chí Minh', N'Nam', N'1966', N'Kon Tum', N'D#', CAST(N'00:07:47' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS802', N'Phạm Nguyễn Băng Nghi', N'Nữ', N'1967', N'Bến Tre', N'CKQT', CAST(N'00:05:35' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS810', N'Đặng Thị Diễm Thúy', N'Nữ', N'1967', N'Bắc Kạn', N'D]', CAST(N'00:05:22' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS818', N'Nguyễn Bá Gia Khánh', N'Nam', N'1967', N'Nam Định', N'PA', CAST(N'00:04:50' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS819', N'Trần Ngọc Uyên Phương', N'Nam', N'1985', N'Đồng Tháp', N'PH', CAST(N'00:05:38' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS820', N'TrầN TrườNg Sinh', N'Nữ', N'1985', N'Bến Tre', N'HH', CAST(N'00:08:32' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS822', N'Cao Thị Thanh Hiền', N'Nam', N'1986', N'Yên Bái', N'DI', CAST(N'00:04:54' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS826', N'Nguyễn Thị Thu Huyền', N'Nam', N'1955', N'Bắc Giang', N'DV', CAST(N'00:03:32' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS827', N'Trương Phú Hưng', N'Nam', N'1985', N'Đồng Tháp', N'D@', CAST(N'00:04:52' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS828', N'Trần Tấn Phát', N'Nam', N'1978', N'Sơn La', N'D^', CAST(N'00:06:47' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS829', N'Võ Ngọc Đoan Trang', N'Nữ', N'1955', N'Nghệ An', N'D)', CAST(N'00:03:48' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS830', N'Nguyễn Công Mạnh', N'Nam', N'1985', N'Hải Phòng', N'D5', CAST(N'00:03:12' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS832', N'Nguyễn Tùng Lâm', N'Nữ', N'1955', N'Bắc Giang', N'PG', CAST(N'00:04:24' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS834', N'Nguyễn Vũ Tường Vi', N'Nam', N'1957', N'Thừa Thiên Huế', N'DG', CAST(N'00:06:06' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS835', N'Đoàn Đan Thanh', N'Nam', N'1966', N'Bà Rịa - Vũng Tàu', N'DY', CAST(N'00:06:58' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS839', N'Nguyễn Tấn Lợi', N'Nam', N'1987', N'Hòa Bình', N'D_', CAST(N'00:08:05' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS840', N'Nguyễn Lê Tuấn Thành', N'Nam', N'1976', N'Hà Tĩnh', N'D@', CAST(N'00:06:01' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS842', N'Nguyễn Hoàng Ngân Hà', N'Nam', N'1965', N'Đồng Nai', N'DD', CAST(N'00:04:56' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS843', N'Phan Bảo Ngọc', N'Nam', N'1988', N'Điện Biên', N'DV', CAST(N'00:05:48' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS844', N'Hoàng Bảo Hân', N'Nam', N'1965', N'Tiền Giang', N'PI', CAST(N'00:03:10' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS846', N'Nguyễn Minh Thư', N'Nam', N'1958', N'Sơn La', N'YHGD', CAST(N'00:03:58' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS847', N'Nguyễn Thị Mỹ Tiên', N'Nam', N'1955', N'Thái Nguyên', N'D4', CAST(N'00:04:13' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS851', N'Phạm Nguyễn Anh Thư', N'Nam', N'1986', N'Hưng Yên', N'D1', CAST(N'00:06:07' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS862', N'Dương Minh Chiến', N'Nam', N'1977', N'Bắc Giang', N'D?', CAST(N'00:08:49' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS864', N'Võ Thị Huyền Trân', N'Nam', N'1958', N'Phú Thọ', N'UB', CAST(N'00:08:12' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS866', N'Trần Thị Thanh Tâm', N'Nữ', N'1987', N'Hà Nam', N'D]', CAST(N'00:04:04' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS867', N'Lương Gia Bảo', N'Nữ', N'1976', N'Quảng Bình	', N'P2', CAST(N'00:08:05' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS868', N'Nguyễn Thị Hằng', N'Nam', N'1967', N'Hòa Bình', N'DD', CAST(N'00:03:44' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS871', N'Lê Ngọc Kim Thoa', N'Nam', N'1985', N'Đà Nẵng', N'PK', CAST(N'00:05:57' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS880', N'Trần Anh Thư', N'Nữ', N'1956', N'Đồng Nai', N'DR', CAST(N'00:08:39' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS882', N'Đỗ Lê Minh Thuận', N'Nữ', N'1977', N'Hà Nam', N'D5', CAST(N'00:04:56' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS887', N'Phan Trung Hậu', N'Nữ', N'1967', N'Hà Giang	', N'PR', CAST(N'00:08:24' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS888', N'Lê Song Sắt', N'Nam', N'1985', N'Hà Nội', N'P@', CAST(N'00:04:28' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS889', N'Lê Song Dong', N'Nam', N'1985', N'Hà Nội', N'P@', CAST(N'00:07:00' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS892', N'Võ Minh Tâm', N'Nam', N'1967', N'Hòa Bình', N'KBTS', CAST(N'00:07:20' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS895', N'Huỳnh Như', N'Nam', N'1988', N'Quảng Ngãi', N'PV', CAST(N'00:08:25' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS901', N'Lê Thị Bảo Chiêu', N'Nam', N'1977', N'Thái Bình', N'PS', CAST(N'00:07:25' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS904', N'Tôn Nguyễn Thuỳ Trang', N'Nam', N'1957', N'Thanh Hóa', N'P!', CAST(N'00:08:06' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS912', N'Cái Thị Thành Ánh', N'Nữ', N'1977', N'Bắc Giang', N'0D03', CAST(N'00:05:39' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS914', N'Võ Văn Sơn', N'Nam', N'1967', N'Đắk Lắk', N'PQ', CAST(N'00:07:50' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS915', N'Đỗ Trần Phương Lan', N'Nữ', N'1987', N'Hà Giang	', N'D#', CAST(N'00:08:34' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS916', N'Lê Đình Phúc', N'Nam', N'1975', N'Khánh Hòa', N'PK', CAST(N'00:08:00' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS917', N'Phùng Khả Di', N'Nữ', N'1976', N'An Giang', N'D#', CAST(N'00:05:06' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS922', N'Ngô Quốc An', N'Nam', N'1988', N'Sóc Trăng', N'PN', CAST(N'00:05:20' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS937', N'Võ Quỳnh Mai', N'Nam', N'1966', N'Thái Bình', N'PHCN', CAST(N'00:05:02' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS947', N'Phạm Đào Tường Vy', N'Nữ', N'1957', N'Bắc Giang', N'DQ', CAST(N'00:05:09' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS948', N'Trần Phạm Hiền Anh', N'Nam', N'1967', N'Lâm Đồng', N'DC', CAST(N'00:06:04' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS951', N'Nguyễn Văn Hoàng Thiện', N'Nữ', N'1988', N'Ninh Thuận', N'D1', CAST(N'00:05:49' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS956', N'Nguyễn Đức Duy', N'Nữ', N'1965', N'Đắk Lắk', N'D@', CAST(N'00:03:31' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS968', N'Huỳnh Hiếu Thuận', N'Nam', N'1965', N'Ninh Thuận', N'D_', CAST(N'00:03:53' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS970', N'Tăng Hồ Gia Hân', N'Nữ', N'1958', N'Vĩnh Phúc', N'DN', CAST(N'00:03:07' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS976', N'Võ Minh Tuấn', N'Nữ', N'1987', N'Ninh Thuận', N'PM', CAST(N'00:03:04' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS978', N'Phạm Nguyễn Thanh Thảo', N'Nam', N'1966', N'Điện Biên', N'A0', CAST(N'00:07:46' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS985', N'Nguyễn Phan Quốc Trung', N'Nam', N'1988', N'Hải Phòng', N'PHCN', CAST(N'00:06:16' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS989', N'Vũ Tuấn Kỳ', N'Nam', N'1989', N'BRVT', N'PD', CAST(N'00:05:29' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS990', N'Vũ Tuấn Sơn', N'Nam', N'1988', N'BRVT', N'PD', CAST(N'00:07:23' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS991', N'Vũ Thanh Kỳ', N'Nam', N'1987', N'BRVT', N'PD', CAST(N'00:08:15' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS992', N'Vũ Nam Kỳ', N'Nam', N'1989', N'BRVT', N'PD', CAST(N'00:05:48' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS993', N'Lê Nam', N'Nam', N'1989', N'BRVT', N'PD', CAST(N'00:04:49' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS994', N'Lê Ki Ma', N'Nam', N'1988', N'Hà Nội', N'PD', CAST(N'00:08:07' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS995', N'Diệp Ngô Gia Phát', N'Nam', N'1955', N'Hải Phòng', N'PS', CAST(N'00:07:54' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS996', N'Lê Hàn Quốc', N'Nam', N'1989', N'BRVT', N'PD', CAST(N'00:03:13' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS997', N'Lê Quốc Trung', N'Nam', N'1957', N'Sóc Trăng', N'DT', CAST(N'00:05:48' AS Time))
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK1', N'1', 1, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK1', N'117', 1, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK1', N'141', 1, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK1', N'15', 1, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK1', N'154', 1, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK1', N'16', 1, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK1', N'23', 1, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK1', N'24', 1, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK1', N'25', 1, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK1', N'35', 1, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK1', N'44', 1, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK1', N'48', 1, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK1', N'56', 1, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK1', N'98', 1, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK2', N'1', 2, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK2', N'117', 2, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK2', N'141', 2, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK2', N'15', 2, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK2', N'154', 2, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK2', N'16', 2, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK2', N'23', 2, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK2', N'24', 2, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK2', N'25', 2, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK2', N'35', 2, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK2', N'48', 2, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK2', N'98', 2, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK3', N'117', 3, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK3', N'15', 3, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK3', N'154', 3, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK3', N'23', 3, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK3', N'24', 3, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK3', N'48', 3, 1)
INSERT [dbo].[BanKham] ([IDBan], [Phong], [SoBan], [TinhTrang]) VALUES (N'BK3', N'98', 3, 1)
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21114', N'Nguyễn', N'Tuấn', N'Mai', N'4862121655', N'Nam', CAST(N'1967-07-03' AS Date), N'Phú Yên	', N'Nội trợ', N'0975157057', N'Lai Châu')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21122', N'Bùi', N'Minh', N'Linh', N'4893514419', N'Nữ', CAST(N'1972-08-26' AS Date), N'Đắk Lắk', N'Công nhân', N'0934452072', N'Đắk Lắk')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21123', N'Ngô', N'Minh', N'Trinh', N'7349456327', N'Nữ', CAST(N'1990-01-14' AS Date), N'Quảng Trị', N'Nội trợ', N'0995649378', N'Long An')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21125', N'Lê', N'Minh', N'Kim', N'6379372917', N'Nữ', CAST(N'1997-05-18' AS Date), N'Quảng Trị', N'Buôn bán', N'0959178573', N'Lai Châu')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21126', N'Cao', N'Minh', N'Sơn', N'1832913573', N'Nữ', CAST(N'1966-04-10' AS Date), N'Phú Thọ', N'Thương nhân', N'0982612033', N'Quảng Ninh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21131', N'Trần', N'Quang', N'Tú', N'9536568382', N'Nam', CAST(N'1995-12-06' AS Date), N'Đà Nẵng', N'Nông dân', N'0950212119', N'Tây Ninh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21132', N'Trịnh', N'Văn', N'Minh', N'5666319187', N'Nam', CAST(N'1975-03-24' AS Date), N'Bình Phước', N'Công chức', N'0953138366', N'Hòa Bình')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21135', N'Trần', N'Cao ', N'Sơn', N'3153624212', N'Nữ', CAST(N'1995-02-13' AS Date), N'Hải Phòng', N'Nội trợ', N'0989986512', N'Quảng Ninh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21136', N'Trịnh', N'Mai', N'Sơn', N'4675894136', N'Nữ', CAST(N'1987-10-24' AS Date), N'Thừa Thiên Huế', N'Nội trợ', N'0927527238', N'Hòa Bình')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21143', N'Cao', N'Hữu', N'Hóa', N'5886516914', N'Nữ', CAST(N'1991-02-15' AS Date), N'Cao Bằng', N'Y tá', N'0985984018', N'Kiên Giang')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21144', N'Bùi', N'Thái', N'Tám', N'3121586764', N'Nam', CAST(N'1978-11-20' AS Date), N'Bến Tre', N'Công an', N'0912296525', N'Khánh Hòa')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21151', N'Võ', N'Văn', N'Ân', N'4723557385', N'Nam', CAST(N'1984-11-22' AS Date), N'Hà Giang	', N'Công chức', N'0941779003', N'Hà Nội')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21166', N'Phùng', N'Kim', N'Khôi', N'5789438494', N'Nam', CAST(N'1983-08-08' AS Date), N'Bình Định', N'Y tá', N'0972745130', N'Điện Biên')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21213', N'Dương', N'Quang', N'Bắc', N'3842923251', N'Nam', CAST(N'1993-01-10' AS Date), N'Bến Tre', N'Nông dân', N'0977466161', N'Khánh Hòa')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21214', N'Phan', N'Thanh', N'Huyền', N'8365215959', N'Nữ', CAST(N'1995-02-12' AS Date), N'Kiên Giang', N'Giáo viên', N'0970019432', N'Bình Dương')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21222', N'Lê', N'Thành', N'Khôi', N'6923224794', N'Nữ', CAST(N'1994-02-25' AS Date), N'Cà Mau', N'Công an', N'0925072429', N'Ninh Bình')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21226', N'Ngô', N'Ngọc', N'Trinh', N'5566372637', N'Nam', CAST(N'1970-02-04' AS Date), N'Cần Thơ', N'Buôn bán', N'0909452721', N'Bình Phước')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21234', N'Bùi', N'Thái', N'Khoa', N'1913356584', N'Nam', CAST(N'1976-08-31' AS Date), N'Bắc Ninh', N'Y tá', N'0932290732', N'Hà Nội')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21235', N'Trần', N'Thị ', N'Huyền', N'9146633382', N'Nam', CAST(N'1973-05-15' AS Date), N'Hưng Yên', N'Nông dân', N'0949646624', N'Thái Nguyên')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21236', N'Ngô', N'Thị Thùy', N'Hải', N'9695436179', N'Nam', CAST(N'1974-03-20' AS Date), N'Kiên Giang', N'Dân phòng', N'0944595707', N'Hải Phòng')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21241', N'Phan', N'Phương', N'My', N'6864415425', N'Nam', CAST(N'1969-10-29' AS Date), N'Bắc Ninh', N'Công chức', N'0959558054', N'Hậu Giang')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21252', N'Trương', N'Trương', N'My', N'2219436251', N'Nữ', CAST(N'1984-11-26' AS Date), N'Đồng Nai', N'Thương nhân', N'0983685965', N'Bà Rịa - Vũng Tàu')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21253', N'Vũ', N'Trương', N'Hải', N'4836456682', N'Nam', CAST(N'1985-07-20' AS Date), N'Cà Mau', N'Y tá', N'0917747090', N'Long An')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21254', N'Trương', N'Thanh', N'Minh', N'7897437146', N'Nam', CAST(N'1987-04-02' AS Date), N'Lào Cai', N'Y tá', N'0909938270', N'Ninh Thuận')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21255', N'Trịnh', N'Thị ', N'Sơn', N'4344664925', N'Nam', CAST(N'1985-12-09' AS Date), N'Thanh Hóa', N'Dân phòng', N'0925957077', N'Phú Yên	')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21256', N'Trương', N'Cao ', N'Khoa', N'4532246311', N'Nữ', CAST(N'1992-09-15' AS Date), N'Quảng Bình	', N'Công an', N'0907204801', N'Nghệ An')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21261', N'Vũ', N'Văn', N'Sơn', N'6217878111', N'Nam', CAST(N'1979-06-01' AS Date), N'Phú Yên	', N'Nội trợ', N'0939645506', N'Khánh Hòa')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21264', N'Phạm', N'Minh', N'Minh', N'7232788897', N'Nữ', CAST(N'1975-10-31' AS Date), N'Đắk Nông', N'Dân phòng', N'0925717848', N'Lâm Đồng')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21313', N'Dương', N'Cao ', N'Kỳ', N'8289666326', N'Nam', CAST(N'1988-02-26' AS Date), N'Nam Định', N'Dân phòng', N'0939054529', N'Điện Biên')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21315', N'Phan', N'Mai', N'Khoa', N'9589543323', N'Nam', CAST(N'1967-04-12' AS Date), N'Bình Phước', N'Nông dân', N'0985038615', N'Bình Phước')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21321', N'Võ', N'Trương', N'My', N'4387662684', N'Nam', CAST(N'1980-07-22' AS Date), N'Hải Dương', N'Thương nhân', N'0963241358', N'Đà Nẵng')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21323', N'Bùi', N'Phi', N'Hiền', N'2764448366', N'Nữ', CAST(N'1970-01-17' AS Date), N'Lạng Sơn', N'Công chức', N'0924150514', N'Đắk Lắk')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21325', N'Hoàng', N'Minh', N'Hóa', N'4294896484', N'Nam', CAST(N'1997-06-27' AS Date), N'Hà Tĩnh', N'Giáo viên', N'0962423172', N'Hậu Giang')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21332', N'Nguyễn', N'Mai', N'Kim', N'1737535241', N'Nam', CAST(N'1992-05-23' AS Date), N'Quảng Ninh', N'Nông dân', N'0932578002', N'Cần Thơ')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21333', N'Ngô', N'Văn', N'Minh', N'5533459365', N'Nữ', CAST(N'1979-06-24' AS Date), N'Khánh Hòa', N'Nông dân', N'0992157091', N'Kon Tum')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21334', N'Trần', N'Minh', N'Linh', N'2976687615', N'Nam', CAST(N'1965-05-13' AS Date), N'Đà Nẵng', N'Dân phòng', N'0917337612', N'Vĩnh Phúc')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21335', N'Lê', N'Thành', N'Vinh', N'9219375274', N'Nam', CAST(N'1996-02-18' AS Date), N'Phú Thọ', N'Y tá', N'0961712861', N'Vĩnh Long')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21342', N'Phùng', N'Ngọc', N'Chinh', N'3552824116', N'Nam', CAST(N'1996-01-02' AS Date), N'Quảng Bình	', N'Nội trợ', N'0902191766', N'Long An')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21344', N'Phạm', N'Quang', N'Huyền', N'1379488199', N'Nam', CAST(N'1971-04-21' AS Date), N'Thanh Hóa', N'Buôn bán', N'0999926310', N'Vĩnh Phúc')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21345', N'Lê', N'Ngọc', N'Nhật', N'9724554756', N'Nam', CAST(N'1977-05-12' AS Date), N'Phú Thọ', N'Y tá', N'0997416086', N'Long An')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21352', N'Dương', N'Mai', N'Hải', N'3369821591', N'Nam', CAST(N'1980-09-28' AS Date), N'Bạc Liêu', N'Nội trợ', N'0988170895', N'Thái Nguyên')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21353', N'Nguyễn', N'Minh', N'Hóa', N'5786998515', N'Nữ', CAST(N'1970-05-06' AS Date), N'Yên Bái', N'Công an', N'0970639568', N'Hòa Bình')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21354', N'Nguyễn', N'Văn', N'Nhật', N'1427117945', N'Nam', CAST(N'1982-08-27' AS Date), N'Vĩnh Phúc', N'Nông dân', N'0943120311', N'Lào Cai')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21355', N'Dương', N'Thái', N'Nam', N'9794181951', N'Nam', CAST(N'1969-10-08' AS Date), N'Long An', N'Y tá', N'0956301248', N'Tây Ninh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21363', N'Ngô', N'Thành', N'Minh', N'4836476358', N'Nam', CAST(N'1989-10-08' AS Date), N'Đồng Tháp', N'Buôn bán', N'0932265878', N'Cao Bằng')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21411', N'Trần', N'Phi', N'Nhật', N'4879385887', N'Nam', CAST(N'1972-11-03' AS Date), N'An Giang', N'Giáo viên', N'0989862861', N'Bình Định')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21414', N'Bùi', N'Thị Thùy', N'Hóa', N'2963733668', N'Nữ', CAST(N'1985-05-06' AS Date), N'Khánh Hòa', N'Công nhân', N'0988348222', N'Thừa Thiên Huế')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21415', N'Phan', N'Văn', N'Linh', N'1184685597', N'Nam', CAST(N'1965-03-16' AS Date), N'Cao Bằng', N'Nội trợ', N'0960170841', N'Bình Phước')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21416', N'Cao', N'Thái', N'Sơn', N'2476794632', N'Nam', CAST(N'1989-08-02' AS Date), N'Bắc Kạn', N'Buôn bán', N'0995785455', N'Bạc Liêu')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21424', N'Dương', N'Minh', N'Sơn', N'5646516625', N'Nam', CAST(N'1965-07-02' AS Date), N'Lâm Đồng', N'Công an', N'0927949641', N'Thái Bình')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21425', N'Cao', N'Ngọc', N'Nhật', N'8362847275', N'Nam', CAST(N'1991-06-12' AS Date), N'Điện Biên', N'Y tá', N'0927293850', N'Bình Thuận')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21432', N'Nguyễn', N'Thành', N'Ân', N'7682555379', N'Nam', CAST(N'1970-08-17' AS Date), N'Sóc Trăng', N'Y tá', N'0980991746', N'Ninh Bình')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21435', N'Phạm', N'Ngọc', N'Khoa', N'6898739343', N'Nữ', CAST(N'1993-11-05' AS Date), N'Nghệ An', N'Nội trợ', N'0908303560', N'Thái Nguyên')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21441', N'Hoàng', N'Minh', N'Minh', N'9114129434', N'Nữ', CAST(N'1968-08-31' AS Date), N'Hà Nội', N'Giáo viên', N'0925925095', N'Lai Châu')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21442', N'Trương', N'Phi', N'Tám', N'5469326865', N'Nam', CAST(N'1965-07-16' AS Date), N'Sóc Trăng', N'Công chức', N'0963346289', N'Hải Phòng')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21444', N'Bùi', N'Thái', N'Minh', N'6318212465', N'Nữ', CAST(N'1978-04-26' AS Date), N'Lào Cai', N'Giáo viên', N'0943822211', N'Hưng Yên')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21451', N'Lê', N'Kim', N'An', N'1612269911', N'Nam', CAST(N'1990-07-19' AS Date), N'Sóc Trăng', N'Buôn bán', N'0987854867', N'Nam Định')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21456', N'Trịnh', N'Thị ', N'Vinh', N'8241979415', N'Nam', CAST(N'1983-12-21' AS Date), N'An Giang', N'Thương nhân', N'0901444697', N'Bắc Giang')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21464', N'Bùi', N'Quang', N'Nam', N'5577685288', N'Nam', CAST(N'1994-12-18' AS Date), N'Quảng Nam', N'Dân phòng', N'0964581975', N'Phú Thọ')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21466', N'Phạm', N'Kim', N'Huyền', N'9528636831', N'Nam', CAST(N'1969-12-11' AS Date), N'Bắc Giang', N'Buôn bán', N'0934235346', N'Thái Nguyên')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21511', N'Hoàng', N'Thị Thùy', N'Anh', N'8975952845', N'Nam', CAST(N'1990-08-17' AS Date), N'Cà Mau', N'Y tá', N'0904239151', N'Thừa Thiên Huế')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21512', N'Phạm', N'Mai', N'Hải', N'5417269351', N'Nữ', CAST(N'1979-09-13' AS Date), N'Thanh Hóa', N'Buôn bán', N'0951253126', N'Đắk Lắk')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21514', N'Dương', N'Trương', N'Minh', N'5531447324', N'Nữ', CAST(N'1967-03-16' AS Date), N'Tây Ninh', N'Công chức', N'0934669773', N'Hưng Yên')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21516', N'Phùng', N'Văn', N'Mai', N'9968111836', N'Nữ', CAST(N'1975-10-13' AS Date), N'Vĩnh Phúc', N'Y tá', N'0943139612', N'Vĩnh Long')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21522', N'Dương', N'Quang', N'Nam', N'3796436687', N'Nữ', CAST(N'1994-04-17' AS Date), N'Hải Phòng', N'Y tá', N'0926806729', N'Trà Vinh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21526', N'Hoàng', N'Thị ', N'Trinh', N'9344766723', N'Nam', CAST(N'1995-05-20' AS Date), N'Hải Phòng', N'Công nhân', N'0941555019', N'Đắk Nông')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21533', N'Cao', N'Phương', N'Quang', N'2926551229', N'Nam', CAST(N'1984-10-30' AS Date), N'Bắc Ninh', N'Dân phòng', N'0975844207', N'Bạc Liêu')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21534', N'Lê', N'Minh', N'Huyền', N'1871135746', N'Nữ', CAST(N'1967-03-01' AS Date), N'Hưng Yên', N'Nông dân', N'0913321979', N'Nam Định')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21541', N'Phan', N'Văn', N'Khoa', N'9584736669', N'Nam', CAST(N'1970-01-17' AS Date), N'Cà Mau', N'Công nhân', N'0904027887', N'Kiên Giang')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21545', N'Bùi', N'Trương', N'Sơn', N'2771826577', N'Nam', CAST(N'1970-09-30' AS Date), N'Đà Nẵng', N'Công nhân', N'0944317491', N'Quảng Ninh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21546', N'Phan', N'Ngọc', N'Anh', N'7485283371', N'Nam', CAST(N'1989-10-29' AS Date), N'Phú Thọ', N'Nông dân', N'0980139551', N'Bình Thuận')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21551', N'Phạm', N'Văn', N'Sơn', N'8248377286', N'Nam', CAST(N'1992-01-07' AS Date), N'Thái Nguyên', N'Công an', N'0917231031', N'Bình Định')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21554', N'Cao', N'Cao ', N'Ân', N'8448653863', N'Nữ', CAST(N'1975-07-02' AS Date), N'Bình Dương', N'Công an', N'0985038974', N'Tiền Giang')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21555', N'Phùng', N'Kim', N'Sơn', N'9266144911', N'Nữ', CAST(N'1988-02-01' AS Date), N'Hà Giang	', N'Công an', N'0948122974', N'Lào Cai')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21556', N'Cao', N'Minh', N'Vinh', N'2311741943', N'Nữ', CAST(N'1980-02-16' AS Date), N'Lâm Đồng', N'Công chức', N'0998376431', N'TP HCM')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21563', N'Ngô', N'Minh', N'Hiền', N'6554783213', N'Nam', CAST(N'1975-08-02' AS Date), N'Bình Định', N'Công nhân', N'0912590314', N'Quảng Ninh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21564', N'Bùi', N'Ngọc', N'An', N'3931823557', N'Nam', CAST(N'1991-04-21' AS Date), N'Lạng Sơn', N'Nội trợ', N'0964701856', N'Bình Dương')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21566', N'Cao', N'Cao ', N'Minh', N'1754125729', N'Nam', CAST(N'1990-09-12' AS Date), N'Trà Vinh', N'Nội trợ', N'0989096761', N'Hải Dương')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21611', N'Cao', N'Minh', N'Kỳ', N'6674735171', N'Nữ', CAST(N'1988-06-05' AS Date), N'Khánh Hòa', N'Thương nhân', N'0920589994', N'Hưng Yên')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21612', N'Trương', N'Kim', N'My', N'5815273826', N'Nam', CAST(N'1996-07-26' AS Date), N'Bắc Ninh', N'Thương nhân', N'0981933172', N'Yên Bái')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21614', N'Phạm', N'Phương', N'Vinh', N'7559383219', N'Nam', CAST(N'1994-06-14' AS Date), N'Yên Bái', N'Dân phòng', N'0964256322', N'Phú Thọ')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21616', N'Trương', N'Thị Thùy', N'My', N'1278794667', N'Nữ', CAST(N'1971-04-03' AS Date), N'Tây Ninh', N'Công chức', N'0975023228', N'Sóc Trăng')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21632', N'Lê', N'Hữu', N'Kỳ', N'6894716866', N'Nữ', CAST(N'1980-05-30' AS Date), N'Quảng Bình	', N'Công nhân', N'0904388280', N'Bình Phước')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21634', N'Võ', N'Phương', N'Vinh', N'1481213286', N'Nam', CAST(N'1990-04-11' AS Date), N'Lạng Sơn', N'Công an', N'0972903366', N'Bà Rịa - Vũng Tàu')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21635', N'Phan', N'Thị ', N'Nhật', N'6491586614', N'Nam', CAST(N'1975-07-24' AS Date), N'Quảng Ngãi', N'Y tá', N'0911352925', N'Hà Tĩnh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21641', N'Trịnh', N'Kim', N'Nam', N'7889845443', N'Nữ', CAST(N'1982-06-02' AS Date), N'Tây Ninh', N'Công nhân', N'0921541340', N'Bắc Giang')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21642', N'Nguyễn', N'Quang', N'Tú', N'3799187664', N'Nữ', CAST(N'1992-07-11' AS Date), N'Quảng Ninh', N'Buôn bán', N'0913650155', N'Điện Biên')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21644', N'Hoàng', N'Kim', N'Thư', N'3914913142', N'Nữ', CAST(N'1982-09-14' AS Date), N'Hà Tĩnh', N'Nông dân', N'0965327689', N'Tiền Giang')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21645', N'Ngô', N'Ngọc', N'Khôi', N'8696238352', N'Nam', CAST(N'1993-05-12' AS Date), N'Trà Vinh', N'Công an', N'0961659981', N'Vĩnh Phúc')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21646', N'Bùi', N'Ngọc', N'Nhật', N'5727379978', N'Nữ', CAST(N'1976-11-29' AS Date), N'Bắc Ninh', N'Nông dân', N'0999689833', N'Ninh Thuận')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21652', N'Hoàng', N'Văn', N'Nam', N'2987942377', N'Nam', CAST(N'1997-04-08' AS Date), N'Hậu Giang', N'Công nhân', N'0926524444', N'Quảng Trị')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21661', N'Hoàng', N'Cao ', N'Thư', N'2866478115', N'Nam', CAST(N'1966-03-09' AS Date), N'Ninh Thuận', N'Dân phòng', N'0941567438', N'Thanh Hóa')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21676', N'Lê', N'Quang', N'Nhật', N'273620258', N'Nam', CAST(N'1997-05-25' AS Date), N'Ninh THuận', N'Sinh Viên', N'953621258', N'TP HCM')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21677', N'Lê', N'Quang', N'Anh', N'273620259', N'Nam', CAST(N'1989-03-27' AS Date), N'Đà Lạt', N'Giáo Viên', N'987652258', N'TP HCM')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21678', N'Võ', N'Nhân', N'Ngọc', N'273620278', N'Nam', CAST(N'1988-05-02' AS Date), N'BRVT', N'Kỹ Sư', N'989625123', N'TP HCM')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21679', N'Lê', N'Thị', N'Đào', N'273620268', N'Nữ', CAST(N'1980-08-25' AS Date), N'Phan Thiết', N'Nội Trợ', N'988856253', N'TP HCM')
INSERT [dbo].[CaKham] ([IDCa], [TenCa], [GioBatDau], [GioKetThuc]) VALUES (1, N'Sáng', N'7:00 AM', N'12:00 AM')
INSERT [dbo].[CaKham] ([IDCa], [TenCa], [GioBatDau], [GioKetThuc]) VALUES (2, N'Chiều', N'1:00 PM', N'6:00 PM')
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'0D03', N'Khoa chẩn đoán hình ảnh', 5, 1, 0, 1)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'0UGM', N'UNG BƯỚU GAN MẬT VÀ GHÉP GAN', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'A0', N'KHOA KHÁM SỨC KHỎE THEO YÊU CẦU', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'B0', N'PHÒNG TÀI CHÍNH KẾ TOÁN', 5, 3, 0, 5)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'CKQT', N'PK QUỐC TẾ (CHUYÊN KHOA)', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D-', N'DV PK DA LIỄU', 5, 3, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D!', N'DV PK NỘI TIẾT', 5, 3, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D#', N'PHOTO TẠI P. NGHIỆP VỤ', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D$', N'DV PHÒNG KHÁM NIỆU', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D&', N'ĐƠN VỊ HUYẾT HỌC', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D(', N'DỊ ỨNG - MD LÂM SÀNG', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D)', N'HÓA TRỊ', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D*', N'DỊCH VỤ PHÒNG HIFU', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D?', N'Y HỌC CỔ TRUYỀN', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D@', N'DỊCH VỤ KHOA PT TIM', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D[', N'XÉT NGHIỆM TẠI KHOA', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D]', N'CHÍCH NGỪA', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D^', N'DV PK TIÊU HOÁ', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D_', N'DV PK NAM KHOA', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D+', N'KHOA PHỤC HỒI CHỨC NĂNG', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D<', N'KHOA GIẢI PHẪU BỆNH', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D0', N'DV PK HẬU MÔN', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D1', N'DỊCH VỤ NỘI TRÚ A', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D2', N'DỊCH VỤ NỘI TRÚ B', 5, 3, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D3', N'DỊCH VỤ PK THẦN KINH', 5, 3, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D4', N'DV PHÒNG KHÁM KHỚP', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D5', N'DV KHÁM TỔNG QUÁT', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D6', N'DV PHÒNG KHÁM TIM MẠCH', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D7', N'DV PHÒNG BÓ BỘT', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D8', N'DV PHÒNG CHĂM SÓC DA', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D9', N'DV PK TẠO HÌNH-THẨM MỸ', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DA', N'X - QUANG', 5, 1, 0, 1)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DB', N'NỘI SOI', 5, 1, 0, 1)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DC', N'SIÊU ÂM', 5, 1, 0, 1)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DD', N'SIÊU ÂM TIM', 5, 2, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DE', N'ĐO ĐIỆN TIM', 5, 2, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DF', N'THĂM DÒ CHỨC NĂNG', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DG', N'SPECT', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DH', N'XÉT NGHIỆM', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DI', N'DSA', 5, 2, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DJ', N'XN ĐƯỜNG HUYẾT', 5, 3, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DK', N'DV KHÁM PHỔI', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DL', N'DV TAI MŨI HỌNG', 5, 3, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DM', N'DV PK MẮT', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DN', N'RĂNG HÀM MẶT', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DP', N'TRĨ - DÒ HẬU MÔN (TT )', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DQ', N'Đ/T TRƯƠNG LỰC CƠ (L. 1)', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DR', N'DV PK PHỤ KHOA', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DS', N'DỊCH VỤ PK VÚ SỐ 20', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DT', N'DỊCH VỤ CẤP CỨU', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DTTL', N'TƯ VẤN TÂM LÝ', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DU', N'PK.VIÊM GAN', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DV', N'PHÒNG CT-SCANNER', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DW', N'PHÒNG MRI', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DX', N'VTYT PHÒNG MỔ', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DY', N'PK RỐI LOẠN ĐẠI TIỆN', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DZ', N'KIỂM SOÁT NHIỄM KHUẨN', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'EEG', N'ĐIỆN NÃO', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'EMG', N'ĐIỆN CƠ', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'GN', N'CHĂM SÓC GIẢM NHẸ', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'HH', N'HUYẾT HỌC', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'KBTS', N'PHỤ SẢN LẦU 2 KHU B', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'KTN', N'TIÊM NGỪA', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'LM', N'LỒNG NGỰC - MẠCH MÁU', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'ND', N'NHI', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'NHCN', N'NIỆU HỌC CHỨC NĂNG', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'NHI2', N'NHI LẦU 2', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'NXK', N'NỘI CƠ XƯƠNG KHỚP', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'P!', N'PHẪU THUẬT HÀM MẶT - RHM', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'P#', N'DỊ ỨNG - MIỄN DỊCH LÂM SÀNG', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'P$', N'NGOẠI THẦN KINH', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'P(', N'ĐAU MẠN TÍNH', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'P@', N'Y HỌC CỔ TRUYỀN', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'P^', N'KHÁM VÀ TƯ VẤN DINH DƯỠNG', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'P2', N'PARKINSON VÀ RỐI LOẠN VẬN ĐỘNG', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'P6', N'NAM KHOA', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'P7', N'TIÊU HÓA GAN MẬT', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'P9', N'Y HỌC HẠT NHÂN', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PA', N'SẢN - PHỤ KHOA', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PB', N'DA LIỄU', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PC', N'PHỔI', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PD', N'TAI MŨI HỌNG', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PF', N'MẮT', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PG', N'VIÊM GAN', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PH', N'TỔNG QUÁT', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PHCN', N'PHỤC HỒI CHỨC NĂNG', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PI', N'TIM MẠCH', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PJ', N'XƯƠNG KHỚP CHỈNH HÌNH', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PK', N'THẦN KINH', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PL', N'NỘI TIẾT', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PM', N'TIẾT NIỆU', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PN', N'TÂM THẦN KINH', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PO', N'NGOẠI TIM MẠCH', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PP', N'HẬU MÔN HỌC', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PQ', N'HÔ HẤP', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PR', N'HÓA TRỊ', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PS', N'PHÒNG TƯ VẤN', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PT', N'CHĂM SÓC DA', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PU', N'TẠO HÌNH - THẨM MỸ', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PV', N'H. ẢNH HỌC CAN THIỆP', 1, 1, 0, 2)
GO
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PW', N'LÃO KHOA', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PY', N'VÚ', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PZ', N'TIỂU PHẪU', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'TN', N'NỘI THẬN', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'TQQT', N'PK QUỐC TẾ (TỔNG QUÁT)', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'UB', N'UNG BƯỚU', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'VT01', N'PHÒNG KHÁM BỆNH VIỆN ĐẠI HỌC Y DƯỢC 1', 1, 3, 0, 23)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'YHGD', N'Y HỌC GIA ĐÌNH', 1, 3, 0, 2)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'E038', N'Nội soi can thiệp - cắt polyp ống tiêu hóa < 1cm', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI0', N'Phế máu ngoại biên (BV TMHH)', N'GA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI1', N'Xét nghiệm tế bào học tủy xương (tủy đồ) (BV TMHH)', N'GA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI2', N'Định lượng Arsenic nước tiểu', N'GA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI3', N'Định lượng Arsenic tóc', N'GA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI4', N'Tia xạ túi máu', N'GA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI6', N'BK đàm (PNT)', N'GA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI8', N'Soi trực tiếp nhuộm soi (nhuộm Gram...) (CR)', N'GA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI9', N'Nuôi cấy và định danh nấm bằng phương pháp thông thường (CR)', N'GA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGJ1', N'Nuôi cấy định danh vi khuẩn bằng phương pháp thông thường (CR)', N'GA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGJ2', N'Kháng sinh đồ nấm (CR)', N'GA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGJ3', N'Kháng sinh đồ vi khuẩn (CR)', N'GA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGJ5', N'Xét nghiệm tìm BK (CR)', N'GA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGJ6', N'Định lượng Catecholamin /máu', N'GA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGL9', N'Soi mủ hạch, abces tìm BK (NĐ)', N'GA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGM0', N'Soi mủ tìm nấm (BĐ)', N'GA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGM1', N'Soi dịch vết thương tìm BK (NĐ)', N'GA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGM2', N'Soi dịch vết thương tìm vi trùng (NĐ)', N'GA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGM3', N'Soi tìm BK đàm (NĐ)', N'GA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'KX11', N'Đo mật độ xương bằng phương pháp DEXA (cổ xương đùi) và đo chiều dài trụ khớp háng (HAL) hai bên', N'KX', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'KX12', N'Đo các thành phần cơ, mỡ, xương toàn thân người lớn', N'KX', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'KX14', N'Đo mật độ xương bằng phương pháp DEXA (CSTL + cổ xương đùi một bên)', N'KX', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MA', N'Chụp X-Quang dạ dày - tá tràng có uống thuốc cản quang Bary sulfat 275mg số hóa', N'MA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MAP6', N'Chụp X-quang xương cánh tay thẳng 1 bên số hóa  1 phim', N'MA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MAP7', N'Chụp X-quang xương cánh tay nghiêng 1 bên số hóa', N'MA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MAP8', N'Chụp X-quang khớp gối thẳng – nghiêng 1 bên (tư thế đứng) số hóa  1 phim', N'MA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MAP9', N'Chụp X-quang khớp gối thẳng – nghiêng 2 bên (tư thế đứng) 2 phim số hóa  1 phim', N'MA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MAQ0', N'Chụp X-quang khớp gối nghiêng 1 bên (tư thế đứng) số hóa  1 phim', N'MA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MAQ1', N'Chụp X-quang khớp gối thẳng 1 bên (tư thế đứng) số hóa  1 phim', N'MA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MAQ2', N'Chụp X-quang lưu thông ruột non có cản quang tan trong nước số hóa', N'MA', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MB39', N'Bộ thun thắt tĩnh mạch thực quản', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MB82', N'Nội soi can thiệp - cắt polyp ống tiêu hóa > 1cm hoặc nhiều polyp', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MB84', N'Nội soi chích (tiêm) keo điều trị dãn tĩnh mạch phình vị', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MB86', N'Chụp đường mật trong mổ nội soi', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MB88', N'Chụp mật qua Kehr', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MB89', N'Đặt stent thực quản qua nội soi.', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MB91', N'Nội soi thanh quản lấy dị vật', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBA1', N'Nội soi đại trực tràng toàn bộ ống mềm không sinh thiết', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBA4', N'Nội soi mật tụy ngược dòng - (ERCP) chẩn đoán', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBC8', N'Nội soi thanh quản ống mềm sinh thiết', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBD0', N'Nội soi can thiệp - thắt búi giãn tĩnh mạch thực quản bằng vòng cao su', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBD1', N'Tiêm hoặc kẹp cầm máu qua nội soi dạ dày', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBD2', N'Tiêm hoặc kẹp cầm máu qua nội soi đại tràng', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBD5', N'Nội soi nong hẹp miệng nối ruột-ruột hoặc mật-ruột', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBE0', N'Nội soi thực quản - dạ dày - tá tràng không sinh thiết (ống mềm, gây mê)', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBE1', N'Nội soi đại trực tràng toàn bộ ống mềm không sinh thiết (gây mê)', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBE3', N'Nội soi thực quản-dạ dày, lấy dị vật', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBE5', N'Nội soi can thiệp - gắp giun, dị vật ống tiêu hóa', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBE7', N'Nội soi can thiệp - cầm máu ống tiêu hóa bằng laser argon', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBE8', N'Nội soi phế quản ống mềm (gây mê)', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBE9', N'Nội soi thực quản- dạ dày- tá tràng không sinh thiết (ống mềm)', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBF0', N'Nội soi thực quản- dạ dày- tá tràng có thể kết hợp sinh thiết (ống mềm, gây mê)', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBF1', N'Nội soi đại trực tràng ống mềm gây mê (có thuốc, có sinh thiết)', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBF2', N'Nội soi đại trực tràng ống mềm gây mê (không thuốc, không sinh thiết)', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBF3', N'Nội soi đại trực tràng ống mềm gây mê (không thuốc, có sinh thiết)', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBH0', N'Kỹ thuật mở cơ qua nội soi đường miệng điều trị co thắt tâm vị', N'MB', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC60', N'Chọc hút tế bào tuyến giáp dưới hướng dẫn siêu âm', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC61', N'Bơm nước lòng tử cung (SHG) qua siêu âm', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC65', N'Chọc FNA >=2 nhân qua siêu âm', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC66', N'Chọc FNA 1 nhân qua siêu âm', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC67', N'Chọc hút dịch ( ổ bụng, màng phổi) qua siêu âm', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC68', N'Chọc hút nang vú dưới hướng dẫn siêu âm', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC69', N'Đốt sóng cao tần điều trị ung thư gan (RFA) dưới hướng dẫn siêu âm', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC72', N'Siêu âm Doppler tinh hoàn, mào tinh hoàn hai bên', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC73', N'Siêu âm ổ bụng', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC74', N'Siêu âm mắt (siêu âm thường qui) (1 mắt)', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC75', N'Siêu âm mắt (siêu âm thường qui) (2 mắt)', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC81', N'Siêu âm ổ bụng (đo thể tích nước tiểu)', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC88', N'Siêu âm 3D/4D tim', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC89', N'Siêu âm phần mềm', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC90', N'Siêu âm 3D/4D trực tràng', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC91', N'Siêu âm mắt (lấy thông số mổ cận thị)', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC92', N'Siêu âm mắt (đo kính nội nhãn)', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC93', N'Siêu âm phụ khoa ngã H.môn-T.Tràng (màu)', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC94', N'Siêu âm phụ khoa ngã H.môn-T.Tràng (trắng đen)', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MCD0', N'Siêu âm thai (thai, nhau thai, nước ối)', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MCD1', N'Siêu âm Doppler thai nhi (thai, nhau thai, dây rốn, động mạch tử cung)', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MCD2', N'Siêu âm thai nhi trong 3 tháng đầu (Siêu âm khảo sát hình thái học)', N'MC', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF15', N'Chụp đáy mắt không huỳnh quang', N'MF', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF16', N'Chụp đáy mắt không huỳnh quang (màu)', N'MF', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF17', N'Dấu hiệu sinh tồn tại phòng khám TDCNHH', N'MF', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF20', N'Điện tim thường (ECG)', N'MF', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF21', N'Nghiệm pháp gắng sức điện tâm đồ', N'MF', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF22', N'Đo áp lực hậu môn trực tràng', N'MF', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF26', N'Đo Điện cơ (EMG)', N'MF', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF28', N'Đo Điện não (EEG)', N'MF', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF29', N'Đo độ lồi mắt', N'MF', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF30', N'Đo hô hấp ký toàn diện', N'MF', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF32', N'Holter điện tâm đồ', N'MF', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF52', N'Điện tim thường tại giường', N'MF', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF58', N'Holter huyết áp', N'MF', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF59', N'Đo nồng độ chất Indocyanine Green (ICG)', N'MF', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF60', N'Đo chỉ số ABI (chỉ số cổ chân/cánh tay)', N'MF', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF61', N'Đo thành phần cơ thể', N'MF', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF62', N'Ghi điện não thường quy (Điện não thường quy tại giường)', N'MF', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF63', N'Ghi điện não giấc ngủ (Điện não giấc ngủ ngắn 60 phút)', N'MF', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF71', N'Ghi điện não video (Điện não video 24 giờ tại giường)', N'MF', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF72', N'Ghi điện cơ (Điện cơ tại giường)', N'MF', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MG92', N'Xạ hình xương 3 pha với Tc99m MDP', N'MG', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MH21', N'Ion đồ (Na+, K+, Cl-, Ca)', N'MH', 0, NULL)
GO
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MI29', N'Xét nghiệm hồng cầu lưới (bằng máy đếm laser)', N'MI', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MI30', N'Tế bào dịch màng (phổi, bụng, tim, khớp…) có đếm số lượng tế bào', N'MI', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MI33', N'Xét nghiệm số lượng và độ tập trung tiểu cầu (bằng phương pháp thủ công)', N'MI', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MI56', N'Điện di huyết sắc tố (định lượng)', N'MI', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MI57', N'Tìm mảnh vỡ hồng cầu', N'MI', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MW98', N'Chụp cộng hưởng từ gan với chất tương phản đặc hiệu mô', N'MW', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MW99', N'Gây mê liên tục kiểm soát người bệnh thở máy ≤ 8 giờ (gây mê chụp MRI)', N'MW', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MXD1', N'Chụp, nong và đặt stent động mạch mạc treo (tràng trên, tràng dưới) số hóa xóa nền', N'MX', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MXD2', N'Chụp, nong và đặt Stent động mạch thận số hóa xóa nền', N'MX', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MXD3', N'Theo dõi ACT tại chỗ', N'MX', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MXD4', N'Nong, đặt Stent đường mật số hóa xóa nền', N'MX', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'ND64', N'Chụp cắt lớp vi tính bụng-tiểu khung thường quy', N'ND', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'ND65', N'Chụp cắt lớp vi tính bụng-tiểu khung thường quy có tiêm thuốc cản quang (chưa bao gồm thuốc cản quang)', N'ND', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'ND66', N'Chụp cắt lớp vi tính xương chi không tiêm thuốc cản quang', N'ND', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'ND67', N'Chụp cắt lớp vi tính xương chi có tiêm thuốc cản quang (chưa bao gồm thuốc cản quang)', N'ND', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NR04', N'Nghiệm pháp bàn nghiêng (TILT TEST)', N'NR', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW02', N'Chẩn đoán điện', N'NW', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW04', N'Điều trị bằng máy kéo giãn cột sống ', N'NW', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW05', N'Chườm lạnh', N'NW', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW06', N'Chườm nóng', N'NW', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW08', N'Điện vi dòng giảm đau', N'NW', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW23', N'Kích thích điện < 3 cơ', N'NW', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW24', N'Kích thích điện > 3 cơ', N'NW', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW46', N'Vật lý trị liệu hô hấp (người lớn)', N'NW', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW47', N'Vật lý trị liệu phòng ngừa các biến chứng do bất động', N'NW', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW48', N'VLTL bệnh phổi tắc nghẽn mãn tính', N'NW', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NWA5', N'Vật lý trị liệu hô hấp (trẻ nhỏ)', N'NW', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NWA6', N'VLTL cho bệnh nhân rối loạn vận động khác (loạn trương lục, múa giật,...)', N'NW', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NWA7', N'Khám - lượng giá VLTL - thiết lập mục tiêu và chương trình VLTL cho bệnh nhân Parkinson', N'NW', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NWA8', N'Tập do cứng khớp', N'NW', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NY04', N'Hấp khử trùng dụng cụ phẫu thuật bằng PP khác', N'NY', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NY05', N'Hấp khử trùng dụng cụ phẫu thuật máy STERRAD', N'NY', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NY06', N'Phí tiệt khuẩn gói vải phẫu thuật', N'NY', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NY07', N'Phí tiệt khuẩn LMA PROSIEAL (S3,S4,S5)', N'NY', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ18', N'Soi tìm vi trùng (dịch ổ bụng)', N'NZ', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ19', N'Soi tìm vi trùng (dịch não tủy)', N'NZ', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ33', N'Soi tìm vi trùng (dịch đầu CVC)', N'NZ', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ34', N'Soi tìm vi trùng (dịch phết họng)', N'NZ', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ35', N'Soi tìm vi trùng (dịch khác)', N'NZ', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ38', N'Kháng sinh đồ', N'NZ', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ75', N'Vi khuẩn nhuộm soi (nhuộm Gram) đàm', N'NZ', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ98', N'Vi khuẩn nhuộm soi (nhuộm Gram) dịch khác', N'NZ', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ99', N'XN tìm BK nước tiểu', N'NZ', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA0', N'XN tìm BK đàm', N'NZ', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA1', N'XN tìm BK dịch phế quản', N'NZ', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA2', N'XN tìm BK dịch dạ dày', N'NZ', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA3', N'XN tìm BK dịch màng phổi', N'NZ', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA4', N'XN tìm BK dịch màng bụng', N'NZ', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA5', N'XN tìm BK dịch não tủy', N'NZ', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA6', N'XN tìm BK dịch khớp', N'NZ', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA7', N'XN tìm BK dịch khác', N'NZ', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA8', N'XN tìm BK lần 1', N'NZ', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA9', N'XN tìm BK lần 2', N'NZ', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZB0', N'XN tìm BK lần 3', N'NZ', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TJ04', N'Điện châm ngoại viện', N'TJ', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TN01', N'INR tại giường', N'TN', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TN02', N'Keton mao mạch (tại giường)', N'TN', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TN04', N'Manometry biofeeback', N'TN', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TN05', N'Định nhóm máu tại giường', N'TN', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TN08', N'Thổi hơi thở tìm H.pylori C14', N'TN', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TN15', N'Xét nghiệm đường máu mao mạch tại Phòng khám', N'TN', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TO85', N'Nhiễm sắc thể đồ bệnh lý huyết học', N'TO', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TZ01', N'Nội soi tai mũi họng', N'MM', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TZ02', N'Nội soi tai', N'MM', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TZ03', N'Nội soi mũi xoang', N'MM', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TZ04', N'Nội soi họng', N'MM', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TZ05', N'Đo thính lực đơn âm', N'MM', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TZ06', N'Đo phản xạ cơ bàn đạp', N'MM', 0, NULL)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TZ07', N'Đo nhĩ lượng', N'MM', 0, NULL)
INSERT [dbo].[DonViChucNang] ([IDDonViChucNang], [TenDonViChucNang]) VALUES (1, N'Khám bệnh ngoại trú')
INSERT [dbo].[DonViChucNang] ([IDDonViChucNang], [TenDonViChucNang]) VALUES (5, N'Đơn Vị Dịch Vụ')
INSERT [dbo].[KhuVuc] ([IDKhuVuc], [TenKhuVuc]) VALUES (1, N'Khu B')
INSERT [dbo].[KhuVuc] ([IDKhuVuc], [TenKhuVuc]) VALUES (2, N'Khu C')
INSERT [dbo].[KhuVuc] ([IDKhuVuc], [TenKhuVuc]) VALUES (3, N'Khu A')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'1', CAST(N'2019-03-27' AS Date), 1, N'BS819')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'117', CAST(N'2019-03-27' AS Date), 1, N'BS750')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'141', CAST(N'2019-03-27' AS Date), 1, N'BS159')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'15', CAST(N'2019-03-27' AS Date), 1, N'BS381')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'154', CAST(N'2019-03-27' AS Date), 1, N'BS193')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'16', CAST(N'2019-03-27' AS Date), 1, N'BS329')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'23', CAST(N'2019-03-27' AS Date), 1, N'BS352')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'24', CAST(N'2019-03-27' AS Date), 1, N'BS993')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'25', CAST(N'2019-03-27' AS Date), 1, N'BS994')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'35', CAST(N'2019-03-27' AS Date), 1, N'BS188')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'44', CAST(N'2019-03-27' AS Date), 1, N'BS495')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'48', CAST(N'2019-03-27' AS Date), 1, N'BS108')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'56', CAST(N'2019-03-27' AS Date), 1, N'BS245')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'98', CAST(N'2019-03-27' AS Date), 1, N'BS889')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'1', CAST(N'2019-03-27' AS Date), 1, N'BS298')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'117', CAST(N'2019-03-27' AS Date), 1, N'BS689')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'141', CAST(N'2019-03-27' AS Date), 1, N'BS330')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'15', CAST(N'2019-03-27' AS Date), 1, N'BS345')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'154', CAST(N'2019-03-27' AS Date), 1, N'BS661')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'16', CAST(N'2019-03-27' AS Date), 1, N'BS256')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'23', CAST(N'2019-03-27' AS Date), 1, N'BS989')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'24', CAST(N'2019-03-27' AS Date), 1, N'BS992')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'25', CAST(N'2019-03-27' AS Date), 1, N'BS996')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'35', CAST(N'2019-03-27' AS Date), 1, N'BS057')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'48', CAST(N'2019-03-27' AS Date), 1, N'BS544')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'98', CAST(N'2019-03-27' AS Date), 1, N'BS888')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK3', N'117', CAST(N'2019-03-27' AS Date), 1, N'BS844')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK3', N'15', CAST(N'2019-03-27' AS Date), 1, N'BS480')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK3', N'154', CAST(N'2019-03-27' AS Date), 1, N'BS189')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK3', N'23', CAST(N'2019-03-27' AS Date), 1, N'BS990')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK3', N'24', CAST(N'2019-03-27' AS Date), 1, N'BS991')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK3', N'48', CAST(N'2019-03-27' AS Date), 1, N'BS709')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK3', N'98', CAST(N'2019-03-27' AS Date), 1, N'BS787')
INSERT [dbo].[LichSuTraCuu] ([IDTraCuu], [IDNguoiTim], [IDNguoiDuocTim], [ThoiGian]) VALUES (N'LS00001   ', N'BN21676', N'BN21677', CAST(N'2019-04-20T03:13:44.763' AS DateTime))
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'GA', N'XN GỬI ĐI', N'DH')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'KX', N'ĐO LOÃNG XƯƠNG', N'DA')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MA', N'X-QUANG', N'DA')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MB', N'NỘI SOI            ', N'DB')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MC', N'SIÊU ÂM           ', N'DC')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MD', N'SIÊU ÂM TIM       ', N'DD')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MF', N'THĂM DÒ CHỨC NĂNG', N'DF')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MG', N'XẠ HÌNH            ', N'DG')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MH', N'XN SINH HÓA', N'DH')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MI', N'XN HUYẾT HỌC      ', N'DH')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MJ', N'XN MIỄN DỊCH       ', N'DH')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MK', N'XN SH NƯỚC TIỂU   ', N'DH')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MM', N'DV TAI MŨI HỌNG', N'DL')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MQ', N'XN SINH HỌC PHÂN TỬ', N'DH')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MT', N'ĐIỀU TRỊ TRƯƠNG LỰC CƠ', N'DQ')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MW', N'CHỤP MRI', N'DW')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MX', N'DSA_CAN THIỆP', N'DI')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MZ', N'XN KHÁC', N'DH')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'ND', N'CHỤP CT-SCAN', N'DV')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'NR', N'DV PHÒNG KHÁM TIM MẠCH', N'D6')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'NW', N'VẬT LÝ TRỊ LIỆU', N'D+')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'NY', N'KIỂM SOÁT NHIỄM KHUẨN', N'DZ')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'NZ', N'XN VI SINH', N'DH')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'TI', N'CHÍCH NGỪA', N'D]')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'TJ', N'Y HỌC CỔ TRUYỀN', N'D?')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'TK', N'DỊ ỨNG - MD LÂM SÀNG', N'D(')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'TL', N'HÓA TRỊ', N'D)')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'TM', N'TRUYỀN MÁU', N'D&')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'TN', N'XÉT NGHIỆM', N'D[')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'TO', N'XN Y SINH HỌC PHÂN TỬ NÂNG CAO', N'DH')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'TP', N'GIẢI PHẪU BỆNH', N'D<')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'TR', N'XN KÝ SINH TRÙNG', N'DH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PK66665', N'BN21676', CAST(N'2019-03-27T00:00:00.000' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PK66666', N'BN21677', CAST(N'2019-03-27T00:00:00.000' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PK66667', N'BN21678', CAST(N'2019-03-27T00:00:00.000' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PK66668', N'BN21679', CAST(N'2019-03-27T08:00:00.000' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PK66669', N'BN21114', CAST(N'2019-03-27T00:00:00.000' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PK66670', N'BN21122', CAST(N'2019-03-27T00:00:00.000' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PK66671', N'BN21123', CAST(N'2019-03-27T00:00:00.000' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PK66672', N'BN21125', CAST(N'2019-03-27T00:00:00.000' AS DateTime), N'PH')
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'1', N'Phòng Ði?n Châm 210', NULL, 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'2', N'Phòng Ði?n Châm 211', NULL, 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'CT1', N'Phòng CT-Scan', NULL, 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'DSA', N'Phòng DSA', NULL, 2)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'KSNK1', N'Phòng 237', NULL, 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'MRI', N'Phòng MRI', NULL, 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'NS1', N'Phòng N?i Soi 212', NULL, 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'NS2', N'Phòng N?i Soi 213', NULL, 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'NS3', N'Phòng N?i Soi 214', NULL, 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'PHCN1', N'Phòng 235', NULL, 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'PHCN2', N'Phòng 236', NULL, 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'SA1', N'Phòng 331', N'4', 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'SA2', N'Phòng 332', N'4', 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'SA3', N'Phòng 333', N'3', 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'SA4', N'Phòng 334', N'3', 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'SPECT', N'Phòng SPECT', NULL, 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'TD1', N'Phòng 340', NULL, 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'TD2', N'Phòng 341', NULL, 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'TMH1', N'Phòng 320', NULL, 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'TMH2', N'Phòng 321', NULL, 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'XN1', N'Phòng Xét Nghi?m 301', NULL, 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'XN2', N'Phòng Xét Nghi?m 302', NULL, 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'XN3', N'Phòng Xét Nghi?m 303', NULL, 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'XN4', N'Phòng Xét Nghi?m 304', NULL, 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'XNK1', N'Phòng 238', NULL, 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'XQ1', N'Phòng X-Quang 310', N'104', 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'XQ2', N'Phòng X-Quang 311', N'104', 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [KhuVuc]) VALUES (N'XQ3', N'Phòng X-Quang 312', N'104', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'1', N'Phòng 32', N'PH')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'100', N'Phòng 21', N'PK')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'101', N'Phòng 21', N'PN')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'104', N'X Quang (Khu B)', N'DA')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'105', N'X Quang (Khu A)', N'DA')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'109', N'Phòng 81', N'ND')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'110', N'Phòng 82', N'ND')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'111', N'Phòng 69', N'PG')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'112', N'Phòng 70', N'PG')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'113', N'SPECT (Khu A)', N'DG')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'114', N'MRI(ĐHYD)', N'DW')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'117', N'Phòng 49', N'PI')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'118', N'Phòng 37', N'YHGD')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'119', N'Phòng 38', N'YHGD')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'120', N'Phòng 79', N'PA')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'121', N'Phòng 80', N'PA')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'122', N'Phòng 83', N'KTN')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'123', N'Phòng 60', N'GN')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'124', N'Phòng 64', N'DTTL')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'125', N'Phòng 5', N'HH')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'126', N'Phòng 27', N'TN')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'129', N'Phòng 1', N'P(')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'130', N'Phòng 28', N'LM')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'131', N'Phòng 29', N'LM')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'132', N'Phòng VIP', N'DTTL')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'133', N'Phòng VIP', N'GN')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'134', N'Phòng VIP', N'HH')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'135', N'Phòng VIP', N'KTN')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'136', N'Phòng VIP', N'LM')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'137', N'Phòng VIP', N'ND')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'138', N'Phòng VIP', N'P!')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'139', N'Phòng VIP', N'P#')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'140', N'Phòng VIP', N'P(')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'141', N'Phòng VIP', N'P@')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'143', N'Phòng VIP', N'P6')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'144', N'Phòng VIP', N'P7')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'146', N'Phòng VIP', N'P9')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'147', N'Phòng VIP', N'PA')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'148', N'Phòng VIP', N'PB')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'149', N'Phòng VIP', N'PC')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'15', N'Phòng 31', N'PB')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'150', N'Phòng VIP', N'PD')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'151', N'Phòng VIP', N'PF')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'152', N'Phòng VIP', N'PG')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'153', N'Phòng VIP', N'PH')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'154', N'Phòng VIP', N'PI')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'155', N'Phòng VIP', N'PJ')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'156', N'Phòng VIP', N'PK')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'157', N'Phòng VIP', N'PL')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'158', N'Phòng VIP', N'PM')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'159', N'Phòng VIP', N'PN')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'16', N'Phòng 11', N'P7')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'160', N'Phòng VIP', N'PO')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'161', N'Phòng VIP', N'PP')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'162', N'Phòng VIP', N'PQ')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'163', N'Phòng VIP', N'PR')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'164', N'Phòng VIP', N'PS')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'165', N'Phòng VIP', N'PT')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'166', N'Phòng VIP', N'PU')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'167', N'Phòng VIP', N'PV')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'168', N'Phòng VIP', N'PW')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'17', N'Phòng 12', N'P7')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'170', N'Phòng VIP', N'PY')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'171', N'Phòng VIP', N'PZ')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'172', N'Phòng VIP', N'TN')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'173', N'Phòng VIP', N'YHGD')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'174', N'Phòng 5', N'P(')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'177', N'Phòng 45', N'PJ')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'178', N'Phòng 70', N'UB')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'179', N'Phòng 70', N'PY')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'18', N'Phòng 14', N'P7')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'180', N'Phòng 74', N'PY')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'181', N'Phòng 22', N'P$')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'182', N'Phòng VIP', N'P$')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'183', N'Phòng 71', N'HH')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'184', N'Phòng 71', N'PL')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'185', N'Phòng 16', N'0UGM')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'187', N'Phòng 41', N'NXK')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'188', N'Phòng 29', N'P^')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'189', N'Phòng 1', N'TQQT')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'19', N'Phòng 15', N'P7')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'190', N'Phòng 1', N'CKQT')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'191', N'Phòng 01', N'KBTS')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'192', N'Phòng 02', N'KBTS')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'195', N'CT-Scan ', N'DV')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'198', N'Phòng 02', N'NHI2')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'199', N'Tiểu phẫu B', N'PZ')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'2', N'Phòng 33', N'PH')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'20', N'Phòng 16', N'P7')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'200', N'Phòng 25', N'PN')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'201', N'Phòng 84', N'P(')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'202', N'Phòng 63', N'PN')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'203', N'Phòng 62', N'TN')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'204', N'Phòng 27', N'PL')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'207', N'Phòng 65', N'NHCN')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'209', N'Phòng 85', N'PHCN')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'21', N'Phòng 4', N'P7')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'22', N'Phòng 5', N'P7')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'23', N'Phòng 6', N'PD')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'24', N'Phòng 7', N'PD')
GO
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'25', N'Phòng 8', N'PD')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'26', N'Phòng 9', N'PD')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'27', N'Phòng 10', N'PD')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'28', N'Phòng 2', N'PM')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'29', N'Phòng 3', N'PM')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'3', N'Siêu âm 1', N'DC')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'30', N'Phòng 34', N'PH')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'31', N'Phòng 35', N'PH')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'32', N'Phòng 36', N'PH')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'35', N'Phòng 46', N'PI')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'36', N'Phòng 47', N'PI')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'37', N'Phòng 48', N'PI')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'4', N'Siêu âm 2', N'DC')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'40', N'Phòng 60', N'P2')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'42', N'Phòng 1', N'P6')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'44', N'Phòng 30', N'PC')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'48', N'Phòng 42', N'PJ')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'49', N'Phòng 43', N'PJ')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'50', N'Phòng 44', N'PJ')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'51', N'Phòng 22', N'PK')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'52', N'Phòng 25', N'PK')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'53', N'Phòng 26', N'PK')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'54', N'Phòng 61', N'P9')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'55', N'Phòng 77', N'PA')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'56', N'Phòng 72', N'PF')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'57', N'Phòng 66', N'PG')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'58', N'Phòng 39', N'PL')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'59', N'Phòng 40', N'PL')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'60', N'Phòng 1', N'PD')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'61', N'Phòng 50', N'PO')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'62', N'Phòng 59', N'PP')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'63', N'Phòng 53', N'PQ')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'64', N'Phòng 58', N'PR')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'66', N'Phòng 75', N'PY')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'68', N'Phòng 24', N'PN')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'69', N'Phòng 3', N'TN')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'70', N'Phòng 52', N'PW')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'71', N'Lầu 6, Block A', N'P!')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'72', N'Phòng 2', N'PD')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'73', N'Phòng 3', N'PD')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'74', N'Phòng 24', N'PK')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'75', N'Phòng 67', N'PG')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'76', N'Phòng 68', N'PG')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'79', N'Phòng 56', N'P#')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'80', N'Phòng 57', N'P#')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'81', N'Phòng 54', N'PQ')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'82', N'Phòng 78', N'PA')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'83', N'Phòng 73', N'PF')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'90', N'Phòng siêu âm 7', N'PV')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'92', N'Phòng 17', N'PU')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'93', N'Phòng 19', N'PU')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'94', N'Phòng 18', N'PT')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'95', N'Phòng 20', N'PT')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'96', N'Tiểu phẫu A', N'PZ')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'97', N'Phòng tư vấn', N'PS')
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa]) VALUES (N'98', N'Phòng 1', N'P@')
INSERT [dbo].[QuyDinhPhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoSTTmax]) VALUES (N'TMH1', CAST(N'2019-03-27' AS Date), 1, 40)
INSERT [dbo].[QuyDinhPhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoSTTmax]) VALUES (N'TMH1', CAST(N'2019-03-27' AS Date), 2, 45)
INSERT [dbo].[QuyDinhPhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoSTTmax]) VALUES (N'TMH2', CAST(N'2019-03-27' AS Date), 1, 30)
INSERT [dbo].[QuyDinhPhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoSTTmax]) VALUES (N'TMH2', CAST(N'2019-03-27' AS Date), 2, 35)
INSERT [dbo].[SoHienThiPhongCanLamSang] ([IDPhongCanLamSang], [STT], [IDPhieuKham], [Gio]) VALUES (N'TMH1', 1, N'PK66665', CAST(N'2019-03-27T10:27:08.910' AS DateTime))
INSERT [dbo].[SoHienThiPhongCanLamSang] ([IDPhongCanLamSang], [STT], [IDPhieuKham], [Gio]) VALUES (N'TMH2', 1, N'PK66666', CAST(N'2019-03-27T10:30:08.910' AS DateTime))
INSERT [dbo].[SoThuTuPhongCLS] ([IDPhieuKham], [STT], [PhongCanLamSang], [CaKham], [Gio], [TinhTrang], [CanLamSang]) VALUES (N'PK66665', 1, N'TMH1', 1, CAST(N'2019-03-27T10:25:08.910' AS DateTime), N'Chua', N'TZ01')
INSERT [dbo].[SoThuTuPhongCLS] ([IDPhieuKham], [STT], [PhongCanLamSang], [CaKham], [Gio], [TinhTrang], [CanLamSang]) VALUES (N'PK66666', 1, N'TMH2', 1, CAST(N'2019-03-27T10:26:08.910' AS DateTime), N'Chua', N'TZ01')
INSERT [dbo].[Temp] ([Status]) VALUES (1)
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'1', 1, 0, N'PH', CAST(N'00:05:38' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'117', 1, 0, N'PI', CAST(N'00:06:46' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'141', 1, 0, N'P@', CAST(N'00:04:06' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'15', 1, 0, N'PB', CAST(N'00:08:07' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'154', 1, 0, N'PI', CAST(N'00:06:20' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'16', 1, 0, N'P7', CAST(N'00:03:39' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'23', 1, 0, N'PD', CAST(N'00:07:31' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'24', 1, 0, N'PD', CAST(N'00:04:49' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'25', 1, 0, N'PD', CAST(N'00:08:07' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'35', 1, 0, N'PI', CAST(N'00:03:19' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'44', 1, 0, N'PC', CAST(N'00:06:51' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'48', 1, 0, N'PJ', CAST(N'00:07:47' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'56', 1, 0, N'PF', CAST(N'00:03:02' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'98', 1, 0, N'P@', CAST(N'00:07:00' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'1', 1, 0, N'PH', CAST(N'00:03:47' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'117', 1, 0, N'PI', CAST(N'00:04:38' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'141', 1, 0, N'P@', CAST(N'00:03:58' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'15', 1, 0, N'PB', CAST(N'00:03:28' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'154', 1, 0, N'PI', CAST(N'00:03:27' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'16', 1, 0, N'P7', CAST(N'00:07:31' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'23', 1, 0, N'PD', CAST(N'00:05:29' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'24', 1, 0, N'PD', CAST(N'00:05:48' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'25', 1, 0, N'PD', CAST(N'00:03:13' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'35', 1, 0, N'PI', CAST(N'00:06:40' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'48', 1, 0, N'PJ', CAST(N'00:04:52' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'98', 1, 0, N'P@', CAST(N'00:04:28' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK3', N'117', 1, 0, N'PI', CAST(N'00:03:10' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK3', N'15', 1, 0, N'PB', CAST(N'00:05:09' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK3', N'154', 1, 0, N'PI', CAST(N'00:06:30' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK3', N'23', 1, 0, N'PD', CAST(N'00:07:23' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK3', N'24', 1, 0, N'PD', CAST(N'00:08:15' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK3', N'48', 1, 0, N'PJ', CAST(N'00:04:03' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK3', N'98', 1, 0, N'P@', CAST(N'00:05:08' AS Time))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'1', N'TJ04')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'2', N'TJ04')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'CT1', N'ND64')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'CT1', N'ND65')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'CT1', N'ND66')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'CT1', N'ND67')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'DSA', N'MXD1')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'DSA', N'MXD2')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'DSA', N'MXD3')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'DSA', N'MXD4')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'KSNK1', N'NY04')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'KSNK1', N'NY05')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'KSNK1', N'NY06')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'KSNK1', N'NY07')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'MRI', N'MW98')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'MRI', N'MW99')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'MRI', N'NR04')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS1', N'E038')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS1', N'MB39')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS1', N'MB82')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS1', N'MB84')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS1', N'MB86')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS1', N'MB88')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS1', N'MB89')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS1', N'MB91')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS2', N'MBA1')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS2', N'MBA4')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS2', N'MBC8')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS2', N'MBD0')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS2', N'MBD1')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS2', N'MBD2')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS2', N'MBD5')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS3', N'MBE0')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS3', N'MBE1')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS3', N'MBE3')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS3', N'MBE5')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS3', N'MBE7')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS3', N'MBE8')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS3', N'MBE9')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS3', N'MBF0')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS3', N'MBF1')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS3', N'MBF2')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'NS3', N'MBH0')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN1', N'NW02')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN1', N'NW04')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN1', N'NW05')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN1', N'NW06')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN1', N'NW08')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN1', N'NW23')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN1', N'NW24')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN1', N'NW46')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN1', N'NW47')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN1', N'NW48')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN1', N'NWA5')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN1', N'NWA6')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN1', N'NWA7')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN1', N'NWA8')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN2', N'NW02')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN2', N'NW04')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN2', N'NW05')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN2', N'NW06')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN2', N'NW08')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN2', N'NW23')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN2', N'NW24')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN2', N'NW46')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN2', N'NW47')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN2', N'NW48')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN2', N'NWA5')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN2', N'NWA6')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN2', N'NWA7')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'PHCN2', N'NWA8')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA1', N'MC60')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA1', N'MC61')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA1', N'MC65')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA1', N'MC66')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA1', N'MC67')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA1', N'MC68')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA1', N'MC69')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA1', N'MC72')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA1', N'MC73')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA1', N'MC74')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA1', N'MC75')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA2', N'MC60')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA2', N'MC61')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA2', N'MC65')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA2', N'MC66')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA2', N'MC67')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA2', N'MC68')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA2', N'MC69')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA2', N'MC72')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA2', N'MC73')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA2', N'MC74')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA2', N'MC75')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA3', N'MC72')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA3', N'MC73')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA3', N'MC74')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA3', N'MC75')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA3', N'MC81')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA3', N'MC88')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA3', N'MC89')
GO
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA3', N'MC90')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA3', N'MC91')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA3', N'MC92')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA3', N'MC93')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA3', N'MC94')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA3', N'MCD0')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA3', N'MCD1')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA3', N'MCD2')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA4', N'MC72')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA4', N'MC73')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA4', N'MC74')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA4', N'MC75')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA4', N'MC81')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA4', N'MC88')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA4', N'MC89')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA4', N'MC90')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA4', N'MC91')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA4', N'MC92')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA4', N'MC93')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA4', N'MC94')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA4', N'MCD0')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA4', N'MCD1')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SA4', N'MCD2')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'SPECT', N'MG92')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD1', N'MF21')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD1', N'MF22')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD1', N'MF26')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD1', N'MF28')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD1', N'MF29')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD1', N'MF30')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD1', N'MF32')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD1', N'MF52')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD1', N'MF58')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD1', N'MF59')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD1', N'MF60')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD1', N'MF61')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD1', N'MF62')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD1', N'MF63')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD1', N'MF71')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD1', N'MF72')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD2', N'MF21')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD2', N'MF22')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD2', N'MF26')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD2', N'MF28')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD2', N'MF29')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD2', N'MF30')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD2', N'MF32')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD2', N'MF52')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD2', N'MF58')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD2', N'MF59')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD2', N'MF60')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD2', N'MF61')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD2', N'MF62')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD2', N'MF63')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD2', N'MF71')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TD2', N'MF72')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TMH1', N'TZ01')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TMH1', N'TZ02')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TMH1', N'TZ03')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TMH1', N'TZ04')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TMH1', N'TZ05')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TMH1', N'TZ06')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TMH1', N'TZ07')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TMH2', N'TZ01')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TMH2', N'TZ02')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TMH2', N'TZ03')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TMH2', N'TZ04')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TMH2', N'TZ05')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TMH2', N'TZ06')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'TMH2', N'TZ07')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN1', N'GGI0')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN1', N'GGI1')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN1', N'GGI2')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN1', N'GGI3')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN1', N'GGI4')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN1', N'GGI6')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN1', N'GGI8')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN1', N'GGI9')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN2', N'GGJ1')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN2', N'GGJ2')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN2', N'GGJ3')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN2', N'GGJ5')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN2', N'GGJ6')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN2', N'GGL9')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN2', N'GGM0')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN2', N'GGM1')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN2', N'GGM2')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN2', N'GGM3')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'MH21')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'MI29')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'MI30')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'MI33')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'MI56')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'MI57')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'NZ18')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'NZ19')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'NZ33')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'NZ34')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'NZ35')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'NZ38')
GO
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'NZ75')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'NZ98')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'NZ99')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'NZA0')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'NZA1')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'NZA2')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'NZA3')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'NZA4')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'NZA5')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'NZA6')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'NZA7')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'NZA8')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN3', N'NZA9')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN4', N'NZB0')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XN4', N'TO85')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XNK1', N'TN01')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XNK1', N'TN02')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XNK1', N'TN04')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XNK1', N'TN05')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XNK1', N'TN08')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XNK1', N'TN15')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ1', N'KX11')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ1', N'KX12')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ1', N'KX14')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ1', N'MA')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ1', N'MAP6')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ1', N'MAP7')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ1', N'MAP8')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ1', N'MAP9')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ1', N'MAQ0')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ1', N'MAQ1')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ1', N'MAQ2')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ2', N'KX11')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ2', N'KX12')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ2', N'KX14')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ2', N'MA')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ2', N'MAP6')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ2', N'MAP7')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ2', N'MAP8')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ2', N'MAP9')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ2', N'MAQ0')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ2', N'MAQ1')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ2', N'MAQ2')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ3', N'KX11')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ3', N'KX12')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ3', N'KX14')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ3', N'MA')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ3', N'MAP6')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ3', N'MAP7')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ3', N'MAP8')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ3', N'MAP9')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ3', N'MAQ0')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ3', N'MAQ1')
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien]) VALUES (N'XQ3', N'MAQ2')
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__BenhNhan__B9137313204755C6]    Script Date: 5/4/2019 1:52:48 AM ******/
ALTER TABLE [dbo].[BenhNhan] ADD UNIQUE NONCLUSTERED 
(
	[CMND_CCCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BacSi]  WITH CHECK ADD  CONSTRAINT [FK_BacSi_ChuyenKhoa] FOREIGN KEY([ChuyenKhoa])
REFERENCES [dbo].[ChuyenKhoa] ([IDChuyenKhoa])
GO
ALTER TABLE [dbo].[BacSi] CHECK CONSTRAINT [FK_BacSi_ChuyenKhoa]
GO
ALTER TABLE [dbo].[BanKham]  WITH CHECK ADD  CONSTRAINT [FK_Ban_PK] FOREIGN KEY([Phong])
REFERENCES [dbo].[PhongKhamChuyenKhoa] ([ID])
GO
ALTER TABLE [dbo].[BanKham] CHECK CONSTRAINT [FK_Ban_PK]
GO
ALTER TABLE [dbo].[ChuyenKhoa]  WITH CHECK ADD  CONSTRAINT [FK_CK_DVCN] FOREIGN KEY([IDDonViChucNang])
REFERENCES [dbo].[DonViChucNang] ([IDDonViChucNang])
GO
ALTER TABLE [dbo].[ChuyenKhoa] CHECK CONSTRAINT [FK_CK_DVCN]
GO
ALTER TABLE [dbo].[ChuyenKhoa]  WITH CHECK ADD  CONSTRAINT [FK_CK_KhuVuc] FOREIGN KEY([IDKhuVuc])
REFERENCES [dbo].[KhuVuc] ([IDKhuVuc])
GO
ALTER TABLE [dbo].[ChuyenKhoa] CHECK CONSTRAINT [FK_CK_KhuVuc]
GO
ALTER TABLE [dbo].[DichVuCanLamSang]  WITH CHECK ADD  CONSTRAINT [FK_DV_LDV] FOREIGN KEY([LoaiDichVu])
REFERENCES [dbo].[LoaiDichVu] ([IDLoaiDichVu])
GO
ALTER TABLE [dbo].[DichVuCanLamSang] CHECK CONSTRAINT [FK_DV_LDV]
GO
ALTER TABLE [dbo].[LichKhamBacSi]  WITH CHECK ADD  CONSTRAINT [FK_LK_BacSi] FOREIGN KEY([IDBacSi])
REFERENCES [dbo].[BacSi] ([ID])
GO
ALTER TABLE [dbo].[LichKhamBacSi] CHECK CONSTRAINT [FK_LK_BacSi]
GO
ALTER TABLE [dbo].[LichKhamBacSi]  WITH CHECK ADD  CONSTRAINT [FK_LK_Ban] FOREIGN KEY([IDBan], [Phong])
REFERENCES [dbo].[BanKham] ([IDBan], [Phong])
GO
ALTER TABLE [dbo].[LichKhamBacSi] CHECK CONSTRAINT [FK_LK_Ban]
GO
ALTER TABLE [dbo].[LichKhamBacSi]  WITH CHECK ADD  CONSTRAINT [FK_LK_Ca] FOREIGN KEY([CaKham])
REFERENCES [dbo].[CaKham] ([IDCa])
GO
ALTER TABLE [dbo].[LichKhamBacSi] CHECK CONSTRAINT [FK_LK_Ca]
GO
ALTER TABLE [dbo].[LichSuTraCuu]  WITH CHECK ADD  CONSTRAINT [FK_LichSu_NgDuocTim] FOREIGN KEY([IDNguoiDuocTim])
REFERENCES [dbo].[BenhNhan] ([ID])
GO
ALTER TABLE [dbo].[LichSuTraCuu] CHECK CONSTRAINT [FK_LichSu_NgDuocTim]
GO
ALTER TABLE [dbo].[LichSuTraCuu]  WITH CHECK ADD  CONSTRAINT [FK_LichSu_NgTim] FOREIGN KEY([IDNguoiTim])
REFERENCES [dbo].[BenhNhan] ([ID])
GO
ALTER TABLE [dbo].[LichSuTraCuu] CHECK CONSTRAINT [FK_LichSu_NgTim]
GO
ALTER TABLE [dbo].[LoaiDichVu]  WITH CHECK ADD  CONSTRAINT [FK_LDV_CK] FOREIGN KEY([ChuyenKhoa])
REFERENCES [dbo].[ChuyenKhoa] ([IDChuyenKhoa])
GO
ALTER TABLE [dbo].[LoaiDichVu] CHECK CONSTRAINT [FK_LDV_CK]
GO
ALTER TABLE [dbo].[PhieuKham]  WITH CHECK ADD  CONSTRAINT [FK_PK_BN] FOREIGN KEY([IDBenhNhan])
REFERENCES [dbo].[BenhNhan] ([ID])
GO
ALTER TABLE [dbo].[PhieuKham] CHECK CONSTRAINT [FK_PK_BN]
GO
ALTER TABLE [dbo].[PhieuKham]  WITH CHECK ADD  CONSTRAINT [FK_PK_CK] FOREIGN KEY([ChuyenKhoa])
REFERENCES [dbo].[ChuyenKhoa] ([IDChuyenKhoa])
GO
ALTER TABLE [dbo].[PhieuKham] CHECK CONSTRAINT [FK_PK_CK]
GO
ALTER TABLE [dbo].[PhongCanLamSang]  WITH CHECK ADD  CONSTRAINT [FK_PCLS_KV] FOREIGN KEY([KhuVuc])
REFERENCES [dbo].[KhuVuc] ([IDKhuVuc])
GO
ALTER TABLE [dbo].[PhongCanLamSang] CHECK CONSTRAINT [FK_PCLS_KV]
GO
ALTER TABLE [dbo].[PhongKhamChuyenKhoa]  WITH CHECK ADD  CONSTRAINT [FK_PK_ChuyenKhoa] FOREIGN KEY([ChuyenKhoa])
REFERENCES [dbo].[ChuyenKhoa] ([IDChuyenKhoa])
GO
ALTER TABLE [dbo].[PhongKhamChuyenKhoa] CHECK CONSTRAINT [FK_PK_ChuyenKhoa]
GO
ALTER TABLE [dbo].[QuyDinhPhongCLS]  WITH CHECK ADD  CONSTRAINT [FK_PCLS_QuyDinh] FOREIGN KEY([IDPhongCLS])
REFERENCES [dbo].[PhongCanLamSang] ([ID])
GO
ALTER TABLE [dbo].[QuyDinhPhongCLS] CHECK CONSTRAINT [FK_PCLS_QuyDinh]
GO
ALTER TABLE [dbo].[QuyDinhPhongCLS]  WITH CHECK ADD  CONSTRAINT [FK_QD_CKham] FOREIGN KEY([CaKham])
REFERENCES [dbo].[CaKham] ([IDCa])
GO
ALTER TABLE [dbo].[QuyDinhPhongCLS] CHECK CONSTRAINT [FK_QD_CKham]
GO
ALTER TABLE [dbo].[SoHienThiPhongCanLamSang]  WITH CHECK ADD  CONSTRAINT [FK_HienThi_PhongCanLamSang] FOREIGN KEY([IDPhongCanLamSang])
REFERENCES [dbo].[PhongCanLamSang] ([ID])
GO
ALTER TABLE [dbo].[SoHienThiPhongCanLamSang] CHECK CONSTRAINT [FK_HienThi_PhongCanLamSang]
GO
ALTER TABLE [dbo].[SoHienThiPhongCanLamSang]  WITH CHECK ADD  CONSTRAINT [FK_HienThi_STTPhongCanLamSang] FOREIGN KEY([IDPhieuKham], [STT])
REFERENCES [dbo].[SoThuTuPhongCLS] ([IDPhieuKham], [STT])
GO
ALTER TABLE [dbo].[SoHienThiPhongCanLamSang] CHECK CONSTRAINT [FK_HienThi_STTPhongCanLamSang]
GO
ALTER TABLE [dbo].[SoHienThiPhongKham]  WITH CHECK ADD  CONSTRAINT [FK_HienThi_BanKham] FOREIGN KEY([BanKham], [PhongKham])
REFERENCES [dbo].[BanKham] ([IDBan], [Phong])
GO
ALTER TABLE [dbo].[SoHienThiPhongKham] CHECK CONSTRAINT [FK_HienThi_BanKham]
GO
ALTER TABLE [dbo].[SoHienThiPhongKham]  WITH CHECK ADD  CONSTRAINT [FK_HienThi_STTPhongKham] FOREIGN KEY([IDPhieuKham], [STT])
REFERENCES [dbo].[SoThuTuPhongKham] ([IDPhieuKham], [STT])
GO
ALTER TABLE [dbo].[SoHienThiPhongKham] CHECK CONSTRAINT [FK_HienThi_STTPhongKham]
GO
ALTER TABLE [dbo].[SoThuTuPhongCLS]  WITH CHECK ADD  CONSTRAINT [FK_STT_PhongCanLamSang] FOREIGN KEY([PhongCanLamSang])
REFERENCES [dbo].[PhongCanLamSang] ([ID])
GO
ALTER TABLE [dbo].[SoThuTuPhongCLS] CHECK CONSTRAINT [FK_STT_PhongCanLamSang]
GO
ALTER TABLE [dbo].[SoThuTuPhongCLS]  WITH CHECK ADD  CONSTRAINT [Fk_STT_PKCLS] FOREIGN KEY([IDPhieuKham])
REFERENCES [dbo].[PhieuKham] ([IDPhieuKham])
GO
ALTER TABLE [dbo].[SoThuTuPhongCLS] CHECK CONSTRAINT [Fk_STT_PKCLS]
GO
ALTER TABLE [dbo].[SoThuTuPhongCLS]  WITH CHECK ADD  CONSTRAINT [FK_STTCLS_CKham] FOREIGN KEY([CaKham])
REFERENCES [dbo].[CaKham] ([IDCa])
GO
ALTER TABLE [dbo].[SoThuTuPhongCLS] CHECK CONSTRAINT [FK_STTCLS_CKham]
GO
ALTER TABLE [dbo].[SoThuTuPhongCLS]  WITH CHECK ADD  CONSTRAINT [FK_STTCLS_DV] FOREIGN KEY([CanLamSang])
REFERENCES [dbo].[DichVuCanLamSang] ([IDDichVu])
GO
ALTER TABLE [dbo].[SoThuTuPhongCLS] CHECK CONSTRAINT [FK_STTCLS_DV]
GO
ALTER TABLE [dbo].[SoThuTuPhongKham]  WITH CHECK ADD  CONSTRAINT [FK_STT_BanKham] FOREIGN KEY([BanKham], [PhongKham])
REFERENCES [dbo].[BanKham] ([IDBan], [Phong])
GO
ALTER TABLE [dbo].[SoThuTuPhongKham] CHECK CONSTRAINT [FK_STT_BanKham]
GO
ALTER TABLE [dbo].[SoThuTuPhongKham]  WITH CHECK ADD  CONSTRAINT [Fk_STT_PKPhongKham] FOREIGN KEY([IDPhieuKham])
REFERENCES [dbo].[PhieuKham] ([IDPhieuKham])
GO
ALTER TABLE [dbo].[SoThuTuPhongKham] CHECK CONSTRAINT [Fk_STT_PKPhongKham]
GO
ALTER TABLE [dbo].[SoThuTuPhongKham]  WITH CHECK ADD  CONSTRAINT [FK_STTPK_CKham] FOREIGN KEY([CaKham])
REFERENCES [dbo].[CaKham] ([IDCa])
GO
ALTER TABLE [dbo].[SoThuTuPhongKham] CHECK CONSTRAINT [FK_STTPK_CKham]
GO
ALTER TABLE [dbo].[ThucHienCLS]  WITH CHECK ADD  CONSTRAINT [FK_THCLS_DV] FOREIGN KEY([DichVuCLSThucHien])
REFERENCES [dbo].[DichVuCanLamSang] ([IDDichVu])
GO
ALTER TABLE [dbo].[ThucHienCLS] CHECK CONSTRAINT [FK_THCLS_DV]
GO
ALTER TABLE [dbo].[ThucHienCLS]  WITH CHECK ADD  CONSTRAINT [FK_THCLS_PCLS] FOREIGN KEY([IDPhongCLS])
REFERENCES [dbo].[PhongCanLamSang] ([ID])
GO
ALTER TABLE [dbo].[ThucHienCLS] CHECK CONSTRAINT [FK_THCLS_PCLS]
GO
/****** Object:  StoredProcedure [dbo].[BamSoHienThiPhongKham]    Script Date: 5/4/2019 1:52:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[BamSoHienThiPhongKham] @IDBanKham nvarchar(10), @IDPhong nvarchar(10)
as begin
    declare @STTnext int, @STTcur int,@IDPKnext nvarchar(10)
	set @STTcur = (select STT from SoHienThiPhongKham where BanKham=@IDBanKham and PhongKham=@IDPhong
	and Gio>=all(select Gio from SoHienThiPhongKham where BanKham=@IDBanKham and  PhongKham=@IDPhong) 	 group by STT)
	if(@STTcur is null)
	begin
		set @STTcur=0;
	end;
	set @STTnext = @STTcur+1
	set @IDPKnext = (select IDPhieuKham from SoThuTuPhongKham where BanKham=@IDBanKham and  STT=@STTnext and PhongKham=@IDPhong )
	if(@IDPKnext is not null)
	begin
	-- Tao so hien thi
	insert into SoHienThiPhongKham (STT,BanKham,PhongKham,IDPhieuKham,Gio)
	select STT.STT,STT.BanKham,STT.PhongKham,STT.IDPhieuKham,dateadd (minute,2,Gio) from SoThuTuPhongKham as STT 
	where STT.IDPhieuKham=@IDPKnext and   STT.BanKham=@IDBanKham and STT.PhongKham=@IDPhong;
	-- Lay so hien thi
	select *from  SoHienThiPhongKham as STT join PhongKhamChuyenKhoa as PK on PK.ID=STT.PhongKham
	where STT.IDPhieuKham=@IDPKnext and   STT.BanKham=@IDBanKham and STT.PhongKham= @IDPhong;
	update ThongKePhongKham
	set SoLuongDoi=SoLuongDoi-1
	where IDBan=@IDBanKham and Phong=@IDPhong;
	end;

end;
GO
/****** Object:  StoredProcedure [dbo].[CheckBenhNhan]    Script Date: 5/4/2019 1:52:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[CheckBenhNhan] @CMND_CCCD nvarchar(20)
 as begin
	select * from BenhNhan where BenhNhan.CMND_CCCD = @CMND_CCCD
end;
GO
/****** Object:  StoredProcedure [dbo].[DemSoDoi]    Script Date: 5/4/2019 1:52:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[DemSoDoi] 
as begin
truncate table SoLuongDoiPhongKham;
insert into SoLuongDoiPhongKham(BanKham,PhongKham,CaKham,SoLuongDoi,ThoiGianKhamTB)
select  sttpk.BanKham, sttpk.PhongKham,sttpk.CaKham, COUNT(TinhTrang) as soLuongDoi ,BS.ThoiGianKhamTB_min as ThoiGianKhamTB 
from SoThuTuPhongKham as sttpk    join LichKhamBacSi as LK on LK.IDBan=sttpk.BanKham join BacSi as BS on BS.ID= LK.IDBacSi
where sttpk.TinhTrang=N'Chưa'  and LK.Phong=sttpk.PhongKham 
group by sttpk.BanKham, sttpk.PhongKham,sttpk.CaKham,BS.ThoiGianKhamTB_min
end;
GO
/****** Object:  StoredProcedure [dbo].[HienThiLichSuTimKiem]    Script Date: 5/4/2019 1:52:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[HienThiLichSuTimKiem] @IDNgTim nvarchar(10)
as begin
	select IDNguoiTim as TraCuuBoi,IDNguoiDuocTim,BN.Ho,BN.TenLot,BN.Ten,BN.NgaySinh from LichSuTraCuu as LS join BenhNhan as BN on BN.ID=LS.IDNguoiDuocTim
	where IDNguoiTim=@IDNgTim
end;
GO
/****** Object:  StoredProcedure [dbo].[LaySTT]    Script Date: 5/4/2019 1:52:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[LaySTT] @IDBenhNhan nvarchar(10)
as begin
	select distinct IDBenhNhan,STTPK.STT as STTPhongKham,PKCK.SoPhong,A.SoBan,CK.TenChuyenKhoa,convert(time,STTPK.Gio) as ThoiGianDuKien,STTPK.TinhTrang,A.SoHienTaiCuaPhong
	from BenhNhan as BN join PhieuKham as PK on BN.ID=PK.IDBenhNhan join SoThuTuPhongKham as STTPK on STTPK.IDPhieuKham= PK.IDPhieuKham
	join  BanKham as BK on BK.IDBan = STTPK.BanKham join PhongKhamChuyenKhoa as PKCK on PKCK.ID = BK.Phong join
	 (select BK.IDBan as IDBan,BK.SoBan, PK.ID as IDPhongKham,PK.SoPhong, max(SHT.Gio) as Gio ,STT as SoHienTaiCuaPhong from SoHienThiPhongKham as SHT 
	join BanKham as BK on BK.IDBan=SHT.BanKham join PhongKhamChuyenKhoa as PK on PK.ID=Bk.Phong 
	where BK.Phong=SHT.PhongKham
	group by Bk.IDBan,BK.SoBan,PK.ID,PK.SoPhong,STT) as A on A.IDPhongKham=PKCK.ID join ChuyenKhoa as CK on Ck.IDChuyenKhoa=PKCK.ChuyenKhoa
	where IDBenhNhan=@IDBenhNhan;

	select distinct IDBenhNhan,STTCLS.STT as STTPhongCLS, PCLS.SoPhong,DV.TenDichVu as TenCanLamSang,convert(time, STTCLS.Gio) as ThoiGianDuKien,STTCLS.TinhTrang,A.SoHienTaiCuaPhong
	from BenhNhan as BN join PhieuKham as PK on BN.ID=PK.IDBenhNhan join SoThuTuPhongCLS as STTCLS on STTCLS.IDPhieuKham=PK.IDPhieuKham 
		join PhongCanLamSang as PCLS on PCLS.ID=STTCLS.PhongCanLamSang
		join (select PCLS.ID as IDPhongCLS,PCLS.SoPhong, max(SHT.Gio) as Gio,STT as SoHienTaiCuaPhong 
			 from SoHienThiPhongCanLamSang as SHT join PhongCanLamSang as PCLS on PCLS.ID=SHT.IDPhongCanLamSang
	group by PCLS.ID,PCLS.SoPhong,STT ) as A on A.IDPhongCLS=PCLS.ID join ThucHienCLS as TH on TH.IDPhongCLS=PCLS.ID 
	join  DichVuCanLamSang as DV on DV.IDDichVu =TH.DichVuCLSThucHien 
	where IDBenhNhan=@IDBenhNhan and STTCLS.CanLamSang=TH.DichVuCLSThucHien  ;
	end;
GO
/****** Object:  StoredProcedure [dbo].[LaySTTPhongKham]    Script Date: 5/4/2019 1:52:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[LaySTTPhongKham] @IDBenhNhan nvarchar(10)
as begin
	select distinct IDBenhNhan,Ho,TenLot,Ten, PK.IDPhieuKham,STTPK.STT as STTPhongKham,PKCK.ID as IDPhong,PKCK.SoPhong,convert(time,STTPK.Gio) as ThoiGianDuKien,STTPK.TinhTrang
	from BenhNhan as BN join PhieuKham as PK on BN.ID=PK.IDBenhNhan join SoThuTuPhongKham as STTPK on STTPK.IDPhieuKham= PK.IDPhieuKham
	join PhongKhamChuyenKhoa as PKCK on PKCK.ID = STTPK.PhongKham 
	where IDBenhNhan=@IDBenhNhan
	end;
GO
/****** Object:  StoredProcedure [dbo].[LayThongTinBenhNhan]    Script Date: 5/4/2019 1:52:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[LayThongTinBenhNhan] @maBN varchar(10)
as begin
	select *
	from BenhNhan
	where ID = @maBN
end;
GO
/****** Object:  StoredProcedure [dbo].[PhatSinhSTTPhongKham]    Script Date: 5/4/2019 1:52:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PhatSinhSTTPhongKham] @IDPhieuKham nvarchar(10), @IDChuyenKhoa nvarchar(10) 
as begin
	declare @STT int,@STTnew int,@BanKham nvarchar(10),@PhongKham nvarchar(10),@TimeTB time,@CaKham int,@SoLuongDoi int,
			@GioDuKien datetime,@GioDuKien_new datetime,@temp int;
	select @temp=count(*) 
	from ThongKeChiTiet_Null as TK join ThongKePhongKham as PK on PK.IDBan = TK.IDBan and PK.Phong=TK.Phong
	where TK.ThoiGianKhamTB_min<=all(select TK.ThoiGianKhamTB_min from ThongKeChiTiet_Null as TK join ThongKePhongKham as PK on PK.IDBan = TK.IDBan and PK.Phong=TK.Phong where  TK.ChuyenKhoa=@IDChuyenKhoa  and PK.SoLuongDoi=0) 
	  and TK.ChuyenKhoa in (select TK.CHuyenKhoa from ThongKeChiTiet_Null as TK where  TK.ChuyenKhoa=@IDChuyenKhoa) and PK.SoLuongDoi=0;
	select @PhongKham=TK.PhongKham,@BanKham=TK.BanKham,@TimeTB=TK.ThoiGianKhamTB,@CaKham=TK.CaKham,@GioDuKien=TK.GioDuKienSoCuoi
	from ThongKeChiTiet as TK
	where ChuyenKhoa=@IDChuyenKhoa;
	if( @PhongKham is null)
	begin 
	select @PhongKham=TK.Phong,@BanKham=TK.IDBan,@TimeTB=TK.ThoiGianKhamTB_min,@CaKham=TK.CaKham
	from ThongKeChiTiet_Null as TK join ThongKePhongKham as PK on PK.IDBan = TK.IDBan and PK.Phong=TK.Phong
	where TK.ThoiGianKhamTB_min<=all(select TK.ThoiGianKhamTB_min from ThongKeChiTiet_Null as TK join ThongKePhongKham as PK on PK.IDBan = TK.IDBan and PK.Phong=TK.Phong where  TK.ChuyenKhoa=@IDChuyenKhoa  and PK.SoLuongDoi=0) 
	  and TK.ChuyenKhoa in (select TK.CHuyenKhoa from ThongKeChiTiet_Null as TK where  TK.ChuyenKhoa=@IDChuyenKhoa) and PK.SoLuongDoi=0;
	set @STTnew=1;
	set @GioDuKien_new=(select dbo.CongThoiGian(@TimeTB,'2019-03-27 07:00:00'));
	insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chưa');
	end;
	else
	begin
		if(@temp>0)
		begin
		select @PhongKham=TK.Phong,@BanKham=TK.IDBan,@TimeTB=TK.ThoiGianKhamTB_min,@CaKham=TK.CaKham
		from ThongKeChiTiet_Null as TK join ThongKePhongKham as PK on PK.IDBan = TK.IDBan and PK.Phong=TK.Phong
		where TK.ThoiGianKhamTB_min<=all(select TK.ThoiGianKhamTB_min from ThongKeChiTiet_Null as TK join ThongKePhongKham as PK on PK.IDBan = TK.IDBan and PK.Phong=TK.Phong where  TK.ChuyenKhoa=@IDChuyenKhoa  and PK.SoLuongDoi=0) 
		 and TK.ChuyenKhoa in (select TK.CHuyenKhoa from ThongKeChiTiet_Null as TK where  TK.ChuyenKhoa=@IDChuyenKhoa) and PK.SoLuongDoi=0;
		set @STTnew=1;
		set @GioDuKien_new=(select dbo.CongThoiGian(@TimeTB,'2019-03-27 07:00:00'));
		insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chưa');
		end;
		else begin 
		select @STT=max(STT) from SoThuTuPhongKham as STT
		where STT.BanKham=@BanKham and STT.PhongKham=@PhongKham;
		set @STTnew=@STT +1;
		set @GioDuKien_new=(select dbo.CongThoiGian(@TimeTB,@GioDuKien));
		insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chưa');
		end;
	end;
		update ThongKePhongKham
		set SoLuongDoi=SoLuongDoi+1
		where IDBan=@BanKham and Phong=@PhongKham
end;
GO
/****** Object:  StoredProcedure [dbo].[ResetThongKePhongKham]    Script Date: 5/4/2019 1:52:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[ResetThongKePhongKham]
as begin
truncate table ThongKePhongKham;
insert into ThongKePhongKham(IDBan,Phong,CaKham,SoLuongDoi,ChuyenKhoa,ThoiGianKhamTB)
select BK.IDBan,BK.Phong,LK.CaKham,0 as SoLuongDoi,BS.ChuyenKhoa, BS.ThoiGianKhamTB_min
from BanKham as BK join LichKhamBacSi as LK on LK.IDBan=BK.IDBan and LK.Phong=BK.Phong join BacSi as BS on BS.ID=LK.IDBacSi
end;
GO
/****** Object:  StoredProcedure [dbo].[Search]    Script Date: 5/4/2019 1:52:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Search] @IDBenhNhan nvarchar(10)
as begin
	select BenhNhan.Ho, BenhNhan.TenLot,BenhNhan.Ten 
	from BenhNhan
	where ID = @IDBenhNhan;

	select distinct IDBenhNhan,STTPK.STT as STT,PKCK.SoPhong,A.SoBan,CK.TenChuyenKhoa,convert(time,STTPK.Gio) as ThoiGianDuKien,STTPK.TinhTrang,A.SoHienTaiCuaPhong
	from BenhNhan as BN join PhieuKham as PK on BN.ID=PK.IDBenhNhan join SoThuTuPhongKham as STTPK on STTPK.IDPhieuKham= PK.IDPhieuKham
	join  BanKham as BK on BK.IDBan = STTPK.BanKham join PhongKhamChuyenKhoa as PKCK on PKCK.ID = BK.Phong join
	 (select BK.IDBan as IDBan,BK.SoBan, PK.ID as IDPhongKham,PK.SoPhong, max(SHT.Gio) as Gio ,STT as SoHienTaiCuaPhong from SoHienThiPhongKham as SHT 
	join BanKham as BK on BK.IDBan=SHT.BanKham join PhongKhamChuyenKhoa as PK on PK.ID=Bk.Phong 
	where BK.Phong=SHT.PhongKham
	group by Bk.IDBan,BK.SoBan,PK.ID,PK.SoPhong,STT) as A on A.IDPhongKham=PKCK.ID join ChuyenKhoa as CK on Ck.IDChuyenKhoa=PKCK.ChuyenKhoa
	where IDBenhNhan=@IDBenhNhan and A.IDBan=BK.IDBan;

	select distinct IDBenhNhan,STTCLS.STT as STTPhongCLS, PCLS.SoPhong,DV.TenDichVu as TenCanLamSang,convert(time, STTCLS.Gio) as ThoiGianDuKien,STTCLS.TinhTrang,A.SoHienTaiCuaPhong
	from BenhNhan as BN join PhieuKham as PK on BN.ID=PK.IDBenhNhan join SoThuTuPhongCLS as STTCLS on STTCLS.IDPhieuKham=PK.IDPhieuKham 
		join PhongCanLamSang as PCLS on PCLS.ID=STTCLS.PhongCanLamSang
		join (select PCLS.ID as IDPhongCLS,PCLS.SoPhong, max(SHT.Gio) as Gio,STT as SoHienTaiCuaPhong 
			 from SoHienThiPhongCanLamSang as SHT join PhongCanLamSang as PCLS on PCLS.ID=SHT.IDPhongCanLamSang
	group by PCLS.ID,PCLS.SoPhong,STT ) as A on A.IDPhongCLS=PCLS.ID join ThucHienCLS as TH on TH.IDPhongCLS=PCLS.ID 
	join  DichVuCanLamSang as DV on DV.IDDichVu =TH.DichVuCLSThucHien 
	where IDBenhNhan=@IDBenhNhan and STTCLS.CanLamSang=TH.DichVuCLSThucHien  ;

end;
GO
/****** Object:  StoredProcedure [dbo].[TaoHoSoBenhNhan]    Script Date: 5/4/2019 1:52:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[TaoHoSoBenhNhan] @Ho nvarchar(6),
	@TenLot nvarchar(20),
	@Ten nvarchar(5),
	@CMND_CCCD nvarchar(20) ,
	@GioiTinh nvarchar(3),
	@NgaySinh date,
	@QueQuan nvarchar(20),
	@NgheNghiep nvarchar(20),
	@SDT nvarchar(15),
	@Diachi nvarchar(50)
 as begin
 declare @lastSTT nvarchar(10),@STTnew_int int,@STTnew_char nvarchar(10),@newID nvarchar(10);
 set @lastSTT=( select max(right(ID,5)) from BenhNhan);
 set @STTnew_int = CONVERT(int,@lastSTT) + 1;
 set @STTnew_char = CONVERT(nvarchar,@STTnew_int);
 set @newID='BN' + @STTnew_char;
 insert into BenhNhan values(@newID,@Ho,@TenLot,@Ten,@CMND_CCCD,@GioiTinh,@NgaySinh,@QueQuan,@NgheNghiep,@SDT,@Diachi);
 select * from BenhNhan where ID =@newID;
 end;
GO
/****** Object:  StoredProcedure [dbo].[TaoLichSuTimKiem]    Script Date: 5/4/2019 1:52:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[TaoLichSuTimKiem] @IDNgTim nvarchar(10), @IDNgDuocTim nvarchar(10)
as begin
	
	declare @Thoigian datetime,@counter int
	set @counter=(select count(*) from BenhNhan where ID=@IDNgDuocTim);
	if(@counter >0)
	begin
	set @Thoigian=getdate();
	insert into LichSuTraCuu values ('',@IDNgTim,@IDNgDuocTim,@Thoigian);
	update Temp
	set Status = 1;
	select * from temp;
	end;
	else if(@counter=0)
	begin
	update Temp
	set Status = 0;
	select * from temp;
	end;
end;
GO
/****** Object:  StoredProcedure [dbo].[TaoPhieuKham]    Script Date: 5/4/2019 1:52:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[TaoPhieuKham] @IDBenhNhan nvarchar(10),@IDCHuyenKhoa nvarchar(10)
 as begin
 declare @LastPK nvarchar(10),@STT_char nvarchar(10),@STTnew_int int,@STTnew_char nvarchar(10),@NewPK nvarchar(10);
 set @LastPK=(select IDPhieuKham from PhieuKham where Ngay >= all ( select Ngay from PhieuKham));
 set @STT_char=(select right(@LastPK,5));
 set @STTnew_int = CONVERT(int,@STT_char) + 1;
 set @STTnew_char = CONVERT(nvarchar,@STTnew_int);
 set @NewPK='PK' + @STTnew_char;
 insert into PhieuKham values(@NewPK,@IDBenhNhan,getdate(),@IDCHuyenKhoa);
 select * from PhieuKham where Ngay >= all ( select Ngay from PhieuKham);
end;
GO
/****** Object:  Trigger [dbo].[tr_AUTO_IDTraCuu]    Script Date: 5/4/2019 1:52:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_AUTO_IDTraCuu] on [dbo].[LichSuTraCuu] for insert
as
	declare @IDNgTim nvarchar(10), @lastIDTraCuu nvarchar(10)
	set @IDNgTim=(select IDNguoiTim from inserted)
	set @lastIDTraCuu=DBO.AUTO_IDTraCuu()
	update LichSuTraCuu
	set IDTraCuu=@lastIDTraCuu
	where IDTraCuu=''
	select dbo.AUTO_IDTraCuu()
	
GO
ALTER TABLE [dbo].[LichSuTraCuu] ENABLE TRIGGER [tr_AUTO_IDTraCuu]
GO
/****** Object:  Trigger [dbo].[Xulylichsu]    Script Date: 5/4/2019 1:52:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[Xulylichsu] on [dbo].[LichSuTraCuu] for insert
as
	declare @IDNgDuocTim nvarchar(10),@IDNgTim nvarchar(10),@counter int
	set @IDNgTim=(select IDNguoiTim from inserted)
	set @IDNgDuocTim=(select IDNguoiDUocTim from inserted)
	set @counter= (select count(*) from LichSuTraCuu
	where IDNguoiTim=@IDNgTim and IDNguoiDuocTim=@IDNgDuocTim)
	if (@counter>1)
	delete LichSuTraCuu where IDNguoiTim =@IDNgTim and IDNguoiDuocTim=@IDNgDuocTim and 
	ThoiGian<(select max(ThoiGian) from LichSuTraCuu where IDNguoiTim =@IDNgTim and IDNguoiDuocTim=@IDNgDuocTim );
GO
ALTER TABLE [dbo].[LichSuTraCuu] ENABLE TRIGGER [Xulylichsu]
GO
/****** Object:  Trigger [dbo].[UpdateTinhTrangSTTPhongKham]    Script Date: 5/4/2019 1:52:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[UpdateTinhTrangSTTPhongKham] on [dbo].[SoHienThiPhongKham] for insert
as 
	declare @STT int, @BanKham nvarchar(10), @PhongKham nvarchar(10),@IDPK nvarchar(10),@STTpre int;
	select @STT =STT,@BanKham=BanKham,@PhongKham=PhongKham,@IDPK=IDPhieuKham
	from inserted;
	set @STTpre=@STT -1;
	update SoThuTuPhongKham
	set TinhTrang=N'Đang khám'
	where  BanKham=@BanKham and PhongKham=@PhongKham and STT=@STT;
	update SoThuTuPhongKham
	set TinhTrang=N'Đã qua'
	where  BanKham=@BanKham and PhongKham=@PhongKham and STT=@STTpre;
GO
ALTER TABLE [dbo].[SoHienThiPhongKham] ENABLE TRIGGER [UpdateTinhTrangSTTPhongKham]
GO
/****** Object:  Trigger [dbo].[SetCaKhamCLS]    Script Date: 5/4/2019 1:52:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[SetCaKhamCLS] on [dbo].[SoThuTuPhongCLS] for insert 
as 
	declare @GioKham datetime,@IDPK nvarchar(10),@STT nvarchar(10),
	@hour1 int,@hour2 int,@hour3 int,@hour4 int,@min2 int,@min4 int;
	select @GioKham = convert(time,Gio), @IDPK = IDPhieuKham,@STT = STT  from inserted;
	set @hour1 =DATEDIFF(HOUR,'7:00:0',@GioKham);
	--set @hour2 =DATEDIFF(HOUR,'12:00:0',@GioKham);
	set @hour3 =DATEDIFF(HOUR,'13:00:0',@GioKham);
	--set @hour4 =DATEDIFF(HOUR,'18:00:0',@GioKham);
	if(@hour1 >=0 and @hour1 <=5)
	begin
	update SoThuTuPhongCLS
	set CaKham=1
	where IDPhieuKham = @IDPK and STT=@STT
	end;
	else if(@hour3 >=0 and @hour3 <=5)
	begin
	update SoThuTuPhongCLS
	set CaKham=2
	where IDPhieuKham = @IDPK and STT=@STT
	end;
GO
ALTER TABLE [dbo].[SoThuTuPhongCLS] ENABLE TRIGGER [SetCaKhamCLS]
GO
/****** Object:  Trigger [dbo].[SetCaKhamPK]    Script Date: 5/4/2019 1:52:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[SetCaKhamPK] on [dbo].[SoThuTuPhongKham] for insert 
as 
	declare @GioKham datetime,@IDPK nvarchar(10),@STT nvarchar(10),
	@hour1 int,@hour2 int,@hour3 int,@hour4 int,@min2 int,@min4 int;
	select @GioKham = convert(time,Gio), @IDPK = IDPhieuKham,@STT = STT  from inserted;
	set @hour1 =DATEDIFF(HOUR,'7:00:0',@GioKham);
	--set @hour2 =DATEDIFF(HOUR,'12:00:0',@GioKham);
	set @hour3 =DATEDIFF(HOUR,'13:00:0',@GioKham);
	--set @hour4 =DATEDIFF(HOUR,'18:00:0',@GioKham);
	if(@hour1 >=0 and @hour1 <=5)
	begin
	update SoThuTuPhongKham
	set CaKham=1
	where IDPhieuKham = @IDPK and STT=@STT
	end;
	else if(@hour3 >=0 and @hour3 <=5)
	begin
	update SoThuTuPhongKham
	set CaKham=2
	where IDPhieuKham = @IDPK and STT=@STT
	end;
GO
ALTER TABLE [dbo].[SoThuTuPhongKham] ENABLE TRIGGER [SetCaKhamPK]
GO
USE [master]
GO
ALTER DATABASE [TEST] SET  READ_WRITE 
GO
