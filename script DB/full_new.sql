USE [master]
GO
/****** Object:  Database [TEST]    Script Date: 5/26/2019 12:22:08 PM ******/
CREATE DATABASE [TEST]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TEST', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\TEST.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TEST_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\TEST_log.ldf' , SIZE = 1088KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TEST] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TEST].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TEST] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TEST] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TEST] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TEST] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TEST] SET ARITHABORT OFF 
GO
ALTER DATABASE [TEST] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [TEST] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TEST] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TEST] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TEST] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TEST] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TEST] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TEST] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TEST] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TEST] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TEST] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TEST] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TEST] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TEST] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TEST] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TEST] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TEST] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TEST] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TEST] SET  MULTI_USER 
GO
ALTER DATABASE [TEST] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TEST] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TEST] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TEST] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [TEST]
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_IDTraCuu]    Script Date: 5/26/2019 12:22:08 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[CongGioPhut]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[CongGioPhut](@A time,@B time)
returns time
as begin
	declare @C time;
	set @C=(select dateadd(MINUTE,datepart(minute,@A),dateadd(second,datepart(SECOND,@A),@B)));
	return @C;
end;
GO
/****** Object:  UserDefinedFunction [dbo].[CongThoiGian]    Script Date: 5/26/2019 12:22:08 PM ******/
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
/****** Object:  Table [dbo].[BacSi]    Script Date: 5/26/2019 12:22:08 PM ******/
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
/****** Object:  Table [dbo].[BanKham]    Script Date: 5/26/2019 12:22:08 PM ******/
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
/****** Object:  Table [dbo].[BenhNhan]    Script Date: 5/26/2019 12:22:08 PM ******/
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
/****** Object:  Table [dbo].[BenhNhanXetNghiem]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BenhNhanXetNghiem](
	[IDPhieuKham] [nvarchar](10) NOT NULL,
	[IDDichVuXN] [nvarchar](10) NOT NULL,
	[IDXetNghiemBN] [nvarchar](10) NOT NULL,
	[ThoiGianChiDinh] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPhieuKham] ASC,
	[IDDichVuXN] ASC,
	[IDXetNghiemBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CaKham]    Script Date: 5/26/2019 12:22:08 PM ******/
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
/****** Object:  Table [dbo].[ChuyenKhoa]    Script Date: 5/26/2019 12:22:08 PM ******/
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
/****** Object:  Table [dbo].[DichVuCanLamSang]    Script Date: 5/26/2019 12:22:08 PM ******/
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
/****** Object:  Table [dbo].[DonViChucNang]    Script Date: 5/26/2019 12:22:08 PM ******/
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
/****** Object:  Table [dbo].[HienThiSTTXetNghiem]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HienThiSTTXetNghiem](
	[IDPhongXN] [nvarchar](10) NOT NULL,
	[IDHienThiXN] [nvarchar](20) NOT NULL,
	[ChuoiSTT] [nvarchar](20) NULL,
	[CaKham] [int] NULL,
	[ThoiGian] [time](7) NULL,
	[Ngay] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPhongXN] ASC,
	[IDHienThiXN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhuVuc]    Script Date: 5/26/2019 12:22:08 PM ******/
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
/****** Object:  Table [dbo].[Lau]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lau](
	[IDLau] [int] NOT NULL,
	[TenLau] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDLau] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LichKhamBacSi]    Script Date: 5/26/2019 12:22:08 PM ******/
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
/****** Object:  Table [dbo].[LichPhongCanLamSang]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LichPhongCanLamSang](
	[IDPhongCLS] [nvarchar](10) NOT NULL,
	[Ngay] [date] NOT NULL,
	[CaKham] [int] NOT NULL,
	[GioBatDau] [time](7) NULL,
	[GioKetThuc] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPhongCLS] ASC,
	[Ngay] ASC,
	[CaKham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LichSuTraCuu]    Script Date: 5/26/2019 12:22:08 PM ******/
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
/****** Object:  Table [dbo].[LoaiDichVu]    Script Date: 5/26/2019 12:22:08 PM ******/
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
/****** Object:  Table [dbo].[PhieuKham]    Script Date: 5/26/2019 12:22:08 PM ******/
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
/****** Object:  Table [dbo].[PhongCanLamSang]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhongCanLamSang](
	[ID] [nvarchar](10) NOT NULL,
	[SoPhong] [nvarchar](50) NULL,
	[TrucThuoc] [nvarchar](10) NULL,
	[Lau] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhongKhamChuyenKhoa]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhongKhamChuyenKhoa](
	[ID] [nvarchar](10) NOT NULL,
	[SoPhong] [nvarchar](20) NULL,
	[ChuyenKhoa] [nvarchar](10) NULL,
	[Lau] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SoHienThiPhongCanLamSang]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SoHienThiPhongCanLamSang](
	[IDPhongCanLamSang] [nvarchar](10) NOT NULL,
	[STT] [int] NOT NULL,
	[IDPhieuKham] [nvarchar](10) NOT NULL,
	[CanLamSang] [nvarchar](10) NOT NULL,
	[Gio] [datetime] NULL,
	[TinhTrang] [int] NULL,
	[CaKham] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPhongCanLamSang] ASC,
	[IDPhieuKham] ASC,
	[STT] ASC,
	[CanLamSang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SoHienThiPhongKham]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SoHienThiPhongKham](
	[STT] [int] NOT NULL,
	[BanKham] [nvarchar](10) NOT NULL,
	[PhongKham] [nvarchar](10) NOT NULL,
	[IDPhieuKham] [nvarchar](10) NOT NULL,
	[Gio] [datetime] NULL,
	[TinhTrang] [int] NULL,
	[CaKham] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[BanKham] ASC,
	[IDPhieuKham] ASC,
	[PhongKham] ASC,
	[STT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SoHienThiPhongXetNghiem]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SoHienThiPhongXetNghiem](
	[IDPhongXetNghiem] [nvarchar](10) NOT NULL,
	[STT] [int] NOT NULL,
	[IDPhieuKham] [nvarchar](10) NOT NULL,
	[IDXetNghiem] [nvarchar](10) NOT NULL,
	[Gio] [datetime] NULL,
	[TinhTrang] [int] NULL,
	[CaKham] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPhongXetNghiem] ASC,
	[IDPhieuKham] ASC,
	[STT] ASC,
	[IDXetNghiem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SoThuTuPhongCLS]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SoThuTuPhongCLS](
	[IDPhieuKham] [nvarchar](10) NOT NULL,
	[STT] [int] NOT NULL,
	[CanLamSang] [nvarchar](10) NOT NULL,
	[PhongCanLamSang] [nvarchar](10) NULL,
	[CaKham] [int] NULL,
	[Gio] [datetime] NULL,
	[TinhTrang] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPhieuKham] ASC,
	[STT] ASC,
	[CanLamSang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SoThuTuPhongKham]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SoThuTuPhongKham](
	[IDPhieuKham] [nvarchar](10) NOT NULL,
	[STT] [int] NOT NULL,
	[BanKham] [nvarchar](10) NOT NULL,
	[PhongKham] [nvarchar](10) NOT NULL,
	[CaKham] [int] NULL,
	[Gio] [datetime] NULL,
	[TinhTrang] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPhieuKham] ASC,
	[STT] ASC,
	[BanKham] ASC,
	[PhongKham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SoThuTuPhongKham_Overtime]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SoThuTuPhongKham_Overtime](
	[IDPhieuKham] [nvarchar](10) NOT NULL,
	[STT] [int] NOT NULL,
	[BanKham] [nvarchar](10) NOT NULL,
	[PhongKham] [nvarchar](10) NOT NULL,
	[CaKham] [int] NULL,
	[Gio] [datetime] NULL,
	[Thoigiansinhso] [datetime] NULL,
	[TinhTrang] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPhieuKham] ASC,
	[STT] ASC,
	[BanKham] ASC,
	[PhongKham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SoThuTuPhongKhamBacSi_Overtime]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SoThuTuPhongKhamBacSi_Overtime](
	[IDPhieuKham] [nvarchar](10) NOT NULL,
	[STT] [int] NOT NULL,
	[BanKham] [nvarchar](10) NOT NULL,
	[PhongKham] [nvarchar](10) NOT NULL,
	[CaKham] [int] NULL,
	[Gio] [datetime] NULL,
	[Thoigiansinhso] [datetime] NULL,
	[TinhTrang] [nvarchar](10) NULL,
	[BacSi] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPhieuKham] ASC,
	[STT] ASC,
	[BanKham] ASC,
	[PhongKham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SoThuTuPhongXetNghiem]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SoThuTuPhongXetNghiem](
	[IDPhieuKham] [nvarchar](10) NOT NULL,
	[IDXetNghiem] [nvarchar](10) NULL,
	[STT] [int] NOT NULL,
	[PhongXetNghiem] [nvarchar](10) NULL,
	[CaKham] [int] NOT NULL,
	[Gio] [datetime] NULL,
	[TinhTrang] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPhieuKham] ASC,
	[CaKham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Temp]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Temp](
	[Status] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThongKePhongCLS]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongKePhongCLS](
	[IDPhongCLS] [nvarchar](10) NOT NULL,
	[NgayCT] [date] NOT NULL,
	[CaKham] [int] NOT NULL,
	[SoLuongDoi] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPhongCLS] ASC,
	[NgayCT] ASC,
	[CaKham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThongKePhongKham]    Script Date: 5/26/2019 12:22:08 PM ******/
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
/****** Object:  Table [dbo].[ThucHienCLS]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThucHienCLS](
	[IDPhongCLS] [nvarchar](10) NOT NULL,
	[DichVuCLSThucHien] [nvarchar](10) NOT NULL,
	[CaKham] [int] NOT NULL,
	[Ngay] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPhongCLS] ASC,
	[DichVuCLSThucHien] ASC,
	[CaKham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ThongKeGioDuKienSTTCLSCuoi]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ThongKeGioDuKienSTTCLSCuoi] as
select A.PhongCanLamSang,A.CaKham,STT.STT as SoThuTuCuoiCung, A.GioDuKienSoCuoi
from
(select STT.PhongCanLamSang,STT.CaKham,max(STT.Gio) as GioDuKienSoCuoi 
from SoThuTuPhongCLS as STT
group by STT.PhongCanLamSang,STT.CaKham) as A inner join SoThuTuPhongCLS as STT on STT.PhongCanLamSang=A.PhongCanLamSang
where A.GioDuKienSoCuoi=STT.Gio
GO
/****** Object:  View [dbo].[ThongKeCLSChiTiet]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ThongKeCLSChiTiet] as 
select distinct A.IDPhongCLS,B.DichVuCLSThucHien,A.CaKham,A.STT as SoSTTPhatSinhCuoi,A.GioDuKienCuoi
from
(select distinct TK.IDPhongCLS,STT.CaKham,STT.STT,STT.Gio as GioDuKienCuoi
from ThongKePhongCLS as TK inner join ThucHienCLS as Th on TH.IDPhongCLS=TK.IDPhongCLS
						   inner join SoThuTuPhongCLS as STT on STT.PhongCanLamSang = TH.IDPhongCLS) as A
inner join 
(select distinct TK.IDPhongCLS,max(STT.GioDuKienSoCuoi) as GioDuKienCuoi,TH.DichVuCLSThucHien,TK.CaKham
from ThongKePhongCLS as TK inner join ThucHienCLS as Th on TH.IDPhongCLS=TK.IDPhongCLS
						   inner join ThongKeGioDuKienSTTCLSCuoi as STT on STT.PhongCanLamSang = TH.IDPhongCLS
						 where TK.CaKham= TH.CaKham and TK.CaKham=STT.CaKham
						    group by TK.IDPhongCLS,TH.DichVuCLSThucHien,TK.CaKham) as B 
						   on A.IDPhongCLS=B.IDPhongCLS and A.GioDuKienCuoi=B.GioDuKienCuoi;
GO
/****** Object:  View [dbo].[ThongKeGioDuKien]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ThongKeGioDuKien] as
select STT.BanKham,STT.PhongKham,STT.CaKham,max(STT.Gio) as GioDuKienSoCuoi,PK.ChuyenKhoa
from SoThuTuPhongKham as STT join PhongKhamChuyenKhoa as PK on PK.ID=STT.PhongKham
group by STT.BanKham,STT.PhongKham,STT.CaKham,PK.ChuyenKhoa
GO
/****** Object:  View [dbo].[ThongKeSTTCuoiPhongKham]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ThongKeSTTCuoiPhongKham] as
select TK.BanKham,TK.PhongKham,STT.STT,TK.CaKham,TK.GioDuKienSoCuoi,TK.ChuyenKhoa
from ThongKeGioDuKien as TK inner join SoThuTuPhongKham as STT on STT.BanKham=TK.BanKham and TK.PhongKham=STT.PhongKham
where TK.GioDuKienSoCuoi=STT.Gio
GO
/****** Object:  View [dbo].[ThongKeChiTiet]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ThongKeChiTiet] as
select A.BanKham,A.PhongKham,A.CaKham,A.GioDuKienSoCuoi,A.SoLuongDoi,A.ThoiGianKhamTB,A.ChuyenKhoa  from
(select DK.BanKham,Dk.PhongKham,DK.CaKham,DK.GioDuKienSoCuoi,SL.SoLuongDoi,SL.ThoiGianKhamTB,DK.ChuyenKhoa 
from ThongKeGioDuKien as DK join ThongKePhongKham as SL 
on Dk.BanKham=SL.IDBan and Dk.PhongKham=SL.Phong and DK.ChuyenKhoa=SL.ChuyenKhoa and SL.CaKham=DK.CaKham )as A
inner join
(select min(DK.GioDuKienSoCuoi) as GioDuKienSoCuoi,DK.ChuyenKhoa 
from ThongKeGioDuKien as DK join ThongKePhongKham as SL 
on Dk.BanKham=SL.IDBan and Dk.PhongKham=SL.Phong and DK.ChuyenKhoa=SL.ChuyenKhoa and SL.CaKham=DK.CaKham
group by  DK.ChuyenKhoa) as B on A.ChuyenKhoa=B.ChuyenKhoa and A.GioDuKienSoCuoi=B.GioDuKienSoCuoi
GO
/****** Object:  View [dbo].[ThongKeChiTiet_Null]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ThongKeChiTiet_Null] as
select BK.IDBan,BK.Phong,LK.CaKham,BS.ChuyenKhoa, BS.ThoiGianKhamTB_min
from BanKham as BK join LichKhamBacSi as LK on LK.IDBan=BK.IDBan and LK.Phong=BK.Phong join BacSi as BS on BS.ID=LK.IDBacSi
GO
/****** Object:  View [dbo].[ThongKeCLS]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ThongKeCLS] as 
select TH.IDPhongCLS,DichVuCLSThucHien,Dv.TenDichVu,DV.LoaiDichVu,DV.TinhTrang,DV.ThoiGianNhaySoTB,TH.CaKham,L.GioBatDau,L.GioKetThuc
from ThucHienCLS as TH inner join DichVuCanLamSang as DV on DV.IDDichVu=TH.DichVuCLSThucHien
						inner join LichPhongCanLamSang as L on L.IDPhongCLS=TH.IDPhongCLS and L.CaKham=TH.CaKham and L.Ngay=TH.Ngay
GO
/****** Object:  View [dbo].[ThongKeCLSChiTiet_Null]    Script Date: 5/26/2019 12:22:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ThongKeCLSChiTiet_Null] as
select distinct TK.IDPhongCLS,TK.SoluongDoi,TK.CaKham
from ThongKePhongCLS as TK inner join ThucHienCLS as Th on TH.IDPhongCLS=TK.IDPhongCLS
where TK.IDPhongCLS not in ( select STT.PhongCanLamSang from SoThuTuPhongCLS as STT join SoHienThiPhongCanLamSang as SHT on SHT.IDPhongCanLamSang=STT.PhongCanLamSang)
		
GO
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS004', N'H� Ng?c Tuy?t Trinh', N'Nam', N'1965', N'Hung Y�n', N'EEG', CAST(N'00:07:09' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS011', N'Nguy?n Tu?n �?t', N'Nam', N'1977', N'Vinh Long', N'DB', CAST(N'00:06:59' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS014', N'Phan Nguy?n Th�nh T�i', N'Nam', N'1978', N'L�m �?ng', N'PY', CAST(N'00:04:11' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS018', N'Ho�ng B?o H�n', N'Nam', N'1966', N'H?i Duong', N'P!', CAST(N'00:04:57' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS019', N'Ph?m Thu An', N'N?', N'1988', N'Lai Ch�u', N'DY', CAST(N'00:06:45' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS020', N'Truong Ph� Hung', N'Nam', N'1976', N'An Giang', N'DB', CAST(N'00:07:53' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS021', N'L� Tr?n Kh�nh �oan', N'N?', N'1965', N'B�nh �?nh', N'UB', CAST(N'00:04:06' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS033', N'�?ng Thu? Tr�m', N'Nam', N'1976', N'T�y Ninh', N'KTN', CAST(N'00:07:10' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS036', N'Ph?m B?o Huy', N'Nam', N'1958', N'Y�n B�i', N'PQ', CAST(N'00:04:56' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS042', N'Ph?m Thu An', N'Nam', N'1967', N'Ngh? An', N'UB', CAST(N'00:05:40' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS051', N'Nguy?n Ho�ng Ng?c Lan', N'N?', N'1978', N'B�nh Phu?c', N'D$', CAST(N'00:07:38' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS057', N'L� Th? Nhu Qu?nh', N'Nam', N'1976', N'H� Giang	', N'PI', CAST(N'00:06:40' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS062', N'Ph?m Van �?i Duong', N'N?', N'1978', N'Cao B?ng', N'LM', CAST(N'00:05:30' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS066', N'Nguy?n Th?y Thanh V�n', N'Nam', N'1986', N'Kon Tum', N'D(', CAST(N'00:05:46' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS067', N'Nguy?n Giang Son', N'Nam', N'1978', N'Tuy�n Quang', N'DH', CAST(N'00:05:04' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS069', N'L� Minh Tr�', N'N?', N'1977', N'Ninh Thu?n', N'P!', CAST(N'00:05:09' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS071', N'L� Tr?n B?o Khanh', N'Nam', N'1955', N'B?c Ninh', N'D&', CAST(N'00:05:02' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS078', N'Nguy?n Th? Di?m My', N'Nam', N'1955', N'H?i Ph�ng', N'D*', CAST(N'00:07:32' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS090', N'Ph?m Ng?c Phuong Anh', N'N?', N'1956', N'B?c Ninh', N'P2', CAST(N'00:03:53' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS091', N'Nguy?n Qu?c Ph�t', N'Nam', N'1965', N'Ninh B�nh', N'P9', CAST(N'00:04:21' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS093', N'Tr?n �o�n Tu?n Ki?t', N'Nam', N'1958', N'B?c Li�u', N'DN', CAST(N'00:07:03' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS094', N'Nguy?n �?c Tru?ng Ph�t', N'Nam', N'1986', N'Kon Tum', N'P!', CAST(N'00:08:58' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS096', N'Truong Ho�ng Thu Th?o', N'Nam', N'1955', N'Ninh Thu?n', N'PR', CAST(N'00:08:02' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS099', N'Vu Ho�ng Ph�c', N'N?', N'1958', N'B?c Li�u', N'CKQT', CAST(N'00:05:54' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS1', N'Vy Th? Thu', N'N?', N'1985', N'TP.HCM', N'PO', CAST(N'00:08:26' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS100', N'�?ng Gia Ki?t', N'Nam', N'1987', N'B�nh Thu?n', N'DT', CAST(N'00:06:10' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS101', N'Nguy?n T?n L?i', N'N?', N'1958', N'Th?a Thi�n Hu?', N'D0', CAST(N'00:05:21' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS105', N'Nguy?n Ng?c B?o H�n', N'Nam', N'1986', N'H� N?i', N'P!', CAST(N'00:07:40' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS107', N'L� Th? Ng?c Phu?ng', N'N?', N'1977', N'Y�n B�i', N'DU', CAST(N'00:04:58' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS108', N'L� Nguy?n Gia Nghi', N'Nam', N'1958', N'H�a B�nh', N'PJ', CAST(N'00:07:47' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS118', N'Nguy?n �?ng Kh�nh Vy', N'N?', N'1958', N'Lai Ch�u', N'D5', CAST(N'00:03:04' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS123', N'Tr?nh Duy B?o', N'Nam', N'1975', N'B?c Giang', N'NHCN', CAST(N'00:06:22' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS127', N'Tr?n Nguy?n Nh?t Tr�m', N'N?', N'1975', N'Hung Y�n', N'EMG', CAST(N'00:03:28' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS134', N'Duong Qu?c Anh', N'Nam', N'1966', N'Son La', N'D&', CAST(N'00:06:52' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS135', N'Tr?n Nguy?n Ho�i Anh', N'N?', N'1985', N'Ti?n Giang', N'D^', CAST(N'00:05:34' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS138', N'Duong Minh Chi?n', N'Nam', N'1975', N'B?c Ninh', N'PV', CAST(N'00:08:09' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS139', N'Nguy?n H?u Anh Tu?n', N'N?', N'1976', N'Th?a Thi�n Hu?', N'DL', CAST(N'00:08:24' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS141', N'�inh Lan Huong', N'N?', N'1976', N'H� Tinh', N'DI', CAST(N'00:03:17' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS145', N'Tr?n Van Ph�', N'Nam', N'1978', N'H?i Duong', N'DB', CAST(N'00:04:08' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS149', N'Hu?nh L� Y?n Nhi', N'Nam', N'1968', N'Kh�nh H�a', N'0UGM', CAST(N'00:05:12' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS154', N'Nguy?n H�ng Th?ng', N'Nam', N'1957', N'�?ng Nai', N'PK', CAST(N'00:08:23' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS155', N'Nguy?n Th? Thanh Uy�n', N'N?', N'1976', N'Ph� Th?', N'0D03', CAST(N'00:06:47' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS159', N'L� Th? Phuong Th�y', N'N?', N'1985', N'Vinh Ph�c', N'P@', CAST(N'00:04:06' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS162', N'Nguy?n H?ng Th?y Ti�n', N'Nam', N'1966', N'S�c Trang', N'PHCN', CAST(N'00:06:26' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS165', N'Nguy?n  Th? �i Linh', N'Nam', N'1955', N'Gia Lai', N'P6', CAST(N'00:08:50' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS167', N'B�i Ng?c �nh Duong', N'Nam', N'1967', N'S�c Trang', N'PHCN', CAST(N'00:08:44' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS168', N'Ph?m L� �oan H�n', N'N?', N'1977', N'�?ng Nai', N'ND', CAST(N'00:03:45' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS180', N'Nguy?n Nh?t C?nh', N'Nam', N'1955', N'B�nh Thu?n', N'DH', CAST(N'00:03:54' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS181', N'Tr?n Nguy?n Kh? Vy', N'Nam', N'1958', N'C� Mau', N'UB', CAST(N'00:08:04' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS186', N'Luong Kh�nh Lu�n', N'N?', N'1967', N'Vinh Ph�c', N'NHI2', CAST(N'00:08:25' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS187', N'Tr?n L� Tu?n Ki?t', N'Nam', N'1956', N'Kon Tum', N'D3', CAST(N'00:05:03' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS188', N'T�n Nguy?n Thu? Trang', N'Nam', N'1976', N'Qu?ng Tr?', N'PI', CAST(N'00:03:19' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS189', N'L� Tr?ng B?o Khang', N'Nam', N'1956', N'�?k N�ng', N'PI', CAST(N'00:06:30' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS193', N'Tr?n Th? Nhu Qu?nh', N'Nam', N'1988', N'S�c Trang', N'PI', CAST(N'00:06:20' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS2', N'Vy Th? Thu', N'N?', N'1985', N'TP.HCM', N'PO', CAST(N'00:07:50' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS203', N'L� S? H�o', N'N?', N'1966', N'B?c Li�u', N'D]', CAST(N'00:04:12' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS204', N'Tr?n Vu Uy�n Chi', N'Nam', N'1977', N'H�a B�nh', N'DE', CAST(N'00:04:30' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS206', N'Nguy?n Ho�ng Tr?ng Hi?p', N'Nam', N'1978', N'Ph� Th?', N'D!', CAST(N'00:04:06' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS207', N'Luong Tr?ng Minh Phuong', N'N?', N'1987', N'Long An', N'DR', CAST(N'00:05:19' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS213', N'Tr?n Nguy?n Ho�i Anh', N'Nam', N'1978', N'H� Nam', N'PU', CAST(N'00:06:02' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS219', N'L� Ho�ng Nam', N'N?', N'1956', N'B?c K?n', N'DE', CAST(N'00:05:24' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS223', N'L� Hu?nh Anh Thu', N'Nam', N'1956', N'Y�n B�i', N'DZ', CAST(N'00:03:37' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS227', N'Nguy?n Tr?n Anh Thu', N'Nam', N'1975', N'Qu?ng Nam', N'D8', CAST(N'00:03:27' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS230', N'Vuong �?c Hi?u', N'Nam', N'1985', N'Qu?ng Ng�i', N'P(', CAST(N'00:08:48' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS233', N'B�i Ng?c Tr�m', N'Nam', N'1988', N'H� Giang	', N'ND', CAST(N'00:05:04' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS239', N'Th�i Nguy?t Minh', N'N?', N'1977', N'B?c Ninh', N'DB', CAST(N'00:06:19' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS241', N'L� Ng?c Y?n Vy', N'Nam', N'1988', N'B�nh Thu?n', N'PK', CAST(N'00:05:53' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS242', N'B�i Phu?ng Vy', N'Nam', N'1957', N'L?ng Son', N'PG', CAST(N'00:08:46' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS243', N'V� �?i Gi�u', N'Nam', N'1966', N'B?n Tre', N'DT', CAST(N'00:04:34' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS245', N'Nguy?n Th? H� Ti�n', N'N?', N'1968', N'S�c Trang', N'PF', CAST(N'00:03:02' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS247', N'L�m Thanh Qu?c Th?ng', N'Nam', N'1977', N'Vinh Ph�c', N'P(', CAST(N'00:03:23' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS253', N'�?ng Gia Ki?t', N'N?', N'1976', N'TP HCM', N'D]', CAST(N'00:08:14' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS255', N'L� Tr?n �ang Khoa', N'N?', N'1965', N'Ki�n Giang', N'PP', CAST(N'00:06:19' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS256', N'Ph?m L?c Ph� Qu�', N'N?', N'1985', N'Ti?n Giang', N'P7', CAST(N'00:07:31' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS261', N'Ho�ng ��ng H?i', N'N?', N'1988', N'Vinh Long', N'D+', CAST(N'00:04:06' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS262', N'Tr?n Th? T� Trinh', N'N?', N'1976', N'Lai Ch�u', N'D&', CAST(N'00:07:49' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS265', N'�? Minh Chuong', N'Nam', N'1957', N'TP HCM', N'P(', CAST(N'00:04:50' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS269', N'Nguy?n Tr?ng H�n', N'Nam', N'1978', N'Y�n B�i', N'YHGD', CAST(N'00:08:21' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS278', N'Nguy?n Ph� Khang', N'N?', N'1957', N'Ngh? An', N'VT01', CAST(N'00:03:08' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS286', N'Tr?nh Gia Linh', N'Nam', N'1966', N'Qu?ng B�nh	', N'DG', CAST(N'00:05:22' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS288', N'Phan Th? Thanh Danh', N'Nam', N'1986', N'C� Mau', N'UB', CAST(N'00:03:32' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS289', N'Nguy?n Ng� Qu?nh Giang', N'N?', N'1976', N'B�nh �?nh', N'KBTS', CAST(N'00:07:35' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS298', N'Ph?m Th? D?u', N'Nam', N'1975', N'B?c K?n', N'PH', CAST(N'00:03:47' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS299', N'Ph?m Tu?ng V�n', N'N?', N'1978', N'H� Tinh', N'PY', CAST(N'00:06:15' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS3', N'Vy Th? Thu', N'N?', N'1985', N'TP.HCM', N'PO', CAST(N'00:05:35' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS300', N'Tr?n Kim Ng�n', N'N?', N'1967', N'�?k N�ng', N'D!', CAST(N'00:06:03' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS303', N'Tr?n Kh�nh Ng?c', N'N?', N'1967', N'Ti?n Giang', N'VT01', CAST(N'00:08:34' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS314', N'Ph�ng Ng?c B�ch Tr�m', N'Nam', N'1986', N'H� Tinh', N'TN', CAST(N'00:03:54' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS315', N'L� Minh Hi?u', N'Nam', N'1956', N'L?ng Son', N'PT', CAST(N'00:05:07' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS321', N'Ho�ng Th? Mai Phuong', N'N?', N'1965', N'B?c Li�u', N'PT', CAST(N'00:07:42' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS329', N'Duong Th? Y?n Nhi', N'Nam', N'1986', N'H� Nam', N'P7', CAST(N'00:03:39' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS330', N'L� Song To�n', N'Nam', N'1985', N'H� N?i', N'P@', CAST(N'00:03:58' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS333', N'L� Tr?n Xu�n Qu?nh', N'N?', N'1958', N'H� Giang	', N'PR', CAST(N'00:05:52' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS334', N'Bu`I Quang Trung', N'Nam', N'1956', N'H� Tinh', N'DZ', CAST(N'00:04:42' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS337', N'Nguy?n Ch�u Tr�c My', N'N?', N'1958', N'H� Giang	', N'DK', CAST(N'00:03:34' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS341', N'�?i Th? Ng?c �i?p', N'Nam', N'1985', N'C� Mau', N'P$', CAST(N'00:04:42' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS343', N'�?ng Phan Tr� My', N'N?', N'1957', N'Qu?ng Nam', N'DV', CAST(N'00:08:31' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS345', N'Nguy?n Anh Duy', N'Nam', N'1965', N'H?i Duong', N'PB', CAST(N'00:03:28' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS346', N'Tr?n Th? Ki?u Linh', N'Nam', N'1955', N'Y�n B�i', N'ND', CAST(N'00:05:36' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS351', N'Nguy?n Minh Hi?u', N'Nam', N'1955', N'B�nh Phu?c', N'PZ', CAST(N'00:04:07' AS Time))
GO
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS352', N'L�   Ng?c  Huy?n Tr�n', N'Nam', N'1976', N'Tuy�n Quang', N'PD', CAST(N'00:07:31' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS358', N'Tr?n Hu?nh Gia B?o', N'Nam', N'1987', N'Qu?ng Ng�i', N'DS', CAST(N'00:03:24' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS360', N'V� Minh T�m', N'Nam', N'1966', N'Th�i B�nh', N'DV', CAST(N'00:04:02' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS365', N'Ng� Ho�ng Kh?i Nguy�n', N'N?', N'1977', N'L�o Cai', N'D0', CAST(N'00:07:52' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS380', N'Cao Ho�ng Minh T�m', N'Nam', N'1955', N'B�nh Thu?n', N'P2', CAST(N'00:08:14' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS381', N'Nguy?n Thanh Xu�n', N'N?', N'1958', N'C� Mau', N'PB', CAST(N'00:08:07' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS386', N'L� Ph?m Linh Chi', N'Nam', N'1986', N'Qu?ng B�nh	', N'VT01', CAST(N'00:03:58' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS394', N'V� Van Son', N'Nam', N'1987', N'B?c Giang', N'PS', CAST(N'00:04:34' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS4', N'Vy Th? Thu', N'N?', N'1985', N'TP.HCM', N'PO', CAST(N'00:03:48' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS408', N'H? Anh Duy', N'Nam', N'1987', N'H� Nam', N'CKQT', CAST(N'00:04:36' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS411', N'L� Th? Phuong Th?o', N'Nam', N'1975', N'B?n Tre', N'PG', CAST(N'00:06:25' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS412', N'Giao Th�i Nguy�n', N'N?', N'1976', N'Ph� Th?', N'P$', CAST(N'00:03:42' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS414', N'L� Ng?c Th? Hoa', N'Nam', N'1965', N'H� N?i', N'D?', CAST(N'00:08:39' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS425', N'Nguy?n Thanh Tr?ng', N'N?', N'1976', N'B� R?a - Vung T�u', N'PR', CAST(N'00:03:19' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS427', N'Tr?n Ho�i Y�n Nhi', N'N?', N'1988', N'An Giang', N'D(', CAST(N'00:04:01' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS446', N'Nguy?n Truong Thanh Huy?n', N'Nam', N'1985', N'Gia Lai', N'D_', CAST(N'00:07:50' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS447', N'Vu Nguy?n Minh Ch�u', N'N?', N'1956', N'�i?n Bi�n', N'D7', CAST(N'00:08:21' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS454', N'L?i Vu Ph�c Duy', N'Nam', N'1966', N'�?ng Nai', N'PN', CAST(N'00:06:34' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS463', N'V� Ho�ng Nam', N'N?', N'1968', N'T�y Ninh', N'DH', CAST(N'00:03:00' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS474', N'Tr?n Duong Th?o Uy�n', N'N?', N'1957', N'�?k N�ng', N'DH', CAST(N'00:07:53' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS480', N'Luu Phu?c M?nh', N'N?', N'1976', N'Son La', N'PB', CAST(N'00:05:09' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS483', N'Nguy?n B?o Nguy�n', N'Nam', N'1967', N'H� Tinh', N'EEG', CAST(N'00:05:48' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS484', N'Tr?n Ng?c Tri?u Vi', N'Nam', N'1967', N'B?n Tre', N'P$', CAST(N'00:03:09' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS489', N'Ph?m Do�n Ho�ng D�n', N'Nam', N'1976', N'Long An', N'DZ', CAST(N'00:03:42' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS495', N'Nguy?n K�ng Nguy�n', N'Nam', N'1975', N'Vinh Ph�c', N'PC', CAST(N'00:06:51' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS498', N'Ng� ��nh Tu?n', N'N?', N'1988', N'Ph� Th?', N'D*', CAST(N'00:06:52' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS5', N'Vy Th? Thu', N'N?', N'1985', N'TP.HCM', N'PO', CAST(N'00:06:04' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS503', N'Nguy?n Nh?t C?nh', N'N?', N'1956', N'B�nh Duong', N'DTTL', CAST(N'00:04:34' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS510', N'Nguy?n Truong Thanh Huy?n', N'N?', N'1967', N'Qu?ng B�nh	', N'D5', CAST(N'00:04:09' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS512', N'Nguy?n Minh To�n', N'Nam', N'1968', N'An Giang', N'D<', CAST(N'00:08:43' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS513', N'Tr?n Nguy?n Ng?c H�n', N'Nam', N'1958', N'L�m �?ng', N'D5', CAST(N'00:08:41' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS522', N'Nguy?n Th? Tuy?t H�n', N'Nam', N'1986', N'Vinh Ph�c', N'EEG', CAST(N'00:06:54' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS527', N'�? Gia Huy', N'Nam', N'1986', N'L?ng Son', N'GN', CAST(N'00:07:06' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS529', N'Ph?m L?c Ph� Qu�', N'N?', N'1986', N'Ti?n Giang', N'KTN', CAST(N'00:03:46' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS531', N'Cao Ho�ng Minh Nguy?t', N'Nam', N'1955', N'�?k N�ng', N'DA', CAST(N'00:03:02' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS540', N'L� Tr?ng B?o Khang', N'Nam', N'1988', N'H� N?i', N'D@', CAST(N'00:05:50' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS541', N'Nguy?n Th? Ho�i Thuong', N'N?', N'1965', N'Long An', N'DK', CAST(N'00:04:26' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS543', N'Ph?m Van �?i Duong', N'Nam', N'1967', N'H� Tinh', N'D6', CAST(N'00:04:35' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS544', N'Senthil Kumar Goutham', N'Nam', N'1975', N'�� N?ng', N'PJ', CAST(N'00:04:52' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS546', N'Ph?m Ho�ng Qu?nh Anh', N'Nam', N'1967', N'B�nh Phu?c', N'P9', CAST(N'00:08:05' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS554', N'Ph?m Ph� Quang', N'Nam', N'1975', N'Qu?ng Ng�i', N'CKQT', CAST(N'00:06:59' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS555', N'Luu M? T�m', N'Nam', N'1958', N'Ninh B�nh', N'D4', CAST(N'00:03:54' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS559', N'T? Thu H?ng', N'N?', N'1975', N'B?n Tre', N'EEG', CAST(N'00:07:56' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS562', N'T�n N? Qu?nh Nhu', N'Nam', N'1985', N'�� N?ng', N'PM', CAST(N'00:04:14' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS563', N'Ph?m Thu An', N'Nam', N'1968', N'Son La', N'DK', CAST(N'00:05:46' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS565', N'Nguy?n Th?o An', N'Nam', N'1987', N'B�nh �?nh', N'DM', CAST(N'00:05:24' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS570', N'Ph?m Tu?ng V�n', N'N?', N'1985', N'Ph� Th?', N'DA', CAST(N'00:06:12' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS571', N'Phan Thanh T?n', N'N?', N'1987', N'Qu?ng Nam', N'DM', CAST(N'00:07:44' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS575', N'Nguy?n T?n Ho�ng Thy', N'N?', N'1975', N'L�o Cai', N'DA', CAST(N'00:03:43' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS582', N'T� Th? Di?m Qu?nh', N'N?', N'1957', N'Qu?ng Ng�i', N'D)', CAST(N'00:07:06' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS587', N'Hu?nh L� Th?o Nguy�n', N'Nam', N'1986', N'Nam �?nh', N'P2', CAST(N'00:07:18' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS589', N'Nguy?n Vu Minh Phuong', N'N?', N'1955', N'H� Giang	', N'D+', CAST(N'00:05:11' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS597', N'B�i Nguy?n B?o Ch�u', N'N?', N'1975', N'B?c Li�u', N'PT', CAST(N'00:04:01' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS6', N'Vy Th? Thu', N'N?', N'1985', N'TP.HCM', N'PO', CAST(N'00:05:41' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS603', N'Nguy?n Huong Giang', N'Nam', N'1977', N'B?c Giang', N'PG', CAST(N'00:06:12' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS605', N'L� Minh Qu�n', N'N?', N'1986', N'Qu?ng Ng�i', N'PN', CAST(N'00:04:07' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS613', N'L� S? H�o', N'Nam', N'1985', N'B?c Giang', N'PR', CAST(N'00:08:23' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS616', N'Nguy?n Tu?n Anh', N'Nam', N'1975', N'Ngh? An', N'DTTL', CAST(N'00:08:58' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS618', N'Ph?m Gia My', N'Nam', N'1977', N'H?u Giang', N'P#', CAST(N'00:08:21' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS620', N'Tr?n Th? Thanh T�m', N'N?', N'1968', N'�?ng Th�p', N'PU', CAST(N'00:03:01' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS622', N'Ph?m Cao Ho�ng My', N'N?', N'1967', N'B�nh �?nh', N'PR', CAST(N'00:04:07' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS624', N'Nguy?n Ph�c Vinh', N'Nam', N'1976', N'B�nh Thu?n', N'P$', CAST(N'00:03:58' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS631', N'Duong Vi H�o', N'Nam', N'1968', N'Qu?ng Ninh', N'DS', CAST(N'00:06:53' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS635', N'L� Duong Ch� B?o', N'N?', N'1957', N'Qu?ng Ng�i', N'DI', CAST(N'00:06:58' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS641', N'Tr?n Ho�i T�n', N'N?', N'1958', N'B�nh Thu?n', N'PQ', CAST(N'00:04:21' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS646', N'Di?p Ng� Gia Ph�t', N'Nam', N'1955', N'Tr� Vinh', N'HH', CAST(N'00:03:44' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS650', N'Nguy?n Ng?c Thanh Tr�m', N'N?', N'1955', N'Son La', N'D3', CAST(N'00:07:25' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS651', N'V� Van �uong', N'Nam', N'1957', N'Th�i Nguy�n', N'D0', CAST(N'00:06:03' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS652', N'Phan Vu Nam Thi', N'N?', N'1957', N'T�y Ninh', N'DH', CAST(N'00:07:09' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS655', N'Nguy?n Linh Chi', N'N?', N'1988', N'Th�i Nguy�n', N'DD', CAST(N'00:04:37' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS661', N'Hu?nh B?o Minh Tr�', N'Nam', N'1955', N'Ti?n Giang', N'PI', CAST(N'00:03:27' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS666', N'Ph?m Th? Kim Phu?ng', N'Nam', N'1976', N'Th�i B�nh', N'GN', CAST(N'00:06:17' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS675', N'Nguy?n Th? Ng?c Huy?n', N'Nam', N'1975', N'Ph� Th?', N'YHGD', CAST(N'00:06:02' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS685', N'B�i Ng?c �nh Duong', N'Nam', N'1955', N'L�o Cai', N'PK', CAST(N'00:08:40' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS689', N'Duong Nguy?n Anh Thy', N'Nam', N'1957', N'H?i Duong', N'PI', CAST(N'00:04:38' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS692', N'Tr?n Thanh B�nh', N'Nam', N'1966', N'Son La', N'D&', CAST(N'00:08:50' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS695', N'Phan Ngo?c Hi�?u', N'N?', N'1957', N'Qu?ng Tr?', N'DD', CAST(N'00:08:31' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS697', N'L� Hu?nh Anh Thu', N'Nam', N'1955', N'Qu?ng B�nh	', N'P!', CAST(N'00:08:22' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS706', N'L� Hu?nh Anh Thu', N'N?', N'1977', N'Kon Tum', N'PA', CAST(N'00:07:33' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS707', N'Ph?m Th? Qu?nh Anh', N'Nam', N'1976', N'H� Tinh', N'D4', CAST(N'00:05:13' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS709', N'T�n N? Qu?nh Nhu', N'Nam', N'1987', N'�?ng Th�p', N'PJ', CAST(N'00:04:03' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS712', N'H� Minh T?n', N'Nam', N'1978', N'An Giang', N'PHCN', CAST(N'00:03:16' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS721', N'Nguy?n Tr?nh Minh H?ng', N'Nam', N'1968', N'Qu?ng Tr?', N'PK', CAST(N'00:03:09' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS735', N'Nguy?n Ho�ng T�', N'Nam', N'1965', N'Kh�nh H�a', N'D?', CAST(N'00:08:14' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS739', N'Nguy?n Th? Th?o Uy�n', N'Nam', N'1956', N'H?i Ph�ng', N'PL', CAST(N'00:03:45' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS750', N'Nguy?n B?o Ly', N'Nam', N'1968', N'�?ng Th�p', N'PI', CAST(N'00:06:46' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS751', N'Nguy?n ��nh Th?ng', N'Nam', N'1977', N'Kon Tum', N'D4', CAST(N'00:04:50' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS752', N'L� ��nh L�m', N'N?', N'1985', N'Th�i Nguy�n', N'D[', CAST(N'00:07:17' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS755', N'Ng� Th? Nhu Qu?nh', N'N?', N'1986', N'B�nh Duong', N'D8', CAST(N'00:05:29' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS756', N'T?ng Ng?c V�n Anh', N'N?', N'1965', N'Ninh B�nh', N'D6', CAST(N'00:03:19' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS758', N'V� ��nh Thi�n Ph�', N'Nam', N'1985', N'L�o Cai', N'D+', CAST(N'00:08:33' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS759', N'L� Th? Ng?c Phu?ng', N'Nam', N'1986', N'TP HCM', N'UB', CAST(N'00:08:12' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS760', N'Nguy?n B� Gia Kh�nh', N'Nam', N'1975', N'B�nh Duong', N'EMG', CAST(N'00:05:18' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS762', N'Vu �?c Gia B?o', N'N?', N'1966', N'Ti?n Giang', N'A0', CAST(N'00:07:00' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS764', N'Nguy?n �?c Th?ng', N'N?', N'1956', N'Gia Lai', N'P!', CAST(N'00:03:02' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS769', N'Nguy?n Qu?c Cu?ng', N'N?', N'1978', N'B�nh Duong', N'P!', CAST(N'00:05:20' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS772', N'Nguy?n Ph?m H� My', N'Nam', N'1976', N'Ti?n Giang', N'D?', CAST(N'00:04:53' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS774', N'Hu?nh Phuong Vinh', N'N?', N'1976', N'Ti?n Giang', N'D<', CAST(N'00:07:47' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS776', N'Nguy?n L� Tu?n Th�nh', N'Nam', N'1987', N'L?ng Son', N'D@', CAST(N'00:05:17' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS777', N'L� ��nh Ph�', N'Nam', N'1967', N'B�nh Phu?c', N'D8', CAST(N'00:08:12' AS Time))
GO
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS778', N'Nguy?n B�i Tu?n �?t', N'N?', N'1956', N'�?ng Th�p', N'D&', CAST(N'00:06:25' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS787', N'L� Song Ti�u', N'Nam', N'1985', N'H� N?i', N'P@', CAST(N'00:05:08' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS794', N'T? Duy Khang', N'Nam', N'1966', N'Ngh? An', N'D^', CAST(N'00:05:31' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS802', N'Ph?m Nguy?n Bang Nghi', N'N?', N'1967', N'B?n Tre', N'CKQT', CAST(N'00:05:35' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS810', N'�?ng Th? Di?m Th�y', N'N?', N'1967', N'B?c K?n', N'D]', CAST(N'00:05:22' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS818', N'Nguy?n B� Gia Kh�nh', N'Nam', N'1967', N'Nam �?nh', N'PA', CAST(N'00:04:50' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS819', N'Tr?n Ng?c Uy�n Phuong', N'Nam', N'1985', N'�?ng Th�p', N'PH', CAST(N'00:03:47' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS820', N'Tr�`N Truo`Ng Sinh', N'N?', N'1985', N'B?n Tre', N'HH', CAST(N'00:08:32' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS822', N'Cao Th? Thanh Hi?n', N'Nam', N'1986', N'Y�n B�i', N'DI', CAST(N'00:04:54' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS826', N'Nguy?n Th? Thu Huy?n', N'Nam', N'1955', N'B?c Giang', N'DV', CAST(N'00:03:32' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS827', N'Truong Ph� Hung', N'Nam', N'1985', N'�?ng Th�p', N'D@', CAST(N'00:04:52' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS828', N'Tr?n T?n Ph�t', N'Nam', N'1978', N'Son La', N'D^', CAST(N'00:06:47' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS829', N'V� Ng?c �oan Trang', N'N?', N'1955', N'Ngh? An', N'D)', CAST(N'00:03:48' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS830', N'Nguy?n C�ng M?nh', N'Nam', N'1985', N'H?i Ph�ng', N'D5', CAST(N'00:03:12' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS832', N'Nguy?n T�ng L�m', N'N?', N'1955', N'B?c Giang', N'PG', CAST(N'00:04:24' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS834', N'Nguy?n Vu Tu?ng Vi', N'Nam', N'1957', N'Th?a Thi�n Hu?', N'DG', CAST(N'00:06:06' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS835', N'�o�n �an Thanh', N'Nam', N'1966', N'B� R?a - Vung T�u', N'DY', CAST(N'00:06:58' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS839', N'Nguy?n T?n L?i', N'Nam', N'1987', N'H�a B�nh', N'D_', CAST(N'00:08:05' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS840', N'Nguy?n L� Tu?n Th�nh', N'Nam', N'1976', N'H� Tinh', N'D@', CAST(N'00:06:01' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS842', N'Nguy?n Ho�ng Ng�n H�', N'Nam', N'1965', N'�?ng Nai', N'DD', CAST(N'00:04:56' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS843', N'Phan B?o Ng?c', N'Nam', N'1988', N'�i?n Bi�n', N'DV', CAST(N'00:05:48' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS844', N'Ho�ng B?o H�n', N'Nam', N'1965', N'Ti?n Giang', N'PI', CAST(N'00:03:10' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS846', N'Nguy?n Minh Thu', N'Nam', N'1958', N'Son La', N'YHGD', CAST(N'00:03:58' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS847', N'Nguy?n Th? M? Ti�n', N'Nam', N'1955', N'Th�i Nguy�n', N'D4', CAST(N'00:04:13' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS862', N'Duong Minh Chi?n', N'Nam', N'1977', N'B?c Giang', N'D?', CAST(N'00:08:49' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS864', N'V� Th? Huy?n Tr�n', N'Nam', N'1958', N'Ph� Th?', N'UB', CAST(N'00:08:12' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS866', N'Tr?n Th? Thanh T�m', N'N?', N'1987', N'H� Nam', N'D]', CAST(N'00:04:04' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS867', N'Luong Gia B?o', N'N?', N'1976', N'Qu?ng B�nh	', N'P2', CAST(N'00:08:05' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS868', N'Nguy?n Th? H?ng', N'Nam', N'1967', N'H�a B�nh', N'DD', CAST(N'00:03:44' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS871', N'L� Ng?c Kim Thoa', N'Nam', N'1985', N'�� N?ng', N'PK', CAST(N'00:05:57' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS880', N'Tr?n Anh Thu', N'N?', N'1956', N'�?ng Nai', N'DR', CAST(N'00:08:39' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS882', N'�? L� Minh Thu?n', N'N?', N'1977', N'H� Nam', N'D5', CAST(N'00:04:56' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS887', N'Phan Trung H?u', N'N?', N'1967', N'H� Giang	', N'PR', CAST(N'00:08:24' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS888', N'L� Song S?t', N'Nam', N'1985', N'H� N?i', N'P@', CAST(N'00:04:28' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS889', N'L� Song Dong', N'Nam', N'1985', N'H� N?i', N'P@', CAST(N'00:07:00' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS892', N'V� Minh T�m', N'Nam', N'1967', N'H�a B�nh', N'KBTS', CAST(N'00:07:20' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS895', N'Hu?nh Nhu', N'Nam', N'1988', N'Qu?ng Ng�i', N'PV', CAST(N'00:08:25' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS901', N'L� Th? B?o Chi�u', N'Nam', N'1977', N'Th�i B�nh', N'PS', CAST(N'00:07:25' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS904', N'T�n Nguy?n Thu? Trang', N'Nam', N'1957', N'Thanh H�a', N'P!', CAST(N'00:08:06' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS912', N'C�i Th? Th�nh �nh', N'N?', N'1977', N'B?c Giang', N'0D03', CAST(N'00:05:39' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS914', N'V� Van Son', N'Nam', N'1967', N'�?k L?k', N'PQ', CAST(N'00:07:50' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS916', N'L� ��nh Ph�c', N'Nam', N'1975', N'Kh�nh H�a', N'PK', CAST(N'00:08:00' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS922', N'Ng� Qu?c An', N'Nam', N'1988', N'S�c Trang', N'PN', CAST(N'00:05:20' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS937', N'V� Qu?nh Mai', N'Nam', N'1966', N'Th�i B�nh', N'PHCN', CAST(N'00:05:02' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS948', N'Tr?n Ph?m Hi?n Anh', N'Nam', N'1967', N'L�m �?ng', N'DC', CAST(N'00:06:04' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS956', N'Nguy?n �?c Duy', N'N?', N'1965', N'�?k L?k', N'D@', CAST(N'00:03:31' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS968', N'Hu?nh Hi?u Thu?n', N'Nam', N'1965', N'Ninh Thu?n', N'D_', CAST(N'00:03:53' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS970', N'Tang H? Gia H�n', N'N?', N'1958', N'Vinh Ph�c', N'DN', CAST(N'00:03:07' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS976', N'V� Minh Tu?n', N'N?', N'1987', N'Ninh Thu?n', N'PM', CAST(N'00:03:04' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS978', N'Ph?m Nguy?n Thanh Th?o', N'Nam', N'1966', N'�i?n Bi�n', N'A0', CAST(N'00:07:46' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS985', N'Nguy?n Phan Qu?c Trung', N'Nam', N'1988', N'H?i Ph�ng', N'PHCN', CAST(N'00:06:16' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS989', N'Vu Tu?n K?', N'Nam', N'1989', N'BRVT', N'PD', CAST(N'00:05:29' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS990', N'Vu Tu?n Son', N'Nam', N'1988', N'BRVT', N'PD', CAST(N'00:07:23' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS991', N'Vu Thanh K?', N'Nam', N'1987', N'BRVT', N'PD', CAST(N'00:08:15' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS992', N'Vu Nam K?', N'Nam', N'1989', N'BRVT', N'PD', CAST(N'00:05:48' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS993', N'L� Nam', N'Nam', N'1989', N'BRVT', N'PD', CAST(N'00:04:49' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS994', N'L� Ki Ma', N'Nam', N'1988', N'H� N?i', N'PD', CAST(N'00:08:07' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS995', N'Di?p Ng� Gia Ph�t', N'Nam', N'1955', N'H?i Ph�ng', N'PS', CAST(N'00:07:54' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS996', N'L� H�n Qu?c', N'Nam', N'1989', N'BRVT', N'PD', CAST(N'00:03:13' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS997', N'L� Qu?c Trung', N'Nam', N'1957', N'S�c Trang', N'DT', CAST(N'00:05:48' AS Time))
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
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21114', N'Nguy?n', N'Tu?n', N'Mai', N'4862121655', N'Nam', CAST(N'1967-07-03' AS Date), N'Ph� Y�n	', N'N?i tr?', N'0975157057', N'Lai Ch�u')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21122', N'B�i', N'Minh', N'Linh', N'4893514419', N'N?', CAST(N'1972-08-26' AS Date), N'�?k L?k', N'C�ng nh�n', N'0934452072', N'�?k L?k')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21123', N'Ng�', N'Minh', N'Trinh', N'7349456327', N'N?', CAST(N'1990-01-14' AS Date), N'Qu?ng Tr?', N'N?i tr?', N'0995649378', N'Long An')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21125', N'L�', N'Minh', N'Kim', N'6379372917', N'N?', CAST(N'1997-05-18' AS Date), N'Qu?ng Tr?', N'Bu�n b�n', N'0959178573', N'Lai Ch�u')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21126', N'Cao', N'Minh', N'Son', N'1832913573', N'N?', CAST(N'1966-04-10' AS Date), N'Ph� Th?', N'Thuong nh�n', N'0982612033', N'Qu?ng Ninh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21131', N'Tr?n', N'Quang', N'T�', N'9536568382', N'Nam', CAST(N'1995-12-06' AS Date), N'�� N?ng', N'N�ng d�n', N'0950212119', N'T�y Ninh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21132', N'Tr?nh', N'Van', N'Minh', N'5666319187', N'Nam', CAST(N'1975-03-24' AS Date), N'B�nh Phu?c', N'C�ng ch?c', N'0953138366', N'H�a B�nh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21135', N'Tr?n', N'Cao ', N'Son', N'3153624212', N'N?', CAST(N'1995-02-13' AS Date), N'H?i Ph�ng', N'N?i tr?', N'0989986512', N'Qu?ng Ninh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21136', N'Tr?nh', N'Mai', N'Son', N'4675894136', N'N?', CAST(N'1987-10-24' AS Date), N'Th?a Thi�n Hu?', N'N?i tr?', N'0927527238', N'H�a B�nh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21143', N'Cao', N'H?u', N'H�a', N'5886516914', N'N?', CAST(N'1991-02-15' AS Date), N'Cao B?ng', N'Y t�', N'0985984018', N'Ki�n Giang')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21144', N'B�i', N'Th�i', N'T�m', N'3121586764', N'Nam', CAST(N'1978-11-20' AS Date), N'B?n Tre', N'C�ng an', N'0912296525', N'Kh�nh H�a')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21151', N'V�', N'Van', N'�n', N'4723557385', N'Nam', CAST(N'1984-11-22' AS Date), N'H� Giang	', N'C�ng ch?c', N'0941779003', N'H� N?i')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21166', N'Ph�ng', N'Kim', N'Kh�i', N'5789438494', N'Nam', CAST(N'1983-08-08' AS Date), N'B�nh �?nh', N'Y t�', N'0972745130', N'�i?n Bi�n')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21213', N'Duong', N'Quang', N'B?c', N'3842923251', N'Nam', CAST(N'1993-01-10' AS Date), N'B?n Tre', N'N�ng d�n', N'0977466161', N'Kh�nh H�a')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21214', N'Phan', N'Thanh', N'Huy?n', N'8365215959', N'N?', CAST(N'1995-02-12' AS Date), N'Ki�n Giang', N'Gi�o vi�n', N'0970019432', N'B�nh Duong')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21222', N'L�', N'Th�nh', N'Kh�i', N'6923224794', N'N?', CAST(N'1994-02-25' AS Date), N'C� Mau', N'C�ng an', N'0925072429', N'Ninh B�nh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21226', N'Ng�', N'Ng?c', N'Trinh', N'5566372637', N'Nam', CAST(N'1970-02-04' AS Date), N'C?n Tho', N'Bu�n b�n', N'0909452721', N'B�nh Phu?c')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21234', N'B�i', N'Th�i', N'Khoa', N'1913356584', N'Nam', CAST(N'1976-08-31' AS Date), N'B?c Ninh', N'Y t�', N'0932290732', N'H� N?i')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21235', N'Tr?n', N'Th? ', N'Huy?n', N'9146633382', N'Nam', CAST(N'1973-05-15' AS Date), N'Hung Y�n', N'N�ng d�n', N'0949646624', N'Th�i Nguy�n')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21236', N'Ng�', N'Th? Th�y', N'H?i', N'9695436179', N'Nam', CAST(N'1974-03-20' AS Date), N'Ki�n Giang', N'D�n ph�ng', N'0944595707', N'H?i Ph�ng')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21241', N'Phan', N'Phuong', N'My', N'6864415425', N'Nam', CAST(N'1969-10-29' AS Date), N'B?c Ninh', N'C�ng ch?c', N'0959558054', N'H?u Giang')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21252', N'Truong', N'Truong', N'My', N'2219436251', N'N?', CAST(N'1984-11-26' AS Date), N'�?ng Nai', N'Thuong nh�n', N'0983685965', N'B� R?a - Vung T�u')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21253', N'Vu', N'Truong', N'H?i', N'4836456682', N'Nam', CAST(N'1985-07-20' AS Date), N'C� Mau', N'Y t�', N'0917747090', N'Long An')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21254', N'Truong', N'Thanh', N'Minh', N'7897437146', N'Nam', CAST(N'1987-04-02' AS Date), N'L�o Cai', N'Y t�', N'0909938270', N'Ninh Thu?n')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21255', N'Tr?nh', N'Th? ', N'Son', N'4344664925', N'Nam', CAST(N'1985-12-09' AS Date), N'Thanh H�a', N'D�n ph�ng', N'0925957077', N'Ph� Y�n	')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21256', N'Truong', N'Cao ', N'Khoa', N'4532246311', N'N?', CAST(N'1992-09-15' AS Date), N'Qu?ng B�nh	', N'C�ng an', N'0907204801', N'Ngh? An')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21261', N'Vu', N'Van', N'Son', N'6217878111', N'Nam', CAST(N'1979-06-01' AS Date), N'Ph� Y�n	', N'N?i tr?', N'0939645506', N'Kh�nh H�a')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21264', N'Ph?m', N'Minh', N'Minh', N'7232788897', N'N?', CAST(N'1975-10-31' AS Date), N'�?k N�ng', N'D�n ph�ng', N'0925717848', N'L�m �?ng')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21313', N'Duong', N'Cao ', N'K?', N'8289666326', N'Nam', CAST(N'1988-02-26' AS Date), N'Nam �?nh', N'D�n ph�ng', N'0939054529', N'�i?n Bi�n')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21315', N'Phan', N'Mai', N'Khoa', N'9589543323', N'Nam', CAST(N'1967-04-12' AS Date), N'B�nh Phu?c', N'N�ng d�n', N'0985038615', N'B�nh Phu?c')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21321', N'V�', N'Truong', N'My', N'4387662684', N'Nam', CAST(N'1980-07-22' AS Date), N'H?i Duong', N'Thuong nh�n', N'0963241358', N'�� N?ng')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21323', N'B�i', N'Phi', N'Hi?n', N'2764448366', N'N?', CAST(N'1970-01-17' AS Date), N'L?ng Son', N'C�ng ch?c', N'0924150514', N'�?k L?k')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21325', N'Ho�ng', N'Minh', N'H�a', N'4294896484', N'Nam', CAST(N'1997-06-27' AS Date), N'H� Tinh', N'Gi�o vi�n', N'0962423172', N'H?u Giang')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21332', N'Nguy?n', N'Mai', N'Kim', N'1737535241', N'Nam', CAST(N'1992-05-23' AS Date), N'Qu?ng Ninh', N'N�ng d�n', N'0932578002', N'C?n Tho')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21333', N'Ng�', N'Van', N'Minh', N'5533459365', N'N?', CAST(N'1979-06-24' AS Date), N'Kh�nh H�a', N'N�ng d�n', N'0992157091', N'Kon Tum')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21334', N'Tr?n', N'Minh', N'Linh', N'2976687615', N'Nam', CAST(N'1965-05-13' AS Date), N'�� N?ng', N'D�n ph�ng', N'0917337612', N'Vinh Ph�c')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21335', N'L�', N'Th�nh', N'Vinh', N'9219375274', N'Nam', CAST(N'1996-02-18' AS Date), N'Ph� Th?', N'Y t�', N'0961712861', N'Vinh Long')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21342', N'Ph�ng', N'Ng?c', N'Chinh', N'3552824116', N'Nam', CAST(N'1996-01-02' AS Date), N'Qu?ng B�nh	', N'N?i tr?', N'0902191766', N'Long An')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21344', N'Ph?m', N'Quang', N'Huy?n', N'1379488199', N'Nam', CAST(N'1971-04-21' AS Date), N'Thanh H�a', N'Bu�n b�n', N'0999926310', N'Vinh Ph�c')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21345', N'L�', N'Ng?c', N'Nh?t', N'9724554756', N'Nam', CAST(N'1977-05-12' AS Date), N'Ph� Th?', N'Y t�', N'0997416086', N'Long An')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21352', N'Duong', N'Mai', N'H?i', N'3369821591', N'Nam', CAST(N'1980-09-28' AS Date), N'B?c Li�u', N'N?i tr?', N'0988170895', N'Th�i Nguy�n')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21353', N'Nguy?n', N'Minh', N'H�a', N'5786998515', N'N?', CAST(N'1970-05-06' AS Date), N'Y�n B�i', N'C�ng an', N'0970639568', N'H�a B�nh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21354', N'Nguy?n', N'Van', N'Nh?t', N'1427117945', N'Nam', CAST(N'1982-08-27' AS Date), N'Vinh Ph�c', N'N�ng d�n', N'0943120311', N'L�o Cai')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21355', N'Duong', N'Th�i', N'Nam', N'9794181951', N'Nam', CAST(N'1969-10-08' AS Date), N'Long An', N'Y t�', N'0956301248', N'T�y Ninh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21363', N'Ng�', N'Th�nh', N'Minh', N'4836476358', N'Nam', CAST(N'1989-10-08' AS Date), N'�?ng Th�p', N'Bu�n b�n', N'0932265878', N'Cao B?ng')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21411', N'Tr?n', N'Phi', N'Nh?t', N'4879385887', N'Nam', CAST(N'1972-11-03' AS Date), N'An Giang', N'Gi�o vi�n', N'0989862861', N'B�nh �?nh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21414', N'B�i', N'Th? Th�y', N'H�a', N'2963733668', N'N?', CAST(N'1985-05-06' AS Date), N'Kh�nh H�a', N'C�ng nh�n', N'0988348222', N'Th?a Thi�n Hu?')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21415', N'Phan', N'Van', N'Linh', N'1184685597', N'Nam', CAST(N'1965-03-16' AS Date), N'Cao B?ng', N'N?i tr?', N'0960170841', N'B�nh Phu?c')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21416', N'Cao', N'Th�i', N'Son', N'2476794632', N'Nam', CAST(N'1989-08-02' AS Date), N'B?c K?n', N'Bu�n b�n', N'0995785455', N'B?c Li�u')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21424', N'Duong', N'Minh', N'Son', N'5646516625', N'Nam', CAST(N'1965-07-02' AS Date), N'L�m �?ng', N'C�ng an', N'0927949641', N'Th�i B�nh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21425', N'Cao', N'Ng?c', N'Nh?t', N'8362847275', N'Nam', CAST(N'1991-06-12' AS Date), N'�i?n Bi�n', N'Y t�', N'0927293850', N'B�nh Thu?n')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21432', N'Nguy?n', N'Th�nh', N'�n', N'7682555379', N'Nam', CAST(N'1970-08-17' AS Date), N'S�c Trang', N'Y t�', N'0980991746', N'Ninh B�nh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21435', N'Ph?m', N'Ng?c', N'Khoa', N'6898739343', N'N?', CAST(N'1993-11-05' AS Date), N'Ngh? An', N'N?i tr?', N'0908303560', N'Th�i Nguy�n')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21441', N'Ho�ng', N'Minh', N'Minh', N'9114129434', N'N?', CAST(N'1968-08-31' AS Date), N'H� N?i', N'Gi�o vi�n', N'0925925095', N'Lai Ch�u')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21442', N'Truong', N'Phi', N'T�m', N'5469326865', N'Nam', CAST(N'1965-07-16' AS Date), N'S�c Trang', N'C�ng ch?c', N'0963346289', N'H?i Ph�ng')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21444', N'B�i', N'Th�i', N'Minh', N'6318212465', N'N?', CAST(N'1978-04-26' AS Date), N'L�o Cai', N'Gi�o vi�n', N'0943822211', N'Hung Y�n')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21451', N'L�', N'Kim', N'An', N'1612269911', N'Nam', CAST(N'1990-07-19' AS Date), N'S�c Trang', N'Bu�n b�n', N'0987854867', N'Nam �?nh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21456', N'Tr?nh', N'Th? ', N'Vinh', N'8241979415', N'Nam', CAST(N'1983-12-21' AS Date), N'An Giang', N'Thuong nh�n', N'0901444697', N'B?c Giang')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21464', N'B�i', N'Quang', N'Nam', N'5577685288', N'Nam', CAST(N'1994-12-18' AS Date), N'Qu?ng Nam', N'D�n ph�ng', N'0964581975', N'Ph� Th?')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21466', N'Ph?m', N'Kim', N'Huy?n', N'9528636831', N'Nam', CAST(N'1969-12-11' AS Date), N'B?c Giang', N'Bu�n b�n', N'0934235346', N'Th�i Nguy�n')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21511', N'Ho�ng', N'Th? Th�y', N'Anh', N'8975952845', N'Nam', CAST(N'1990-08-17' AS Date), N'C� Mau', N'Y t�', N'0904239151', N'Th?a Thi�n Hu?')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21512', N'Ph?m', N'Mai', N'H?i', N'5417269351', N'N?', CAST(N'1979-09-13' AS Date), N'Thanh H�a', N'Bu�n b�n', N'0951253126', N'�?k L?k')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21514', N'Duong', N'Truong', N'Minh', N'5531447324', N'N?', CAST(N'1967-03-16' AS Date), N'T�y Ninh', N'C�ng ch?c', N'0934669773', N'Hung Y�n')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21516', N'Ph�ng', N'Van', N'Mai', N'9968111836', N'N?', CAST(N'1975-10-13' AS Date), N'Vinh Ph�c', N'Y t�', N'0943139612', N'Vinh Long')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21522', N'Duong', N'Quang', N'Nam', N'3796436687', N'N?', CAST(N'1994-04-17' AS Date), N'H?i Ph�ng', N'Y t�', N'0926806729', N'Tr� Vinh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21526', N'Ho�ng', N'Th? ', N'Trinh', N'9344766723', N'Nam', CAST(N'1995-05-20' AS Date), N'H?i Ph�ng', N'C�ng nh�n', N'0941555019', N'�?k N�ng')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21533', N'Cao', N'Phuong', N'Quang', N'2926551229', N'Nam', CAST(N'1984-10-30' AS Date), N'B?c Ninh', N'D�n ph�ng', N'0975844207', N'B?c Li�u')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21534', N'L�', N'Minh', N'Huy?n', N'1871135746', N'N?', CAST(N'1967-03-01' AS Date), N'Hung Y�n', N'N�ng d�n', N'0913321979', N'Nam �?nh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21541', N'Phan', N'Van', N'Khoa', N'9584736669', N'Nam', CAST(N'1970-01-17' AS Date), N'C� Mau', N'C�ng nh�n', N'0904027887', N'Ki�n Giang')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21545', N'B�i', N'Truong', N'Son', N'2771826577', N'Nam', CAST(N'1970-09-30' AS Date), N'�� N?ng', N'C�ng nh�n', N'0944317491', N'Qu?ng Ninh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21546', N'Phan', N'Ng?c', N'Anh', N'7485283371', N'Nam', CAST(N'1989-10-29' AS Date), N'Ph� Th?', N'N�ng d�n', N'0980139551', N'B�nh Thu?n')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21551', N'Ph?m', N'Van', N'Son', N'8248377286', N'Nam', CAST(N'1992-01-07' AS Date), N'Th�i Nguy�n', N'C�ng an', N'0917231031', N'B�nh �?nh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21554', N'Cao', N'Cao ', N'�n', N'8448653863', N'N?', CAST(N'1975-07-02' AS Date), N'B�nh Duong', N'C�ng an', N'0985038974', N'Ti?n Giang')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21555', N'Ph�ng', N'Kim', N'Son', N'9266144911', N'N?', CAST(N'1988-02-01' AS Date), N'H� Giang	', N'C�ng an', N'0948122974', N'L�o Cai')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21556', N'Cao', N'Minh', N'Vinh', N'2311741943', N'N?', CAST(N'1980-02-16' AS Date), N'L�m �?ng', N'C�ng ch?c', N'0998376431', N'TP HCM')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21563', N'Ng�', N'Minh', N'Hi?n', N'6554783213', N'Nam', CAST(N'1975-08-02' AS Date), N'B�nh �?nh', N'C�ng nh�n', N'0912590314', N'Qu?ng Ninh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21564', N'B�i', N'Ng?c', N'An', N'3931823557', N'Nam', CAST(N'1991-04-21' AS Date), N'L?ng Son', N'N?i tr?', N'0964701856', N'B�nh Duong')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21566', N'Cao', N'Cao ', N'Minh', N'1754125729', N'Nam', CAST(N'1990-09-12' AS Date), N'Tr� Vinh', N'N?i tr?', N'0989096761', N'H?i Duong')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21611', N'Cao', N'Minh', N'K?', N'6674735171', N'N?', CAST(N'1988-06-05' AS Date), N'Kh�nh H�a', N'Thuong nh�n', N'0920589994', N'Hung Y�n')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21612', N'Truong', N'Kim', N'My', N'5815273826', N'Nam', CAST(N'1996-07-26' AS Date), N'B?c Ninh', N'Thuong nh�n', N'0981933172', N'Y�n B�i')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21614', N'Ph?m', N'Phuong', N'Vinh', N'7559383219', N'Nam', CAST(N'1994-06-14' AS Date), N'Y�n B�i', N'D�n ph�ng', N'0964256322', N'Ph� Th?')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21616', N'Truong', N'Th? Th�y', N'My', N'1278794667', N'N?', CAST(N'1971-04-03' AS Date), N'T�y Ninh', N'C�ng ch?c', N'0975023228', N'S�c Trang')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21632', N'L�', N'H?u', N'K?', N'6894716866', N'N?', CAST(N'1980-05-30' AS Date), N'Qu?ng B�nh	', N'C�ng nh�n', N'0904388280', N'B�nh Phu?c')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21634', N'V�', N'Phuong', N'Vinh', N'1481213286', N'Nam', CAST(N'1990-04-11' AS Date), N'L?ng Son', N'C�ng an', N'0972903366', N'B� R?a - Vung T�u')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21635', N'Phan', N'Th? ', N'Nh?t', N'6491586614', N'Nam', CAST(N'1975-07-24' AS Date), N'Qu?ng Ng�i', N'Y t�', N'0911352925', N'H� Tinh')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21641', N'Tr?nh', N'Kim', N'Nam', N'7889845443', N'N?', CAST(N'1982-06-02' AS Date), N'T�y Ninh', N'C�ng nh�n', N'0921541340', N'B?c Giang')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21642', N'Nguy?n', N'Quang', N'T�', N'3799187664', N'N?', CAST(N'1992-07-11' AS Date), N'Qu?ng Ninh', N'Bu�n b�n', N'0913650155', N'�i?n Bi�n')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21644', N'Ho�ng', N'Kim', N'Thu', N'3914913142', N'N?', CAST(N'1982-09-14' AS Date), N'H� Tinh', N'N�ng d�n', N'0965327689', N'Ti?n Giang')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21645', N'Ng�', N'Ng?c', N'Kh�i', N'8696238352', N'Nam', CAST(N'1993-05-12' AS Date), N'Tr� Vinh', N'C�ng an', N'0961659981', N'Vinh Ph�c')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21646', N'B�i', N'Ng?c', N'Nh?t', N'5727379978', N'N?', CAST(N'1976-11-29' AS Date), N'B?c Ninh', N'N�ng d�n', N'0999689833', N'Ninh Thu?n')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21652', N'Ho�ng', N'Van', N'Nam', N'2987942377', N'Nam', CAST(N'1997-04-08' AS Date), N'H?u Giang', N'C�ng nh�n', N'0926524444', N'Qu?ng Tr?')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21661', N'Ho�ng', N'Cao ', N'Thu', N'2866478115', N'Nam', CAST(N'1966-03-09' AS Date), N'Ninh Thu?n', N'D�n ph�ng', N'0941567438', N'Thanh H�a')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21676', N'L�', N'Quang', N'Nh?t', N'273620258', N'Nam', CAST(N'1997-05-25' AS Date), N'Ninh THu?n', N'Sinh Vi�n', N'953621258', N'TP HCM')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21677', N'L�', N'Quang', N'Anh', N'273620259', N'Nam', CAST(N'1989-03-27' AS Date), N'�� L?t', N'Gi�o Vi�n', N'987652258', N'TP HCM')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21678', N'V�', N'Nh�n', N'Ng?c', N'273620278', N'Nam', CAST(N'1988-05-02' AS Date), N'BRVT', N'K? Su', N'989625123', N'TP HCM')
INSERT [dbo].[BenhNhan] ([ID], [Ho], [TenLot], [Ten], [CMND_CCCD], [GioiTinh], [NgaySinh], [QueQuan], [NgheNghiep], [SDT], [Diachi]) VALUES (N'BN21679', N'L�', N'Th?', N'��o', N'273620268', N'N?', CAST(N'1980-08-25' AS Date), N'Phan Thi?t', N'N?i Tr?', N'988856253', N'TP HCM')
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10001', N'GGI1', N'XNPH10001', CAST(N'2019-05-24T16:45:47.517' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10001', N'GGI2', N'XNPH10001', CAST(N'2019-05-24T16:46:40.360' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10001', N'GGI3', N'XNPH10001', CAST(N'2019-05-24T16:46:44.207' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10002', N'GGI3', N'XNPH10002', CAST(N'2019-05-24T16:46:57.537' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10003', N'GGI3', N'XNPH10003', CAST(N'2019-05-24T16:47:05.250' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10004', N'GGI1', N'XNPH10004', CAST(N'2019-05-24T15:01:03.600' AS DateTime))
INSERT [dbo].[CaKham] ([IDCa], [TenCa], [GioBatDau], [GioKetThuc]) VALUES (1, N'S�ng', N'7:00 AM', N'12:00 AM')
INSERT [dbo].[CaKham] ([IDCa], [TenCa], [GioBatDau], [GioKetThuc]) VALUES (2, N'Chi?u', N'1:00 PM', N'6:00 PM')
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'0D03', N'Khoa ch?n do�n h�nh ?nh', 5, 1, 0, 1)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'0UGM', N'UNG BU?U GAN M?T V� GH�P GAN', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'A0', N'KHOA KH�M S?C KH?E THEO Y�U C?U', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'CKQT', N'PK QU?C T? (CHUY�N KHOA)', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D-', N'DV PK DA LI?U', 5, 3, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D!', N'DV PK N?I TI?T', 5, 3, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D$', N'DV PH�NG KH�M NI?U', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D&', N'�ON V? HUY?T H?C', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D(', N'D? ?NG - MD L�M S�NG', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D)', N'H�A TR?', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D*', N'D?CH V? PH�NG HIFU', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D?', N'Y H?C C? TRUY?N', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D@', N'D?CH V? KHOA PT TIM', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D[', N'X�T NGHI?M T?I KHOA', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D]', N'CH�CH NG?A', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D^', N'DV PK TI�U HO�', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D_', N'DV PK NAM KHOA', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D+', N'KHOA PH?C H?I CH?C NANG', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D<', N'KHOA GI?I PH?U B?NH', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D0', N'DV PK H?U M�N', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D3', N'D?CH V? PK TH?N KINH', 5, 3, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D4', N'DV PH�NG KH�M KH?P', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D5', N'DV KH�M T?NG QU�T', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D6', N'DV PH�NG KH�M TIM M?CH', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D7', N'DV PH�NG B� B?T', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D8', N'DV PH�NG CHAM S�C DA', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D9', N'DV PK T?O H�NH-TH?M M?', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DA', N'X - QUANG', 5, 1, 0, 1)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DB', N'N?I SOI', 5, 1, 0, 1)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DC', N'SI�U �M', 5, 1, 0, 1)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DD', N'SI�U �M TIM', 5, 2, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DE', N'�O �I?N TIM', 5, 2, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DF', N'THAM D� CH?C NANG', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DG', N'SPECT', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DH', N'X�T NGHI?M', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DI', N'DSA', 5, 2, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DJ', N'XN �U?NG HUY?T', 5, 3, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DK', N'DV KH�M PH?I', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DL', N'DV TAI MUI H?NG', 5, 3, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DM', N'DV PK M?T', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DN', N'RANG H�M M?T', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DP', N'TRI - D� H?U M�N (TT )', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DQ', N'�/T TRUONG L?C CO (L. 1)', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DR', N'DV PK PH? KHOA', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DS', N'D?CH V? PK V� S? 20', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DT', N'D?CH V? C?P C?U', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DTTL', N'TU V?N T�M L�', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DU', N'PK.VI�M GAN', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DV', N'PH�NG CT-SCANNER', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DW', N'PH�NG MRI', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DY', N'PK R?I LO?N �?I TI?N', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'DZ', N'KI?M SO�T NHI?M KHU?N', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'EEG', N'�I?N N�O', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'EMG', N'�I?N CO', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'GN', N'CHAM S�C GI?M NH?', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'HH', N'HUY?T H?C', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'KBTS', N'PH? S?N L?U 2 KHU B', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'KTN', N'TI�M NG?A', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'LM', N'L?NG NG?C - M?CH M�U', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'ND', N'NHI', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'NHCN', N'NI?U H?C CH?C NANG', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'NHI2', N'NHI L?U 2', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'NXK', N'N?I CO XUONG KH?P', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'P!', N'PH?U THU?T H�M M?T - RHM', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'P#', N'D? ?NG - MI?N D?CH L�M S�NG', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'P$', N'NGO?I TH?N KINH', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'P(', N'�AU M?N T�NH', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'P@', N'Y H?C C? TRUY?N', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'P^', N'KH�M V� TU V?N DINH DU?NG', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'P2', N'PARKINSON V� R?I LO?N V?N �?NG', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'P6', N'NAM KHOA', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'P7', N'TI�U H�A GAN M?T', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'P9', N'Y H?C H?T NH�N', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PA', N'S?N - PH? KHOA', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PB', N'DA LI?U', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PC', N'PH?I', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PD', N'TAI MUI H?NG', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PF', N'M?T', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PG', N'VI�M GAN', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PH', N'T?NG QU�T', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PHCN', N'PH?C H?I CH?C NANG', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PI', N'TIM M?CH', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PJ', N'XUONG KH?P CH?NH H�NH', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PK', N'TH?N KINH', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PL', N'N?I TI?T', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PM', N'TI?T NI?U', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PN', N'T�M TH?N KINH', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PO', N'NGO?I TIM M?CH', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PP', N'H?U M�N H?C', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PQ', N'H� H?P', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PR', N'H�A TR?', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PS', N'PH�NG TU V?N', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PT', N'CHAM S�C DA', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PU', N'T?O H�NH - TH?M M?', 1, 3, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PV', N'H. ?NH H?C CAN THI?P', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PW', N'L�O KHOA', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PY', N'V�', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PZ', N'TI?U PH?U', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'TN', N'N?I TH?N', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'TQQT', N'PK QU?C T? (T?NG QU�T)', 1, 1, 0, 2)
GO
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'UB', N'UNG BU?U', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'VT01', N'PH�NG KH�M B?NH VI?N �?I H?C Y DU?C 1', 1, 3, 0, 23)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'YHGD', N'Y H?C GIA ��NH', 1, 3, 0, 2)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'E038', N'N?i soi can thi?p - c?t polyp ?ng ti�u h�a < 1cm', N'MB', 0, CAST(N'00:08:31' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI0', N'Ph? m�u ngo?i bi�n (BV TMHH)', N'GA', 0, CAST(N'00:05:29' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI1', N'X�t nghi?m t? b�o h?c t?y xuong (t?y d?) (BV TMHH)', N'GA', 0, CAST(N'00:05:27' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI2', N'�?nh lu?ng Arsenic nu?c ti?u', N'GA', 0, CAST(N'00:05:54' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI3', N'�?nh lu?ng Arsenic t�c', N'GA', 0, CAST(N'00:08:23' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI4', N'Tia x? t�i m�u', N'GA', 0, CAST(N'00:09:37' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI6', N'BK d�m (PNT)', N'GA', 0, CAST(N'00:07:37' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI8', N'Soi tr?c ti?p nhu?m soi (nhu?m Gram...) (CR)', N'GA', 0, CAST(N'00:10:50' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI9', N'Nu�i c?y v� d?nh danh n?m b?ng phuong ph�p th�ng thu?ng (CR)', N'GA', 0, CAST(N'00:09:15' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGJ1', N'Nu�i c?y d?nh danh vi khu?n b?ng phuong ph�p th�ng thu?ng (CR)', N'GA', 0, CAST(N'00:09:14' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGJ2', N'Kh�ng sinh d? n?m (CR)', N'GA', 0, CAST(N'00:05:25' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGJ3', N'Kh�ng sinh d? vi khu?n (CR)', N'GA', 0, CAST(N'00:07:19' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGJ5', N'X�t nghi?m t�m BK (CR)', N'GA', 0, CAST(N'00:09:54' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGJ6', N'�?nh lu?ng Catecholamin /m�u', N'GA', 0, CAST(N'00:09:50' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGL9', N'Soi m? h?ch, abces t�m BK (N�)', N'GA', 0, CAST(N'00:05:06' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGM0', N'Soi m? t�m n?m (B�)', N'GA', 0, CAST(N'00:05:25' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGM1', N'Soi d?ch v?t thuong t�m BK (N�)', N'GA', 0, CAST(N'00:05:52' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGM2', N'Soi d?ch v?t thuong t�m vi tr�ng (N�)', N'GA', 0, CAST(N'00:08:40' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGM3', N'Soi t�m BK d�m (N�)', N'GA', 0, CAST(N'00:05:08' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'KX11', N'�o m?t d? xuong b?ng phuong ph�p DEXA (c? xuong d�i) v� do chi?u d�i tr? kh?p h�ng (HAL) hai b�n', N'KX', 0, CAST(N'00:10:39' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'KX12', N'�o c�c th�nh ph?n co, m?, xuong to�n th�n ngu?i l?n', N'KX', 0, CAST(N'00:09:05' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'KX14', N'�o m?t d? xuong b?ng phuong ph�p DEXA (CSTL + c? xuong d�i m?t b�n)', N'KX', 0, CAST(N'00:05:04' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MA', N'Ch?p X-Quang d? d�y - t� tr�ng c� u?ng thu?c c?n quang Bary sulfat 275mg s? h�a', N'MA', 0, CAST(N'00:06:07' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MAP6', N'Ch?p X-quang xuong c�nh tay th?ng 1 b�n s? h�a  1 phim', N'MA', 0, CAST(N'00:09:59' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MAP7', N'Ch?p X-quang xuong c�nh tay nghi�ng 1 b�n s? h�a', N'MA', 0, CAST(N'00:07:08' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MAP8', N'Ch?p X-quang kh?p g?i th?ng � nghi�ng 1 b�n (tu th? d?ng) s? h�a  1 phim', N'MA', 0, CAST(N'00:07:07' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MAP9', N'Ch?p X-quang kh?p g?i th?ng � nghi�ng 2 b�n (tu th? d?ng) 2 phim s? h�a  1 phim', N'MA', 0, CAST(N'00:06:46' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MAQ0', N'Ch?p X-quang kh?p g?i nghi�ng 1 b�n (tu th? d?ng) s? h�a  1 phim', N'MA', 0, CAST(N'00:08:37' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MAQ1', N'Ch?p X-quang kh?p g?i th?ng 1 b�n (tu th? d?ng) s? h�a  1 phim', N'MA', 0, CAST(N'00:10:43' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MAQ2', N'Ch?p X-quang luu th�ng ru?t non c� c?n quang tan trong nu?c s? h�a', N'MA', 0, CAST(N'00:05:09' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MB39', N'B? thun th?t tinh m?ch th?c qu?n', N'MB', 0, CAST(N'00:09:29' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MB82', N'N?i soi can thi?p - c?t polyp ?ng ti�u h�a > 1cm ho?c nhi?u polyp', N'MB', 0, CAST(N'00:09:57' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MB84', N'N?i soi ch�ch (ti�m) keo di?u tr? d�n tinh m?ch ph�nh v?', N'MB', 0, CAST(N'00:09:18' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MB86', N'Ch?p du?ng m?t trong m? n?i soi', N'MB', 0, CAST(N'00:06:25' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MB88', N'Ch?p m?t qua Kehr', N'MB', 0, CAST(N'00:06:53' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MB89', N'�?t stent th?c qu?n qua n?i soi.', N'MB', 0, CAST(N'00:09:05' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MB91', N'N?i soi thanh qu?n l?y d? v?t', N'MB', 0, CAST(N'00:05:39' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBA1', N'N?i soi d?i tr?c tr�ng to�n b? ?ng m?m kh�ng sinh thi?t', N'MB', 0, CAST(N'00:10:35' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBA4', N'N?i soi m?t t?y ngu?c d�ng - (ERCP) ch?n do�n', N'MB', 0, CAST(N'00:05:50' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBC8', N'N?i soi thanh qu?n ?ng m?m sinh thi?t', N'MB', 0, CAST(N'00:05:08' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBD0', N'N?i soi can thi?p - th?t b�i gi�n tinh m?ch th?c qu?n b?ng v�ng cao su', N'MB', 0, CAST(N'00:10:53' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBD1', N'Ti�m ho?c k?p c?m m�u qua n?i soi d? d�y', N'MB', 0, CAST(N'00:06:11' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBD2', N'Ti�m ho?c k?p c?m m�u qua n?i soi d?i tr�ng', N'MB', 0, CAST(N'00:07:09' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBD5', N'N?i soi nong h?p mi?ng n?i ru?t-ru?t ho?c m?t-ru?t', N'MB', 0, CAST(N'00:05:04' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBE0', N'N?i soi th?c qu?n - d? d�y - t� tr�ng kh�ng sinh thi?t (?ng m?m, g�y m�)', N'MB', 0, CAST(N'00:08:55' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBE1', N'N?i soi d?i tr?c tr�ng to�n b? ?ng m?m kh�ng sinh thi?t (g�y m�)', N'MB', 0, CAST(N'00:08:16' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBE3', N'N?i soi th?c qu?n-d? d�y, l?y d? v?t', N'MB', 0, CAST(N'00:08:56' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBE5', N'N?i soi can thi?p - g?p giun, d? v?t ?ng ti�u h�a', N'MB', 0, CAST(N'00:06:03' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBE7', N'N?i soi can thi?p - c?m m�u ?ng ti�u h�a b?ng laser argon', N'MB', 0, CAST(N'00:10:08' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBE8', N'N?i soi ph? qu?n ?ng m?m (g�y m�)', N'MB', 0, CAST(N'00:08:27' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBE9', N'N?i soi th?c qu?n- d? d�y- t� tr�ng kh�ng sinh thi?t (?ng m?m)', N'MB', 0, CAST(N'00:10:59' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBF0', N'N?i soi th?c qu?n- d? d�y- t� tr�ng c� th? k?t h?p sinh thi?t (?ng m?m, g�y m�)', N'MB', 0, CAST(N'00:05:58' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBF1', N'N?i soi d?i tr?c tr�ng ?ng m?m g�y m� (c� thu?c, c� sinh thi?t)', N'MB', 0, CAST(N'00:07:10' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBF2', N'N?i soi d?i tr?c tr�ng ?ng m?m g�y m� (kh�ng thu?c, kh�ng sinh thi?t)', N'MB', 0, CAST(N'00:05:07' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBF3', N'N?i soi d?i tr?c tr�ng ?ng m?m g�y m� (kh�ng thu?c, c� sinh thi?t)', N'MB', 0, CAST(N'00:08:18' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBH0', N'K? thu?t m? co qua n?i soi du?ng mi?ng di?u tr? co th?t t�m v?', N'MB', 0, CAST(N'00:10:22' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC60', N'Ch?c h�t t? b�o tuy?n gi�p du?i hu?ng d?n si�u �m', N'MC', 0, CAST(N'00:10:49' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC61', N'Bom nu?c l�ng t? cung (SHG) qua si�u �m', N'MC', 0, CAST(N'00:06:44' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC65', N'Ch?c FNA >=2 nh�n qua si�u �m', N'MC', 0, CAST(N'00:08:57' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC66', N'Ch?c FNA 1 nh�n qua si�u �m', N'MC', 0, CAST(N'00:05:54' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC67', N'Ch?c h�t d?ch ( ? b?ng, m�ng ph?i) qua si�u �m', N'MC', 0, CAST(N'00:06:56' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC68', N'Ch?c h�t nang v� du?i hu?ng d?n si�u �m', N'MC', 0, CAST(N'00:09:14' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC69', N'�?t s�ng cao t?n di?u tr? ung thu gan (RFA) du?i hu?ng d?n si�u �m', N'MC', 0, CAST(N'00:08:44' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC72', N'Si�u �m Doppler tinh ho�n, m�o tinh ho�n hai b�n', N'MC', 0, CAST(N'00:05:13' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC73', N'Si�u �m ? b?ng', N'MC', 0, CAST(N'00:07:47' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC74', N'Si�u �m m?t (si�u �m thu?ng qui) (1 m?t)', N'MC', 0, CAST(N'00:10:59' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC75', N'Si�u �m m?t (si�u �m thu?ng qui) (2 m?t)', N'MC', 0, CAST(N'00:05:26' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC81', N'Si�u �m ? b?ng (do th? t�ch nu?c ti?u)', N'MC', 0, CAST(N'00:08:43' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC88', N'Si�u �m 3D/4D tim', N'MC', 0, CAST(N'00:05:20' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC89', N'Si�u �m ph?n m?m', N'MC', 0, CAST(N'00:09:18' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC90', N'Si�u �m 3D/4D tr?c tr�ng', N'MC', 0, CAST(N'00:10:02' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC91', N'Si�u �m m?t (l?y th�ng s? m? c?n th?)', N'MC', 0, CAST(N'00:10:18' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC92', N'Si�u �m m?t (do k�nh n?i nh�n)', N'MC', 0, CAST(N'00:10:41' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC93', N'Si�u �m ph? khoa ng� H.m�n-T.Tr�ng (m�u)', N'MC', 0, CAST(N'00:05:06' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC94', N'Si�u �m ph? khoa ng� H.m�n-T.Tr�ng (tr?ng den)', N'MC', 0, CAST(N'00:06:50' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MCD0', N'Si�u �m thai (thai, nhau thai, nu?c ?i)', N'MC', 0, CAST(N'00:06:13' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MCD1', N'Si�u �m Doppler thai nhi (thai, nhau thai, d�y r?n, d?ng m?ch t? cung)', N'MC', 0, CAST(N'00:05:13' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MCD2', N'Si�u �m thai nhi trong 3 th�ng d?u (Si�u �m kh?o s�t h�nh th�i h?c)', N'MC', 0, CAST(N'00:09:43' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF15', N'Ch?p d�y m?t kh�ng hu?nh quang', N'MF', 0, CAST(N'00:06:01' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF16', N'Ch?p d�y m?t kh�ng hu?nh quang (m�u)', N'MF', 0, CAST(N'00:09:28' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF17', N'D?u hi?u sinh t?n t?i ph�ng kh�m TDCNHH', N'MF', 0, CAST(N'00:06:03' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF20', N'�i?n tim thu?ng (ECG)', N'MF', 0, CAST(N'00:09:58' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF21', N'Nghi?m ph�p g?ng s?c di?n t�m d?', N'MF', 0, CAST(N'00:06:45' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF22', N'�o �p l?c h?u m�n tr?c tr�ng', N'MF', 0, CAST(N'00:05:07' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF26', N'�o �i?n co (EMG)', N'MF', 0, CAST(N'00:05:29' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF28', N'�o �i?n n�o (EEG)', N'MF', 0, CAST(N'00:09:20' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF29', N'�o d? l?i m?t', N'MF', 0, CAST(N'00:10:35' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF30', N'�o h� h?p k� to�n di?n', N'MF', 0, CAST(N'00:06:18' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF32', N'Holter di?n t�m d?', N'MF', 0, CAST(N'00:09:44' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF52', N'�i?n tim thu?ng t?i giu?ng', N'MF', 0, CAST(N'00:08:50' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF58', N'Holter huy?t �p', N'MF', 0, CAST(N'00:07:02' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF59', N'�o n?ng d? ch?t Indocyanine Green (ICG)', N'MF', 0, CAST(N'00:06:50' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF60', N'�o ch? s? ABI (ch? s? c? ch�n/c�nh tay)', N'MF', 0, CAST(N'00:09:38' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF61', N'�o th�nh ph?n co th?', N'MF', 0, CAST(N'00:07:17' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF62', N'Ghi di?n n�o thu?ng quy (�i?n n�o thu?ng quy t?i giu?ng)', N'MF', 0, CAST(N'00:07:07' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF63', N'Ghi di?n n�o gi?c ng? (�i?n n�o gi?c ng? ng?n 60 ph�t)', N'MF', 0, CAST(N'00:08:50' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF71', N'Ghi di?n n�o video (�i?n n�o video 24 gi? t?i giu?ng)', N'MF', 0, CAST(N'00:05:34' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF72', N'Ghi di?n co (�i?n co t?i giu?ng)', N'MF', 0, CAST(N'00:10:56' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MG92', N'X? h�nh xuong 3 pha v?i Tc99m MDP', N'MG', 0, CAST(N'00:07:55' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MH21', N'Ion d? (Na+, K+, Cl-, Ca)', N'MH', 0, CAST(N'00:06:44' AS Time))
GO
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MI29', N'X�t nghi?m h?ng c?u lu?i (b?ng m�y d?m laser)', N'MI', 0, CAST(N'00:09:05' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MI30', N'T? b�o d?ch m�ng (ph?i, b?ng, tim, kh?p�) c� d?m s? lu?ng t? b�o', N'MI', 0, CAST(N'00:09:43' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MI33', N'X�t nghi?m s? lu?ng v� d? t?p trung ti?u c?u (b?ng phuong ph�p th? c�ng)', N'MI', 0, CAST(N'00:09:45' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MI56', N'�i?n di huy?t s?c t? (d?nh lu?ng)', N'MI', 0, CAST(N'00:06:30' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MI57', N'T�m m?nh v? h?ng c?u', N'MI', 0, CAST(N'00:07:00' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MW98', N'Ch?p c?ng hu?ng t? gan v?i ch?t tuong ph?n d?c hi?u m�', N'MW', 0, CAST(N'00:10:05' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MW99', N'G�y m� li�n t?c ki?m so�t ngu?i b?nh th? m�y = 8 gi? (g�y m� ch?p MRI)', N'MW', 0, CAST(N'00:05:18' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MXD1', N'Ch?p, nong v� d?t stent d?ng m?ch m?c treo (tr�ng tr�n, tr�ng du?i) s? h�a x�a n?n', N'MX', 0, CAST(N'00:08:44' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MXD2', N'Ch?p, nong v� d?t Stent d?ng m?ch th?n s? h�a x�a n?n', N'MX', 0, CAST(N'00:07:12' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MXD3', N'Theo d�i ACT t?i ch?', N'MX', 0, CAST(N'00:09:57' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MXD4', N'Nong, d?t Stent du?ng m?t s? h�a x�a n?n', N'MX', 0, CAST(N'00:09:26' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MZ09', N'Test hoi th? C13 ph�t hi?n VK H.Pylori', N'MZ', 0, CAST(N'00:07:21' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'ND64', N'Ch?p c?t l?p vi t�nh b?ng-ti?u khung thu?ng quy', N'ND', 0, CAST(N'00:06:23' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'ND65', N'Ch?p c?t l?p vi t�nh b?ng-ti?u khung thu?ng quy c� ti�m thu?c c?n quang (chua bao g?m thu?c c?n quang)', N'ND', 0, CAST(N'00:05:16' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'ND66', N'Ch?p c?t l?p vi t�nh xuong chi kh�ng ti�m thu?c c?n quang', N'ND', 0, CAST(N'00:08:40' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'ND67', N'Ch?p c?t l?p vi t�nh xuong chi c� ti�m thu?c c?n quang (chua bao g?m thu?c c?n quang)', N'ND', 0, CAST(N'00:07:46' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NR04', N'Nghi?m ph�p b�n nghi�ng (TILT TEST)', N'NR', 0, CAST(N'00:10:42' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW02', N'Ch?n do�n di?n', N'NW', 0, CAST(N'00:10:45' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW04', N'�i?u tr? b?ng m�y k�o gi�n c?t s?ng ', N'NW', 0, CAST(N'00:09:06' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW05', N'Chu?m l?nh', N'NW', 0, CAST(N'00:10:48' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW06', N'Chu?m n�ng', N'NW', 0, CAST(N'00:07:34' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW08', N'�i?n vi d�ng gi?m dau', N'NW', 0, CAST(N'00:06:30' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW23', N'K�ch th�ch di?n < 3 co', N'NW', 0, CAST(N'00:10:07' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW24', N'K�ch th�ch di?n > 3 co', N'NW', 0, CAST(N'00:08:31' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW46', N'V?t l� tr? li?u h� h?p (ngu?i l?n)', N'NW', 0, CAST(N'00:06:19' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW47', N'V?t l� tr? li?u ph�ng ng?a c�c bi?n ch?ng do b?t d?ng', N'NW', 0, CAST(N'00:05:32' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW48', N'VLTL b?nh ph?i t?c ngh?n m�n t�nh', N'NW', 0, CAST(N'00:08:26' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NWA5', N'V?t l� tr? li?u h� h?p (tr? nh?)', N'NW', 0, CAST(N'00:08:47' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NWA6', N'VLTL cho b?nh nh�n r?i lo?n v?n d?ng kh�c (lo?n truong l?c, m�a gi?t,...)', N'NW', 0, CAST(N'00:06:43' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NWA7', N'Kh�m - lu?ng gi� VLTL - thi?t l?p m?c ti�u v� chuong tr�nh VLTL cho b?nh nh�n Parkinson', N'NW', 0, CAST(N'00:05:58' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NWA8', N'T?p do c?ng kh?p', N'NW', 0, CAST(N'00:08:23' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NY04', N'H?p kh? tr�ng d?ng c? ph?u thu?t b?ng PP kh�c', N'NY', 0, CAST(N'00:09:07' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NY05', N'H?p kh? tr�ng d?ng c? ph?u thu?t m�y STERRAD', N'NY', 0, CAST(N'00:08:02' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NY06', N'Ph� ti?t khu?n g�i v?i ph?u thu?t', N'NY', 0, CAST(N'00:06:39' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NY07', N'Ph� ti?t khu?n LMA PROSIEAL (S3,S4,S5)', N'NY', 0, CAST(N'00:08:23' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ18', N'Soi t�m vi tr�ng (d?ch ? b?ng)', N'NZ', 0, CAST(N'00:07:46' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ19', N'Soi t�m vi tr�ng (d?ch n�o t?y)', N'NZ', 0, CAST(N'00:05:58' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ33', N'Soi t�m vi tr�ng (d?ch d?u CVC)', N'NZ', 0, CAST(N'00:10:16' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ34', N'Soi t�m vi tr�ng (d?ch ph?t h?ng)', N'NZ', 0, CAST(N'00:08:57' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ35', N'Soi t�m vi tr�ng (d?ch kh�c)', N'NZ', 0, CAST(N'00:06:31' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ38', N'Kh�ng sinh d?', N'NZ', 0, CAST(N'00:08:30' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ75', N'Vi khu?n nhu?m soi (nhu?m Gram) d�m', N'NZ', 0, CAST(N'00:09:11' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ98', N'Vi khu?n nhu?m soi (nhu?m Gram) d?ch kh�c', N'NZ', 0, CAST(N'00:09:16' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ99', N'XN t�m BK nu?c ti?u', N'NZ', 0, CAST(N'00:05:18' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA0', N'XN t�m BK d�m', N'NZ', 0, CAST(N'00:08:47' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA1', N'XN t�m BK d?ch ph? qu?n', N'NZ', 0, CAST(N'00:08:30' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA2', N'XN t�m BK d?ch d? d�y', N'NZ', 0, CAST(N'00:05:32' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA3', N'XN t�m BK d?ch m�ng ph?i', N'NZ', 0, CAST(N'00:08:55' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA4', N'XN t�m BK d?ch m�ng b?ng', N'NZ', 0, CAST(N'00:08:00' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA5', N'XN t�m BK d?ch n�o t?y', N'NZ', 0, CAST(N'00:08:22' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA6', N'XN t�m BK d?ch kh?p', N'NZ', 0, CAST(N'00:10:55' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA7', N'XN t�m BK d?ch kh�c', N'NZ', 0, CAST(N'00:06:37' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA8', N'XN t�m BK l?n 1', N'NZ', 0, CAST(N'00:06:21' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA9', N'XN t�m BK l?n 2', N'NZ', 0, CAST(N'00:10:26' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZB0', N'XN t�m BK l?n 3', N'NZ', 0, CAST(N'00:10:33' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TJ04', N'�i?n ch�m ngo?i vi?n', N'TJ', 0, CAST(N'00:05:11' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TN01', N'INR t?i giu?ng', N'TN', 0, CAST(N'00:06:03' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TN02', N'Keton mao m?ch (t?i giu?ng)', N'TN', 0, CAST(N'00:06:15' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TN04', N'Manometry biofeeback', N'TN', 0, CAST(N'00:10:04' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TN05', N'�?nh nh�m m�u t?i giu?ng', N'TN', 0, CAST(N'00:09:57' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TN08', N'Th?i hoi th? t�m H.pylori C14', N'TN', 0, CAST(N'00:07:53' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TN15', N'X�t nghi?m du?ng m�u mao m?ch t?i Ph�ng kh�m', N'TN', 0, CAST(N'00:05:39' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TO85', N'Nhi?m s?c th? d? b?nh l� huy?t h?c', N'TO', 0, CAST(N'00:08:22' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TZ01', N'N?i soi tai mui h?ng', N'MM', 0, CAST(N'00:06:54' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TZ02', N'N?i soi tai', N'MM', 0, CAST(N'00:10:44' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TZ03', N'N?i soi mui xoang', N'MM', 0, CAST(N'00:06:32' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TZ04', N'N?i soi h?ng', N'MM', 0, CAST(N'00:10:20' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TZ05', N'�o th�nh l?c don �m', N'MM', 0, CAST(N'00:05:41' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TZ06', N'�o ph?n x? co b�n d?p', N'MM', 0, CAST(N'00:08:11' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TZ07', N'�o nhi lu?ng', N'MM', 0, CAST(N'00:07:21' AS Time))
INSERT [dbo].[DonViChucNang] ([IDDonViChucNang], [TenDonViChucNang]) VALUES (1, N'Kh�m b?nh ngo?i tr�')
INSERT [dbo].[DonViChucNang] ([IDDonViChucNang], [TenDonViChucNang]) VALUES (5, N'�on V? D?ch V?')
INSERT [dbo].[KhuVuc] ([IDKhuVuc], [TenKhuVuc]) VALUES (1, N'Khu B')
INSERT [dbo].[KhuVuc] ([IDKhuVuc], [TenKhuVuc]) VALUES (2, N'Khu C')
INSERT [dbo].[KhuVuc] ([IDKhuVuc], [TenKhuVuc]) VALUES (3, N'Khu A')
INSERT [dbo].[Lau] ([IDLau], [TenLau]) VALUES (0, N'Tr?t')
INSERT [dbo].[Lau] ([IDLau], [TenLau]) VALUES (1, N'1')
INSERT [dbo].[Lau] ([IDLau], [TenLau]) VALUES (2, N'2')
INSERT [dbo].[Lau] ([IDLau], [TenLau]) VALUES (3, N'3')
INSERT [dbo].[Lau] ([IDLau], [TenLau]) VALUES (4, N'4')
INSERT [dbo].[Lau] ([IDLau], [TenLau]) VALUES (5, N'5')
INSERT [dbo].[Lau] ([IDLau], [TenLau]) VALUES (6, N'6')
INSERT [dbo].[Lau] ([IDLau], [TenLau]) VALUES (7, N'7')
INSERT [dbo].[Lau] ([IDLau], [TenLau]) VALUES (8, N'8')
INSERT [dbo].[Lau] ([IDLau], [TenLau]) VALUES (9, N'9')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'1', CAST(N'2019-03-27' AS Date), 1, N'BS819')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'1', CAST(N'2019-03-27' AS Date), 2, N'BS819')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'117', CAST(N'2019-03-27' AS Date), 1, N'BS750')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'117', CAST(N'2019-03-27' AS Date), 2, N'BS750')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'141', CAST(N'2019-03-27' AS Date), 1, N'BS159')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'141', CAST(N'2019-03-27' AS Date), 2, N'BS159')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'15', CAST(N'2019-03-27' AS Date), 1, N'BS381')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'15', CAST(N'2019-03-27' AS Date), 2, N'BS381')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'154', CAST(N'2019-03-27' AS Date), 1, N'BS193')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'154', CAST(N'2019-03-27' AS Date), 2, N'BS193')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'16', CAST(N'2019-03-27' AS Date), 1, N'BS329')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'16', CAST(N'2019-03-27' AS Date), 2, N'BS329')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'23', CAST(N'2019-03-27' AS Date), 1, N'BS352')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'23', CAST(N'2019-03-27' AS Date), 2, N'BS352')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'24', CAST(N'2019-03-27' AS Date), 1, N'BS993')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'24', CAST(N'2019-03-27' AS Date), 2, N'BS993')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'25', CAST(N'2019-03-27' AS Date), 1, N'BS994')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'25', CAST(N'2019-03-27' AS Date), 2, N'BS994')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'35', CAST(N'2019-03-27' AS Date), 1, N'BS188')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'35', CAST(N'2019-03-27' AS Date), 2, N'BS188')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'44', CAST(N'2019-03-27' AS Date), 1, N'BS495')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'44', CAST(N'2019-03-27' AS Date), 2, N'BS495')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'48', CAST(N'2019-03-27' AS Date), 1, N'BS108')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'48', CAST(N'2019-03-27' AS Date), 2, N'BS108')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'56', CAST(N'2019-03-27' AS Date), 1, N'BS245')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'56', CAST(N'2019-03-27' AS Date), 2, N'BS245')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'98', CAST(N'2019-03-27' AS Date), 1, N'BS889')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK1', N'98', CAST(N'2019-03-27' AS Date), 2, N'BS889')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'1', CAST(N'2019-03-27' AS Date), 1, N'BS298')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'1', CAST(N'2019-03-27' AS Date), 2, N'BS298')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'117', CAST(N'2019-03-27' AS Date), 1, N'BS689')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'117', CAST(N'2019-03-27' AS Date), 2, N'BS689')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'141', CAST(N'2019-03-27' AS Date), 1, N'BS330')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'141', CAST(N'2019-03-27' AS Date), 2, N'BS330')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'15', CAST(N'2019-03-27' AS Date), 1, N'BS345')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'15', CAST(N'2019-03-27' AS Date), 2, N'BS345')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'154', CAST(N'2019-03-27' AS Date), 1, N'BS661')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'154', CAST(N'2019-03-27' AS Date), 2, N'BS661')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'16', CAST(N'2019-03-27' AS Date), 1, N'BS256')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'16', CAST(N'2019-03-27' AS Date), 2, N'BS256')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'23', CAST(N'2019-03-27' AS Date), 1, N'BS989')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'23', CAST(N'2019-03-27' AS Date), 2, N'BS989')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'24', CAST(N'2019-03-27' AS Date), 1, N'BS992')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'24', CAST(N'2019-03-27' AS Date), 2, N'BS992')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'25', CAST(N'2019-03-27' AS Date), 1, N'BS996')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'25', CAST(N'2019-03-27' AS Date), 2, N'BS996')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'35', CAST(N'2019-03-27' AS Date), 1, N'BS057')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'35', CAST(N'2019-03-27' AS Date), 2, N'BS057')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'48', CAST(N'2019-03-27' AS Date), 1, N'BS544')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'48', CAST(N'2019-03-27' AS Date), 2, N'BS544')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'98', CAST(N'2019-03-27' AS Date), 1, N'BS888')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK2', N'98', CAST(N'2019-03-27' AS Date), 2, N'BS888')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK3', N'117', CAST(N'2019-03-27' AS Date), 1, N'BS844')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK3', N'117', CAST(N'2019-03-27' AS Date), 2, N'BS844')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK3', N'15', CAST(N'2019-03-27' AS Date), 1, N'BS480')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK3', N'15', CAST(N'2019-03-27' AS Date), 2, N'BS480')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK3', N'154', CAST(N'2019-03-27' AS Date), 1, N'BS189')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK3', N'154', CAST(N'2019-03-27' AS Date), 2, N'BS189')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK3', N'23', CAST(N'2019-03-27' AS Date), 1, N'BS990')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK3', N'23', CAST(N'2019-03-27' AS Date), 2, N'BS990')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK3', N'24', CAST(N'2019-03-27' AS Date), 1, N'BS991')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK3', N'24', CAST(N'2019-03-27' AS Date), 2, N'BS991')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK3', N'48', CAST(N'2019-03-27' AS Date), 1, N'BS709')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK3', N'48', CAST(N'2019-03-27' AS Date), 2, N'BS709')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK3', N'98', CAST(N'2019-03-27' AS Date), 1, N'BS787')
INSERT [dbo].[LichKhamBacSi] ([IDBan], [Phong], [Ngay], [CaKham], [IDBacSi]) VALUES (N'BK3', N'98', CAST(N'2019-03-27' AS Date), 2, N'BS787')
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'1', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'1', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'2', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'2', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'CT1', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'CT1', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'DSA', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'DSA', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'KSNK1', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'KSNK1', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'MRI', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'MRI', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'NS1', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'NS1', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'NS2', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'NS2', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'NS3', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'NS3', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'PHCN1', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'PHCN1', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'PHCN2', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'PHCN2', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'SA1', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'SA1', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'SA2', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'SA2', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'SA3', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'SA3', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'SA4', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'SA4', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'SPECT', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'SPECT', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'TD1', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'TD1', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'TD2', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'TD2', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'TMH1', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'TMH1', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'TMH2', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'TMH2', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'XN1', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'XN1', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'XN2', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'XN2', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'XN3', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'XN3', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'XNK1', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'XNK1', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'XQ1', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'XQ1', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'XQ2', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'XQ2', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'XQ3', CAST(N'2019-03-27' AS Date), 1, CAST(N'07:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[LichPhongCanLamSang] ([IDPhongCLS], [Ngay], [CaKham], [GioBatDau], [GioKetThuc]) VALUES (N'XQ3', CAST(N'2019-03-27' AS Date), 2, CAST(N'13:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[LichSuTraCuu] ([IDTraCuu], [IDNguoiTim], [IDNguoiDuocTim], [ThoiGian]) VALUES (N'LS00001   ', N'BN21676', N'BN21677', CAST(N'2019-04-20T03:13:44.763' AS DateTime))
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'GA', N'XN G?I �I', N'DH')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'KX', N'�O LO�NG XUONG', N'DA')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MA', N'X-QUANG', N'DA')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MB', N'N?I SOI            ', N'DB')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MC', N'SI�U �M           ', N'DC')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MD', N'SI�U �M TIM       ', N'DD')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MF', N'THAM D� CH?C NANG', N'DF')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MG', N'X? H�NH            ', N'DG')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MH', N'XN SINH H�A', N'DH')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MI', N'XN HUY?T H?C      ', N'DH')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MJ', N'XN MI?N D?CH       ', N'DH')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MK', N'XN SH NU?C TI?U   ', N'DH')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MM', N'DV TAI MUI H?NG', N'DL')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MQ', N'XN SINH H?C PH�N T?', N'DH')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MT', N'�I?U TR? TRUONG L?C CO', N'DQ')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MW', N'CH?P MRI', N'DW')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MX', N'DSA_CAN THI?P', N'DI')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'MZ', N'XN KH�C', N'DH')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'ND', N'CH?P CT-SCAN', N'DV')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'NR', N'DV PH�NG KH�M TIM M?CH', N'D6')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'NW', N'V?T L� TR? LI?U', N'D+')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'NY', N'KI?M SO�T NHI?M KHU?N', N'DZ')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'NZ', N'XN VI SINH', N'DH')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'TI', N'CH�CH NG?A', N'D]')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'TJ', N'Y H?C C? TRUY?N', N'D?')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'TK', N'D? ?NG - MD L�M S�NG', N'D(')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'TL', N'H�A TR?', N'D)')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'TM', N'TRUY?N M�U', N'D&')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'TN', N'X�T NGHI?M', N'D[')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'TO', N'XN Y SINH H?C PH�N T? N�NG CAO', N'DH')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'TP', N'GI?I PH?U B?NH', N'D<')
INSERT [dbo].[LoaiDichVu] ([IDLoaiDichVu], [TenLoaiDichVu], [ChuyenKhoa]) VALUES (N'TR', N'XN K� SINH TR�NG', N'DH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10001', N'BN21114', CAST(N'2019-05-24T13:29:25.453' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10002', N'BN21122', CAST(N'2019-05-24T13:29:25.460' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10003', N'BN21123', CAST(N'2019-05-24T13:29:25.460' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10004', N'BN21136', CAST(N'2019-05-24T14:59:43.950' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10005', N'BN21444', CAST(N'2019-05-24T16:42:16.180' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10006', N'BN21451', CAST(N'2019-05-24T16:42:16.187' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10007', N'BN21456', CAST(N'2019-05-24T16:42:16.187' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10008', N'BN21464', CAST(N'2019-05-24T16:42:16.187' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10009', N'BN21466', CAST(N'2019-05-24T16:42:16.190' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10010', N'BN21511', CAST(N'2019-05-24T16:42:16.190' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10011', N'BN21512', CAST(N'2019-05-24T16:42:16.190' AS DateTime), N'PH')
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'1', N'Ph�ng �i?n Ch�m 210', N'D?', 2)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'2', N'Ph�ng �i?n Ch�m 211', N'D?', 2)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'CT1', N'Ph�ng CT-Scan', N'DV', 5)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'DSA', N'Ph�ng DSA', N'DI', 5)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'KSNK1', N'Ph�ng 237', N'DZ', 2)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'MRI', N'Ph�ng MRI', N'DW', 4)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'NS1', N'Ph�ng N?i Soi 212', N'DB', 2)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'NS2', N'Ph�ng N?i Soi 213', N'DB', 2)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'NS3', N'Ph�ng N?i Soi 214', N'DB', 2)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'PHCN1', N'Ph�ng 235', N'D+', 2)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'PHCN2', N'Ph�ng 236', N'D+', 2)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'SA1', N'Ph�ng 331', N'DC', 3)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'SA2', N'Ph�ng 332', N'DC', 3)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'SA3', N'Ph�ng 333', N'DC', 3)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'SA4', N'Ph�ng 334', N'DC', 3)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'SPECT', N'Ph�ng SPECT', N'DG', 4)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'TD1', N'Ph�ng 340', N'DF', 3)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'TD2', N'Ph�ng 341', N'DF', 3)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'TMH1', N'Ph�ng 320', N'DL', 3)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'TMH2', N'Ph�ng 321', N'DL', 3)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'XN1', N'Ph�ng X�t Nghi?m A', N'DH', 0)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'XN2', N'Ph�ng X�t Nghi?m B', N'DH', 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'XN3', N'Ph�ng X�t Nghi?m C', N'DH', 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'XNK1', N'Ph�ng 238', N'D[', 2)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'XQ1', N'Ph�ng X-Quang A', N'DA', 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'XQ2', N'Ph�ng X-Quang B', N'DA', 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'XQ3', N'Ph�ng X-Quang C', N'DA', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'1', N'Ph�ng 32', N'PH', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'100', N'Ph�ng 21', N'PK', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'101', N'Ph�ng 21', N'PN', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'104', N'X Quang (Khu B)', N'DA', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'105', N'X Quang (Khu A)', N'DA', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'109', N'Ph�ng 81', N'ND', 8)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'110', N'Ph�ng 82', N'ND', 8)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'111', N'Ph�ng 69', N'PG', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'112', N'Ph�ng 70', N'PG', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'113', N'SPECT (Khu A)', N'DG', 8)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'114', N'MRI(�HYD)', N'DW', 8)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'117', N'Ph�ng 49', N'PI', 4)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'118', N'Ph�ng 37', N'YHGD', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'119', N'Ph�ng 38', N'YHGD', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'120', N'Ph�ng 79', N'PA', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'121', N'Ph�ng 80', N'PA', 8)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'122', N'Ph�ng 83', N'KTN', 8)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'123', N'Ph�ng 60', N'GN', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'124', N'Ph�ng 64', N'DTTL', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'125', N'Ph�ng 5', N'HH', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'126', N'Ph�ng 27', N'TN', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'129', N'Ph�ng 1', N'P(', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'130', N'Ph�ng 28', N'LM', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'131', N'Ph�ng 29', N'LM', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'132', N'Ph�ng VIP', N'DTTL', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'133', N'Ph�ng VIP', N'GN', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'134', N'Ph�ng VIP', N'HH', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'135', N'Ph�ng VIP', N'KTN', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'136', N'Ph�ng VIP', N'LM', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'137', N'Ph�ng VIP', N'ND', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'138', N'Ph�ng VIP', N'P!', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'139', N'Ph�ng VIP', N'P#', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'140', N'Ph�ng VIP', N'P(', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'141', N'Ph�ng VIP', N'P@', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'143', N'Ph�ng VIP', N'P6', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'144', N'Ph�ng VIP', N'P7', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'146', N'Ph�ng VIP', N'P9', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'147', N'Ph�ng VIP', N'PA', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'148', N'Ph�ng VIP', N'PB', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'149', N'Ph�ng VIP', N'PC', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'15', N'Ph�ng 31', N'PB', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'150', N'Ph�ng VIP', N'PD', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'151', N'Ph�ng VIP', N'PF', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'152', N'Ph�ng VIP', N'PG', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'153', N'Ph�ng VIP', N'PH', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'154', N'Ph�ng VIP', N'PI', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'155', N'Ph�ng VIP', N'PJ', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'156', N'Ph�ng VIP', N'PK', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'157', N'Ph�ng VIP', N'PL', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'158', N'Ph�ng VIP', N'PM', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'159', N'Ph�ng VIP', N'PN', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'16', N'Ph�ng 11', N'P7', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'160', N'Ph�ng VIP', N'PO', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'161', N'Ph�ng VIP', N'PP', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'162', N'Ph�ng VIP', N'PQ', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'163', N'Ph�ng VIP', N'PR', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'164', N'Ph�ng VIP', N'PS', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'165', N'Ph�ng VIP', N'PT', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'166', N'Ph�ng VIP', N'PU', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'167', N'Ph�ng VIP', N'PV', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'168', N'Ph�ng VIP', N'PW', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'17', N'Ph�ng 12', N'P7', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'170', N'Ph�ng VIP', N'PY', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'171', N'Ph�ng VIP', N'PZ', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'172', N'Ph�ng VIP', N'TN', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'173', N'Ph�ng VIP', N'YHGD', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'174', N'Ph�ng 5', N'P(', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'177', N'Ph�ng 45', N'PJ', 4)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'178', N'Ph�ng 70', N'UB', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'179', N'Ph�ng 70', N'PY', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'18', N'Ph�ng 14', N'P7', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'180', N'Ph�ng 74', N'PY', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'181', N'Ph�ng 22', N'P$', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'182', N'Ph�ng VIP', N'P$', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'183', N'Ph�ng 71', N'HH', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'184', N'Ph�ng 71', N'PL', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'185', N'Ph�ng 16', N'0UGM', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'187', N'Ph�ng 41', N'NXK', 4)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'188', N'Ph�ng 29', N'P^', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'189', N'Ph�ng 1', N'TQQT', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'19', N'Ph�ng 15', N'P7', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'190', N'Ph�ng 1', N'CKQT', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'191', N'Ph�ng 01', N'KBTS', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'192', N'Ph�ng 02', N'KBTS', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'195', N'CT-Scan ', N'DV', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'198', N'Ph�ng 02', N'NHI2', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'199', N'Ti?u ph?u B', N'PZ', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'2', N'Ph�ng 33', N'PH', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'20', N'Ph�ng 16', N'P7', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'200', N'Ph�ng 25', N'PN', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'201', N'Ph�ng 84', N'P(', 8)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'202', N'Ph�ng 63', N'PN', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'203', N'Ph�ng 62', N'TN', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'204', N'Ph�ng 27', N'PL', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'207', N'Ph�ng 65', N'NHCN', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'209', N'Ph�ng 85', N'PHCN', 8)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'21', N'Ph�ng 4', N'P7', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'22', N'Ph�ng 5', N'P7', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'23', N'Ph�ng 6', N'PD', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'24', N'Ph�ng 7', N'PD', 0)
GO
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'25', N'Ph�ng 8', N'PD', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'26', N'Ph�ng 9', N'PD', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'27', N'Ph�ng 10', N'PD', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'28', N'Ph�ng 2', N'PM', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'29', N'Ph�ng 3', N'PM', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'3', N'Si�u �m 1', N'DC', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'30', N'Ph�ng 34', N'PH', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'31', N'Ph�ng 35', N'PH', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'32', N'Ph�ng 36', N'PH', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'35', N'Ph�ng 46', N'PI', 4)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'36', N'Ph�ng 47', N'PI', 4)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'37', N'Ph�ng 48', N'PI', 4)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'4', N'Si�u �m 2', N'DC', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'40', N'Ph�ng 60', N'P2', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'42', N'Ph�ng 1', N'P6', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'44', N'Ph�ng 30', N'PC', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'48', N'Ph�ng 42', N'PJ', 4)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'49', N'Ph�ng 43', N'PJ', 4)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'50', N'Ph�ng 44', N'PJ', 4)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'51', N'Ph�ng 22', N'PK', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'52', N'Ph�ng 25', N'PK', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'53', N'Ph�ng 26', N'PK', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'54', N'Ph�ng 61', N'P9', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'55', N'Ph�ng 77', N'PA', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'56', N'Ph�ng 72', N'PF', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'57', N'Ph�ng 66', N'PG', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'58', N'Ph�ng 39', N'PL', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'59', N'Ph�ng 40', N'PL', 4)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'60', N'Ph�ng 1', N'PD', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'61', N'Ph�ng 50', N'PO', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'62', N'Ph�ng 59', N'PP', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'63', N'Ph�ng 53', N'PQ', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'64', N'Ph�ng 58', N'PR', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'66', N'Ph�ng 75', N'PY', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'68', N'Ph�ng 24', N'PN', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'69', N'Ph�ng 3', N'TN', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'70', N'Ph�ng 52', N'PW', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'71', N'L?u 6, Block A', N'P!', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'72', N'Ph�ng 2', N'PD', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'73', N'Ph�ng 3', N'PD', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'74', N'Ph�ng 24', N'PK', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'75', N'Ph�ng 67', N'PG', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'76', N'Ph�ng 68', N'PG', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'79', N'Ph�ng 56', N'P#', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'80', N'Ph�ng 57', N'P#', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'81', N'Ph�ng 54', N'PQ', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'82', N'Ph�ng 78', N'PA', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'83', N'Ph�ng 73', N'PF', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'90', N'Ph�ng si�u �m 7', N'PV', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'92', N'Ph�ng 17', N'PU', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'93', N'Ph�ng 19', N'PU', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'94', N'Ph�ng 18', N'PT', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'95', N'Ph�ng 20', N'PT', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'96', N'Ti?u ph?u A', N'PZ', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'97', N'Ph�ng tu v?n', N'PS', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'98', N'Ph�ng 1', N'P@', 0)
INSERT [dbo].[SoHienThiPhongKham] ([STT], [BanKham], [PhongKham], [IDPhieuKham], [Gio], [TinhTrang], [CaKham]) VALUES (1, N'BK1', N'1', N'PKPH10002', CAST(N'2019-03-27T07:05:47.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongKham] ([STT], [BanKham], [PhongKham], [IDPhieuKham], [Gio], [TinhTrang], [CaKham]) VALUES (1, N'BK2', N'1', N'PKPH10001', CAST(N'2019-03-27T07:05:47.000' AS DateTime), 1, 1)
INSERT [dbo].[SoThuTuPhongCLS] ([IDPhieuKham], [STT], [CanLamSang], [PhongCanLamSang], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10001', 1, N'TZ02', N'TMH1', 1, CAST(N'2019-03-27T07:00:00.000' AS DateTime), N'Chua')
INSERT [dbo].[SoThuTuPhongCLS] ([IDPhieuKham], [STT], [CanLamSang], [PhongCanLamSang], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10002', 1, N'TZ02', N'TMH2', 1, CAST(N'2019-03-27T07:00:00.000' AS DateTime), N'Chua')
INSERT [dbo].[SoThuTuPhongKham] ([IDPhieuKham], [STT], [BanKham], [PhongKham], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10001', 1, N'BK2', N'1', 1, CAST(N'2019-03-27T07:03:47.000' AS DateTime), N'�ang kh�m')
INSERT [dbo].[SoThuTuPhongKham] ([IDPhieuKham], [STT], [BanKham], [PhongKham], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10002', 1, N'BK1', N'1', 1, CAST(N'2019-03-27T07:03:47.000' AS DateTime), N'�ang kh�m')
INSERT [dbo].[SoThuTuPhongKham] ([IDPhieuKham], [STT], [BanKham], [PhongKham], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10003', 2, N'BK2', N'1', 1, CAST(N'2019-03-27T07:07:34.000' AS DateTime), N'Chua')
INSERT [dbo].[SoThuTuPhongKham] ([IDPhieuKham], [STT], [BanKham], [PhongKham], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10004', 2, N'BK1', N'1', 1, CAST(N'2019-03-27T07:07:34.000' AS DateTime), N'Chua')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10001', N'XNPH10001', 1, N'XN1', 1, CAST(N'2019-03-27T07:00:00.000' AS DateTime), N'Chua')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10002', N'XNPH10002', 1, N'XN2', 1, CAST(N'2019-03-27T07:00:00.000' AS DateTime), N'Chua')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10003', N'XNPH10003', 1, N'XN3', 1, CAST(N'2019-03-27T07:00:00.000' AS DateTime), N'Chua')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10004', N'XNPH10004', 2, N'XN3', 1, CAST(N'2019-03-27T07:02:00.000' AS DateTime), N'Chua')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10005', NULL, 2, N'XN2', 1, CAST(N'2019-03-27T07:02:00.000' AS DateTime), N'Chua')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10006', NULL, 2, N'XN1', 1, CAST(N'2019-03-27T07:02:00.000' AS DateTime), N'Chua')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10007', NULL, 1, N'XN1', 2, CAST(N'2019-03-27T13:00:00.000' AS DateTime), N'Chua')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10008', NULL, 1, N'XN2', 2, CAST(N'2019-03-27T13:00:00.000' AS DateTime), N'Chua')
INSERT [dbo].[Temp] ([Status]) VALUES (1)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'1', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'1', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'2', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'2', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'CT1', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'CT1', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'DSA', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'DSA', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'KSNK1', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'KSNK1', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'MRI', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'MRI', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'NS1', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'NS1', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'NS2', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'NS2', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'NS3', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'NS3', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'PHCN1', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'PHCN1', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'PHCN2', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'PHCN2', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'SA1', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'SA1', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'SA2', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'SA2', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'SA3', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'SA3', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'SA4', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'SA4', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'SPECT', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'SPECT', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'TD1', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'TD1', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'TD2', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'TD2', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'TMH1', CAST(N'2019-03-27' AS Date), 1, 1)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'TMH1', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'TMH2', CAST(N'2019-03-27' AS Date), 1, 1)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'TMH2', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XN1', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XN1', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XN2', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XN2', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XN3', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XN3', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XNK1', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XNK1', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XQ1', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XQ1', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XQ2', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XQ2', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XQ3', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XQ3', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'1', 1, 1, N'PH', CAST(N'00:03:47' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'1', 2, 0, N'PH', CAST(N'00:03:47' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'117', 1, 0, N'PI', CAST(N'00:06:46' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'117', 2, 0, N'PI', CAST(N'00:06:46' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'141', 1, 0, N'P@', CAST(N'00:04:06' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'141', 2, 0, N'P@', CAST(N'00:04:06' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'15', 1, 0, N'PB', CAST(N'00:08:07' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'15', 2, 0, N'PB', CAST(N'00:08:07' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'154', 1, 0, N'PI', CAST(N'00:06:20' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'154', 2, 0, N'PI', CAST(N'00:06:20' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'16', 1, 0, N'P7', CAST(N'00:03:39' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'16', 2, 0, N'P7', CAST(N'00:03:39' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'23', 1, 0, N'PD', CAST(N'00:07:31' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'23', 2, 0, N'PD', CAST(N'00:07:31' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'24', 1, 0, N'PD', CAST(N'00:04:49' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'24', 2, 0, N'PD', CAST(N'00:04:49' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'25', 1, 0, N'PD', CAST(N'00:08:07' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'25', 2, 0, N'PD', CAST(N'00:08:07' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'35', 1, 0, N'PI', CAST(N'00:03:19' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'35', 2, 0, N'PI', CAST(N'00:03:19' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'44', 1, 0, N'PC', CAST(N'00:06:51' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'44', 2, 0, N'PC', CAST(N'00:06:51' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'48', 1, 0, N'PJ', CAST(N'00:07:47' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'48', 2, 0, N'PJ', CAST(N'00:07:47' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'56', 1, 0, N'PF', CAST(N'00:03:02' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'56', 2, 0, N'PF', CAST(N'00:03:02' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'98', 1, 0, N'P@', CAST(N'00:07:00' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'98', 2, 0, N'P@', CAST(N'00:07:00' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'1', 1, 1, N'PH', CAST(N'00:03:47' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'1', 2, 0, N'PH', CAST(N'00:03:47' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'117', 1, 0, N'PI', CAST(N'00:04:38' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'117', 2, 0, N'PI', CAST(N'00:04:38' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'141', 1, 0, N'P@', CAST(N'00:03:58' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'141', 2, 0, N'P@', CAST(N'00:03:58' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'15', 1, 0, N'PB', CAST(N'00:03:28' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'15', 2, 0, N'PB', CAST(N'00:03:28' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'154', 1, 0, N'PI', CAST(N'00:03:27' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'154', 2, 0, N'PI', CAST(N'00:03:27' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'16', 1, 0, N'P7', CAST(N'00:07:31' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'16', 2, 0, N'P7', CAST(N'00:07:31' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'23', 1, 0, N'PD', CAST(N'00:05:29' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'23', 2, 0, N'PD', CAST(N'00:05:29' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'24', 1, 0, N'PD', CAST(N'00:05:48' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'24', 2, 0, N'PD', CAST(N'00:05:48' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'25', 1, 0, N'PD', CAST(N'00:03:13' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'25', 2, 0, N'PD', CAST(N'00:03:13' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'35', 1, 0, N'PI', CAST(N'00:06:40' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'35', 2, 0, N'PI', CAST(N'00:06:40' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'48', 1, 0, N'PJ', CAST(N'00:04:52' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'48', 2, 0, N'PJ', CAST(N'00:04:52' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'98', 1, 0, N'P@', CAST(N'00:04:28' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'98', 2, 0, N'P@', CAST(N'00:04:28' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK3', N'117', 1, 0, N'PI', CAST(N'00:03:10' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK3', N'117', 2, 0, N'PI', CAST(N'00:03:10' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK3', N'15', 1, 0, N'PB', CAST(N'00:05:09' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK3', N'15', 2, 0, N'PB', CAST(N'00:05:09' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK3', N'154', 1, 0, N'PI', CAST(N'00:06:30' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK3', N'154', 2, 0, N'PI', CAST(N'00:06:30' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK3', N'23', 1, 0, N'PD', CAST(N'00:07:23' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK3', N'23', 2, 0, N'PD', CAST(N'00:07:23' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK3', N'24', 1, 0, N'PD', CAST(N'00:08:15' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK3', N'24', 2, 0, N'PD', CAST(N'00:08:15' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK3', N'48', 1, 0, N'PJ', CAST(N'00:04:03' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK3', N'48', 2, 0, N'PJ', CAST(N'00:04:03' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK3', N'98', 1, 0, N'P@', CAST(N'00:05:08' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK3', N'98', 2, 0, N'P@', CAST(N'00:05:08' AS Time))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'1', N'TJ04', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'1', N'TJ04', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'2', N'TJ04', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'2', N'TJ04', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'CT1', N'ND64', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'CT1', N'ND64', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'CT1', N'ND65', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'CT1', N'ND65', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'CT1', N'ND66', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'CT1', N'ND66', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'CT1', N'ND67', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'CT1', N'ND67', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'DSA', N'MXD1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'DSA', N'MXD1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'DSA', N'MXD2', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'DSA', N'MXD2', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'DSA', N'MXD3', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'DSA', N'MXD3', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'DSA', N'MXD4', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'DSA', N'MXD4', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'KSNK1', N'NY04', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'KSNK1', N'NY04', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'KSNK1', N'NY05', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'KSNK1', N'NY05', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'KSNK1', N'NY06', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'KSNK1', N'NY06', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'KSNK1', N'NY07', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'KSNK1', N'NY07', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'MRI', N'MW98', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'MRI', N'MW98', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'MRI', N'MW99', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'MRI', N'MW99', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'MRI', N'NR04', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'MRI', N'NR04', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'E038', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'E038', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MB39', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MB39', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MB82', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MB82', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MB84', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MB84', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MB86', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MB86', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MB88', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MB88', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MB89', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MB89', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MB91', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MB91', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MBA1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MBA1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MBA4', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MBA4', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MBC8', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MBC8', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MBD0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MBD0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MBD1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MBD1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MBD2', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MBD2', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MBD5', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS1', N'MBD5', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'E038', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'E038', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MB39', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MB39', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MB82', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MB82', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MB84', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MB84', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MB86', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MB86', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MB88', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MB88', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MB89', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MB89', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MBA1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MBA1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MBA4', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MBA4', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MBC8', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MBC8', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MBD0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MBD0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MBD1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MBD1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MBD2', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MBD2', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MBD5', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS2', N'MBD5', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'E038', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'E038', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MB39', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MB39', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MB82', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MB82', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MB84', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MB84', 2, CAST(N'2019-03-27' AS Date))
GO
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MB86', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MB86', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MB88', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MB88', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MB89', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MB89', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MB91', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MB91', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBA1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBA1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBA4', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBA4', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBC8', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBC8', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBE0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBE0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBE1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBE1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBE3', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBE3', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBE5', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBE5', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBE7', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBE7', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBE8', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBE8', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBE9', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBE9', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBF0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBF0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBF1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBF1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBF2', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBF2', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBH0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'NS3', N'MBH0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NW02', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NW02', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NW04', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NW04', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NW05', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NW05', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NW06', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NW06', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NW08', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NW08', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NW23', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NW23', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NW24', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NW24', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NW46', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NW46', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NW47', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NW47', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NW48', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NW48', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NWA5', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NWA5', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NWA6', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NWA6', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NWA7', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NWA7', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NWA8', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN1', N'NWA8', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NW02', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NW02', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NW04', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NW04', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NW05', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NW05', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NW06', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NW06', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NW08', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NW08', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NW23', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NW23', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NW24', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NW24', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NW46', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NW46', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NW47', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NW47', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NW48', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NW48', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NWA5', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NWA5', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NWA6', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NWA6', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NWA7', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NWA7', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NWA8', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'PHCN2', N'NWA8', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC60', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC60', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC61', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC61', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC65', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC65', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC66', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC66', 2, CAST(N'2019-03-27' AS Date))
GO
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC67', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC67', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC68', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC68', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC69', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC69', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC72', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC72', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC73', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC73', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC74', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC74', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC75', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA1', N'MC75', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC60', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC60', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC61', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC61', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC65', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC65', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC66', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC66', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC67', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC67', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC68', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC68', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC69', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC69', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC72', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC72', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC73', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC73', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC74', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC74', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC75', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA2', N'MC75', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC72', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC72', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC73', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC73', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC74', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC74', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC75', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC75', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC81', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC81', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC88', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC88', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC89', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC89', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC90', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC90', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC91', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC91', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC92', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC92', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC93', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC93', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC94', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MC94', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MCD0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MCD0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MCD1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MCD1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MCD2', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA3', N'MCD2', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC72', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC72', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC73', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC73', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC74', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC74', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC75', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC75', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC81', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC81', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC88', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC88', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC89', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC89', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC90', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC90', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC91', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC91', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC92', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC92', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC93', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC93', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC94', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MC94', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MCD0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MCD0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MCD1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MCD1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MCD2', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SA4', N'MCD2', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SPECT', N'MG92', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'SPECT', N'MG92', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF21', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF21', 2, CAST(N'2019-03-27' AS Date))
GO
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF22', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF22', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF26', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF26', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF28', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF28', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF29', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF29', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF30', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF30', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF32', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF32', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF52', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF52', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF58', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF58', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF59', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF59', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF60', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF60', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF61', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF61', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF62', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF62', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF63', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF63', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF71', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF71', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF72', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD1', N'MF72', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF21', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF21', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF22', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF22', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF26', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF26', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF28', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF28', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF29', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF29', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF30', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF30', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF32', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF32', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF52', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF52', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF58', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF58', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF59', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF59', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF60', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF60', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF61', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF61', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF62', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF62', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF63', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF63', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF71', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF71', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF72', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TD2', N'MF72', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH1', N'TZ01', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH1', N'TZ01', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH1', N'TZ02', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH1', N'TZ02', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH1', N'TZ03', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH1', N'TZ03', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH1', N'TZ04', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH1', N'TZ04', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH1', N'TZ05', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH1', N'TZ05', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH1', N'TZ06', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH1', N'TZ06', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH1', N'TZ07', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH1', N'TZ07', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH2', N'TZ01', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH2', N'TZ01', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH2', N'TZ02', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH2', N'TZ02', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH2', N'TZ03', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH2', N'TZ03', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH2', N'TZ04', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH2', N'TZ04', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH2', N'TZ05', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH2', N'TZ05', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH2', N'TZ06', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH2', N'TZ06', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH2', N'TZ07', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'TMH2', N'TZ07', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGI0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGI0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGI1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGI1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGI2', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGI2', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGI3', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGI3', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGI4', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGI4', 2, CAST(N'2019-03-27' AS Date))
GO
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGI6', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGI6', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGI8', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGI8', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGI9', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGI9', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGJ1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGJ1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGJ2', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGJ2', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGJ3', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGJ3', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGJ5', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGJ5', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGJ6', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGJ6', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGL9', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGL9', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGM0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGM0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGM1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGM1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGM2', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGM2', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGM3', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'GGM3', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'MH21', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'MH21', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'MI29', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'MI29', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'MI30', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'MI30', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'MI33', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'MI33', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'MI56', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'MI56', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'MI57', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'MI57', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'MZ09', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'MZ09', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZ18', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZ18', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZ19', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZ19', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZ33', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZ33', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZ34', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZ34', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZ35', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZ35', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZ38', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZ38', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZ75', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZ75', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZ98', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZ98', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZ99', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZ99', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZA0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZA0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZA1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZA1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZA2', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZA2', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZA3', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZA3', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZA4', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZA4', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZA5', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZA5', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZA6', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZA6', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZA7', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZA7', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZA8', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZA8', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZA9', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZA9', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZB0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'NZB0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'TO85', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN1', N'TO85', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGI0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGI0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGI1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGI1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGI2', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGI2', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGI3', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGI3', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGI4', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGI4', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGI6', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGI6', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGI8', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGI8', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGI9', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGI9', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGJ1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGJ1', 2, CAST(N'2019-03-27' AS Date))
GO
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGJ2', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGJ2', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGJ3', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGJ3', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGJ5', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGJ5', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGJ6', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGJ6', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGL9', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGL9', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGM0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGM0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGM1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGM1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGM2', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGM2', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGM3', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'GGM3', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'MH21', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'MH21', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'MI29', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'MI29', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'MI30', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'MI30', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'MI33', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'MI33', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'MI56', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'MI56', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'MI57', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'MI57', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'MZ09', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'MZ09', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZ18', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZ18', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZ19', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZ19', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZ33', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZ33', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZ34', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZ34', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZ35', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZ35', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZ38', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZ38', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZ75', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZ75', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZ98', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZ98', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZ99', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZ99', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZA0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZA0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZA1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZA1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZA2', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZA2', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZA3', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZA3', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZA4', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZA4', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZA5', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZA5', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZA6', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZA6', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZA7', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZA7', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZA8', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZA8', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZA9', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZA9', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZB0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'NZB0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'TO85', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN2', N'TO85', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGI0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGI0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGI1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGI1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGI2', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGI2', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGI3', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGI3', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGI4', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGI4', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGI6', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGI6', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGI8', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGI8', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGI9', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGI9', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGJ1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGJ1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGJ2', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGJ2', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGJ3', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGJ3', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGJ5', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGJ5', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGJ6', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGJ6', 2, CAST(N'2019-03-27' AS Date))
GO
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGL9', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGL9', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGM0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGM0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGM1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGM1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGM2', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGM2', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGM3', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'GGM3', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'MH21', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'MH21', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'MI29', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'MI29', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'MI30', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'MI30', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'MI33', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'MI33', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'MI56', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'MI56', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'MI57', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'MI57', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'MZ09', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'MZ09', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZ18', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZ18', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZ19', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZ19', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZ33', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZ33', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZ34', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZ34', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZ35', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZ35', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZ38', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZ38', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZ75', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZ75', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZ98', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZ98', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZ99', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZ99', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZA0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZA0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZA1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZA1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZA2', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZA2', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZA3', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZA3', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZA4', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZA4', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZA5', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZA5', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZA6', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZA6', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZA7', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZA7', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZA8', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZA8', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZA9', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZA9', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZB0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'NZB0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'TO85', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XN3', N'TO85', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XNK1', N'TN01', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XNK1', N'TN01', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XNK1', N'TN02', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XNK1', N'TN02', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XNK1', N'TN04', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XNK1', N'TN04', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XNK1', N'TN05', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XNK1', N'TN05', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XNK1', N'TN08', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XNK1', N'TN08', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XNK1', N'TN15', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XNK1', N'TN15', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'KX11', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'KX11', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'KX12', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'KX12', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'KX14', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'KX14', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'MA', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'MA', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'MAP6', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'MAP6', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'MAP7', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'MAP7', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'MAP8', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'MAP8', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'MAP9', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'MAP9', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'MAQ0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'MAQ0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'MAQ1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'MAQ1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'MAQ2', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ1', N'MAQ2', 2, CAST(N'2019-03-27' AS Date))
GO
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'KX11', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'KX11', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'KX12', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'KX12', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'KX14', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'KX14', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'MA', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'MA', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'MAP6', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'MAP6', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'MAP7', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'MAP7', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'MAP8', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'MAP8', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'MAP9', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'MAP9', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'MAQ0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'MAQ0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'MAQ1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'MAQ1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'MAQ2', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ2', N'MAQ2', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'KX11', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'KX11', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'KX12', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'KX12', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'KX14', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'KX14', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'MA', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'MA', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'MAP6', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'MAP6', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'MAP7', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'MAP7', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'MAP8', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'MAP8', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'MAP9', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'MAP9', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'MAQ0', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'MAQ0', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'MAQ1', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'MAQ1', 2, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'MAQ2', 1, CAST(N'2019-03-27' AS Date))
INSERT [dbo].[ThucHienCLS] ([IDPhongCLS], [DichVuCLSThucHien], [CaKham], [Ngay]) VALUES (N'XQ3', N'MAQ2', 2, CAST(N'2019-03-27' AS Date))
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__BenhNhan__B9137313204755C6]    Script Date: 5/26/2019 12:22:09 PM ******/
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
ALTER TABLE [dbo].[PhongKhamChuyenKhoa]  WITH CHECK ADD  CONSTRAINT [FK_PK_ChuyenKhoa] FOREIGN KEY([ChuyenKhoa])
REFERENCES [dbo].[ChuyenKhoa] ([IDChuyenKhoa])
GO
ALTER TABLE [dbo].[PhongKhamChuyenKhoa] CHECK CONSTRAINT [FK_PK_ChuyenKhoa]
GO
ALTER TABLE [dbo].[SoHienThiPhongCanLamSang]  WITH CHECK ADD  CONSTRAINT [FK_HienThi_PhongCanLamSang] FOREIGN KEY([IDPhongCanLamSang])
REFERENCES [dbo].[PhongCanLamSang] ([ID])
GO
ALTER TABLE [dbo].[SoHienThiPhongCanLamSang] CHECK CONSTRAINT [FK_HienThi_PhongCanLamSang]
GO
ALTER TABLE [dbo].[SoHienThiPhongCanLamSang]  WITH CHECK ADD  CONSTRAINT [FK_HienThi_STTPhongCanLamSang] FOREIGN KEY([IDPhieuKham], [STT], [CanLamSang])
REFERENCES [dbo].[SoThuTuPhongCLS] ([IDPhieuKham], [STT], [CanLamSang])
GO
ALTER TABLE [dbo].[SoHienThiPhongCanLamSang] CHECK CONSTRAINT [FK_HienThi_STTPhongCanLamSang]
GO
ALTER TABLE [dbo].[SoHienThiPhongKham]  WITH CHECK ADD  CONSTRAINT [FK_HienThi_STTPhongKham] FOREIGN KEY([IDPhieuKham], [STT], [BanKham], [PhongKham])
REFERENCES [dbo].[SoThuTuPhongKham] ([IDPhieuKham], [STT], [BanKham], [PhongKham])
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
ALTER TABLE [dbo].[ThongKePhongCLS]  WITH CHECK ADD  CONSTRAINT [FK_TK_CKham] FOREIGN KEY([CaKham])
REFERENCES [dbo].[CaKham] ([IDCa])
GO
ALTER TABLE [dbo].[ThongKePhongCLS] CHECK CONSTRAINT [FK_TK_CKham]
GO
ALTER TABLE [dbo].[ThongKePhongCLS]  WITH CHECK ADD  CONSTRAINT [FK_TK_PCLS] FOREIGN KEY([IDPhongCLS])
REFERENCES [dbo].[PhongCanLamSang] ([ID])
GO
ALTER TABLE [dbo].[ThongKePhongCLS] CHECK CONSTRAINT [FK_TK_PCLS]
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
/****** Object:  StoredProcedure [dbo].[BacSiTheoChuyenKhoa]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[BacSiTheoChuyenKhoa]
@ChuyenKhoa nvarchar(10)
as
begin
select bs.ID, bs.HovaTen, bs.GioiTinh, bs.NamSinh, bs.QueQuan, bs.ChuyenKhoa,ck.TenChuyenKhoa,lk.IDBan,bk.SoBan ,lk.phong as IDPhong,pk.SoPhong ,bs.ThoiGianKhamTB_min,lk.CaKham
from BacSi bs
inner join ChuyenKhoa ck on bs.ChuyenKhoa=ck.IDChuyenKhoa
inner join LichKhamBacSi lk on lk.IDBacSi=bs.ID
inner join PhongKhamChuyenKhoa pk on pk.ID=lk.Phong
inner join BanKham bk on bk.IDBan=lk.IDBan and bk.Phong=lk.Phong
where bs.ChuyenKhoa=@ChuyenKhoa
order by lk.CaKham,lk.IDBan
end;
GO
/****** Object:  StoredProcedure [dbo].[BamSoHienThiPhongCLS]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[BamSoHienThiPhongCLS] @IDPhong nvarchar(10),@CaKham int
as begin
	declare @STTnext int, @STTcur int,@IDPKnext nvarchar(10),@SoLuongDoi int
	set @STTcur = (select STT from SoHienThiPhongCanLamSang where  IDPhongCanLamSang=@IDPhong and CaKham=@CaKham
	and Gio>=all(select Gio from SoHienThiPhongCanLamSang where  IDPhongCanLamSang=@IDPhong and CaKham=@CaKham)group by STT)
	if(@STTcur is null)
	begin
		set @STTcur=0;
	end;
	set @STTnext = @STTcur+1
	set @IDPKnext = (select IDPhieuKham from SoThuTuPhongCLS where STT=@STTnext and PhongCanLamSang=@IDPhong and CaKham=@CaKham )
	-- Tao so hien thi
	insert into SoHienThiPhongCanLamSang(IDPhongCanLamSang,STT,IDPhieuKham,CanLamSang,Gio,TinhTrang,CaKham)
	select STT.PhongCanLamSang,STT.STT,STT.IDPhieuKham,STT.CanLamSang,dateadd (minute,2,Gio),1 as TinhTrang,@CaKham from SoThuTuPhongCLS as STT 
	where STT.IDPhieuKham=@IDPKnext and STT.PhongCanLamSang=@IDPhong;
	-- Lay so hien thi
	select *from SoHienThiPhongCanLamSang as STT join PhongCanLamSang as PCLS on PCLS.ID=STT.IDPhongCanLamSang
	where STT.IDPhieuKham=@IDPKnext  and STT.IDPhongCanLamSang=@IDPhong and STT.CaKham=@CaKham;
	set @SoLuongDoi=(select SoLuongDoi from ThongKePhongCLS where IDPhongCLS=@IDPhong and CaKham=@CaKham)
	if(@SoLuongDoi>0)
	begin
	update ThongKePhongCLS
	set SoLuongDoi=SoLuongDoi-1
	where  IDPhongCLS=@IDPhong and CaKham=@CaKham;
	end;
	else if(@SoLuongDoi <=0)
	begin
	update ThongKePhongCLS
	set SoLuongDoi=0
	where  IDPhongCLS=@IDPhong and CaKham=@CaKham;
	end;
end;
GO
/****** Object:  StoredProcedure [dbo].[BamSoHienThiPhongKham]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[BamSoHienThiPhongKham] @IDBanKham nvarchar(10), @IDPhong nvarchar(10),@CaKham int
as begin
    declare @STTnext int, @STTcur int,@IDPKnext nvarchar(10),@SoLuongDoi int;
	set @STTcur = (select STT from SoHienThiPhongKham where BanKham=@IDBanKham and PhongKham=@IDPhong and CaKham=@CaKham
	and Gio>=all(select Gio from SoHienThiPhongKham where BanKham=@IDBanKham and  PhongKham=@IDPhong) 	 group by STT);
	if(@STTcur is null)
	begin
		set @STTcur=0;
	end;
	set @STTnext = @STTcur+1
	set @IDPKnext = (select IDPhieuKham from SoThuTuPhongKham where BanKham=@IDBanKham and  STT=@STTnext and PhongKham=@IDPhong and CaKham=@CaKham );
	-- Tao so hien thi
	insert into SoHienThiPhongKham (STT,BanKham,PhongKham,IDPhieuKham,Gio,TinhTrang,CaKham)
	select STT.STT,STT.BanKham,STT.PhongKham,STT.IDPhieuKham,dateadd (minute,2,Gio),1 as TinhTrang,@CaKham from SoThuTuPhongKham as STT 
	where STT.IDPhieuKham=@IDPKnext and   STT.BanKham=@IDBanKham and STT.PhongKham=@IDPhong;
	-- Lay so hien thi
	select STT.STT,STT.BanKham as IDban,Bk.SoBan,STT.PhongKham as IDPhong,PK.SoPhong,STT.Gio,STT.TinhTrang,STT.CaKham from  SoHienThiPhongKham as STT join PhongKhamChuyenKhoa as PK on PK.ID=STT.PhongKham
										join BanKham as BK on BK.IDBan=STT.BanKham and BK.Phong=STT.PhongKham
	where STT.IDPhieuKham=@IDPKnext and   STT.BanKham=@IDBanKham and STT.PhongKham= @IDPhong and STT.CaKham=@CaKham;
	set @SoLuongDoi=(select SoLuongDoi from ThongKePhongKham where IDBan=@IDBanKham and Phong=@IDPhong and CaKham=@CaKham )
	if(@SoLuongDoi>0)
	begin
	update ThongKePhongKham
	set SoLuongDoi=SoLuongDoi-1
	where IDBan=@IDBanKham and Phong=@IDPhong and CaKham=@CaKham;
	end;
	else if(@SoLuongDoi<=0)
	begin
	update ThongKePhongKham
	set SoLuongDoi=0
	where IDBan=@IDBanKham and Phong=@IDPhong and CaKham=@CaKham;
	end;
end;
GO
/****** Object:  StoredProcedure [dbo].[CheckBenhNhan]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[CheckBenhNhan] @CMND_CCCD nvarchar(20)
 as begin
	select * from BenhNhan where BenhNhan.CMND_CCCD = @CMND_CCCD
end;
GO
/****** Object:  StoredProcedure [dbo].[CheckCanLamSang]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[CheckCanLamSang]  @IDDichVu nvarchar(10), @IDPhieuKham nvarchar(10)
as
begin
	declare @IDChuyenKhoa nvarchar(10),@IDBNXN nvarchar(10)
	if(@IDDichVu = 'TN08' or @IDDichVu = 'MZ09')
	begin
	select 0 as KetQua;
	end;
	else if(@IDDichVu != 'TN08' and @IDDichVu != 'MZ09')
	begin
	select @IDChuyenKhoa=CK.IDChuyenKhoa
	from DichVuCanLamSang as DV join LoaiDichVu as Loai on Loai.IDLoaiDichVu=DV.LoaiDichVu
								join ChuyenKhoa as CK on CK.IDChuyenKhoa=Loai.ChuyenKhoa
	where DV.IDDichVu=@IDDichVu 
		if( @IDChuyenKhoa = 'DH')
		begin
		set @IDBNXN = 'XN' + right(@IDPhieuKham,7);
		insert into BenhNhanXetNghiem values(@IDPhieuKham,@IDDichVu,@IDBNXN,GETDATE());
		end;
		else 
		begin 
		select 0 as KetQua;
		end;
	end;
end;
GO
/****** Object:  StoredProcedure [dbo].[CheckPhieuKham]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[CheckPhieuKham] @IDPhieuKham nvarchar(10)
as begin
	declare @temp int;
	set @temp=(select count(*) from PhieuKham where IDPhieuKham=@IDPhieuKham)
	if(@temp!=0)
	begin
	select PK.IDPhieuKham,PK.Ngay,BN.Ho,BN.TenLot,BN.Ten,BN.CMND_CCCD,BN.GioiTinh,BN.NgheNghiep,BN.NgaySinh,BN.SDT,BN.QueQuan,BN.Diachi
    from PhieuKham as PK inner join BenhNhan as BN on Bn.ID=PK.IDBenhNhan
	where PK.IDPhieuKham=@IDPhieuKham;
	end;
	else if(@temp=0)
	begin
	select @temp as Temp;
	end;
end;
GO
/****** Object:  StoredProcedure [dbo].[ChiTietCanLamSangTheoChuyenKhoa]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[ChiTietCanLamSangTheoChuyenKhoa] @IDChuyenKhoa nvarchar(10)
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
GO
/****** Object:  StoredProcedure [dbo].[ChiTietCanLamSangTheoLoaiDichVu]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[ChiTietCanLamSangTheoLoaiDichVu] @IDLoaiDichVu nvarchar(10)
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
GO
/****** Object:  StoredProcedure [dbo].[ChiTietCanLamSangTheoTenDichVu]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[ChiTietCanLamSangTheoTenDichVu] @IDDichVu nvarchar(10)
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
GO
/****** Object:  StoredProcedure [dbo].[DanhSachBacSiThuocChuyenKhoa]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[DanhSachBacSiThuocChuyenKhoa] @IDChuyenKhoa nvarchar(10)
as
begin
select distinct bs.ID as IDBacSi, bs.HovaTen
from BacSi bs
inner join PhongKhamChuyenKhoa p on p.ChuyenKhoa=bs.ChuyenKhoa
where @IDChuyenKhoa = p.ChuyenKhoa
end;
GO
/****** Object:  StoredProcedure [dbo].[DanhSachChuyenKhoaCLS]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[DanhSachChuyenKhoaCLS]
as
begin
select ck.IDChuyenKhoa, ck.TenChuyenKhoa
from  ChuyenKhoa ck 
where ck.IDDonViChucNang=5
end;
GO
/****** Object:  StoredProcedure [dbo].[DanhSachChuyenKhoaLamSang]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[DanhSachChuyenKhoaLamSang]
as
begin
select ck.IDChuyenKhoa, ck.TenChuyenKhoa
from  ChuyenKhoa ck 
where ck.IDDonViChucNang = 1
end;
GO
/****** Object:  StoredProcedure [dbo].[DanhSachCLS]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DanhSachCLS] 
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
/****** Object:  StoredProcedure [dbo].[DanhSachDichVuCanLamSangTheoChuyenKhoa]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[DanhSachDichVuCanLamSangTheoChuyenKhoa] @IDChuyenKhoa nvarchar(10)
as
begin
	select dv.IDDichVu, dv.TenDichVu
	from  DichVuCanLamSang dv
	inner join LoaiDichVu ldv on ldv.IDLoaiDichVu=dv.LoaiDichVu	
where @IDChuyenKhoa =ldv.ChuyenKhoa
end;
GO
/****** Object:  StoredProcedure [dbo].[DanhSachPhongCanLamSangTheoChuyenKhoa]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[DanhSachPhongCanLamSangTheoChuyenKhoa] @IDChuyenKhoa nvarchar(10)
as
begin
	select  P.ID as IDPhong,P.SoPhong 
	from PhongCanLamSang P
where @IDChuyenKhoa =P.TrucThuoc
end;
GO
/****** Object:  StoredProcedure [dbo].[DanhSachPhongKhamBanKhamTheoChuyenKhoa]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[DanhSachPhongKhamBanKhamTheoChuyenKhoa] @IDChuyenKhoa nvarchar(10)
as
begin
select p.ID as IDPhong,p.SoPhong,bk.IDBan, bk.SoBan,p.ChuyenKhoa as IDChuyenKhoa, ck.TenChuyenKhoa
from PhongKhamChuyenKhoa p
inner join ChuyenKhoa ck on ck.IDChuyenKhoa=p.ChuyenKhoa
inner join BanKham bk on bk.Phong=p.ID
where @IDChuyenKhoa = p.ChuyenKhoa
end;
GO
/****** Object:  StoredProcedure [dbo].[DemSoDoi]    Script Date: 5/26/2019 12:22:09 PM ******/
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
where sttpk.TinhTrang=N'Chua'  and LK.Phong=sttpk.PhongKham 
group by sttpk.BanKham, sttpk.PhongKham,sttpk.CaKham,BS.ThoiGianKhamTB_min
end;
GO
/****** Object:  StoredProcedure [dbo].[HienThiLichSuTimKiem]    Script Date: 5/26/2019 12:22:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[HienThiThongTinBN]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[HienThiThongTinBN]
@ID nvarchar(10)
AS
BEGIN
select (BN.Ho + ' ' +BN.TenLot + ' ' + BN.Ten) AS HoVaTen, BN.GioiTinh, BN.NgaySinh, datediff(year,BN.NgaySinh,getdate()) AS Tuoi, BN.QueQuan, BN.CMND_CCCD, BN.DiaChi, BN.NgheNghiep, BN.SDT, null as NguoiThan
from BenhNhan BN
where BN.ID=@ID
END;
GO
/****** Object:  StoredProcedure [dbo].[LaySTT]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[LaySTT] @IDBenhNhan nvarchar(10)
as begin
	select distinct IDBenhNhan,B.STT as STTPhongKham,B.SoPhong,B.SoBan,B.TenChuyenKhoa,convert(time,B.Gio) as ThoiGianDuKien,B.TinhTrang,A.SoHienTaiCuaPhong
	from 
		(select IDBenhNhan,STTPK.IDPhieuKham,STTPK.STT,STTPK.BanKham,bk.SoBan,STTPK.PhongKham,PKCK.SoPhong,CK.TenChuyenKhoa,STTPK.Gio,STTPK.TinhTrang
		from BenhNhan as BN join PhieuKham as PK on BN.ID=PK.IDBenhNhan  join SoThuTuPhongKham as STTPK on STTPK.IDPhieuKham= PK.IDPhieuKham
		join  BanKham as BK on BK.IDBan = STTPK.BanKham join PhongKhamChuyenKhoa as PKCK on PKCK.ID = BK.Phong and PKCK.ID=STTPK.PhongKham
		join ChuyenKhoa as CK on Ck.IDChuyenKhoa=PKCK.ChuyenKhoa
		where IDBenhNhan=@IDBenhNhan) as B
		 left outer join
		(select BK.IDBan as IDBan,BK.SoBan, PK.ID as IDPhongKham,PK.SoPhong,max(STT) as SoHienTaiCuaPhong from SoHienThiPhongKham as SHT 
		join BanKham as BK on BK.IDBan=SHT.BanKham join PhongKhamChuyenKhoa as PK on PK.ID=Bk.Phong 
		where BK.Phong=SHT.PhongKham 
		group by Bk.IDBan,BK.SoBan,PK.ID,PK.SoPhong) as A on A.IDBan=B.BanKham and A.IDPhongKham=B.PhongKham;

	select distinct IDBenhNhan,STTCLS.STT as STTPhongCLS, PCLS.SoPhong,DV.TenDichVu as TenCanLamSang,convert(time, STTCLS.Gio) as ThoiGianDuKien,STTCLS.TinhTrang,A.SoHienTaiCuaPhong
	from BenhNhan as BN join PhieuKham as PK on BN.ID=PK.IDBenhNhan join SoThuTuPhongCLS as STTCLS on STTCLS.IDPhieuKham=PK.IDPhieuKham 
		join PhongCanLamSang as PCLS on PCLS.ID=STTCLS.PhongCanLamSang
		left outer join (select PCLS.ID as IDPhongCLS,PCLS.SoPhong,max(STT) as SoHienTaiCuaPhong 
			 from SoHienThiPhongCanLamSang as SHT join PhongCanLamSang as PCLS on PCLS.ID=SHT.IDPhongCanLamSang
	group by PCLS.ID,PCLS.SoPhong) as A on A.IDPhongCLS=PCLS.ID join ThucHienCLS as TH on TH.IDPhongCLS=PCLS.ID 
	join  DichVuCanLamSang as DV on DV.IDDichVu =TH.DichVuCLSThucHien 
	where IDBenhNhan=@IDBenhNhan and STTCLS.CanLamSang=TH.DichVuCLSThucHien ;
	end;
GO
/****** Object:  StoredProcedure [dbo].[LaySTTPhongKham]    Script Date: 5/26/2019 12:22:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[LayThongTinBenhNhan]    Script Date: 5/26/2019 12:22:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[LuuSoHienThiPhongKham]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[LuuSoHienThiPhongKham] @Ca int
as begin
	update SoHienThiPhongKham 
	set TinhTrang=0
	where CaKham =@Ca;
end
GO
/****** Object:  StoredProcedure [dbo].[PhatSinhSTTCLSCa1]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PhatSinhSTTCLSCa1] @IDPhieuKham nvarchar(10),@IDDichVuCLS nvarchar(10)
as begin 
	declare @IDPhongCLS nvarchar(10),@STTcur int,@STTnew int,@GioDuKien datetime,@GioHienTai datetime,@GioDuKiennew datetime,
	@temp int,@temp1 int,@Timenhayso time,@IDDichVu nvarchar(10), @hieu1 int,@GioBatDau time,@GioKetThuc time,@hieu int,@TimeDuKien datetime;
	set @GioHienTai='2019-03-27 07:00:0.000';
	select @temp1=count(*)
	from ThongKeCLSChiTiet as CT 
	where CaKham=1 and CT.DichVuCLSThucHien =@IDDichVuCLS and CT.GioDuKienCuoi<=all( select CT.GioDuKienCuoi from ThongKeCLSChiTiet as CT          
	where CT.DichVuCLSThucHien =@IDDichVuCLS and CaKham=1);
	select @temp=count(*)
	from ThongKeCLSChiTiet_Null as CT inner join ThongKeCLS as CLS on CLS.IDPhongCLS=CT.IDPhongCLS
	where CLS.DichVuCLSThucHien =@IDDichVuCLS and CLS.CaKham=1 and CT.CaKham=1  and CT.IDPhongCLS not in
	 (select STT.PhongCanLamSang from SoThuTuPhongCLS as STT where CaKham=1);
	if(@temp1>0 and @temp=0)
	begin
		select top(1) @IDPhongCLS = CT.IDPhongCLS,@STTcur=CT.SoSTTPhatSinhCuoi,@Timenhayso=CLS.ThoiGianNhaySoTB,@GioDuKien=CT.GioDuKienCuoi,@GioBatDau=CLS.GioBatDau,@GioKetThuc=CLS.GioKetThuc
		from ThongKeCLSChiTiet as CT join ThongKeCLS as CLS on CLS.IDPhongCLS=CT.IDPhongCLS and CLS.DichVuCLSThucHien=@IDDichVuCLS
		where CT.CaKham=1 and CLS.CaKham=CT.CaKham and CT.DichVuCLSThucHien =@IDDichVuCLS and CT.GioDuKienCuoi<=all( select CT.GioDuKienCuoi from ThongKeCLSChiTiet as CT          
		where CT.DichVuCLSThucHien =@IDDichVuCLS and CT.CaKham=1)
		if(@GioDuKien<@GioHienTai)
		begin
			set @STTnew=@STTcur+1;
			set @GioDuKiennew=(select dbo.CongThoiGian(@Timenhayso,@GioHienTai));
			set @hieu = (select DATEDIFF(minute,@GioKetThuc,convert(time,@GioDuKiennew)));
			if(@hieu<0)
			begin
			insert into SoThuTuPhongCLS values(@IDPhieuKham,@STTnew,@IDDichVuCLS,@IDPhongCLS,null,@GioDuKiennew,N'Chua');
			update ThongKePhongCLS
			set SoLuongDoi=SoLuongDoi+1
			where IDPhongCLS=@IDPhongCLS and CaKham=1;
			select * from SoThuTuPhongCLS where IDPhieuKham=@IDPhieuKham and STT=@STTnew and PhongCanLamSang=@IDPhongCLS;
			end;
			else if(@hieu>=0)
			begin
			exec PhatSinhSTTCLSCa2 @IDPhieuKham, @IDDichVuCLS;
			end;
		end;
		else if(@GioDuKien>=@GioHienTai)
		begin
			set @STTnew=@STTcur+1;
			set @GioDuKiennew=(select dbo.CongThoiGian(@Timenhayso,@GioDuKien));
			set @hieu = (select DATEDIFF(minute,@GioKetThuc,convert(time,@GioDuKiennew)));
			if(@hieu<0)
			begin
			insert into SoThuTuPhongCLS values(@IDPhieuKham,@STTnew,@IDDichVuCLS,@IDPhongCLS,null,@GioDuKiennew,N'Chua');
			update ThongKePhongCLS
			set SoLuongDoi=SoLuongDoi+1
			where IDPhongCLS=@IDPhongCLS and CaKham=1;
			select * from SoThuTuPhongCLS where IDPhieuKham=@IDPhieuKham and STT=@STTnew and PhongCanLamSang=@IDPhongCLS;
			end;
			else if(@hieu>=0)
			begin
			exec PhatSinhSTTCLSCa2 @IDPhieuKham, @IDDichVuCLS;
			end;
		end;
	end;
	else if(@temp>0)
	begin
		select top(1) @IDPhongCLS = CT.IDPhongCLS,@Timenhayso=CLS.ThoiGianNhaySoTB,@GioBatDau=CLS.GioBatDau,@GioKetThuc=CLS.GioKetThuc
		from ThongKeCLSChiTiet_Null as CT inner join ThongKeCLS as CLS on CLS.IDPhongCLS=CT.IDPhongCLS
		where CT.CaKham=1 and CLS.CaKham=1 and CLS.DichVuCLSThucHien =@IDDichVuCLS and CT.IDPhongCLS not in (select STT.PhongCanLamSang from SoThuTuPhongCLS as STT where STT.CaKham=1);
		set @STTnew=1;
		set @TimeDuKien=(select  convert(datetime2,'2019-03-27 '+ convert(varchar,@GioBatDau)));
		insert into SoThuTuPhongCLS values(@IDPhieuKham,@STTnew,@IDDichVuCLS,@IDPhongCLS,null,@TimeDuKien,N'Chua');
		update ThongKePhongCLS
		set SoLuongDoi=SoLuongDoi+1
		where IDPhongCLS=@IDPhongCLS and CaKham=1;
		select * from SoThuTuPhongCLS where IDPhieuKham=@IDPhieuKham and STT=@STTnew and PhongCanLamSang=@IDPhongCLS;
	end;
	
end;
GO
/****** Object:  StoredProcedure [dbo].[PhatSinhSTTCLSCa2]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PhatSinhSTTCLSCa2] @IDPhieuKham nvarchar(10),@IDDichVuCLS nvarchar(10)
as begin 
	declare @IDPhongCLS nvarchar(10),@STTcur int,@STTnew int,@GioDuKien datetime,@GioHienTai datetime,@GioDuKiennew datetime,
	@temp int,@temp1 int,@Timenhayso time,@IDDichVu nvarchar(10),@GioBatDau time,@GioKetThuc time,@TimeDuKien datetime;
	set @GioHienTai='2019-03-27 13:00:0.000';
	select @temp1=count(*)
	from ThongKeCLSChiTiet as CT 
	where CaKham=2 and CT.DichVuCLSThucHien =@IDDichVuCLS and CT.GioDuKienCuoi<=all( select CT.GioDuKienCuoi from ThongKeCLSChiTiet as CT          
	where CT.DichVuCLSThucHien =@IDDichVuCLS and CaKham=2);
	select @temp=count(*)
	from ThongKeCLSChiTiet_Null as CT inner join ThongKeCLS as CLS on CLS.IDPhongCLS=CT.IDPhongCLS
	where CLS.DichVuCLSThucHien =@IDDichVuCLS and CLS.CaKham=2 and CT.CaKham=2  and CT.IDPhongCLS not in
	 (select STT.PhongCanLamSang from SoThuTuPhongCLS as STT where CaKham=2);
	if(@temp1>0 and @temp=0)
	begin
		select top(1) @IDPhongCLS = CT.IDPhongCLS,@STTcur=CT.SoSTTPhatSinhCuoi,@Timenhayso=CLS.ThoiGianNhaySoTB,@GioDuKien=CT.GioDuKienCuoi,@GioBatDau=CLS.GioBatDau,@GioKetThuc=CLS.GioKetThuc
		from ThongKeCLSChiTiet as CT join ThongKeCLS as CLS on CLS.IDPhongCLS=CT.IDPhongCLS and CLS.DichVuCLSThucHien=@IDDichVuCLS
		where CT.CaKham=2 and CLS.CaKham=CT.CaKham  and CT.DichVuCLSThucHien =@IDDichVuCLS and CT.GioDuKienCuoi<=all( select CT.GioDuKienCuoi from ThongKeCLSChiTiet as CT          
		where CT.DichVuCLSThucHien =@IDDichVuCLS and CT.CaKham=2)
		if(@GioDuKien<@GioHienTai)
		begin
			set @STTnew=@STTcur+1;
			set @GioDuKiennew=(select dbo.CongThoiGian(@Timenhayso,@GioHienTai));
			insert into SoThuTuPhongCLS values(@IDPhieuKham,@STTnew,@IDDichVuCLS,@IDPhongCLS,null,@GioDuKiennew,N'Chua');
			update ThongKePhongCLS
			set SoLuongDoi=SoLuongDoi+1
			where IDPhongCLS=@IDPhongCLS and CaKham=2;
			select * from SoThuTuPhongCLS where IDPhieuKham=@IDPhieuKham and STT=@STTnew and PhongCanLamSang=@IDPhongCLS;
		end;
		else if(@GioDuKien>=@GioHienTai)
		begin
			set @STTnew=@STTcur+1;
			set @GioDuKiennew=(select dbo.CongThoiGian(@Timenhayso,@GioDuKien));
			insert into SoThuTuPhongCLS values(@IDPhieuKham,@STTnew,@IDDichVuCLS,@IDPhongCLS,null,@GioDuKiennew,N'Chua');
			update ThongKePhongCLS
			set SoLuongDoi=SoLuongDoi+1
			where IDPhongCLS=@IDPhongCLS and CaKham=2;		
			select * from SoThuTuPhongCLS where IDPhieuKham=@IDPhieuKham and STT=@STTnew and PhongCanLamSang=@IDPhongCLS;
		end;
	end;
	else if(@temp>0)
	begin
		select top(1) @IDPhongCLS = CT.IDPhongCLS,@Timenhayso=CLS.ThoiGianNhaySoTB,@GioBatDau=CLS.GioBatDau,@GioKetThuc=CLS.GioKetThuc
		from ThongKeCLSChiTiet_Null as CT inner join ThongKeCLS as CLS on CLS.IDPhongCLS=CT.IDPhongCLS
		where CT.CaKham=2 and CLS.CaKham=2 and CLS.DichVuCLSThucHien =@IDDichVuCLS and CT.IDPhongCLS not in (select STT.PhongCanLamSang from SoThuTuPhongCLS as STT where STT.CaKham=2);
		set @STTnew=1;
		set @TimeDuKien=(select  convert(datetime2,'2019-03-27 '+ convert(varchar,@GioBatDau)));
		insert into SoThuTuPhongCLS values(@IDPhieuKham,@STTnew,@IDDichVuCLS,@IDPhongCLS,null,@TimeDuKien,N'Chua');
		update ThongKePhongCLS
		set SoLuongDoi=SoLuongDoi+1
		where IDPhongCLS=@IDPhongCLS and CaKham=2;
		select * from SoThuTuPhongCLS where IDPhieuKham=@IDPhieuKham and STT=@STTnew and PhongCanLamSang=@IDPhongCLS;
	end;
	
end;
GO
/****** Object:  StoredProcedure [dbo].[PhatSinhSTTPhongKham_BacSiCa1]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PhatSinhSTTPhongKham_BacSiCa1] @IDPhieuKham nvarchar(10), @IDChuyenKhoa nvarchar(10),@IDBacSi nvarchar(10)
as begin
	declare @STT int,@STTnew int,@BanKham nvarchar(10),@PhongKham nvarchar(10),@TimeTB time,@CaKham int,@SoLuongDoi int,
			@GioDuKien datetime,@GioDuKien_new datetime,@temp int,@Timecur datetime;
	set @Timecur='2019-03-27 07:00:00';
	select @temp=count(*)
	from SoThuTuPhongKham as STT inner join LichKhamBacSi as LK on LK.IDBan=STT.BanKham and LK.Phong=STT.PhongKham
	where IDBacSi=@IDBacSi and LK.CaKham=1 and STT.CaKham=1;
	if(@temp=0)
	begin 
		set @STTnew=1;
		select @BanKham= BK.IDBan,@PhongKham=BK.Phong,@CaKham= Lk.CaKham,@TimeTB= BS.ThoiGianKhamTB_min
		from BanKham as BK inner join LichKhamBacSi as LK on LK.IDBan=BK.IDBan and LK.Phong=BK.Phong 
						   inner join BacSi as BS on BS.ID=LK.IDBacSi
		where BS.ChuyenKhoa=@IDChuyenKhoa and BS.ID=@IDBacSi and LK.CaKham=1;
		set @GioDuKien_new=(select dbo.CongThoiGian(@TimeTB,'2019-03-27 07:00:00'));
		insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chua');
		update ThongKePhongKham
		set SoLuongDoi=SoLuongDoi+1
		where IDBan=@BanKham and Phong=@PhongKham and CaKham=1;
	end;
	else
	begin
		select  @BanKham= BK.IDBan,@PhongKham=BK.Phong,@STT=TK.STT, @CaKham= Lk.CaKham,@TimeTB= BS.ThoiGianKhamTB_min,@GioDuKien=TK.GioDuKienSoCuoi
		from BanKham as BK inner join ThongKeSTTCuoiPhongKham as TK on TK.BanKham=BK.IDBan and TK.PhongKham=BK.Phong
						   inner join LichKhamBacSi as LK on LK.IDBan=TK.BanKham and LK.Phong=TK.PhongKham
						   inner join BacSi as BS on BS.ID=LK.IDBacSi 
		where BS.ChuyenKhoa=@IDChuyenKhoa and BS.ID=@IDBacSi and LK.CaKham=1 and TK.CaKham=1;
		if( @GioDuKien<@Timecur)
		begin
				set @STTnew=@STT +1;
				set @GioDuKien_new=(select dbo.CongThoiGian(@TimeTB,@Timecur));
				declare @hieu int;
				set @hieu = (select DATEDIFF(minute,'12:00:00.0000000',convert(time,@GioDuKien_new)));
				if(@hieu>=0)
				begin
				insert into SoThuTuPhongKhamBacSi_Overtime values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,getdate(),N'Chua',@IDBacSi);
				end;
				else if(@hieu<0)
				begin
				insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chua');
				update ThongKePhongKham
				set SoLuongDoi=SoLuongDoi+1
				where IDBan=@BanKham and Phong=@PhongKham and CaKham=1;
				end;
		end;
		else
		begin
			set @STTnew=@STT +1;
			set @GioDuKien_new=(select dbo.CongThoiGian(@TimeTB,@GioDuKien));
			declare @hieu1 int;
				set @hieu1 = (select DATEDIFF(minute,'12:00:00.0000000',convert(time,@GioDuKien_new)));
				if(@hieu1>=0)
				begin
				insert into SoThuTuPhongKhamBacSi_Overtime values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,getdate(),N'Chua',@IDBacSi);
				end;
				else if(@hieu1<0)
				begin
				insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chua');
				update ThongKePhongKham
				set SoLuongDoi=SoLuongDoi+1
				where IDBan=@BanKham and Phong=@PhongKham and CaKham=1;
				end;
		end;
	end;
	select * from SoThuTuPhongKham where IDPhieuKham=@IDPhieuKham and STT=@STTnew and BanKham=@BanKham and PhongKham=@PhongKham and CaKham=1;
end;
GO
/****** Object:  StoredProcedure [dbo].[PhatSinhSTTPhongKham_BacSiCa2]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PhatSinhSTTPhongKham_BacSiCa2] @IDPhieuKham nvarchar(10), @IDChuyenKhoa nvarchar(10),@IDBacSi nvarchar(10)
as begin
	declare @STT int,@STTnew int,@BanKham nvarchar(10),@PhongKham nvarchar(10),@TimeTB time,@CaKham int,@SoLuongDoi int,
			@GioDuKien datetime,@GioDuKien_new datetime,@temp int,@Timecur datetime;
	set @Timecur='2019-03-27 13:00:00';
	select @temp=count(*)
	from SoThuTuPhongKham as STT inner join LichKhamBacSi as LK on LK.IDBan=STT.BanKham and LK.Phong=STT.PhongKham
	where IDBacSi=@IDBacSi and LK.CaKham=2 and STT.CaKham=2;
	if(@temp=0)
	begin  
		set @STTnew=1;
		select @BanKham= BK.IDBan,@PhongKham=BK.Phong,@CaKham= Lk.CaKham,@TimeTB= BS.ThoiGianKhamTB_min
		from BanKham as BK inner join LichKhamBacSi as LK on LK.IDBan=BK.IDBan and LK.Phong=BK.Phong 
						   inner join BacSi as BS on BS.ID=LK.IDBacSi
		where BS.ChuyenKhoa=@IDChuyenKhoa and BS.ID=@IDBacSi and LK.CaKham=2;
		set @GioDuKien_new=(select dbo.CongThoiGian(@TimeTB,'2019-03-27 13:00:00'));
		insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chua');
		update ThongKePhongKham
		set SoLuongDoi=SoLuongDoi+1
		where IDBan=@BanKham and Phong=@PhongKham and CaKham=2;
	end;
	else
	begin
		select  @BanKham= BK.IDBan,@PhongKham=BK.Phong,@STT=TK.STT, @CaKham= Lk.CaKham,@TimeTB= BS.ThoiGianKhamTB_min,@GioDuKien=TK.GioDuKienSoCuoi
		from BanKham as BK inner join ThongKeSTTCuoiPhongKham as TK on TK.BanKham=BK.IDBan and TK.PhongKham=BK.Phong
						   inner join LichKhamBacSi as LK on LK.IDBan=TK.BanKham and LK.Phong=TK.PhongKham
						   inner join BacSi as BS on BS.ID=LK.IDBacSi 
		where BS.ChuyenKhoa=@IDChuyenKhoa and BS.ID=@IDBacSi and LK.CaKham=2 and TK.CaKham=2;
		if( @GioDuKien<@Timecur)
		begin
				set @STTnew=@STT +1;
				set @GioDuKien_new=(select dbo.CongThoiGian(@TimeTB,@Timecur));
				insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chua');
				update ThongKePhongKham
				set SoLuongDoi=SoLuongDoi+1
				where IDBan=@BanKham and Phong=@PhongKham and CaKham=2;
		end;
		else
		begin
			set @STTnew=@STT +1;
			set @GioDuKien_new=(select dbo.CongThoiGian(@TimeTB,@GioDuKien));
				insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chua');
				update ThongKePhongKham
				set SoLuongDoi=SoLuongDoi+1
				where IDBan=@BanKham and Phong=@PhongKham and CaKham=2;
		end;
	end;
	select * from SoThuTuPhongKham where IDPhieuKham=@IDPhieuKham and STT=@STTnew and BanKham=@BanKham and PhongKham=@PhongKham and CaKham=2;
end;
GO
/****** Object:  StoredProcedure [dbo].[PhatSinhSTTPhongKhamCa1]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PhatSinhSTTPhongKhamCa1] @IDPhieuKham nvarchar(10), @IDChuyenKhoa nvarchar(10) 
as begin
	declare @STT int,@STTnew int,@BanKham nvarchar(10),@PhongKham nvarchar(10),@TimeTB time,@CaKham int,@SoLuongDoi int,
			@GioDuKien datetime,@GioDuKien_new datetime,@temp int,@temp1 int,@Timehientai datetime;
	set @Timehientai='2019-03-27 07:00:00';
	select @temp=count(*) 
	from ThongKeChiTiet_Null as TK join ThongKePhongKham as PK on PK.IDBan = TK.IDBan and PK.Phong=TK.Phong
	where PK.CaKham=1 and TK.CaKham=1 and TK.ThoiGianKhamTB_min<=all(select TK.ThoiGianKhamTB_min from ThongKeChiTiet_Null as TK join ThongKePhongKham as PK on PK.IDBan = TK.IDBan and PK.Phong=TK.Phong where  TK.ChuyenKhoa=@IDChuyenKhoa and PK.SoLuongDoi=0) 
	  and TK.ChuyenKhoa in (select TK.CHuyenKhoa from ThongKeChiTiet_Null as TK where  TK.ChuyenKhoa=@IDChuyenKhoa) and PK.SoLuongDoi=0 
	  and left(convert(char,TK.IDBan),3)+' '+ convert(char,TK.Phong)  not in (select left(convert(char,BanKham),3)+' '+ convert(char,PhongKham)  from SoHienThiPhongKham where CaKham=1)
	  and left(convert(char,TK.IDBan),3)+' '+ convert(char,TK.Phong) not in (select  left(convert(char,BanKham),3)+' '+ convert(char,PhongKham)  from SoThuTuPhongKham where CaKham=1);

	select @temp1= count(*)
	from (select distinct *
	from ThongKeChiTiet as TK where TK.CaKham=1 and ChuyenKhoa=@IDChuyenKhoa) as A;
	select @PhongKham=TK.PhongKham,@BanKham=TK.BanKham,@TimeTB=TK.ThoiGianKhamTB,@CaKham=TK.CaKham,@GioDuKien=TK.GioDuKienSoCuoi
	from ThongKeChiTiet as TK
	where ChuyenKhoa=@IDChuyenKhoa and TK.CaKham=1; 
	if( @PhongKham is null)
	begin 
		select @PhongKham=TK.Phong,@BanKham=TK.IDBan,@TimeTB=TK.ThoiGianKhamTB_min,@CaKham=TK.CaKham
		from ThongKeChiTiet_Null as TK join ThongKePhongKham as PK on PK.IDBan = TK.IDBan and PK.Phong=TK.Phong
		where TK.CaKham=1 and PK.CaKham=1 and TK.ThoiGianKhamTB_min<=all(select TK.ThoiGianKhamTB_min from ThongKeChiTiet_Null as TK join ThongKePhongKham as PK on PK.IDBan = TK.IDBan and PK.Phong=TK.Phong where  TK.ChuyenKhoa=@IDChuyenKhoa and PK.SoLuongDoi=0) 
		  and TK.ChuyenKhoa in (select TK.CHuyenKhoa from ThongKeChiTiet_Null as TK where  TK.ChuyenKhoa=@IDChuyenKhoa) and PK.SoLuongDoi=0 
		  and left(convert(char,TK.IDBan),3)+' '+ convert(char,TK.Phong)  not in (select left(convert(char,BanKham),3)+' '+ convert(char,PhongKham)  from SoHienThiPhongKham where CaKham=1)
		 and left(convert(char,TK.IDBan),3)+' '+ convert(char,TK.Phong) not in (select  left(convert(char,BanKham),3)+' '+ convert(char,PhongKham)  from SoThuTuPhongKham where CaKham =1)
		order by TK.IDBan,TK.Phong;
		set @STTnew=1;
		set @GioDuKien_new=(select dbo.CongThoiGian(@TimeTB,'2019-03-27 07:00:00'));
		insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chua');
		update ThongKePhongKham
		set SoLuongDoi=SoLuongDoi+1
		where IDBan=@BanKham and Phong=@PhongKham and CaKham=1;
	end;
	else
	begin
		if(@temp>0 and @temp1>0 )
		begin
			select @PhongKham=TK.Phong,@BanKham=TK.IDBan,@TimeTB=TK.ThoiGianKhamTB_min,@CaKham=TK.CaKham
			from ThongKeChiTiet_Null as TK join ThongKePhongKham as PK on PK.IDBan = TK.IDBan and PK.Phong=TK.Phong
			where TK.CaKham=1 and PK.CaKham=1 and TK.ThoiGianKhamTB_min<=all(select TK.ThoiGianKhamTB_min from ThongKeChiTiet_Null as TK join ThongKePhongKham as PK on PK.IDBan = TK.IDBan and PK.Phong=TK.Phong where  TK.ChuyenKhoa=@IDChuyenKhoa  and PK.SoLuongDoi=0) 
			 and TK.ChuyenKhoa in (select TK.CHuyenKhoa from ThongKeChiTiet_Null as TK where  TK.ChuyenKhoa=@IDChuyenKhoa) and PK.SoLuongDoi=0 
			 and left(convert(char,TK.IDBan),3)+' '+ convert(char,TK.Phong)  not in (select left(convert(char,BanKham),3)+' '+ convert(char,PhongKham)  from SoHienThiPhongKham where CaKham=1)
			 and left(convert(char,TK.IDBan),3)+' '+ convert(char,TK.Phong) not in (select  left(convert(char,BanKham),3)+' '+ convert(char,PhongKham)  from SoThuTuPhongKham where CaKham=1)
			order by TK.IDBan,TK.Phong;
			set @STTnew=1;
			set @GioDuKien_new=(select dbo.CongThoiGian(@TimeTB,'2019-03-27 07:00:00'));
			insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chua');
			update ThongKePhongKham
			set SoLuongDoi=SoLuongDoi+1
			where IDBan=@BanKham and Phong=@PhongKham and CaKham=1;
		end;
		else 
		begin 
			if(@GioDuKien<@Timehientai)
			begin
				select @STT=max(STT) from SoThuTuPhongKham as STT
				where STT.BanKham=@BanKham and STT.PhongKham=@PhongKham and CaKham=1;
				set @STTnew=@STT +1;
				set @GioDuKien_new=(select dbo.CongThoiGian(@TimeTB,@Timehientai)); 
				declare @hieu int;
				set @hieu = (select DATEDIFF(minute,'12:00:00.0000000',convert(time,@GioDuKien_new)));
				if(@hieu>=0)
				begin
				insert into SoThuTuPhongKham_Overtime values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,getdate(),N'Chua');
				end;
				else if(@hieu<0)
				begin
				insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chua');
				update ThongKePhongKham
				set SoLuongDoi=SoLuongDoi+1
				where IDBan=@BanKham and Phong=@PhongKham and CaKham=1;
				end;
			end;
			else 
			begin
				select @STT=max(STT) from SoThuTuPhongKham as STT
				where STT.BanKham=@BanKham and STT.PhongKham=@PhongKham and CaKham=1;
				set @STTnew=@STT +1;
				set @GioDuKien_new=(select dbo.CongThoiGian(@TimeTB,@GioDuKien));
				declare @hieu2 int;
				set @hieu2 = (select DATEDIFF(minute,'12:00:00.0000000',convert(time,@GioDuKien_new)));
				if(@hieu2>=0)
				begin
				insert into SoThuTuPhongKham_Overtime values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,getdate(),N'Chua');
				end;
				else if(@hieu2<0)
				begin
				insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chua');
				update ThongKePhongKham
				set SoLuongDoi=SoLuongDoi+1
				where IDBan=@BanKham and Phong=@PhongKham and CaKham=1;
				end;
			end;	
		end;
	end;
		
	select * from SoThuTuPhongKham where IDPhieuKham=@IDPhieuKham and STT=@STTnew and BanKham=@BanKham and PhongKham=@PhongKham and CaKham=1;;
end;
GO
/****** Object:  StoredProcedure [dbo].[PhatSinhSTTPhongKhamCa2]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PhatSinhSTTPhongKhamCa2] @IDPhieuKham nvarchar(10), @IDChuyenKhoa nvarchar(10) 
as begin
	declare @STT int,@STTnew int,@BanKham nvarchar(10),@PhongKham nvarchar(10),@TimeTB time,@CaKham int,@SoLuongDoi int,
			@GioDuKien datetime,@GioDuKien_new datetime,@temp int,@temp1 int,@Timehientai datetime;
	set @Timehientai='2019-03-27 13:00:00';
	select @temp=count(*)
	from ThongKeChiTiet_Null as TK join ThongKePhongKham as PK on PK.IDBan = TK.IDBan and PK.Phong=TK.Phong
	where PK.CaKham=2 and TK.CaKham=2  and TK.ThoiGianKhamTB_min<=all(select TK.ThoiGianKhamTB_min from ThongKeChiTiet_Null as TK join ThongKePhongKham as PK on PK.IDBan = TK.IDBan and PK.Phong=TK.Phong where  TK.ChuyenKhoa=@IDChuyenKhoa and PK.SoLuongDoi=0) 
	  and TK.ChuyenKhoa in (select TK.CHuyenKhoa from ThongKeChiTiet_Null as TK where  TK.ChuyenKhoa=@IDChuyenKhoa) and PK.SoLuongDoi=0 
	  and left(convert(char,TK.IDBan),3)+' '+ convert(char,TK.Phong)  not in (select left(convert(char,BanKham),3)+' '+ convert(char,PhongKham)  from SoHienThiPhongKham)
	  and left(convert(char,TK.IDBan),3)+' '+ convert(char,TK.Phong) not in (select  left(convert(char,BanKham),3)+' '+ convert(char,PhongKham)  from SoThuTuPhongKham);
	select @temp1= count(*)
	from (select distinct *
	from ThongKeChiTiet as TK where TK.CaKham=2 and ChuyenKhoa=@IDChuyenKhoa) as A;
	select @PhongKham=TK.PhongKham,@BanKham=TK.BanKham,@TimeTB=TK.ThoiGianKhamTB,@CaKham=TK.CaKham,@GioDuKien=TK.GioDuKienSoCuoi
	from ThongKeChiTiet as TK
	where ChuyenKhoa=@IDChuyenKhoa and TK.CaKham=2; 
	if( @PhongKham is null)
	begin 
		select @PhongKham=TK.Phong,@BanKham=TK.IDBan,@TimeTB=TK.ThoiGianKhamTB_min,@CaKham=TK.CaKham
		from ThongKeChiTiet_Null as TK join ThongKePhongKham as PK on PK.IDBan = TK.IDBan and PK.Phong=TK.Phong
		where TK.CaKham=2 and PK.CaKham=2 and TK.ThoiGianKhamTB_min<=all(select TK.ThoiGianKhamTB_min from ThongKeChiTiet_Null as TK join ThongKePhongKham as PK on PK.IDBan = TK.IDBan and PK.Phong=TK.Phong where  TK.ChuyenKhoa=@IDChuyenKhoa and PK.SoLuongDoi=0) 
		  and TK.ChuyenKhoa in (select TK.CHuyenKhoa from ThongKeChiTiet_Null as TK where  TK.ChuyenKhoa=@IDChuyenKhoa) and PK.SoLuongDoi=0 
		  and left(convert(char,TK.IDBan),3)+' '+ convert(char,TK.Phong)  not in (select left(convert(char,BanKham),3)+' '+ convert(char,PhongKham)  from SoHienThiPhongKham where CaKham=2)
		 and left(convert(char,TK.IDBan),3)+' '+ convert(char,TK.Phong) not in (select  left(convert(char,BanKham),3)+' '+ convert(char,PhongKham)  from SoThuTuPhongKham where CaKham=2)
		order by TK.IDBan,TK.Phong;
		set @STTnew=1;
		set @GioDuKien_new=(select dbo.CongThoiGian(@TimeTB,'2019-03-27 13:00:00'));
		insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chua');
		update ThongKePhongKham
		set SoLuongDoi=SoLuongDoi+1
		where IDBan=@BanKham and Phong=@PhongKham and CaKham=2;
	end;
	else
	begin
		if(@temp>0 and @temp1>0 )
		begin
			select @PhongKham=TK.Phong,@BanKham=TK.IDBan,@TimeTB=TK.ThoiGianKhamTB_min,@CaKham=TK.CaKham
			from ThongKeChiTiet_Null as TK join ThongKePhongKham as PK on PK.IDBan = TK.IDBan and PK.Phong=TK.Phong
			where TK.CaKham=2 and PK.CaKham=2 and TK.ThoiGianKhamTB_min<=all(select TK.ThoiGianKhamTB_min from ThongKeChiTiet_Null as TK join ThongKePhongKham as PK on PK.IDBan = TK.IDBan and PK.Phong=TK.Phong where  TK.ChuyenKhoa=@IDChuyenKhoa  and PK.SoLuongDoi=0) 
			 and TK.ChuyenKhoa in (select TK.CHuyenKhoa from ThongKeChiTiet_Null as TK where  TK.ChuyenKhoa=@IDChuyenKhoa) and PK.SoLuongDoi=0 
			 and left(convert(char,TK.IDBan),3)+' '+ convert(char,TK.Phong)  not in (select left(convert(char,BanKham),3)+' '+ convert(char,PhongKham)  from SoHienThiPhongKham)
			 and left(convert(char,TK.IDBan),3)+' '+ convert(char,TK.Phong) not in (select  left(convert(char,BanKham),3)+' '+ convert(char,PhongKham)  from SoThuTuPhongKham)
			order by TK.IDBan,TK.Phong;
			set @STTnew=1;
			set @GioDuKien_new=(select dbo.CongThoiGian(@TimeTB,'2019-03-27 13:00:00'));
			insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chua');
			update ThongKePhongKham
			set SoLuongDoi=SoLuongDoi+1
			where IDBan=@BanKham and Phong=@PhongKham and CaKham=2;
		end;
		else 
		begin 
			if(@GioDuKien<@Timehientai)
			begin
				select @STT=max(STT) from SoThuTuPhongKham as STT
				where STT.BanKham=@BanKham and STT.PhongKham=@PhongKham and CaKham=2;
				set @STTnew=@STT +1;
				set @GioDuKien_new=(select dbo.CongThoiGian(@TimeTB,@Timehientai)); 
				insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chua');
				update ThongKePhongKham
				set SoLuongDoi=SoLuongDoi+1
				where IDBan=@BanKham and Phong=@PhongKham and CaKham=2;
				end;
			else 
			begin
				select @STT=max(STT) from SoThuTuPhongKham as STT
				where STT.BanKham=@BanKham and STT.PhongKham=@PhongKham and CaKham=2; 
				set @STTnew=@STT +1;
				set @GioDuKien_new=(select dbo.CongThoiGian(@TimeTB,@GioDuKien));
				insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chua');
				update ThongKePhongKham
				set SoLuongDoi=SoLuongDoi+1
				where IDBan=@BanKham and Phong=@PhongKham and CaKham=2;
			end;
		end;
	end;
	select * from SoThuTuPhongKham where IDPhieuKham=@IDPhieuKham and STT=@STTnew and BanKham=@BanKham and PhongKham=@PhongKham and CaKham=2;
end;
GO
/****** Object:  StoredProcedure [dbo].[PhatSinhSTTXetNghiemCa1]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PhatSinhSTTXetNghiemCa1] @IDPhieuKham nvarchar(10)
as begin
	declare @IDPhongXN nvarchar(10),@STTcur int,@STTnew int,@GioDuKien datetime,@GioHienTai datetime,@GioDuKiennew time,
		@hieu2 int,@GioBatDau time,@GioKetThuc time,@IDXetNghiemBN nvarchar(10),@TimeDuKien datetime;
	set @IDXetNghiemBN=(select distinct IDXetNghiemBN from BenhNhanXetNghiem where IDPhieuKham=@IDPhieuKham);
	set @GioHienTai='2019-03-27 07:00:0.000';
	set @IDPhongXN= (select top(1) ID
					 from PhongCanLamSang
					 where ID not in (select distinct PhongXetNghiem from SoThuTuPhongXetNghiem where CaKham=1)
						and ( ID ='XN1' or ID ='XN2' or ID ='XN3'));
	if(@IDPhongXN is not null)
	begin
	select distinct @GioBatDau= GioBatDau,@GioKetThuc=GioKetThuc from LichPhongCanLamSang where IDPhongCLS=@IDPhongXN and CaKham=1;
	set @STTnew=1;
		if(@IDPhongXN='XN1')
		begin
		set @GioDuKiennew= (select dbo.CongGioPhut('00:00:12',@GioBatDau));
		end;
		else if(@IDPhongXN='XN2' or @IDPhongXN='XN3')
		begin
		set @GioDuKiennew= (select dbo.CongGioPhut('00:00:24',@GioBatDau));
		end;
	set @TimeDuKien=(select  convert(datetime2,'2019-03-27 '+ convert(varchar,@GioBatDau)));
	insert into SoThuTuPhongXetNghiem values(@IDPhieuKham,@IDXetNghiemBN,@STTnew,@IDPhongXN,1,@TimeDuKien,N'Chua');
	update ThongKePhongCLS 
	set SoLuongDoi=SoLuongDoi +1 
	where IDPhongCLS=@IDPhongXN and CaKham=1;
	end;
	else if(@IDPhongXN is null)
	begin
	set @IDPhongXN=( select top(1) A.PhongXetNghiem
						from  (select  PhongXetNghiem,max(STT) as STTCuoi
						 from SoThuTuPhongXetNghiem
						 where CaKham=1
						 group by PhongXetNghiem) as A 
						 join SoThuTuPhongXetNghiem as STT 
						 on STT.PhongXetNghiem=A.PhongXetNghiem and STT.STT=A.STTCuoi
						 where STT.CaKham=1 and STT.Gio<=all( select  STT.Gio
												from  (select  PhongXetNghiem,max(STT) as STTCuoi
												 from SoThuTuPhongXetNghiem
												 where CaKham=1
												 group by PhongXetNghiem) as A 
												 join SoThuTuPhongXetNghiem as STT 
												 on STT.PhongXetNghiem=A.PhongXetNghiem and STT.STT=A.STTCuoi where STT.CaKham=1));
						
	select distinct @GioBatDau= GioBatDau,@GioKetThuc=GioKetThuc from LichPhongCanLamSang where IDPhongCLS=@IDPhongXN and CaKham=1;
	set @STTcur= (select max(STT)
				 from SoThuTuPhongXetNghiem
				 where PhongXetNghiem = @IDPhongXN and CaKham=1);
	set @STTnew=@STTcur+1;
	set @GioDuKien= (select Gio from SoThuTuPhongXetNghiem where PhongXetNghiem = @IDPhongXN and STT=@STTcur);
	set @GioDuKiennew= (select dbo.CongGioPhut('00:02:00',@GioDuKien));
	set @hieu2 = (select DATEDIFF(minute,@GioKetThuc,convert(time,@GioDuKiennew)));
	set @TimeDuKien=(select  convert(datetime2,'2019-03-27 '+ convert(varchar,@GioDuKiennew)));
		if(@hieu2<0) 
		begin
		insert into SoThuTuPhongXetNghiem values(@IDPhieuKham,@IDXetNghiemBN,@STTnew,@IDPhongXN,1,@TimeDuKien,N'Chua');
		update ThongKePhongCLS 
		set SoLuongDoi=SoLuongDoi +1 
		where IDPhongCLS=@IDPhongXN and CaKham=1;
		end;
		else if (@hieu2>=0)
		begin
		exec PhatSinhSTTXetNghiemCa2 @IDPhieuKham;
		end;
	end;

end;
GO
/****** Object:  StoredProcedure [dbo].[PhatSinhSTTXetNghiemCa2]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PhatSinhSTTXetNghiemCa2] @IDPhieuKham nvarchar(10)
as begin
	declare @IDPhongXN nvarchar(10),@STTcur int,@STTnew int,@GioDuKien datetime,@GioHienTai datetime,@GioDuKiennew time,
		@hieu2 int,@GioBatDau time,@GioKetThuc time,@IDXetNghiemBN nvarchar(10),@TimeDuKien datetime;
	set @IDXetNghiemBN=(select distinct IDXetNghiemBN from BenhNhanXetNghiem where IDPhieuKham=@IDPhieuKham);
	set @GioHienTai='2019-03-27 13:00:0.000';
	set @IDPhongXN= (select top(1) ID
					 from PhongCanLamSang
					 where ID not in (select distinct PhongXetNghiem from SoThuTuPhongXetNghiem where CaKham=2)
						and ( ID ='XN1' or ID ='XN2' or ID ='XN3'));
	if(@IDPhongXN is not null)
	begin
	select distinct @GioBatDau= GioBatDau,@GioKetThuc=GioKetThuc from LichPhongCanLamSang where IDPhongCLS=@IDPhongXN and CaKham=2;
	set @STTnew=1;
	set @GioDuKiennew= (select dbo.CongGioPhut('00:02:00',@GioBatDau));
	set @TimeDuKien=(select  convert(datetime2,'2019-03-27 '+ convert(varchar,@GioBatDau)));
	insert into SoThuTuPhongXetNghiem values(@IDPhieuKham,@IDXetNghiemBN,@STTnew,@IDPhongXN,2,@TimeDuKien,N'Chua');
	update ThongKePhongCLS 
	set SoLuongDoi=SoLuongDoi +1 
	where IDPhongCLS=@IDPhongXN and CaKham=2;
	end;
	else if(@IDPhongXN is null)
	begin
	set @IDPhongXN=( select top(1) A.PhongXetNghiem
						from  (select  PhongXetNghiem,max(STT) as STTCuoi
						 from SoThuTuPhongXetNghiem
						 where CaKham=2
						 group by PhongXetNghiem) as A 
						 join SoThuTuPhongXetNghiem as STT 
						 on STT.PhongXetNghiem=A.PhongXetNghiem and STT.STT=A.STTCuoi
						 where STT.CaKham=2 and STT.Gio<=all( select  STT.Gio
												from  (select  PhongXetNghiem,max(STT) as STTCuoi
												 from SoThuTuPhongXetNghiem
												 where CaKham=2
												 group by PhongXetNghiem) as A 
												 join SoThuTuPhongXetNghiem as STT 
												 on STT.PhongXetNghiem=A.PhongXetNghiem and STT.STT=A.STTCuoi where STT.CaKham=2));
						
	select distinct @GioBatDau= GioBatDau,@GioKetThuc=GioKetThuc from LichPhongCanLamSang where IDPhongCLS=@IDPhongXN and CaKham=2;
	set @STTcur= (select max(STT)
				 from SoThuTuPhongXetNghiem
				 where PhongXetNghiem = @IDPhongXN and CaKham=2);
	set @STTnew=@STTcur+1;
	set @GioDuKien= (select Gio from SoThuTuPhongXetNghiem where PhongXetNghiem = @IDPhongXN and STT=@STTcur);
	if(@IDPhongXN='XN1')
		begin
		set @GioDuKiennew= (select dbo.CongGioPhut('00:00:12',@GioBatDau));
		end;
		else if(@IDPhongXN='XN2' or @IDPhongXN='XN3')
		begin
		set @GioDuKiennew= (select dbo.CongGioPhut('00:00:24',@GioBatDau));
		end;
	set @TimeDuKien=(select  convert(datetime2,'2019-03-27 '+ convert(varchar,@GioDuKiennew)));
	insert into SoThuTuPhongXetNghiem values(@IDPhieuKham,@IDXetNghiemBN,@STTnew,@IDPhongXN,2,@TimeDuKien,N'Chua');
	update ThongKePhongCLS 
	set SoLuongDoi=SoLuongDoi +1 
	where IDPhongCLS=@IDPhongXN and CaKham=2;	
	end;
end;
GO
/****** Object:  StoredProcedure [dbo].[ResetThongKePhongCLS]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[ResetThongKePhongCLS]
as begin
truncate table ThongKePhongCLS;
insert into ThongKePhongCLS(IDPhongCLS,NgayCT,CaKham,SoLuongDoi)
select distinct TH.IDPhongCLS,'2019-03-27'as NgayCT,1 as CaKham,0 as SoLuongDoi
from ThucHienCLS as TH inner join DichVuCanLamSang as DV on DV.IDDichVu=TH.DichVuCLSThucHien 
end;
GO
/****** Object:  StoredProcedure [dbo].[ResetThongKePhongKham]    Script Date: 5/26/2019 12:22:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Search]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Search] @IDBenhNhan nvarchar(10)
as begin
	select BenhNhan.Ho, BenhNhan.TenLot,BenhNhan.Ten 
	from BenhNhan
	where ID = @IDBenhNhan;

	select distinct IDBenhNhan,B.STT as STTPhongKham,B.SoPhong,B.SoBan,B.TenChuyenKhoa,convert(time,B.Gio) as ThoiGianDuKien,B.TinhTrang,A.SoHienTaiCuaPhong
	from 
		(select IDBenhNhan,STTPK.IDPhieuKham,STTPK.STT,STTPK.BanKham,bk.SoBan,STTPK.PhongKham,PKCK.SoPhong,CK.TenChuyenKhoa,STTPK.Gio,STTPK.TinhTrang
		from BenhNhan as BN join PhieuKham as PK on BN.ID=PK.IDBenhNhan  join SoThuTuPhongKham as STTPK on STTPK.IDPhieuKham= PK.IDPhieuKham
		join  BanKham as BK on BK.IDBan = STTPK.BanKham join PhongKhamChuyenKhoa as PKCK on PKCK.ID = BK.Phong and PKCK.ID=STTPK.PhongKham
		join ChuyenKhoa as CK on Ck.IDChuyenKhoa=PKCK.ChuyenKhoa
		where IDBenhNhan=@IDBenhNhan) as B
		 left outer join
		(select BK.IDBan as IDBan,BK.SoBan, PK.ID as IDPhongKham,PK.SoPhong,max(STT) as SoHienTaiCuaPhong from SoHienThiPhongKham as SHT 
		join BanKham as BK on BK.IDBan=SHT.BanKham join PhongKhamChuyenKhoa as PK on PK.ID=Bk.Phong 
		where BK.Phong=SHT.PhongKham 
		group by Bk.IDBan,BK.SoBan,PK.ID,PK.SoPhong) as A on A.IDBan=B.BanKham and A.IDPhongKham=B.PhongKham;

	select distinct IDBenhNhan,STTCLS.STT as STTPhongCLS, PCLS.SoPhong,DV.TenDichVu as TenCanLamSang,convert(time, STTCLS.Gio) as ThoiGianDuKien,STTCLS.TinhTrang,max(A.SoHienTaiCuaPhong) as SoHienTaiCuaPhong
	from BenhNhan as BN join PhieuKham as PK on BN.ID=PK.IDBenhNhan join SoThuTuPhongCLS as STTCLS on STTCLS.IDPhieuKham=PK.IDPhieuKham 
		join PhongCanLamSang as PCLS on PCLS.ID=STTCLS.PhongCanLamSang
		join (select PCLS.ID as IDPhongCLS,PCLS.SoPhong, max(SHT.Gio) as Gio,STT as SoHienTaiCuaPhong 
			 from SoHienThiPhongCanLamSang as SHT join PhongCanLamSang as PCLS on PCLS.ID=SHT.IDPhongCanLamSang
	group by PCLS.ID,PCLS.SoPhong,STT ) as A on A.IDPhongCLS=PCLS.ID join ThucHienCLS as TH on TH.IDPhongCLS=PCLS.ID 
	join  DichVuCanLamSang as DV on DV.IDDichVu =TH.DichVuCLSThucHien 
	where IDBenhNhan=@IDBenhNhan and STTCLS.CanLamSang=TH.DichVuCLSThucHien 
	group by  IDBenhNhan,STTCLS.STT,PCLS.SoPhong,DV.TenDichVu,convert(time, STTCLS.Gio),STTCLS.TinhTrang;
	end;
GO
/****** Object:  StoredProcedure [dbo].[TaoHoSoBenhNhan]    Script Date: 5/26/2019 12:22:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[TaoLichSuTimKiem]    Script Date: 5/26/2019 12:22:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[TaoPhieuKham]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[TaoPhieuKham] @IDBenhNhan nvarchar(10),@IDCHuyenKhoa nvarchar(10)
 as begin
 declare @LastPK nvarchar(10),@STT_char nvarchar(10),@STTnew_int int,@STTnew_char nvarchar(10),@NewPK nvarchar(10)
 set @LastPK=(select IDPhieuKham 
			  from PhieuKham 
			  where  ChuyenKhoa=@IDCHuyenKhoa and right(IDPhieuKham,5) >=all( select right(IDPhieuKham,5) 
																			  from PhieuKham
																			   where  ChuyenKhoa=@IDCHuyenKhoa));
 if(@LastPK is not null)
 begin
 set @STT_char=(select right(@LastPK,5));
 set @STTnew_int = CONVERT(int,@STT_char) + 1;
 set @STTnew_char = CONVERT(nvarchar,@STTnew_int);
 set @NewPK='PK' +@IDCHuyenKhoa + @STTnew_char;
 insert into PhieuKham values(@NewPK,@IDBenhNhan,getdate(),@IDCHuyenKhoa);
 end;
 else if(@LastPK is null)
 begin
 set @STT_char=(select right('10000',5));
 set @STTnew_int = CONVERT(int,@STT_char) + 1;
 set @STTnew_char = CONVERT(nvarchar,@STTnew_int);
 set @NewPK='PK' +@IDCHuyenKhoa + @STTnew_char;
 insert into PhieuKham values(@NewPK,@IDBenhNhan,getdate(),@IDCHuyenKhoa);
 end;
 select * from PhieuKham where IDPhieuKham=@NewPK;
 
end;
GO
/****** Object:  StoredProcedure [dbo].[TimBenhNhanTheoHoTenDiaChi]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TimBenhNhanTheoHoTenDiaChi]
@HoVaTen nvarchar(50),
@DiaChi nvarchar(50)
AS
BEGIN
SELECT  *
FROM(
SELECT *, (BN.Ho + ' ' + BN.TenLot + ' ' + BN.Ten) as HoTen FROM BenhNhan BN) A
WHERE 
 LTRiM(RTRIM(UPPER(A.HoTen))) =LTRiM(RTRIM(UPPER(@HoVaTen))) and upper(A.Diachi)=upper(@DiaChi)
END;
GO
/****** Object:  StoredProcedure [dbo].[TimBenhNhanTheoHoTenGioiTinh]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TimBenhNhanTheoHoTenGioiTinh]
@HoVaTen nvarchar(50),
@GioiTinh nvarchar(3),
@NgaySinh date
AS
BEGIN
SELECT  *
FROM(
SELECT *, (BN.Ho + ' ' + BN.TenLot + ' ' + BN.Ten) as HoTen FROM BenhNhan BN) A
WHERE 
 LTRiM(RTRIM(UPPER(A.HoTen))) =LTRiM(RTRIM(UPPER(@HoVaTen))) and A.GioiTinh=@GioiTinh and A.NgaySinh=@NgaySinh
END;
GO
/****** Object:  StoredProcedure [dbo].[TimBenhNhanTheoID]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TimBenhNhanTheoID]
@IDBenhNhan nvarchar(10)
AS
BEGIN
SELECT * FROM BenhNhan BN
WHERE BN.ID = upper(@IDBenhNhan)
END;
GO
/****** Object:  StoredProcedure [dbo].[TimBenhNhanTheoSDT]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TimBenhNhanTheoSDT]
@SDT nvarchar(15)
AS
BEGIN
SELECT * FROM BenhNhan BN
WHERE BN.SDT = upper(@SDT)
END;
GO
/****** Object:  StoredProcedure [dbo].[TinhTrangConChoTheoChuyenKhoa]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TinhTrangConChoTheoChuyenKhoa]
@IDchuyenKhoa nvarchar(10),@Cakham int
AS
BEGIN
	declare @temp int;
	set @temp=(select count(*) from ( select stt.PhongKham, stt.BanKham, stt.CaKham, max(stt.Gio) as GioMax
		from SoThuTuPhongKham stt
		where stt.CaKham=@Cakham
		group by stt.PhongKham, stt.BanKham, stt.CaKham ) as B
inner join ThongKePhongKham tk on tk.IDBan=B.BanKham and tk.Phong=B.PhongKham and tk.CaKham=B.CaKham
	join BanKham as BK on BK.IDBan=tk.IDBan and Bk.Phong=tk.Phong
	join PhongKhamChuyenKhoa as PK on PK.ID=tk.Phong
where tk.ChuyenKhoa=@IDchuyenKhoa);
if(@temp !=0)
begin
select  BK.SoBan ,PK.SoPhong ,tk.SoLuongDoi as SoConCho,TK.CaKham, tk.ThoiGianKhamTB as TocDoNhaySo,B.GioMax as ThoiGianKhamSoCuoi
from ( select stt.PhongKham, stt.BanKham, stt.CaKham, max(stt.Gio) as GioMax
		from SoThuTuPhongKham stt
		where stt.CaKham=@Cakham
		group by stt.PhongKham, stt.BanKham, stt.CaKham ) as B
inner join ThongKePhongKham tk on tk.IDBan=B.BanKham and tk.Phong=B.PhongKham and tk.CaKham=B.CaKham
	join BanKham as BK on BK.IDBan=tk.IDBan and Bk.Phong=tk.Phong
	join PhongKhamChuyenKhoa as PK on PK.ID=tk.Phong
where tk.ChuyenKhoa=@IDchuyenKhoa
end;
else if(@temp=0)
begin
select  BK.SoBan ,PK.SoPhong ,tk.SoLuongDoi as SoConCho,TK.CaKham, tk.ThoiGianKhamTB as TocDoNhaySo,null as ThoiGianKhamSoCuoi
from  ThongKePhongKham tk 
	join BanKham as BK on BK.IDBan=tk.IDBan and Bk.Phong=tk.Phong
	join PhongKhamChuyenKhoa as PK on PK.ID=tk.Phong
where tk.ChuyenKhoa=@IDchuyenKhoa and tk.CaKham=@Cakham
end;
END;
GO
/****** Object:  StoredProcedure [dbo].[TinhTrangConChoTheoPhongKhamThuocChuyenKhoa]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TinhTrangConChoTheoPhongKhamThuocChuyenKhoa]
@IDPhong nvarchar(10)
AS
BEGIN
select  BK.SoBan ,PK.SoPhong ,tk.SoLuongDoi as SoConCho,TK.CaKham, tk.ThoiGianKhamTB as TocDoNhaySo,B.GioMax as ThoiGianKhamSoCuoi
from ( select stt.PhongKham, stt.BanKham, stt.CaKham, max(stt.Gio) as GioMax
		from SoThuTuPhongKham stt
		group by stt.PhongKham, stt.BanKham, stt.CaKham ) as B
inner join ThongKePhongKham tk on tk.IDBan=B.BanKham and tk.Phong=B.PhongKham and tk.CaKham=B.CaKham
	join BanKham as BK on BK.IDBan=tk.IDBan and Bk.Phong=tk.Phong
	join PhongKhamChuyenKhoa as PK on PK.ID=tk.Phong
where TK.Phong=@IDPhong
END;
GO
/****** Object:  StoredProcedure [dbo].[TinhTrangConChoTheoPhongThuocChuyenKhoa]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[TinhTrangConChoTheoPhongThuocChuyenKhoa] @IDPhong nvarchar(10)
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
/****** Object:  StoredProcedure [dbo].[TinhTrangHienTaiTheoChuyenKhoa]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[TinhTrangHienTaiTheoChuyenKhoa]
@IDchuyenKhoa nvarchar(10),@Cakham int
AS
BEGIN
declare @temp int,@temp2 int
set @temp= (select count(*)
			from (select distinct sht.BanKham,sht.PhongKham
			 from SoHienThiPhongKham sht inner join PhongKhamChuyenKhoa pkck on pkck.ID= sht.PhongKham
			where pkck.ChuyenKhoa=@IDchuyenKhoa and sht.CaKham=@Cakham) as A );
set @temp2 =(select count(*)
			from (select distinct pkck.ChuyenKhoa,lk.Phong ,LK.IDBan from SoThuTuPhongKham as STT join LichKhamBacSi as LK 
							 on STT.BanKham=LK.IDBan and LK.Phong= STT.PhongKham 
							 inner join PhongKhamChuyenKhoa pkck on pkck.ID= STT.PhongKham
							 where pkck.ChuyenKhoa=@IDchuyenKhoa and STT.CaKham=@Cakham) as A);
if(@temp=0 and @temp2=0)
begin
select  pkck.ChuyenKhoa,lk.Phong as IDPhongKham,pkck.SoPhong,bk.IDBan,bk.SoBan,bs.ID as IDBacSi,  bs.HovaTen as BacSi,0 as SoHienTai, N'Chua c� b?nh nh�n' AS BenhNhan
	from LichKhamBacSi lk 
	inner join BanKham bk on bk.IDBan=lk.IDBan and bk.Phong=lk.Phong
	inner join BacSi bs on bs.ID=lk.IDBacSi
	inner join PhongKhamChuyenKhoa pkck on pkck.ID= bk.Phong
	where pkck.ChuyenKhoa=@IDchuyenKhoa and lk.CaKham=@Cakham
	order by  pkck.ChuyenKhoa,lk.Phong ,bk.SoBan;
end;

else if(@temp=0  and @temp2!=0)
begin
select  pkck.ChuyenKhoa,lk.Phong as IDPhongKham,pkck.SoPhong,bk.IDBan,bk.SoBan,bs.ID as IDBacSi,  bs.HovaTen as BacSi,0 as SoHienTai, N'Chua c� b?nh nh�n' AS BenhNhan
	from LichKhamBacSi lk 
	inner join SoThuTuPhongKham as STT on STT.BanKham=lk.IDBan and STT.PhongKham=lk.Phong
	inner join BanKham bk on bk.IDBan=lk.IDBan and bk.Phong=STT.PhongKham
	inner join BacSi bs on bs.ID=lk.IDBacSi
	inner join PhongKhamChuyenKhoa pkck on pkck.ID= bk.Phong
	where pkck.ChuyenKhoa=@IDchuyenKhoa and STT.CaKham=@Cakham
	order by  pkck.ChuyenKhoa,lk.Phong ,bk.SoBan;
end;
else if(@temp2=0 and @temp!=0)
begin
select distinct pkck.ChuyenKhoa,B.PhongKham as IDPhongKham,pkck.SoPhong,bk.IDBan,bk.SoBan, bs.ID as IDBacSi, bs.HoVaTen as BacSi,  A.stt AS SoHienTai, (BN.Ho + ' ' +BN.TenLot + ' ' + BN.Ten) AS BenhNhan, B.GioMax
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
where pkck.ChuyenKhoa=@IDchuyenKhoa and A.CaKham=@Cakham;
end;
else if(((@temp2 >@temp ) and @temp!=0) or ((@temp2<@temp ) and @temp2!=0))
begin
select distinct pkck.ChuyenKhoa,B.PhongKham as IDPhongKham,pkck.SoPhong,bk.IDBan,bk.SoBan, bs.ID as IDBacSi, bs.HoVaTen as BacSi,  A.stt AS SoHienTai, (BN.Ho + ' ' +BN.TenLot + ' ' + BN.Ten) AS BenhNhan, B.GioMax
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
where pkck.ChuyenKhoa=@IDchuyenKhoa and A.CaKham=@Cakham;
select  distinct pkck.ChuyenKhoa,lk.Phong as  IDPhongKham,pkck.SoPhong,bk.IDBan ,bk.SoBan,bs.ID as IDBacSi,  bs.HovaTen as BacSi,0 as SoHienTai, N'Chua c� b?nh nh�n' AS BenhNhan
	from LichKhamBacSi lk 
	inner join SoThuTuPhongKham as STT on STT.BanKham=lk.IDBan and STT.PhongKham=lk.Phong
	inner join BanKham bk on bk.IDBan=lk.IDBan and bk.Phong=STT.PhongKham
	inner join BacSi bs on bs.ID=lk.IDBacSi
	inner join PhongKhamChuyenKhoa pkck on pkck.ID= bk.Phong
	where pkck.ChuyenKhoa=@IDchuyenKhoa and bs.ID not in (select lich.IDBacSi from SoHienThiPhongKham as HT join BanKham as ban 
																		on HT.BanKham=ban.IDBan and HT.PhongKham=ban.Phong
																		join PhongKhamChuyenKhoa as phong on phong.ID=ban.Phong
																		join LichKhamBacSi as lich on lich.IDBan=HT.BanKham and lich.Phong=HT.PhongKham
																		join BacSi as bs on bs.ID=lich.IDBacSi
																	 where phong.ChuyenKhoa =@IDchuyenKhoa) and STT.CaKham=@Cakham
	order by  pkck.ChuyenKhoa,lk.Phong ,bk.SoBan;
end;
else if(@temp =@temp2 and @temp!=0)
begin
select distinct pkck.ChuyenKhoa,B.PhongKham as IDPhongKham,pkck.SoPhong,bk.IDBan,bk.SoBan, bs.ID as IDBacSi, bs.HoVaTen as BacSi,  A.stt AS SoHienTai, (BN.Ho + ' ' +BN.TenLot + ' ' + BN.Ten) AS BenhNhan, B.GioMax
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
where pkck.ChuyenKhoa=@IDchuyenKhoa and A.CaKham=@Cakham;
end
end
GO
/****** Object:  StoredProcedure [dbo].[TinhTrangHienTaiTheoPhongKhamThuocChuyenKhoa]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TinhTrangHienTaiTheoPhongKhamThuocChuyenKhoa]
@IDPhong nvarchar(10)
AS
BEGIN
declare @temp int,@temp2 int
set @temp=(select count(*) from SoHienThiPhongKham sht where sht.PhongKham=@IDPhong );
set @temp2=(select count(*) from SoThuTuPhongKham stt where stt.PhongKham=@IDPhong );
if(@temp=0 and @temp2=0)
begin
select  distinct pkck.ChuyenKhoa,lk.Phong as IDPhongKham,pkck.SoPhong,bk.IDBan,bk.SoBan,bs.ID as IDBacSi,  bs.HovaTen as BacSi,0 as SoHienTai, N'Chua c� b?nh nh�n' AS BenhNhan
	from LichKhamBacSi lk 
	inner join BanKham bk on bk.IDBan=lk.IDBan and bk.Phong=lk.Phong
	inner join BacSi bs on bs.ID=lk.IDBacSi
	inner join PhongKhamChuyenKhoa pkck on pkck.ID= bk.Phong
	where pkck.ID=@IDPhong
	order by  pkck.ChuyenKhoa,lk.Phong ,bk.SoBan;
end;
else if(@temp = 0 and @temp2!=0)
begin 
select distinct  pkck.ChuyenKhoa,bk.Phong as IDPhongKham,pkck.SoPhong,bk.IDBan ,bk.SoBan, bs.ID as IDBacSi, bs.HoVaTen as BacSi, 0 as SoHienTai,  N'Chua c� b?nh nh�n' AS BenhNhan
from LichKhamBacSi lk 
inner join BanKham bk on bk.IDBan=lk.IDBan and lk.Phong=bk.Phong 
inner join BacSi bs on bs.ID=lk.IDBacSi
inner join PhongKhamChuyenKhoa pkck on pkck.ID= bk.Phong 
inner join SoThuTuPhongKham as STT on STT.BanKham=lk.IDBan and STT.PhongKham=lk.Phong
where pkck.ID=@IDPhong
end;
else if (@temp2=0 and @temp!=0)
begin
select distinct pkck.ChuyenKhoa, B.PhongKham as IDPhongKham,pkck.SoPhong,bk.IDBan, bk.SoBan, bs.ID as IDBacSi, bs.HoVaTen as BacSi, A.stt AS STTHienTai, (BN.Ho + ' ' +BN.TenLot + ' ' + BN.Ten) AS BenhNhan,B.GioMax
from ( select sht.PhongKham, sht.BanKham, max(sht.Gio) as GioMax
		from SoHienThiPhongKham sht
		group by sht.PhongKham, sht.BanKham ) as B
inner join SoHienThiPhongKham as A on A.BanKham=B.BanKham and A.PhongKham=b.PhongKham and A.Gio=B.GioMax
inner join PhieuKham pk on pk.IDPhieuKham= A.IDPhieuKham
inner join BenhNhan BN on IDBenhNhan=BN.ID
inner join BanKham bk on bk.IDBan=B.BanKham and bk.Phong=B.PhongKham
inner join LichKhamBacSi lk on lk.IDBan=B.BanKham and lk.Phong=B.PhongKham
inner join BacSi bs on bs.ID=lk.IDBacSi
inner join PhongKhamChuyenKhoa pkck on pkck.ID= bk.Phong and pkck.ID=lk.Phong
where pkck.ID=@IDPhong 
end;
else if(((@temp > @temp2) and @temp2!=0) or ((@temp2 > @temp) and @temp!=0))
begin
select distinct pkck.ChuyenKhoa, B.PhongKham as IDPhongKham,pkck.SoPhong,bk.IDBan, bk.SoBan,bs.ID as IDBacSi, bs.HoVaTen as BacSi,  A.stt AS SoHienTai, (BN.Ho + ' ' +BN.TenLot + ' ' + BN.Ten) AS BenhNhan, B.GioMax
from ( select sht.PhongKham, sht.BanKham, max(sht.Gio) as GioMax
		from SoHienThiPhongKham sht
		group by sht.PhongKham, sht.BanKham ) as B
inner join SoHienThiPhongKham as A on A.BanKham=B.BanKham and A.PhongKham=b.PhongKham and A.Gio=B.GioMax
inner join PhieuKham pk on pk.IDPhieuKham= A.IDPhieuKham
inner join BenhNhan BN on IDBenhNhan=BN.ID
inner join BanKham bk on bk.IDBan=B.BanKham and bk.Phong=B.PhongKham
inner join LichKhamBacSi lk on lk.IDBan=B.BanKham and lk.Phong=B.PhongKham
inner join BacSi bs on bs.ID=lk.IDBacSi
inner join PhongKhamChuyenKhoa pkck on pkck.ID= bk.Phong and pkck.ID=lk.Phong
where pkck.ID=@IDPhong ;
select  distinct pkck.ChuyenKhoa,lk.Phong as  IDPhongKham,pkck.SoPhong,bk.IDBan ,bk.SoBan,bs.ID as IDBacSi,  bs.HovaTen as BacSi,0 as SoHienTai, N'Chua c� b?nh nh�n' AS BenhNhan
	from LichKhamBacSi lk 
	inner join SoThuTuPhongKham as STT on STT.BanKham=lk.IDBan and STT.PhongKham=lk.Phong
	inner join BanKham bk on bk.IDBan=lk.IDBan and bk.Phong=STT.PhongKham
	inner join BacSi bs on bs.ID=lk.IDBacSi
	inner join PhongKhamChuyenKhoa pkck on pkck.ID= bk.Phong and pkck.ID=lk.Phong
	where pkck.ID=@IDPhong and bs.ID not in (select lich.IDBacSi from SoHienThiPhongKham as HT join BanKham as ban 
																		on HT.BanKham=ban.IDBan and HT.PhongKham=ban.Phong
																		join PhongKhamChuyenKhoa as phong on phong.ID=ban.Phong
																		join LichKhamBacSi as lich on lich.IDBan=HT.BanKham and lich.Phong=HT.PhongKham
																		join BacSi as bs on bs.ID=lich.IDBacSi
																	 where phong.ID =@IDPhong)
	order by  pkck.ChuyenKhoa,lk.Phong ,bk.SoBan;
end;
else if (@temp=@temp2 and @temp!=0)
begin
select distinct pkck.ChuyenKhoa, B.PhongKham as IDPhongKham,pkck.SoPhong,bk.IDBan, bk.SoBan,bs.ID as IDBacSi, bs.HoVaTen as BacSi,  A.stt AS STTHienTai,  (BN.Ho + ' ' +BN.TenLot + ' ' + BN.Ten) AS BenhNhan, B.GioMax
from ( select sht.PhongKham, sht.BanKham, max(sht.Gio) as GioMax
		from SoHienThiPhongKham sht
		group by sht.PhongKham, sht.BanKham ) as B
inner join SoHienThiPhongKham as A on A.BanKham=B.BanKham and A.PhongKham=b.PhongKham and A.Gio=B.GioMax
inner join PhieuKham pk on pk.IDPhieuKham= A.IDPhieuKham
inner join BenhNhan BN on IDBenhNhan=BN.ID
inner join BanKham bk on bk.IDBan=B.BanKham and bk.Phong=B.PhongKham
inner join LichKhamBacSi lk on lk.IDBan=B.BanKham and lk.Phong=B.PhongKham
inner join BacSi bs on bs.ID=lk.IDBacSi
inner join PhongKhamChuyenKhoa pkck on pkck.ID= bk.Phong and pkck.ID=lk.Phong
where pkck.ID=@IDPhong ;
end;
END;
GO
/****** Object:  StoredProcedure [dbo].[XuatDanhSachChuyenKhoa]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[XuatDanhSachChuyenKhoa]
AS
BEGIN
select distinct ck.IDChuyenKhoa,ck.TenChuyenKhoa
from ChuyenKhoa ck join BacSi as bs on bs.ChuyenKhoa=ck.IDChuyenKhoa join LichKhamBacSi as lk on lk.IDBacSi=bs.ID
END;
GO
/****** Object:  StoredProcedure [dbo].[XuatDanhSachPhongKhamTheoChuyenKhoa]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[XuatDanhSachPhongKhamTheoChuyenKhoa]
@IDChuyenKhoa nvarchar(10)
AS
BEGIN
select pkck.ID, pkck.SoPhong
from ChuyenKhoa ck
inner join PhongKhamChuyenKhoa pkck on pkck.ChuyenKhoa=ck.IDChuyenKhoa
where ck.IDChuyenKhoa=@IDChuyenKhoa
END;
GO
/****** Object:  StoredProcedure [dbo].[XuatDichVuCanLamSang]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[XuatDichVuCanLamSang] ( @IDLoaiDichVu nvarchar(10))
as
begin
	select distinct DV.IDDichVu,DV.TenDichVu from DichVuCanLamSang as DV 
										 join ThucHienCLS as Th on Th.DichVuCLSThucHien=DV.IDDichVu
					  where DV.LoaiDichVu=@IDLoaiDichVu;
end;
GO
/****** Object:  StoredProcedure [dbo].[XuatLoaiDichVuCanLamSang]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[XuatLoaiDichVuCanLamSang]
as
begin
	select distinct DV.LoaiDichVu,Loai.TenLoaiDichVu from DichVuCanLamSang as DV join LoaiDichVu as Loai on Loai.IDLoaiDichVu=DV.LoaiDichVu
										 join ThucHienCLS as Th on Th.DichVuCLSThucHien=DV.IDDichVu
end;
GO
/****** Object:  Trigger [dbo].[tr_AUTO_IDTraCuu]    Script Date: 5/26/2019 12:22:09 PM ******/
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
/****** Object:  Trigger [dbo].[Xulylichsu]    Script Date: 5/26/2019 12:22:09 PM ******/
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
/****** Object:  Trigger [dbo].[UpdateTinhTrangSTTPhongCLS]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[UpdateTinhTrangSTTPhongCLS] on [dbo].[SoHienThiPhongCanLamSang] for insert
as 
	declare @STT int,  @IDPhongCLS nvarchar(10),@IDPK nvarchar(10),@STTpre int;
	select @STT =STT,@IDPhongCLS=IDPhongCanLamSang,@IDPK=IDPhieuKham
	from inserted;
	set @STTpre=@STT -1;
	update SoThuTuPhongCLS
	set TinhTrang=N'�ang kh�m'
	where  PhongCanLamSang=@IDPhongCLS and STT=@STT;
	update SoThuTuPhongCLS
	set TinhTrang=N'�� qua'
	where  PhongCanLamSang=@IDPhongCLS and STT=@STTpre;
GO
ALTER TABLE [dbo].[SoHienThiPhongCanLamSang] ENABLE TRIGGER [UpdateTinhTrangSTTPhongCLS]
GO
/****** Object:  Trigger [dbo].[UpdateTinhTrangSTTPhongKham]    Script Date: 5/26/2019 12:22:09 PM ******/
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
	set TinhTrang=N'�ang kh�m'
	where  BanKham=@BanKham and PhongKham=@PhongKham and STT=@STT;
	update SoThuTuPhongKham
	set TinhTrang=N'�� qua'
	where  BanKham=@BanKham and PhongKham=@PhongKham and STT=@STTpre;
GO
ALTER TABLE [dbo].[SoHienThiPhongKham] ENABLE TRIGGER [UpdateTinhTrangSTTPhongKham]
GO
/****** Object:  Trigger [dbo].[SetCaKhamCLS]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[SetCaKhamCLS] on [dbo].[SoThuTuPhongCLS] for insert 
as 
	declare @GioKham time,@IDPK nvarchar(10),@STT nvarchar(10),
	@hour1 int,@hour3 int;
	select @GioKham = convert(time,Gio), @IDPK = IDPhieuKham,@STT = STT  from inserted;
	set @hour1 =DATEDIFF(HOUR,'7:00:0',@GioKham);
	--set @hour2 select DATEDIFF(HOUR,'12:00:0','07:10:44.000'); select convert(time,'2019-03-27 07:10:44.000')
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
/****** Object:  Trigger [dbo].[SetCaKhamPK]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[SetCaKhamPK] on [dbo].[SoThuTuPhongKham] for insert 
as 
	declare @GioKham time,@IDPK nvarchar(10),@STT nvarchar(10),
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
/****** Object:  Trigger [dbo].[XulySTTOvertime]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[XulySTTOvertime] on [dbo].[SoThuTuPhongKham_Overtime] for insert
as
	declare @PhieuKham nvarchar(10),@ChuyenKhoa nvarchar(10)
	select  @PhieuKham = IDPhieuKham from inserted;
	select @ChuyenKhoa = ChuyenKhoa from PhieuKham where IDPhieuKham=@PhieuKham;
	exec PhatSinhSTTPhongKhamCa2 @PhieuKham,@ChuyenKhoa;
	delete SoThuTuPhongKham_Overtime where IDPhieuKham=@PhieuKham;
GO
ALTER TABLE [dbo].[SoThuTuPhongKham_Overtime] ENABLE TRIGGER [XulySTTOvertime]
GO
/****** Object:  Trigger [dbo].[XulySTTBacSiOvertime]    Script Date: 5/26/2019 12:22:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[XulySTTBacSiOvertime] on [dbo].[SoThuTuPhongKhamBacSi_Overtime] for insert
as
	declare @PhieuKham nvarchar(10),@ChuyenKhoa nvarchar(10),@IDBacSi nvarchar(10)
	select  @PhieuKham = IDPhieuKham ,@IDBacSi= BacSi  from inserted;
	select @ChuyenKhoa = ChuyenKhoa from PhieuKham where IDPhieuKham=@PhieuKham; 
	exec PhatSinhSTTPhongKham_BacSiCa2 @PhieuKham,@ChuyenKhoa,@IDBacSi;
	delete SoThuTuPhongKhamBacSi_Overtime where IDPhieuKham=@PhieuKham;
GO
ALTER TABLE [dbo].[SoThuTuPhongKhamBacSi_Overtime] ENABLE TRIGGER [XulySTTBacSiOvertime]
GO
USE [master]
GO
ALTER DATABASE [TEST] SET  READ_WRITE 
GO
