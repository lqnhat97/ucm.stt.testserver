USE [master]
GO
/****** Object:  Database [TEST]    Script Date: 5/27/2019 2:27:44 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[AUTO_IDTraCuu]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[CongGioPhut]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[CongThoiGian]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[BacSi]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[BanKham]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[BenhNhan]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[BenhNhanXetNghiem]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[CaKham]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[ChuyenKhoa]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[DichVuCanLamSang]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[DonViChucNang]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[HienThiSTTXetNghiem]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[KhuVuc]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[Lau]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[LichKhamBacSi]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[LichPhongCanLamSang]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[LichSuTraCuu]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[LoaiDichVu]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[PhieuKham]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[PhongCanLamSang]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[PhongKhamChuyenKhoa]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[SoHienThiPhongCanLamSang]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[SoHienThiPhongKham]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[SoHienThiPhongXetNghiem]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[SoThuTuPhongCLS]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[SoThuTuPhongKham]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[SoThuTuPhongKham_Overtime]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[SoThuTuPhongKhamBacSi_Overtime]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[SoThuTuPhongXetNghiem]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[Temp]    Script Date: 5/27/2019 2:27:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Temp](
	[Status] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThongKePhongCLS]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[ThongKePhongKham]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Table [dbo].[ThucHienCLS]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  View [dbo].[ThongKeGioDuKienSTTCLSCuoi]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  View [dbo].[ThongKeCLSChiTiet]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  View [dbo].[ThongKeGioDuKien]    Script Date: 5/27/2019 2:27:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ThongKeGioDuKien] as
select STT.BanKham,STT.PhongKham,STT.CaKham,max(STT.Gio) as GioDuKienSoCuoi,PK.ChuyenKhoa
from SoThuTuPhongKham as STT join PhongKhamChuyenKhoa as PK on PK.ID=STT.PhongKham
group by STT.BanKham,STT.PhongKham,STT.CaKham,PK.ChuyenKhoa
GO
/****** Object:  View [dbo].[ThongKeSTTCuoiPhongKham]    Script Date: 5/27/2019 2:27:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ThongKeSTTCuoiPhongKham] as
select TK.BanKham,TK.PhongKham,STT.STT,TK.CaKham,TK.GioDuKienSoCuoi,TK.ChuyenKhoa
from ThongKeGioDuKien as TK inner join SoThuTuPhongKham as STT on STT.BanKham=TK.BanKham and TK.PhongKham=STT.PhongKham
where TK.GioDuKienSoCuoi=STT.Gio
GO
/****** Object:  View [dbo].[ThongKeChiTiet]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  View [dbo].[ThongKeChiTiet_Null]    Script Date: 5/27/2019 2:27:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ThongKeChiTiet_Null] as
select BK.IDBan,BK.Phong,LK.CaKham,BS.ChuyenKhoa, BS.ThoiGianKhamTB_min
from BanKham as BK join LichKhamBacSi as LK on LK.IDBan=BK.IDBan and LK.Phong=BK.Phong join BacSi as BS on BS.ID=LK.IDBacSi
GO
/****** Object:  View [dbo].[ThongKeCLS]    Script Date: 5/27/2019 2:27:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ThongKeCLS] as 
select TH.IDPhongCLS,DichVuCLSThucHien,Dv.TenDichVu,DV.LoaiDichVu,DV.TinhTrang,DV.ThoiGianNhaySoTB,TH.CaKham,L.GioBatDau,L.GioKetThuc
from ThucHienCLS as TH inner join DichVuCanLamSang as DV on DV.IDDichVu=TH.DichVuCLSThucHien
						inner join LichPhongCanLamSang as L on L.IDPhongCLS=TH.IDPhongCLS and L.CaKham=TH.CaKham and L.Ngay=TH.Ngay
GO
/****** Object:  View [dbo].[ThongKeCLSChiTiet_Null]    Script Date: 5/27/2019 2:27:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ThongKeCLSChiTiet_Null] as
select distinct TK.IDPhongCLS,TK.SoluongDoi,TK.CaKham
from ThongKePhongCLS as TK inner join ThucHienCLS as Th on TH.IDPhongCLS=TK.IDPhongCLS
where TK.IDPhongCLS not in ( select STT.PhongCanLamSang from SoThuTuPhongCLS as STT join SoHienThiPhongCanLamSang as SHT on SHT.IDPhongCanLamSang=STT.PhongCanLamSang)
		
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
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS165', N'Nguyễn  Thị Ái Linh', N'Nam', N'1955', N'Gia Lai', N'P6', CAST(N'00:08:50' AS Time))
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
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS298', N'Phạm Thị Dịu', N'Nam', N'1975', N'Bắc Kạn', N'PH', CAST(N'00:03:47' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS299', N'Phạm Tường Vân', N'Nữ', N'1978', N'Hà Tĩnh', N'PY', CAST(N'00:06:15' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS3', N'Vy Thị Thư', N'Nữ', N'1985', N'TP.HCM', N'PO', CAST(N'00:05:35' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS300', N'Trần Kim Ngân', N'Nữ', N'1967', N'Đắk Nông', N'D!', CAST(N'00:06:03' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS303', N'Trần Khánh Ngọc', N'Nữ', N'1967', N'Tiền Giang', N'VT01', CAST(N'00:08:34' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS314', N'Phùng Ngọc Bích Trâm', N'Nam', N'1986', N'Hà Tĩnh', N'TN', CAST(N'00:03:54' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS315', N'Lê Minh Hiếu', N'Nam', N'1956', N'Lạng Sơn', N'PT', CAST(N'00:05:07' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS321', N'Hoàng Thị Mai Phương', N'Nữ', N'1965', N'Bạc Liêu', N'PT', CAST(N'00:07:42' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS329', N'Dương Thị Yến Nhi', N'Nam', N'1986', N'Hà Nam', N'P7', CAST(N'00:03:39' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS330', N'Lê Song Toàn', N'Nam', N'1985', N'Hà Nội', N'P@', CAST(N'00:03:58' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS333', N'Lê Trần Xuân Quỳnh', N'Nữ', N'1958', N'Hà Giang	', N'PR', CAST(N'00:05:52' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS334', N'BùI Quang Trung', N'Nam', N'1956', N'Hà Tĩnh', N'DZ', CAST(N'00:04:42' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS337', N'Nguyễn Châu Trúc My', N'Nữ', N'1958', N'Hà Giang	', N'DK', CAST(N'00:03:34' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS341', N'Đới Thị Ngọc Điệp', N'Nam', N'1985', N'Cà Mau', N'P$', CAST(N'00:04:42' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS343', N'Đặng Phan Trà My', N'Nữ', N'1957', N'Quảng Nam', N'DV', CAST(N'00:08:31' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS345', N'Nguyễn Anh Duy', N'Nam', N'1965', N'Hải Dương', N'PB', CAST(N'00:03:28' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS346', N'Trần Thị Kiều Linh', N'Nam', N'1955', N'Yên Bái', N'ND', CAST(N'00:05:36' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS351', N'Nguyễn Minh Hiếu', N'Nam', N'1955', N'Bình Phước', N'PZ', CAST(N'00:04:07' AS Time))
GO
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
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS512', N'Nguyễn Minh Toàn', N'Nam', N'1968', N'An Giang', N'D<', CAST(N'00:08:43' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS513', N'Trần Nguyễn Ngọc Hân', N'Nam', N'1958', N'Lâm Đồng', N'D5', CAST(N'00:08:41' AS Time))
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
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS675', N'Nguyễn Thị Ngọc Huyền', N'Nam', N'1975', N'Phú Thọ', N'YHGD', CAST(N'00:06:02' AS Time))
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
GO
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS778', N'Nguyễn Bùi Tuấn Đạt', N'Nữ', N'1956', N'Đồng Tháp', N'D&', CAST(N'00:06:25' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS787', N'Lê Song Tiêu', N'Nam', N'1985', N'Hà Nội', N'P@', CAST(N'00:05:08' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS794', N'Từ Duy Khang', N'Nam', N'1966', N'Nghệ An', N'D^', CAST(N'00:05:31' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS802', N'Phạm Nguyễn Băng Nghi', N'Nữ', N'1967', N'Bến Tre', N'CKQT', CAST(N'00:05:35' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS810', N'Đặng Thị Diễm Thúy', N'Nữ', N'1967', N'Bắc Kạn', N'D]', CAST(N'00:05:22' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS818', N'Nguyễn Bá Gia Khánh', N'Nam', N'1967', N'Nam Định', N'PA', CAST(N'00:04:50' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS819', N'Trần Ngọc Uyên Phương', N'Nam', N'1985', N'Đồng Tháp', N'PH', CAST(N'00:03:47' AS Time))
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
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS916', N'Lê Đình Phúc', N'Nam', N'1975', N'Khánh Hòa', N'PK', CAST(N'00:08:00' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS922', N'Ngô Quốc An', N'Nam', N'1988', N'Sóc Trăng', N'PN', CAST(N'00:05:20' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS937', N'Võ Quỳnh Mai', N'Nam', N'1966', N'Thái Bình', N'PHCN', CAST(N'00:05:02' AS Time))
INSERT [dbo].[BacSi] ([ID], [HovaTen], [GioiTinh], [NamSinh], [QueQuan], [ChuyenKhoa], [ThoiGianKhamTB_min]) VALUES (N'BS948', N'Trần Phạm Hiền Anh', N'Nam', N'1967', N'Lâm Đồng', N'DC', CAST(N'00:06:04' AS Time))
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
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10001', N'GGJ5', N'XNPH10001', CAST(N'2019-05-26T15:23:19.623' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10002', N'GGJ5', N'XNPH10002', CAST(N'2019-05-26T15:23:19.627' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10003', N'GGJ5', N'XNPH10003', CAST(N'2019-05-26T15:23:19.627' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10004', N'GGJ5', N'XNPH10004', CAST(N'2019-05-26T15:23:19.627' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10005', N'GGJ5', N'XNPH10005', CAST(N'2019-05-26T15:23:19.630' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10006', N'GGJ5', N'XNPH10006', CAST(N'2019-05-26T15:23:19.630' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10007', N'GGJ5', N'XNPH10007', CAST(N'2019-05-26T15:23:19.630' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10008', N'GGJ5', N'XNPH10008', CAST(N'2019-05-26T15:23:19.630' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10009', N'GGJ5', N'XNPH10009', CAST(N'2019-05-26T15:23:19.630' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10010', N'GGJ5', N'XNPH10010', CAST(N'2019-05-26T15:23:19.630' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10011', N'GGJ5', N'XNPH10011', CAST(N'2019-05-26T15:23:19.630' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10012', N'GGJ5', N'XNPH10012', CAST(N'2019-05-26T16:03:11.037' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10013', N'GGJ5', N'XNPH10013', CAST(N'2019-05-26T16:03:11.040' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10014', N'GGJ5', N'XNPH10014', CAST(N'2019-05-26T16:03:11.040' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10015', N'GGJ5', N'XNPH10015', CAST(N'2019-05-26T16:03:11.040' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10016', N'GGJ5', N'XNPH10016', CAST(N'2019-05-26T16:03:11.043' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10017', N'GGJ5', N'XNPH10017', CAST(N'2019-05-26T16:03:11.043' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10018', N'GGJ5', N'XNPH10018', CAST(N'2019-05-26T16:03:11.043' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10019', N'GGJ5', N'XNPH10019', CAST(N'2019-05-26T16:03:11.043' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10020', N'GGJ5', N'XNPH10020', CAST(N'2019-05-26T16:03:11.047' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10021', N'GGJ5', N'XNPH10021', CAST(N'2019-05-26T16:03:11.047' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10022', N'GGJ5', N'XNPH10022', CAST(N'2019-05-26T16:03:11.047' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10023', N'GGJ5', N'XNPH10023', CAST(N'2019-05-26T16:03:11.047' AS DateTime))
INSERT [dbo].[BenhNhanXetNghiem] ([IDPhieuKham], [IDDichVuXN], [IDXetNghiemBN], [ThoiGianChiDinh]) VALUES (N'PKPH10024', N'GGJ5', N'XNPH10024', CAST(N'2019-05-26T16:03:11.050' AS DateTime))
INSERT [dbo].[CaKham] ([IDCa], [TenCa], [GioBatDau], [GioKetThuc]) VALUES (1, N'Sáng', N'7:00 AM', N'12:00 AM')
INSERT [dbo].[CaKham] ([IDCa], [TenCa], [GioBatDau], [GioKetThuc]) VALUES (2, N'Chiều', N'1:00 PM', N'6:00 PM')
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'0D03', N'Khoa chẩn đoán hình ảnh', 5, 1, 0, 1)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'0UGM', N'UNG BƯỚU GAN MẬT VÀ GHÉP GAN', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'A0', N'KHOA KHÁM SỨC KHỎE THEO YÊU CẦU', 5, 1, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'CKQT', N'PK QUỐC TẾ (CHUYÊN KHOA)', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D-', N'DV PK DA LIỄU', 5, 3, 0, 0)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'D!', N'DV PK NỘI TIẾT', 5, 3, 0, 0)
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
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PW', N'LÃO KHOA', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PY', N'VÚ', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'PZ', N'TIỂU PHẪU', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'TN', N'NỘI THẬN', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'TQQT', N'PK QUỐC TẾ (TỔNG QUÁT)', 1, 1, 0, 2)
GO
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'UB', N'UNG BƯỚU', 1, 1, 0, 2)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'VT01', N'PHÒNG KHÁM BỆNH VIỆN ĐẠI HỌC Y DƯỢC 1', 1, 3, 0, 23)
INSERT [dbo].[ChuyenKhoa] ([IDChuyenKhoa], [TenChuyenKhoa], [IDDonViChucNang], [IDKhuVuc], [NgungSuDung], [IDLoaiDonVi]) VALUES (N'YHGD', N'Y HỌC GIA ĐÌNH', 1, 3, 0, 2)
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'E038', N'Nội soi can thiệp - cắt polyp ống tiêu hóa < 1cm', N'MB', 0, CAST(N'00:08:31' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI0', N'Phế máu ngoại biên (BV TMHH)', N'GA', 0, CAST(N'00:05:29' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI1', N'Xét nghiệm tế bào học tủy xương (tủy đồ) (BV TMHH)', N'GA', 0, CAST(N'00:05:27' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI2', N'Định lượng Arsenic nước tiểu', N'GA', 0, CAST(N'00:05:54' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI3', N'Định lượng Arsenic tóc', N'GA', 0, CAST(N'00:08:23' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI4', N'Tia xạ túi máu', N'GA', 0, CAST(N'00:09:37' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI6', N'BK đàm (PNT)', N'GA', 0, CAST(N'00:07:37' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI8', N'Soi trực tiếp nhuộm soi (nhuộm Gram...) (CR)', N'GA', 0, CAST(N'00:10:50' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGI9', N'Nuôi cấy và định danh nấm bằng phương pháp thông thường (CR)', N'GA', 0, CAST(N'00:09:15' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGJ1', N'Nuôi cấy định danh vi khuẩn bằng phương pháp thông thường (CR)', N'GA', 0, CAST(N'00:09:14' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGJ2', N'Kháng sinh đồ nấm (CR)', N'GA', 0, CAST(N'00:05:25' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGJ3', N'Kháng sinh đồ vi khuẩn (CR)', N'GA', 0, CAST(N'00:07:19' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGJ5', N'Xét nghiệm tìm BK (CR)', N'GA', 0, CAST(N'00:09:54' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGJ6', N'Định lượng Catecholamin /máu', N'GA', 0, CAST(N'00:09:50' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGL9', N'Soi mủ hạch, abces tìm BK (NĐ)', N'GA', 0, CAST(N'00:05:06' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGM0', N'Soi mủ tìm nấm (BĐ)', N'GA', 0, CAST(N'00:05:25' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGM1', N'Soi dịch vết thương tìm BK (NĐ)', N'GA', 0, CAST(N'00:05:52' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGM2', N'Soi dịch vết thương tìm vi trùng (NĐ)', N'GA', 0, CAST(N'00:08:40' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'GGM3', N'Soi tìm BK đàm (NĐ)', N'GA', 0, CAST(N'00:05:08' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'KX11', N'Đo mật độ xương bằng phương pháp DEXA (cổ xương đùi) và đo chiều dài trụ khớp háng (HAL) hai bên', N'KX', 0, CAST(N'00:10:39' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'KX12', N'Đo các thành phần cơ, mỡ, xương toàn thân người lớn', N'KX', 0, CAST(N'00:09:05' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'KX14', N'Đo mật độ xương bằng phương pháp DEXA (CSTL + cổ xương đùi một bên)', N'KX', 0, CAST(N'00:05:04' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MA', N'Chụp X-Quang dạ dày - tá tràng có uống thuốc cản quang Bary sulfat 275mg số hóa', N'MA', 0, CAST(N'00:06:07' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MAP6', N'Chụp X-quang xương cánh tay thẳng 1 bên số hóa  1 phim', N'MA', 0, CAST(N'00:09:59' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MAP7', N'Chụp X-quang xương cánh tay nghiêng 1 bên số hóa', N'MA', 0, CAST(N'00:07:08' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MAP8', N'Chụp X-quang khớp gối thẳng – nghiêng 1 bên (tư thế đứng) số hóa  1 phim', N'MA', 0, CAST(N'00:07:07' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MAP9', N'Chụp X-quang khớp gối thẳng – nghiêng 2 bên (tư thế đứng) 2 phim số hóa  1 phim', N'MA', 0, CAST(N'00:06:46' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MAQ0', N'Chụp X-quang khớp gối nghiêng 1 bên (tư thế đứng) số hóa  1 phim', N'MA', 0, CAST(N'00:08:37' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MAQ1', N'Chụp X-quang khớp gối thẳng 1 bên (tư thế đứng) số hóa  1 phim', N'MA', 0, CAST(N'00:10:43' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MAQ2', N'Chụp X-quang lưu thông ruột non có cản quang tan trong nước số hóa', N'MA', 0, CAST(N'00:05:09' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MB39', N'Bộ thun thắt tĩnh mạch thực quản', N'MB', 0, CAST(N'00:09:29' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MB82', N'Nội soi can thiệp - cắt polyp ống tiêu hóa > 1cm hoặc nhiều polyp', N'MB', 0, CAST(N'00:09:57' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MB84', N'Nội soi chích (tiêm) keo điều trị dãn tĩnh mạch phình vị', N'MB', 0, CAST(N'00:09:18' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MB86', N'Chụp đường mật trong mổ nội soi', N'MB', 0, CAST(N'00:06:25' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MB88', N'Chụp mật qua Kehr', N'MB', 0, CAST(N'00:06:53' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MB89', N'Đặt stent thực quản qua nội soi.', N'MB', 0, CAST(N'00:09:05' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MB91', N'Nội soi thanh quản lấy dị vật', N'MB', 0, CAST(N'00:05:39' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBA1', N'Nội soi đại trực tràng toàn bộ ống mềm không sinh thiết', N'MB', 0, CAST(N'00:10:35' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBA4', N'Nội soi mật tụy ngược dòng - (ERCP) chẩn đoán', N'MB', 0, CAST(N'00:05:50' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBC8', N'Nội soi thanh quản ống mềm sinh thiết', N'MB', 0, CAST(N'00:05:08' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBD0', N'Nội soi can thiệp - thắt búi giãn tĩnh mạch thực quản bằng vòng cao su', N'MB', 0, CAST(N'00:10:53' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBD1', N'Tiêm hoặc kẹp cầm máu qua nội soi dạ dày', N'MB', 0, CAST(N'00:06:11' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBD2', N'Tiêm hoặc kẹp cầm máu qua nội soi đại tràng', N'MB', 0, CAST(N'00:07:09' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBD5', N'Nội soi nong hẹp miệng nối ruột-ruột hoặc mật-ruột', N'MB', 0, CAST(N'00:05:04' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBE0', N'Nội soi thực quản - dạ dày - tá tràng không sinh thiết (ống mềm, gây mê)', N'MB', 0, CAST(N'00:08:55' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBE1', N'Nội soi đại trực tràng toàn bộ ống mềm không sinh thiết (gây mê)', N'MB', 0, CAST(N'00:08:16' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBE3', N'Nội soi thực quản-dạ dày, lấy dị vật', N'MB', 0, CAST(N'00:08:56' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBE5', N'Nội soi can thiệp - gắp giun, dị vật ống tiêu hóa', N'MB', 0, CAST(N'00:06:03' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBE7', N'Nội soi can thiệp - cầm máu ống tiêu hóa bằng laser argon', N'MB', 0, CAST(N'00:10:08' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBE8', N'Nội soi phế quản ống mềm (gây mê)', N'MB', 0, CAST(N'00:08:27' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBE9', N'Nội soi thực quản- dạ dày- tá tràng không sinh thiết (ống mềm)', N'MB', 0, CAST(N'00:10:59' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBF0', N'Nội soi thực quản- dạ dày- tá tràng có thể kết hợp sinh thiết (ống mềm, gây mê)', N'MB', 0, CAST(N'00:05:58' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBF1', N'Nội soi đại trực tràng ống mềm gây mê (có thuốc, có sinh thiết)', N'MB', 0, CAST(N'00:07:10' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBF2', N'Nội soi đại trực tràng ống mềm gây mê (không thuốc, không sinh thiết)', N'MB', 0, CAST(N'00:05:07' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBF3', N'Nội soi đại trực tràng ống mềm gây mê (không thuốc, có sinh thiết)', N'MB', 0, CAST(N'00:08:18' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MBH0', N'Kỹ thuật mở cơ qua nội soi đường miệng điều trị co thắt tâm vị', N'MB', 0, CAST(N'00:10:22' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC60', N'Chọc hút tế bào tuyến giáp dưới hướng dẫn siêu âm', N'MC', 0, CAST(N'00:10:49' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC61', N'Bơm nước lòng tử cung (SHG) qua siêu âm', N'MC', 0, CAST(N'00:06:44' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC65', N'Chọc FNA >=2 nhân qua siêu âm', N'MC', 0, CAST(N'00:08:57' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC66', N'Chọc FNA 1 nhân qua siêu âm', N'MC', 0, CAST(N'00:05:54' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC67', N'Chọc hút dịch ( ổ bụng, màng phổi) qua siêu âm', N'MC', 0, CAST(N'00:06:56' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC68', N'Chọc hút nang vú dưới hướng dẫn siêu âm', N'MC', 0, CAST(N'00:09:14' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC69', N'Đốt sóng cao tần điều trị ung thư gan (RFA) dưới hướng dẫn siêu âm', N'MC', 0, CAST(N'00:08:44' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC72', N'Siêu âm Doppler tinh hoàn, mào tinh hoàn hai bên', N'MC', 0, CAST(N'00:05:13' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC73', N'Siêu âm ổ bụng', N'MC', 0, CAST(N'00:07:47' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC74', N'Siêu âm mắt (siêu âm thường qui) (1 mắt)', N'MC', 0, CAST(N'00:10:59' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC75', N'Siêu âm mắt (siêu âm thường qui) (2 mắt)', N'MC', 0, CAST(N'00:05:26' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC81', N'Siêu âm ổ bụng (đo thể tích nước tiểu)', N'MC', 0, CAST(N'00:08:43' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC88', N'Siêu âm 3D/4D tim', N'MC', 0, CAST(N'00:05:20' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC89', N'Siêu âm phần mềm', N'MC', 0, CAST(N'00:09:18' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC90', N'Siêu âm 3D/4D trực tràng', N'MC', 0, CAST(N'00:10:02' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC91', N'Siêu âm mắt (lấy thông số mổ cận thị)', N'MC', 0, CAST(N'00:10:18' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC92', N'Siêu âm mắt (đo kính nội nhãn)', N'MC', 0, CAST(N'00:10:41' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC93', N'Siêu âm phụ khoa ngã H.môn-T.Tràng (màu)', N'MC', 0, CAST(N'00:05:06' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MC94', N'Siêu âm phụ khoa ngã H.môn-T.Tràng (trắng đen)', N'MC', 0, CAST(N'00:06:50' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MCD0', N'Siêu âm thai (thai, nhau thai, nước ối)', N'MC', 0, CAST(N'00:06:13' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MCD1', N'Siêu âm Doppler thai nhi (thai, nhau thai, dây rốn, động mạch tử cung)', N'MC', 0, CAST(N'00:05:13' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MCD2', N'Siêu âm thai nhi trong 3 tháng đầu (Siêu âm khảo sát hình thái học)', N'MC', 0, CAST(N'00:09:43' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF15', N'Chụp đáy mắt không huỳnh quang', N'MF', 0, CAST(N'00:06:01' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF16', N'Chụp đáy mắt không huỳnh quang (màu)', N'MF', 0, CAST(N'00:09:28' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF17', N'Dấu hiệu sinh tồn tại phòng khám TDCNHH', N'MF', 0, CAST(N'00:06:03' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF20', N'Điện tim thường (ECG)', N'MF', 0, CAST(N'00:09:58' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF21', N'Nghiệm pháp gắng sức điện tâm đồ', N'MF', 0, CAST(N'00:06:45' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF22', N'Đo áp lực hậu môn trực tràng', N'MF', 0, CAST(N'00:05:07' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF26', N'Đo Điện cơ (EMG)', N'MF', 0, CAST(N'00:05:29' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF28', N'Đo Điện não (EEG)', N'MF', 0, CAST(N'00:09:20' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF29', N'Đo độ lồi mắt', N'MF', 0, CAST(N'00:10:35' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF30', N'Đo hô hấp ký toàn diện', N'MF', 0, CAST(N'00:06:18' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF32', N'Holter điện tâm đồ', N'MF', 0, CAST(N'00:09:44' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF52', N'Điện tim thường tại giường', N'MF', 0, CAST(N'00:08:50' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF58', N'Holter huyết áp', N'MF', 0, CAST(N'00:07:02' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF59', N'Đo nồng độ chất Indocyanine Green (ICG)', N'MF', 0, CAST(N'00:06:50' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF60', N'Đo chỉ số ABI (chỉ số cổ chân/cánh tay)', N'MF', 0, CAST(N'00:09:38' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF61', N'Đo thành phần cơ thể', N'MF', 0, CAST(N'00:07:17' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF62', N'Ghi điện não thường quy (Điện não thường quy tại giường)', N'MF', 0, CAST(N'00:07:07' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF63', N'Ghi điện não giấc ngủ (Điện não giấc ngủ ngắn 60 phút)', N'MF', 0, CAST(N'00:08:50' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF71', N'Ghi điện não video (Điện não video 24 giờ tại giường)', N'MF', 0, CAST(N'00:05:34' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MF72', N'Ghi điện cơ (Điện cơ tại giường)', N'MF', 0, CAST(N'00:10:56' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MG92', N'Xạ hình xương 3 pha với Tc99m MDP', N'MG', 0, CAST(N'00:07:55' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MH21', N'Ion đồ (Na+, K+, Cl-, Ca)', N'MH', 0, CAST(N'00:06:44' AS Time))
GO
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MI29', N'Xét nghiệm hồng cầu lưới (bằng máy đếm laser)', N'MI', 0, CAST(N'00:09:05' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MI30', N'Tế bào dịch màng (phổi, bụng, tim, khớp…) có đếm số lượng tế bào', N'MI', 0, CAST(N'00:09:43' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MI33', N'Xét nghiệm số lượng và độ tập trung tiểu cầu (bằng phương pháp thủ công)', N'MI', 0, CAST(N'00:09:45' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MI56', N'Điện di huyết sắc tố (định lượng)', N'MI', 0, CAST(N'00:06:30' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MI57', N'Tìm mảnh vỡ hồng cầu', N'MI', 0, CAST(N'00:07:00' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MW98', N'Chụp cộng hưởng từ gan với chất tương phản đặc hiệu mô', N'MW', 0, CAST(N'00:10:05' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MW99', N'Gây mê liên tục kiểm soát người bệnh thở máy ≤ 8 giờ (gây mê chụp MRI)', N'MW', 0, CAST(N'00:05:18' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MXD1', N'Chụp, nong và đặt stent động mạch mạc treo (tràng trên, tràng dưới) số hóa xóa nền', N'MX', 0, CAST(N'00:08:44' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MXD2', N'Chụp, nong và đặt Stent động mạch thận số hóa xóa nền', N'MX', 0, CAST(N'00:07:12' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MXD3', N'Theo dõi ACT tại chỗ', N'MX', 0, CAST(N'00:09:57' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MXD4', N'Nong, đặt Stent đường mật số hóa xóa nền', N'MX', 0, CAST(N'00:09:26' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'MZ09', N'Test hơi thở C13 phát hiện VK H.Pylori', N'MZ', 0, CAST(N'00:07:21' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'ND64', N'Chụp cắt lớp vi tính bụng-tiểu khung thường quy', N'ND', 0, CAST(N'00:06:23' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'ND65', N'Chụp cắt lớp vi tính bụng-tiểu khung thường quy có tiêm thuốc cản quang (chưa bao gồm thuốc cản quang)', N'ND', 0, CAST(N'00:05:16' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'ND66', N'Chụp cắt lớp vi tính xương chi không tiêm thuốc cản quang', N'ND', 0, CAST(N'00:08:40' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'ND67', N'Chụp cắt lớp vi tính xương chi có tiêm thuốc cản quang (chưa bao gồm thuốc cản quang)', N'ND', 0, CAST(N'00:07:46' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NR04', N'Nghiệm pháp bàn nghiêng (TILT TEST)', N'NR', 0, CAST(N'00:10:42' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW02', N'Chẩn đoán điện', N'NW', 0, CAST(N'00:10:45' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW04', N'Điều trị bằng máy kéo giãn cột sống ', N'NW', 0, CAST(N'00:09:06' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW05', N'Chườm lạnh', N'NW', 0, CAST(N'00:10:48' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW06', N'Chườm nóng', N'NW', 0, CAST(N'00:07:34' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW08', N'Điện vi dòng giảm đau', N'NW', 0, CAST(N'00:06:30' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW23', N'Kích thích điện < 3 cơ', N'NW', 0, CAST(N'00:10:07' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW24', N'Kích thích điện > 3 cơ', N'NW', 0, CAST(N'00:08:31' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW46', N'Vật lý trị liệu hô hấp (người lớn)', N'NW', 0, CAST(N'00:06:19' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW47', N'Vật lý trị liệu phòng ngừa các biến chứng do bất động', N'NW', 0, CAST(N'00:05:32' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NW48', N'VLTL bệnh phổi tắc nghẽn mãn tính', N'NW', 0, CAST(N'00:08:26' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NWA5', N'Vật lý trị liệu hô hấp (trẻ nhỏ)', N'NW', 0, CAST(N'00:08:47' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NWA6', N'VLTL cho bệnh nhân rối loạn vận động khác (loạn trương lục, múa giật,...)', N'NW', 0, CAST(N'00:06:43' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NWA7', N'Khám - lượng giá VLTL - thiết lập mục tiêu và chương trình VLTL cho bệnh nhân Parkinson', N'NW', 0, CAST(N'00:05:58' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NWA8', N'Tập do cứng khớp', N'NW', 0, CAST(N'00:08:23' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NY04', N'Hấp khử trùng dụng cụ phẫu thuật bằng PP khác', N'NY', 0, CAST(N'00:09:07' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NY05', N'Hấp khử trùng dụng cụ phẫu thuật máy STERRAD', N'NY', 0, CAST(N'00:08:02' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NY06', N'Phí tiệt khuẩn gói vải phẫu thuật', N'NY', 0, CAST(N'00:06:39' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NY07', N'Phí tiệt khuẩn LMA PROSIEAL (S3,S4,S5)', N'NY', 0, CAST(N'00:08:23' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ18', N'Soi tìm vi trùng (dịch ổ bụng)', N'NZ', 0, CAST(N'00:07:46' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ19', N'Soi tìm vi trùng (dịch não tủy)', N'NZ', 0, CAST(N'00:05:58' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ33', N'Soi tìm vi trùng (dịch đầu CVC)', N'NZ', 0, CAST(N'00:10:16' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ34', N'Soi tìm vi trùng (dịch phết họng)', N'NZ', 0, CAST(N'00:08:57' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ35', N'Soi tìm vi trùng (dịch khác)', N'NZ', 0, CAST(N'00:06:31' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ38', N'Kháng sinh đồ', N'NZ', 0, CAST(N'00:08:30' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ75', N'Vi khuẩn nhuộm soi (nhuộm Gram) đàm', N'NZ', 0, CAST(N'00:09:11' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ98', N'Vi khuẩn nhuộm soi (nhuộm Gram) dịch khác', N'NZ', 0, CAST(N'00:09:16' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZ99', N'XN tìm BK nước tiểu', N'NZ', 0, CAST(N'00:05:18' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA0', N'XN tìm BK đàm', N'NZ', 0, CAST(N'00:08:47' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA1', N'XN tìm BK dịch phế quản', N'NZ', 0, CAST(N'00:08:30' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA2', N'XN tìm BK dịch dạ dày', N'NZ', 0, CAST(N'00:05:32' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA3', N'XN tìm BK dịch màng phổi', N'NZ', 0, CAST(N'00:08:55' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA4', N'XN tìm BK dịch màng bụng', N'NZ', 0, CAST(N'00:08:00' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA5', N'XN tìm BK dịch não tủy', N'NZ', 0, CAST(N'00:08:22' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA6', N'XN tìm BK dịch khớp', N'NZ', 0, CAST(N'00:10:55' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA7', N'XN tìm BK dịch khác', N'NZ', 0, CAST(N'00:06:37' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA8', N'XN tìm BK lần 1', N'NZ', 0, CAST(N'00:06:21' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZA9', N'XN tìm BK lần 2', N'NZ', 0, CAST(N'00:10:26' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'NZB0', N'XN tìm BK lần 3', N'NZ', 0, CAST(N'00:10:33' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TJ04', N'Điện châm ngoại viện', N'TJ', 0, CAST(N'00:05:11' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TN01', N'INR tại giường', N'TN', 0, CAST(N'00:06:03' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TN02', N'Keton mao mạch (tại giường)', N'TN', 0, CAST(N'00:06:15' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TN04', N'Manometry biofeeback', N'TN', 0, CAST(N'00:10:04' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TN05', N'Định nhóm máu tại giường', N'TN', 0, CAST(N'00:09:57' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TN08', N'Thổi hơi thở tìm H.pylori C14', N'TN', 0, CAST(N'00:07:53' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TN15', N'Xét nghiệm đường máu mao mạch tại Phòng khám', N'TN', 0, CAST(N'00:05:39' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TO85', N'Nhiễm sắc thể đồ bệnh lý huyết học', N'TO', 0, CAST(N'00:08:22' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TZ01', N'Nội soi tai mũi họng', N'MM', 0, CAST(N'00:06:54' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TZ02', N'Nội soi tai', N'MM', 0, CAST(N'00:10:44' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TZ03', N'Nội soi mũi xoang', N'MM', 0, CAST(N'00:06:32' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TZ04', N'Nội soi họng', N'MM', 0, CAST(N'00:10:20' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TZ05', N'Đo thính lực đơn âm', N'MM', 0, CAST(N'00:05:41' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TZ06', N'Đo phản xạ cơ bàn đạp', N'MM', 0, CAST(N'00:08:11' AS Time))
INSERT [dbo].[DichVuCanLamSang] ([IDDichVu], [TenDichVu], [LoaiDichVu], [TinhTrang], [ThoiGianNhaySoTB]) VALUES (N'TZ07', N'Đo nhĩ lượng', N'MM', 0, CAST(N'00:07:21' AS Time))
INSERT [dbo].[DonViChucNang] ([IDDonViChucNang], [TenDonViChucNang]) VALUES (1, N'Khám bệnh ngoại trú')
INSERT [dbo].[DonViChucNang] ([IDDonViChucNang], [TenDonViChucNang]) VALUES (5, N'Đơn Vị Dịch Vụ')
INSERT [dbo].[HienThiSTTXetNghiem] ([IDPhongXN], [IDHienThiXN], [ChuoiSTT], [CaKham], [ThoiGian], [Ngay]) VALUES (N'XN1', N'XN1_1_10', N'1  -->  10', 1, CAST(N'07:02:00' AS Time), CAST(N'2019-03-27' AS Date))
INSERT [dbo].[KhuVuc] ([IDKhuVuc], [TenKhuVuc]) VALUES (1, N'Khu B')
INSERT [dbo].[KhuVuc] ([IDKhuVuc], [TenKhuVuc]) VALUES (2, N'Khu C')
INSERT [dbo].[KhuVuc] ([IDKhuVuc], [TenKhuVuc]) VALUES (3, N'Khu A')
INSERT [dbo].[Lau] ([IDLau], [TenLau]) VALUES (0, N'Trệt')
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
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10001', N'BN21136', CAST(N'2019-05-26T15:21:06.027' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10002', N'BN21444', CAST(N'2019-05-26T15:21:06.030' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10003', N'BN21451', CAST(N'2019-05-26T15:21:06.030' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10004', N'BN21456', CAST(N'2019-05-26T15:21:06.030' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10005', N'BN21464', CAST(N'2019-05-26T15:21:06.030' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10006', N'BN21466', CAST(N'2019-05-26T15:21:06.030' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10007', N'BN21511', CAST(N'2019-05-26T15:21:06.033' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10008', N'BN21512', CAST(N'2019-05-26T15:21:06.033' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10009', N'BN21114', CAST(N'2019-05-26T15:21:06.033' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10010', N'BN21122', CAST(N'2019-05-26T15:21:06.037' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10011', N'BN21123', CAST(N'2019-05-26T15:21:06.037' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10012', N'BN21635', CAST(N'2019-05-26T16:02:28.077' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10013', N'BN21641', CAST(N'2019-05-26T16:02:28.080' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10014', N'BN21642', CAST(N'2019-05-26T16:02:28.080' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10015', N'BN21644', CAST(N'2019-05-26T16:02:28.080' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10016', N'BN21645', CAST(N'2019-05-26T16:02:28.083' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10017', N'BN21646', CAST(N'2019-05-26T16:02:28.083' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10018', N'BN21652', CAST(N'2019-05-26T16:02:28.083' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10019', N'BN21661', CAST(N'2019-05-26T16:02:28.083' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10020', N'BN21676', CAST(N'2019-05-26T16:02:28.087' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10021', N'BN21677', CAST(N'2019-05-26T16:02:28.087' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10022', N'BN21678', CAST(N'2019-05-26T16:02:28.087' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10023', N'BN21679', CAST(N'2019-05-26T16:02:28.087' AS DateTime), N'PH')
INSERT [dbo].[PhieuKham] ([IDPhieuKham], [IDBenhNhan], [Ngay], [ChuyenKhoa]) VALUES (N'PKPH10024', N'BN21556', CAST(N'2019-05-26T16:02:28.090' AS DateTime), N'PH')
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'1', N'Phòng Ðiện Châm 210', N'D?', 2)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'2', N'Phòng Ðiện Châm 211', N'D?', 2)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'CT1', N'Phòng CT-Scan', N'DV', 5)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'DSA', N'Phòng DSA', N'DI', 5)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'KSNK1', N'Phòng 237', N'DZ', 2)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'MRI', N'Phòng MRI', N'DW', 4)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'NS1', N'Phòng Nội Soi 212', N'DB', 2)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'NS2', N'Phòng Nội Soi 213', N'DB', 2)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'NS3', N'Phòng Nội Soi 214', N'DB', 2)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'PHCN1', N'Phòng 235', N'D+', 2)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'PHCN2', N'Phòng 236', N'D+', 2)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'SA1', N'Phòng 331', N'DC', 3)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'SA2', N'Phòng 332', N'DC', 3)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'SA3', N'Phòng 333', N'DC', 3)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'SA4', N'Phòng 334', N'DC', 3)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'SPECT', N'Phòng SPECT', N'DG', 4)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'TD1', N'Phòng 340', N'DF', 3)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'TD2', N'Phòng 341', N'DF', 3)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'TMH1', N'Phòng 320', N'DL', 3)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'TMH2', N'Phòng 321', N'DL', 3)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'XN1', N'Phòng Xét Nghiệm A', N'DH', 0)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'XN2', N'Phòng Xét Nghiệm B', N'DH', 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'XN3', N'Phòng Xét Nghiệm C', N'DH', 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'XNK1', N'Phòng 238', N'D[', 2)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'XQ1', N'Phòng X-Quang A', N'DA', 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'XQ2', N'Phòng X-Quang B', N'DA', 1)
INSERT [dbo].[PhongCanLamSang] ([ID], [SoPhong], [TrucThuoc], [Lau]) VALUES (N'XQ3', N'Phòng X-Quang C', N'DA', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'1', N'Phòng 32', N'PH', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'100', N'Phòng 21', N'PK', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'101', N'Phòng 21', N'PN', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'104', N'X Quang (Khu B)', N'DA', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'105', N'X Quang (Khu A)', N'DA', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'109', N'Phòng 81', N'ND', 8)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'110', N'Phòng 82', N'ND', 8)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'111', N'Phòng 69', N'PG', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'112', N'Phòng 70', N'PG', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'113', N'SPECT (Khu A)', N'DG', 8)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'114', N'MRI(ĐHYD)', N'DW', 8)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'117', N'Phòng 49', N'PI', 4)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'118', N'Phòng 37', N'YHGD', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'119', N'Phòng 38', N'YHGD', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'120', N'Phòng 79', N'PA', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'121', N'Phòng 80', N'PA', 8)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'122', N'Phòng 83', N'KTN', 8)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'123', N'Phòng 60', N'GN', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'124', N'Phòng 64', N'DTTL', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'125', N'Phòng 5', N'HH', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'126', N'Phòng 27', N'TN', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'129', N'Phòng 1', N'P(', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'130', N'Phòng 28', N'LM', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'131', N'Phòng 29', N'LM', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'132', N'Phòng VIP', N'DTTL', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'133', N'Phòng VIP', N'GN', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'134', N'Phòng VIP', N'HH', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'135', N'Phòng VIP', N'KTN', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'136', N'Phòng VIP', N'LM', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'137', N'Phòng VIP', N'ND', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'138', N'Phòng VIP', N'P!', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'139', N'Phòng VIP', N'P#', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'140', N'Phòng VIP', N'P(', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'141', N'Phòng VIP', N'P@', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'143', N'Phòng VIP', N'P6', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'144', N'Phòng VIP', N'P7', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'146', N'Phòng VIP', N'P9', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'147', N'Phòng VIP', N'PA', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'148', N'Phòng VIP', N'PB', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'149', N'Phòng VIP', N'PC', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'15', N'Phòng 31', N'PB', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'150', N'Phòng VIP', N'PD', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'151', N'Phòng VIP', N'PF', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'152', N'Phòng VIP', N'PG', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'153', N'Phòng VIP', N'PH', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'154', N'Phòng VIP', N'PI', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'155', N'Phòng VIP', N'PJ', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'156', N'Phòng VIP', N'PK', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'157', N'Phòng VIP', N'PL', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'158', N'Phòng VIP', N'PM', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'159', N'Phòng VIP', N'PN', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'16', N'Phòng 11', N'P7', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'160', N'Phòng VIP', N'PO', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'161', N'Phòng VIP', N'PP', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'162', N'Phòng VIP', N'PQ', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'163', N'Phòng VIP', N'PR', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'164', N'Phòng VIP', N'PS', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'165', N'Phòng VIP', N'PT', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'166', N'Phòng VIP', N'PU', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'167', N'Phòng VIP', N'PV', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'168', N'Phòng VIP', N'PW', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'17', N'Phòng 12', N'P7', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'170', N'Phòng VIP', N'PY', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'171', N'Phòng VIP', N'PZ', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'172', N'Phòng VIP', N'TN', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'173', N'Phòng VIP', N'YHGD', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'174', N'Phòng 5', N'P(', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'177', N'Phòng 45', N'PJ', 4)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'178', N'Phòng 70', N'UB', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'179', N'Phòng 70', N'PY', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'18', N'Phòng 14', N'P7', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'180', N'Phòng 74', N'PY', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'181', N'Phòng 22', N'P$', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'182', N'Phòng VIP', N'P$', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'183', N'Phòng 71', N'HH', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'184', N'Phòng 71', N'PL', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'185', N'Phòng 16', N'0UGM', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'187', N'Phòng 41', N'NXK', 4)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'188', N'Phòng 29', N'P^', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'189', N'Phòng 1', N'TQQT', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'19', N'Phòng 15', N'P7', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'190', N'Phòng 1', N'CKQT', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'191', N'Phòng 01', N'KBTS', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'192', N'Phòng 02', N'KBTS', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'195', N'CT-Scan ', N'DV', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'198', N'Phòng 02', N'NHI2', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'199', N'Tiểu phẫu B', N'PZ', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'2', N'Phòng 33', N'PH', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'20', N'Phòng 16', N'P7', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'200', N'Phòng 25', N'PN', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'201', N'Phòng 84', N'P(', 8)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'202', N'Phòng 63', N'PN', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'203', N'Phòng 62', N'TN', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'204', N'Phòng 27', N'PL', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'207', N'Phòng 65', N'NHCN', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'209', N'Phòng 85', N'PHCN', 8)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'21', N'Phòng 4', N'P7', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'22', N'Phòng 5', N'P7', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'23', N'Phòng 6', N'PD', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'24', N'Phòng 7', N'PD', 0)
GO
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'25', N'Phòng 8', N'PD', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'26', N'Phòng 9', N'PD', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'27', N'Phòng 10', N'PD', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'28', N'Phòng 2', N'PM', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'29', N'Phòng 3', N'PM', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'3', N'Siêu âm 1', N'DC', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'30', N'Phòng 34', N'PH', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'31', N'Phòng 35', N'PH', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'32', N'Phòng 36', N'PH', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'35', N'Phòng 46', N'PI', 4)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'36', N'Phòng 47', N'PI', 4)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'37', N'Phòng 48', N'PI', 4)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'4', N'Siêu âm 2', N'DC', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'40', N'Phòng 60', N'P2', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'42', N'Phòng 1', N'P6', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'44', N'Phòng 30', N'PC', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'48', N'Phòng 42', N'PJ', 4)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'49', N'Phòng 43', N'PJ', 4)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'50', N'Phòng 44', N'PJ', 4)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'51', N'Phòng 22', N'PK', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'52', N'Phòng 25', N'PK', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'53', N'Phòng 26', N'PK', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'54', N'Phòng 61', N'P9', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'55', N'Phòng 77', N'PA', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'56', N'Phòng 72', N'PF', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'57', N'Phòng 66', N'PG', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'58', N'Phòng 39', N'PL', 3)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'59', N'Phòng 40', N'PL', 4)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'60', N'Phòng 1', N'PD', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'61', N'Phòng 50', N'PO', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'62', N'Phòng 59', N'PP', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'63', N'Phòng 53', N'PQ', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'64', N'Phòng 58', N'PR', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'66', N'Phòng 75', N'PY', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'68', N'Phòng 24', N'PN', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'69', N'Phòng 3', N'TN', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'70', N'Phòng 52', N'PW', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'71', N'Lầu 6, Block A', N'P!', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'72', N'Phòng 2', N'PD', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'73', N'Phòng 3', N'PD', 0)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'74', N'Phòng 24', N'PK', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'75', N'Phòng 67', N'PG', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'76', N'Phòng 68', N'PG', 6)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'79', N'Phòng 56', N'P#', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'80', N'Phòng 57', N'P#', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'81', N'Phòng 54', N'PQ', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'82', N'Phòng 78', N'PA', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'83', N'Phòng 73', N'PF', 7)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'90', N'Phòng siêu âm 7', N'PV', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'92', N'Phòng 17', N'PU', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'93', N'Phòng 19', N'PU', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'94', N'Phòng 18', N'PT', 1)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'95', N'Phòng 20', N'PT', 2)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'96', N'Tiểu phẫu A', N'PZ', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'97', N'Phòng tư vấn', N'PS', 5)
INSERT [dbo].[PhongKhamChuyenKhoa] ([ID], [SoPhong], [ChuyenKhoa], [Lau]) VALUES (N'98', N'Phòng 1', N'P@', 0)
INSERT [dbo].[SoHienThiPhongCanLamSang] ([IDPhongCanLamSang], [STT], [IDPhieuKham], [CanLamSang], [Gio], [TinhTrang], [CaKham]) VALUES (N'TMH1', 1, N'PKPH10001', N'TZ02', CAST(N'2019-03-27T07:02:00.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongCanLamSang] ([IDPhongCanLamSang], [STT], [IDPhieuKham], [CanLamSang], [Gio], [TinhTrang], [CaKham]) VALUES (N'TMH1', 2, N'PKPH10003', N'TZ02', CAST(N'2019-03-27T07:12:44.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongCanLamSang] ([IDPhongCanLamSang], [STT], [IDPhieuKham], [CanLamSang], [Gio], [TinhTrang], [CaKham]) VALUES (N'TMH1', 3, N'PKPH10005', N'TZ01', CAST(N'2019-03-27T07:19:38.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongCanLamSang] ([IDPhongCanLamSang], [STT], [IDPhieuKham], [CanLamSang], [Gio], [TinhTrang], [CaKham]) VALUES (N'TMH1', 4, N'PKPH10007', N'TZ01', CAST(N'2019-03-27T07:26:32.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongCanLamSang] ([IDPhongCanLamSang], [STT], [IDPhieuKham], [CanLamSang], [Gio], [TinhTrang], [CaKham]) VALUES (N'TMH2', 1, N'PKPH10002', N'TZ02', CAST(N'2019-03-27T07:02:00.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongCanLamSang] ([IDPhongCanLamSang], [STT], [IDPhieuKham], [CanLamSang], [Gio], [TinhTrang], [CaKham]) VALUES (N'TMH2', 2, N'PKPH10004', N'TZ02', CAST(N'2019-03-27T07:12:44.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongCanLamSang] ([IDPhongCanLamSang], [STT], [IDPhieuKham], [CanLamSang], [Gio], [TinhTrang], [CaKham]) VALUES (N'TMH2', 3, N'PKPH10006', N'TZ02', CAST(N'2019-03-27T07:23:28.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongCanLamSang] ([IDPhongCanLamSang], [STT], [IDPhieuKham], [CanLamSang], [Gio], [TinhTrang], [CaKham]) VALUES (N'TMH2', 4, N'PKPH10008', N'TZ02', CAST(N'2019-03-27T07:34:12.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongKham] ([STT], [BanKham], [PhongKham], [IDPhieuKham], [Gio], [TinhTrang], [CaKham]) VALUES (1, N'BK1', N'1', N'PKPH10002', CAST(N'2019-03-27T07:05:47.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongKham] ([STT], [BanKham], [PhongKham], [IDPhieuKham], [Gio], [TinhTrang], [CaKham]) VALUES (2, N'BK1', N'1', N'PKPH10004', CAST(N'2019-03-27T07:09:34.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongKham] ([STT], [BanKham], [PhongKham], [IDPhieuKham], [Gio], [TinhTrang], [CaKham]) VALUES (3, N'BK1', N'1', N'PKPH10005', CAST(N'2019-03-27T07:13:21.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongKham] ([STT], [BanKham], [PhongKham], [IDPhieuKham], [Gio], [TinhTrang], [CaKham]) VALUES (4, N'BK1', N'1', N'PKPH10010', CAST(N'2019-03-27T07:17:08.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongKham] ([STT], [BanKham], [PhongKham], [IDPhieuKham], [Gio], [TinhTrang], [CaKham]) VALUES (1, N'BK2', N'1', N'PKPH10003', CAST(N'2019-03-27T07:05:47.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongKham] ([STT], [BanKham], [PhongKham], [IDPhieuKham], [Gio], [TinhTrang], [CaKham]) VALUES (2, N'BK2', N'1', N'PKPH10006', CAST(N'2019-03-27T07:09:34.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongKham] ([STT], [BanKham], [PhongKham], [IDPhieuKham], [Gio], [TinhTrang], [CaKham]) VALUES (3, N'BK2', N'1', N'PKPH10007', CAST(N'2019-03-27T07:13:21.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongKham] ([STT], [BanKham], [PhongKham], [IDPhieuKham], [Gio], [TinhTrang], [CaKham]) VALUES (4, N'BK2', N'1', N'PKPH10008', CAST(N'2019-03-27T07:17:08.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongXetNghiem] ([IDPhongXetNghiem], [STT], [IDPhieuKham], [IDXetNghiem], [Gio], [TinhTrang], [CaKham]) VALUES (N'XN1', 1, N'PKPH10001', N'XNPH10001', CAST(N'2019-03-27T07:00:12.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongXetNghiem] ([IDPhongXetNghiem], [STT], [IDPhieuKham], [IDXetNghiem], [Gio], [TinhTrang], [CaKham]) VALUES (N'XN1', 2, N'PKPH10006', N'XNPH10006', CAST(N'2019-03-27T07:00:24.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongXetNghiem] ([IDPhongXetNghiem], [STT], [IDPhieuKham], [IDXetNghiem], [Gio], [TinhTrang], [CaKham]) VALUES (N'XN1', 3, N'PKPH10007', N'XNPH10007', CAST(N'2019-03-27T07:00:36.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongXetNghiem] ([IDPhongXetNghiem], [STT], [IDPhieuKham], [IDXetNghiem], [Gio], [TinhTrang], [CaKham]) VALUES (N'XN1', 4, N'PKPH10010', N'XNPH10010', CAST(N'2019-03-27T07:00:48.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongXetNghiem] ([IDPhongXetNghiem], [STT], [IDPhieuKham], [IDXetNghiem], [Gio], [TinhTrang], [CaKham]) VALUES (N'XN1', 5, N'PKPH10011', N'XNPH10011', CAST(N'2019-03-27T07:01:00.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongXetNghiem] ([IDPhongXetNghiem], [STT], [IDPhieuKham], [IDXetNghiem], [Gio], [TinhTrang], [CaKham]) VALUES (N'XN1', 6, N'PKPH10014', N'XNPH10014', CAST(N'2019-03-27T07:01:12.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongXetNghiem] ([IDPhongXetNghiem], [STT], [IDPhieuKham], [IDXetNghiem], [Gio], [TinhTrang], [CaKham]) VALUES (N'XN1', 7, N'PKPH10015', N'XNPH10015', CAST(N'2019-03-27T07:01:24.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongXetNghiem] ([IDPhongXetNghiem], [STT], [IDPhieuKham], [IDXetNghiem], [Gio], [TinhTrang], [CaKham]) VALUES (N'XN1', 8, N'PKPH10018', N'XNPH10018', CAST(N'2019-03-27T07:01:36.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongXetNghiem] ([IDPhongXetNghiem], [STT], [IDPhieuKham], [IDXetNghiem], [Gio], [TinhTrang], [CaKham]) VALUES (N'XN1', 9, N'PKPH10019', N'XNPH10019', CAST(N'2019-03-27T07:01:48.000' AS DateTime), 1, 1)
INSERT [dbo].[SoHienThiPhongXetNghiem] ([IDPhongXetNghiem], [STT], [IDPhieuKham], [IDXetNghiem], [Gio], [TinhTrang], [CaKham]) VALUES (N'XN1', 10, N'PKPH10022', N'XNPH10022', CAST(N'2019-03-27T07:02:00.000' AS DateTime), 1, 1)
INSERT [dbo].[SoThuTuPhongCLS] ([IDPhieuKham], [STT], [CanLamSang], [PhongCanLamSang], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10001', 1, N'TZ02', N'TMH1', 1, CAST(N'2019-03-27T07:00:00.000' AS DateTime), N'Đã qua')
INSERT [dbo].[SoThuTuPhongCLS] ([IDPhieuKham], [STT], [CanLamSang], [PhongCanLamSang], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10002', 1, N'TZ02', N'TMH2', 1, CAST(N'2019-03-27T07:00:00.000' AS DateTime), N'Đã qua')
INSERT [dbo].[SoThuTuPhongCLS] ([IDPhieuKham], [STT], [CanLamSang], [PhongCanLamSang], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10003', 2, N'TZ02', N'TMH1', 1, CAST(N'2019-03-27T07:10:44.000' AS DateTime), N'Đã qua')
INSERT [dbo].[SoThuTuPhongCLS] ([IDPhieuKham], [STT], [CanLamSang], [PhongCanLamSang], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10004', 2, N'TZ02', N'TMH2', 1, CAST(N'2019-03-27T07:10:44.000' AS DateTime), N'Đã qua')
INSERT [dbo].[SoThuTuPhongCLS] ([IDPhieuKham], [STT], [CanLamSang], [PhongCanLamSang], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10005', 3, N'TZ01', N'TMH1', 1, CAST(N'2019-03-27T07:17:38.000' AS DateTime), N'Đã qua')
INSERT [dbo].[SoThuTuPhongCLS] ([IDPhieuKham], [STT], [CanLamSang], [PhongCanLamSang], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10006', 3, N'TZ02', N'TMH2', 1, CAST(N'2019-03-27T07:21:28.000' AS DateTime), N'Đã qua')
INSERT [dbo].[SoThuTuPhongCLS] ([IDPhieuKham], [STT], [CanLamSang], [PhongCanLamSang], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10007', 4, N'TZ01', N'TMH1', 1, CAST(N'2019-03-27T07:24:32.000' AS DateTime), N'Đang khám')
INSERT [dbo].[SoThuTuPhongCLS] ([IDPhieuKham], [STT], [CanLamSang], [PhongCanLamSang], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10008', 4, N'TZ02', N'TMH2', 1, CAST(N'2019-03-27T07:32:12.000' AS DateTime), N'Đang khám')
INSERT [dbo].[SoThuTuPhongCLS] ([IDPhieuKham], [STT], [CanLamSang], [PhongCanLamSang], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10009', 5, N'TZ01', N'TMH1', 1, CAST(N'2019-03-27T07:31:26.000' AS DateTime), N'Chưa')
INSERT [dbo].[SoThuTuPhongCLS] ([IDPhieuKham], [STT], [CanLamSang], [PhongCanLamSang], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10010', 6, N'TZ01', N'TMH1', 1, CAST(N'2019-03-27T07:38:20.000' AS DateTime), N'Chưa')
INSERT [dbo].[SoThuTuPhongKham] ([IDPhieuKham], [STT], [BanKham], [PhongKham], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10001', 1, N'BK2', N'1', 2, CAST(N'2019-03-27T13:03:47.000' AS DateTime), N'Đã qua')
INSERT [dbo].[SoThuTuPhongKham] ([IDPhieuKham], [STT], [BanKham], [PhongKham], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10002', 1, N'BK1', N'1', 1, CAST(N'2019-03-27T07:03:47.000' AS DateTime), N'Đã qua')
INSERT [dbo].[SoThuTuPhongKham] ([IDPhieuKham], [STT], [BanKham], [PhongKham], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10003', 1, N'BK2', N'1', 1, CAST(N'2019-03-27T07:03:47.000' AS DateTime), N'Đã qua')
INSERT [dbo].[SoThuTuPhongKham] ([IDPhieuKham], [STT], [BanKham], [PhongKham], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10004', 2, N'BK1', N'1', 1, CAST(N'2019-03-27T07:07:34.000' AS DateTime), N'Đã qua')
INSERT [dbo].[SoThuTuPhongKham] ([IDPhieuKham], [STT], [BanKham], [PhongKham], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10005', 3, N'BK1', N'1', 1, CAST(N'2019-03-27T07:11:21.000' AS DateTime), N'Đã qua')
INSERT [dbo].[SoThuTuPhongKham] ([IDPhieuKham], [STT], [BanKham], [PhongKham], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10006', 2, N'BK2', N'1', 1, CAST(N'2019-03-27T07:07:34.000' AS DateTime), N'Đã qua')
INSERT [dbo].[SoThuTuPhongKham] ([IDPhieuKham], [STT], [BanKham], [PhongKham], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10007', 3, N'BK2', N'1', 1, CAST(N'2019-03-27T07:11:21.000' AS DateTime), N'Đã qua')
INSERT [dbo].[SoThuTuPhongKham] ([IDPhieuKham], [STT], [BanKham], [PhongKham], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10008', 4, N'BK2', N'1', 1, CAST(N'2019-03-27T07:15:08.000' AS DateTime), N'Đang khám')
INSERT [dbo].[SoThuTuPhongKham] ([IDPhieuKham], [STT], [BanKham], [PhongKham], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10009', 1, N'BK1', N'1', 2, CAST(N'2019-03-27T13:03:47.000' AS DateTime), N'Đã qua')
INSERT [dbo].[SoThuTuPhongKham] ([IDPhieuKham], [STT], [BanKham], [PhongKham], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10010', 4, N'BK1', N'1', 1, CAST(N'2019-03-27T07:15:08.000' AS DateTime), N'Đang khám')
INSERT [dbo].[SoThuTuPhongKham] ([IDPhieuKham], [STT], [BanKham], [PhongKham], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10011', 5, N'BK2', N'1', 1, CAST(N'2019-03-27T07:18:55.000' AS DateTime), N'Chưa')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10001', N'XNPH10001', 1, N'XN1', 1, CAST(N'2019-03-27T07:00:00.000' AS DateTime), N'Đang khám')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10002', N'XNPH10002', 1, N'XN2', 1, CAST(N'2019-03-27T07:00:00.000' AS DateTime), N'Chưa')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10003', N'XNPH10003', 1, N'XN3', 1, CAST(N'2019-03-27T07:00:00.000' AS DateTime), N'Chưa')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10004', N'XNPH10004', 2, N'XN3', 1, CAST(N'2019-03-27T07:00:24.000' AS DateTime), N'Chưa')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10005', N'XNPH10005', 2, N'XN2', 1, CAST(N'2019-03-27T07:00:24.000' AS DateTime), N'Chưa')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10006', N'XNPH10006', 2, N'XN1', 1, CAST(N'2019-03-27T07:00:12.000' AS DateTime), N'Đang khám')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10007', N'XNPH10007', 3, N'XN1', 1, CAST(N'2019-03-27T07:00:24.000' AS DateTime), N'Đang khám')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10008', N'XNPH10008', 3, N'XN3', 1, CAST(N'2019-03-27T07:00:48.000' AS DateTime), N'Chưa')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10009', N'XNPH10009', 3, N'XN2', 1, CAST(N'2019-03-27T07:00:48.000' AS DateTime), N'Chưa')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10010', N'XNPH10010', 4, N'XN1', 1, CAST(N'2019-03-27T07:00:36.000' AS DateTime), N'Đang khám')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10011', N'XNPH10011', 5, N'XN1', 1, CAST(N'2019-03-27T07:00:48.000' AS DateTime), N'Đang khám')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10012', N'XNPH10012', 4, N'XN3', 1, CAST(N'2019-03-27T07:01:12.000' AS DateTime), N'Chưa')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10013', N'XNPH10013', 4, N'XN2', 1, CAST(N'2019-03-27T07:01:12.000' AS DateTime), N'Chưa')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10014', N'XNPH10014', 6, N'XN1', 1, CAST(N'2019-03-27T07:01:00.000' AS DateTime), N'Đang khám')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10015', N'XNPH10015', 7, N'XN1', 1, CAST(N'2019-03-27T07:01:12.000' AS DateTime), N'Đang khám')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10016', N'XNPH10016', 5, N'XN3', 1, CAST(N'2019-03-27T07:01:36.000' AS DateTime), N'Chưa')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10017', N'XNPH10017', 5, N'XN2', 1, CAST(N'2019-03-27T07:01:36.000' AS DateTime), N'Chưa')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10018', N'XNPH10018', 8, N'XN1', 1, CAST(N'2019-03-27T07:01:24.000' AS DateTime), N'Đang khám')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10019', N'XNPH10019', 9, N'XN1', 1, CAST(N'2019-03-27T07:01:36.000' AS DateTime), N'Đang khám')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10020', N'XNPH10020', 6, N'XN3', 1, CAST(N'2019-03-27T07:02:00.000' AS DateTime), N'Chưa')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10021', N'XNPH10021', 6, N'XN2', 1, CAST(N'2019-03-27T07:02:00.000' AS DateTime), N'Chưa')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10022', N'XNPH10022', 10, N'XN1', 1, CAST(N'2019-03-27T07:01:48.000' AS DateTime), N'Đang khám')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10023', N'XNPH10023', 11, N'XN1', 1, CAST(N'2019-03-27T07:02:00.000' AS DateTime), N'Chưa')
INSERT [dbo].[SoThuTuPhongXetNghiem] ([IDPhieuKham], [IDXetNghiem], [STT], [PhongXetNghiem], [CaKham], [Gio], [TinhTrang]) VALUES (N'PKPH10024', N'XNPH10024', 7, N'XN3', 1, CAST(N'2019-03-27T07:02:24.000' AS DateTime), N'Chưa')
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
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'TMH1', CAST(N'2019-03-27' AS Date), 1, 2)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'TMH1', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'TMH2', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'TMH2', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XN1', CAST(N'2019-03-27' AS Date), 1, 67)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XN1', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XN2', CAST(N'2019-03-27' AS Date), 1, 36)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XN2', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XN3', CAST(N'2019-03-27' AS Date), 1, 43)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XN3', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XNK1', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XNK1', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XQ1', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XQ1', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XQ2', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XQ2', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XQ3', CAST(N'2019-03-27' AS Date), 1, 0)
INSERT [dbo].[ThongKePhongCLS] ([IDPhongCLS], [NgayCT], [CaKham], [SoLuongDoi]) VALUES (N'XQ3', CAST(N'2019-03-27' AS Date), 2, 0)
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'1', 1, 0, N'PH', CAST(N'00:03:47' AS Time))
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK1', N'1', 2, 1, N'PH', CAST(N'00:03:47' AS Time))
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
INSERT [dbo].[ThongKePhongKham] ([IDBan], [Phong], [CaKham], [SoLuongDoi], [ChuyenKhoa], [ThoiGianKhamTB]) VALUES (N'BK2', N'1', 2, 1, N'PH', CAST(N'00:03:47' AS Time))
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
/****** Object:  Index [UQ__BenhNhan__B9137313204755C6]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[BacSiTheoChuyenKhoa]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[BamSoHienThiPhongCLS]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[BamSoHienThiPhongKham]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[BamSoHienThiPhongXetNghiem]    Script Date: 5/27/2019 2:27:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[BamSoHienThiPhongXetNghiem] @IDPhong nvarchar(10),@CaKham int
as begin
	declare @ThoiGian time,@NgayHienTai date,@STTend int, @STTstart int,@IDPKcur nvarchar(10),@IDPKnext nvarchar(10),@SoLuongDoi int,
			@counter int=0,@ChuoiSTT nvarchar(20),@IDHienThiXN nvarchar(20),@TimeHienThi time,@startprint int;
	select  @STTstart=STT  from SoHienThiPhongXetNghiem where  IDPhongXetNghiem=@IDPhong and CaKham=@CaKham
	and Gio>=all(select Gio from SoHienThiPhongXetNghiem where  IDPhongXetNghiem=@IDPhong and CaKham=@CaKham)group by STT;
	set @NgayHienTai = '2019-03-27';
	if(@STTstart is null)
	begin
		set @STTstart=0; 
		
	end;
	set @startprint=@STTstart;
	set @STTend = 0;
	if(@IDPhong ='XN1')
	begin
		while (@counter<10)
		begin 
			set @STTend = @STTstart+1;
			set @STTstart= @STTstart+1;
			set @ThoiGian=(select convert(time,(select Gio from SoThuTuPhongXetNghiem where PhongXetNghiem=@IDPhong and STT=@STTend and CaKham=@CaKham /*gắn ngày nếu chạy thưc*/)));
			set @counter = @counter+1;
			set @IDPKnext = (select IDPhieuKham from SoThuTuPhongXetNghiem where STT=@STTend and PhongXetNghiem=@IDPhong and CaKham=@CaKham );
			-- Tao so hien thi
			insert into SoHienThiPhongXetNghiem(IDPhongXetNghiem,STT,IDPhieuKham,IDXetNghiem,Gio,TinhTrang,CaKham)
			select STT.PhongXetNghiem,STT.STT,STT.IDPhieuKham,STT.IDXetNghiem,convert(datetime2,convert(varchar,@NgayHienTai)+' '+ convert(varchar,dbo.CongGioPhut('00:00:12',@ThoiGian))),1 as TinhTrang,@CaKham from SoThuTuPhongXetNghiem as STT 
			where STT.IDPhieuKham=@IDPKnext and STT.PhongXetNghiem=@IDPhong;
			/*-- Lay so hien thi
			select *from SoHienThiPhongCanLamSang as STT join PhongCanLamSang as PCLS on PCLS.ID=STT.IDPhongCanLamSang
			where STT.IDPhieuKham=@IDPKnext  and STT.IDPhongCanLamSang=@IDPhong and STT.CaKham=@CaKham;
			set @SoLuongDoi=(select SoLuongDoi from ThongKePhongCLS where IDPhongCLS=@IDPhong and CaKham=@CaKham)*/
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
		select @TimeHienThi= Gio from SoHienThiPhongXetNghiem where IDPhieuKham=@IDPKnext;
		set @IDHienThiXN=(select @IDPhong + '_' + convert(nvarchar,@startprint+1) +'_' + convert(nvarchar,@STTend));
		set @ChuoiSTT =(select  convert(nvarchar,@startprint+1) +'  -->  ' + convert(nvarchar,@STTend));
		insert into HienThiSTTXetNghiem values(@IDPhong,@IDHienThiXN,@ChuoiSTT,@CaKham,@TimeHienThi,@NgayHienTai);
	end;
	else if(@IDPhong ='XN2' or @IDPhong='XN3')
	begin
		while (@counter<5)
		begin 
			set @STTend = @STTstart+1;
			set @STTstart= @STTstart+1;
			set @ThoiGian=(select convert(time,(select Gio from SoThuTuPhongXetNghiem where PhongXetNghiem=@IDPhong and STT=@STTend and CaKham=@CaKham /*gắn ngày nếu chạy thưc*/)));
			set @counter = @counter+1;	
			set @IDPKnext = (select IDPhieuKham from SoThuTuPhongXetNghiem where STT=@STTend and PhongXetNghiem=@IDPhong and CaKham=@CaKham );
			-- Tao so hien thi
			insert into SoHienThiPhongXetNghiem(IDPhongXetNghiem,STT,IDPhieuKham,IDXetNghiem,Gio,TinhTrang,CaKham)
			select STT.PhongXetNghiem,STT.STT,STT.IDPhieuKham,STT.IDXetNghiem,convert(datetime2,convert(varchar,@NgayHienTai)+' '+ convert(varchar,dbo.CongGioPhut('00:00:24','07:00:00'))),1 as TinhTrang,@CaKham from SoThuTuPhongXetNghiem as STT 
			where STT.IDPhieuKham=@IDPKnext and STT.PhongXetNghiem=@IDPhong;
			/*-- Lay so hien thi
			select *from SoHienThiPhongCanLamSang as STT join PhongCanLamSang as PCLS on PCLS.ID=STT.IDPhongCanLamSang
			where STT.IDPhieuKham=@IDPKnext  and STT.IDPhongCanLamSang=@IDPhong and STT.CaKham=@CaKham;
			set @SoLuongDoi=(select SoLuongDoi from ThongKePhongCLS where IDPhongCLS=@IDPhong and CaKham=@CaKham)*/
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
		select @TimeHienThi= Gio from SoHienThiPhongXetNghiem where IDPhieuKham=@IDPKnext;
		set @IDHienThiXN=(select @IDPhong + '_' + convert(nvarchar,@startprint+1) +'_' + convert(nvarchar,@STTend));
		set @ChuoiSTT =(select  convert(nvarchar,@startprint+1) +'  -->  ' + convert(nvarchar,@STTend));
		insert into HienThiSTTXetNghiem values(@IDPhong,@IDHienThiXN,@ChuoiSTT,@CaKham,@TimeHienThi,@NgayHienTai);
		end;
		select * from HienThiSTTXetNghiem where IDPhongXN=@IDPhong and IDHienThiXN=@IDHienThiXN and CaKham =@CaKham and Ngay=@NgayHienTai;
end;

GO
/****** Object:  StoredProcedure [dbo].[CheckBenhNhan]    Script Date: 5/27/2019 2:27:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[CheckBenhNhan] @CMND_CCCD nvarchar(20)
 as begin
	select * from BenhNhan where BenhNhan.CMND_CCCD = @CMND_CCCD
end;
GO
/****** Object:  StoredProcedure [dbo].[CheckCanLamSang]    Script Date: 5/27/2019 2:27:45 PM ******/
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
		select 1 as KetQua;
		end;
		else if(@IDChuyenKhoa = 'D[')
		begin 
		select 2 as KetQua;
		end;
		else
		begin 
		select 0 as KetQua;
		end;
	end;
end;
GO
/****** Object:  StoredProcedure [dbo].[CheckPhieuKham]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ChiTietCanLamSangTheoChuyenKhoa]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ChiTietCanLamSangTheoLoaiDichVu]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ChiTietCanLamSangTheoTenDichVu]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[DanhSachBacSiThuocChuyenKhoa]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[DanhSachChuyenKhoaCLS]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[DanhSachChuyenKhoaLamSang]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[DanhSachCLS]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[DanhSachDichVuCanLamSangTheoChuyenKhoa]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[DanhSachPhongCanLamSangTheoChuyenKhoa]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[DanhSachPhongKhamBanKhamTheoChuyenKhoa]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[DemSoDoi]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[HienThiLichSuTimKiem]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[HienThiThongTinBN]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[LaySTT]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[LaySTTPhongKham]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[LayThongTinBenhNhan]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[LuuSoHienThiPhongKham]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PhatSinhSTTCLSCa1]    Script Date: 5/27/2019 2:27:45 PM ******/
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
			insert into SoThuTuPhongCLS values(@IDPhieuKham,@STTnew,@IDDichVuCLS,@IDPhongCLS,null,@GioDuKiennew,N'Chưa');
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
			insert into SoThuTuPhongCLS values(@IDPhieuKham,@STTnew,@IDDichVuCLS,@IDPhongCLS,null,@GioDuKiennew,N'Chưa');
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
		insert into SoThuTuPhongCLS values(@IDPhieuKham,@STTnew,@IDDichVuCLS,@IDPhongCLS,null,@TimeDuKien,N'Chưa');
		update ThongKePhongCLS
		set SoLuongDoi=SoLuongDoi+1
		where IDPhongCLS=@IDPhongCLS and CaKham=1;
		select * from SoThuTuPhongCLS where IDPhieuKham=@IDPhieuKham and STT=@STTnew and PhongCanLamSang=@IDPhongCLS;
	end;
	
end;
GO
/****** Object:  StoredProcedure [dbo].[PhatSinhSTTCLSCa2]    Script Date: 5/27/2019 2:27:45 PM ******/
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
			insert into SoThuTuPhongCLS values(@IDPhieuKham,@STTnew,@IDDichVuCLS,@IDPhongCLS,null,@GioDuKiennew,N'Chưa');
			update ThongKePhongCLS
			set SoLuongDoi=SoLuongDoi+1
			where IDPhongCLS=@IDPhongCLS and CaKham=2;
			select * from SoThuTuPhongCLS where IDPhieuKham=@IDPhieuKham and STT=@STTnew and PhongCanLamSang=@IDPhongCLS;
		end;
		else if(@GioDuKien>=@GioHienTai)
		begin
			set @STTnew=@STTcur+1;
			set @GioDuKiennew=(select dbo.CongThoiGian(@Timenhayso,@GioDuKien));
			insert into SoThuTuPhongCLS values(@IDPhieuKham,@STTnew,@IDDichVuCLS,@IDPhongCLS,null,@GioDuKiennew,N'Chưa');
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
		insert into SoThuTuPhongCLS values(@IDPhieuKham,@STTnew,@IDDichVuCLS,@IDPhongCLS,null,@TimeDuKien,N'Chưa');
		update ThongKePhongCLS
		set SoLuongDoi=SoLuongDoi+1
		where IDPhongCLS=@IDPhongCLS and CaKham=2;
		select * from SoThuTuPhongCLS where IDPhieuKham=@IDPhieuKham and STT=@STTnew and PhongCanLamSang=@IDPhongCLS;
	end;
	
end;
GO
/****** Object:  StoredProcedure [dbo].[PhatSinhSTTPhongKham_BacSiCa1]    Script Date: 5/27/2019 2:27:45 PM ******/
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
		insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chưa');
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
				insert into SoThuTuPhongKhamBacSi_Overtime values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,getdate(),N'Chưa',@IDBacSi);
				end;
				else if(@hieu<0)
				begin
				insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chưa');
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
				insert into SoThuTuPhongKhamBacSi_Overtime values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,getdate(),N'Chưa',@IDBacSi);
				end;
				else if(@hieu1<0)
				begin
				insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chưa');
				update ThongKePhongKham
				set SoLuongDoi=SoLuongDoi+1
				where IDBan=@BanKham and Phong=@PhongKham and CaKham=1;
				end;
		end;
	end;
	select * from SoThuTuPhongKham where IDPhieuKham=@IDPhieuKham and STT=@STTnew and BanKham=@BanKham and PhongKham=@PhongKham and CaKham=1;
end;
GO
/****** Object:  StoredProcedure [dbo].[PhatSinhSTTPhongKham_BacSiCa2]    Script Date: 5/27/2019 2:27:45 PM ******/
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
		insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chưa');
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
				insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chưa');
				update ThongKePhongKham
				set SoLuongDoi=SoLuongDoi+1
				where IDBan=@BanKham and Phong=@PhongKham and CaKham=2;
		end;
		else
		begin
			set @STTnew=@STT +1;
			set @GioDuKien_new=(select dbo.CongThoiGian(@TimeTB,@GioDuKien));
				insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chưa');
				update ThongKePhongKham
				set SoLuongDoi=SoLuongDoi+1
				where IDBan=@BanKham and Phong=@PhongKham and CaKham=2;
		end;
	end;
	select * from SoThuTuPhongKham where IDPhieuKham=@IDPhieuKham and STT=@STTnew and BanKham=@BanKham and PhongKham=@PhongKham and CaKham=2;
end;
GO
/****** Object:  StoredProcedure [dbo].[PhatSinhSTTPhongKhamCa1]    Script Date: 5/27/2019 2:27:45 PM ******/
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
		insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chưa');
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
			insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chưa');
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
				insert into SoThuTuPhongKham_Overtime values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,getdate(),N'Chưa');
				end;
				else if(@hieu<0)
				begin
				insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chưa');
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
				insert into SoThuTuPhongKham_Overtime values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,getdate(),N'Chưa');
				end;
				else if(@hieu2<0)
				begin
				insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chưa');
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
/****** Object:  StoredProcedure [dbo].[PhatSinhSTTPhongKhamCa2]    Script Date: 5/27/2019 2:27:45 PM ******/
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
		insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chưa');
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
			insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chưa');
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
				insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chưa');
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
				insert into SoThuTuPhongKham values(@IDPhieuKham,@STTnew,@BanKham,@PhongKham,null,@GioDuKien_new,N'Chưa');
				update ThongKePhongKham
				set SoLuongDoi=SoLuongDoi+1
				where IDBan=@BanKham and Phong=@PhongKham and CaKham=2;
			end;
		end;
	end;
	select * from SoThuTuPhongKham where IDPhieuKham=@IDPhieuKham and STT=@STTnew and BanKham=@BanKham and PhongKham=@PhongKham and CaKham=2;
end;
GO
/****** Object:  StoredProcedure [dbo].[PhatSinhSTTXetNghiemCa1]    Script Date: 5/27/2019 2:27:45 PM ******/
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
	set @TimeDuKien=(select  convert(datetime2,'2019-03-27 '+ convert(varchar,@GioBatDau)));
	insert into SoThuTuPhongXetNghiem values(@IDPhieuKham,@IDXetNghiemBN,@STTnew,@IDPhongXN,1,@TimeDuKien,N'Chưa');
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
	if(@IDPhongXN='XN1')
		begin
		set @GioDuKiennew= (select dbo.CongGioPhut('00:00:12',@GioDuKien));
		end;
		else if(@IDPhongXN='XN2' or @IDPhongXN='XN3')
		begin
		set @GioDuKiennew= (select dbo.CongGioPhut('00:00:24',@GioDuKien));
		end;
	set @hieu2 = (select DATEDIFF(minute,@GioKetThuc,convert(time,@GioDuKiennew)));
	set @TimeDuKien=(select  convert(datetime2,'2019-03-27 '+ convert(varchar,@GioDuKiennew)));
		if(@hieu2<0) 
		begin
		insert into SoThuTuPhongXetNghiem values(@IDPhieuKham,@IDXetNghiemBN,@STTnew,@IDPhongXN,1,@TimeDuKien,N'Chưa');
		update ThongKePhongCLS 
		set SoLuongDoi=SoLuongDoi +1 
		where IDPhongCLS=@IDPhongXN and CaKham=1;
		end;
		else if (@hieu2>=0)
		begin
		exec PhatSinhSTTXetNghiemCa2 @IDPhieuKham;
		end;
	end;
	select * from SoThuTuPhongXetNghiem where IDPhieuKham=@IDPhieuKham and STT=@STTnew and CaKham=1;

end;
GO
/****** Object:  StoredProcedure [dbo].[PhatSinhSTTXetNghiemCa2]    Script Date: 5/27/2019 2:27:45 PM ******/
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
	insert into SoThuTuPhongXetNghiem values(@IDPhieuKham,@IDXetNghiemBN,@STTnew,@IDPhongXN,2,@TimeDuKien,N'Chưa');
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
		set @GioDuKiennew= (select dbo.CongGioPhut('00:00:12',@GioDuKien));
		end;
		else if(@IDPhongXN='XN2' or @IDPhongXN='XN3')
		begin
		set @GioDuKiennew= (select dbo.CongGioPhut('00:00:24',@GioDuKien));
		end;
	set @TimeDuKien=(select  convert(datetime2,'2019-03-27 '+ convert(varchar,@GioDuKiennew)));
	insert into SoThuTuPhongXetNghiem values(@IDPhieuKham,@IDXetNghiemBN,@STTnew,@IDPhongXN,2,@TimeDuKien,N'Chưa');
	update ThongKePhongCLS 
	set SoLuongDoi=SoLuongDoi +1 
	where IDPhongCLS=@IDPhongXN and CaKham=2;	
	end;
	select * from SoThuTuPhongXetNghiem where IDPhieuKham=@IDPhieuKham and STT=@STTnew and CaKham=2;
end;
GO
/****** Object:  StoredProcedure [dbo].[ResetThongKePhongCLS]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ResetThongKePhongKham]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Search]    Script Date: 5/27/2019 2:27:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Search] @IDBenhNhan nvarchar(10)
as begin
	select BenhNhan.Ho, BenhNhan.TenLot,BenhNhan.Ten 
	from BenhNhan
	where ID = @IDBenhNhan;

	select distinct IDBenhNhan,B.STT as STTPhongKham,B.SoPhong,B.SoBan,B.Lau,B.TenKhuVuc,B.TenChuyenKhoa,convert(time,B.Gio) as ThoiGianDuKien,B.TinhTrang,A.SoHienTaiCuaPhong
	from 
		(select PK.IDBenhNhan,STTPK.IDPhieuKham,STTPK.STT,STTPK.BanKham,bk.SoBan,STTPK.PhongKham,PKCK.SoPhong,PKCK.Lau,Khu.TenKhuVuc,CK.TenChuyenKhoa,STTPK.Gio,STTPK.TinhTrang
		from  PhieuKham as PK   join SoThuTuPhongKham as STTPK on STTPK.IDPhieuKham= PK.IDPhieuKham
		join  BanKham as BK on BK.IDBan = STTPK.BanKham join PhongKhamChuyenKhoa as PKCK on PKCK.ID = BK.Phong and PKCK.ID=STTPK.PhongKham
		join ChuyenKhoa as CK on Ck.IDChuyenKhoa=PKCK.ChuyenKhoa
		join KhuVuc as Khu on Khu.IDKhuVuc=CK.IDKhuVuc
		where PK.IDBenhNhan=@IDBenhNhan) as B
		 left outer join
		(select BK.IDBan as IDBan,BK.SoBan, PK.ID as IDPhongKham,PK.SoPhong,max(STT) as SoHienTaiCuaPhong from SoHienThiPhongKham as SHT 
		join BanKham as BK on BK.IDBan=SHT.BanKham join PhongKhamChuyenKhoa as PK on PK.ID=Bk.Phong 
		where BK.Phong=SHT.PhongKham 
		group by Bk.IDBan,BK.SoBan,PK.ID,PK.SoPhong) as A on A.IDBan=B.BanKham and A.IDPhongKham=B.PhongKham;

	select distinct IDBenhNhan,STTCLS.STT as STTPhongCLS, PCLS.SoPhong,L.TenLau,Khu.TenKhuVuc,DV.TenDichVu as TenCanLamSang,convert(time, STTCLS.Gio) as ThoiGianDuKien,STTCLS.TinhTrang,max(A.SoHienTaiCuaPhong) as SoHienTaiCuaPhong
	from PhieuKham as PK  join SoThuTuPhongCLS as STTCLS on STTCLS.IDPhieuKham=PK.IDPhieuKham 
		join PhongCanLamSang as PCLS on PCLS.ID=STTCLS.PhongCanLamSang
		join (select PCLS.ID as IDPhongCLS,PCLS.SoPhong, max(SHT.Gio) as Gio,STT as SoHienTaiCuaPhong 
			 from SoHienThiPhongCanLamSang as SHT join PhongCanLamSang as PCLS on PCLS.ID=SHT.IDPhongCanLamSang
	group by PCLS.ID,PCLS.SoPhong,STT ) as A on A.IDPhongCLS=PCLS.ID join ThucHienCLS as TH on TH.IDPhongCLS=PCLS.ID 
	join  DichVuCanLamSang as DV on DV.IDDichVu =TH.DichVuCLSThucHien 
	join ChuyenKhoa as CK on CK.IDChuyenKhoa=PCLS.TrucThuoc
	join KhuVuc as Khu on Khu.IDKhuVuc=CK.IDKhuVuc
	inner join Lau as L on L.IDLau=PCLS.Lau
	where PK.IDBenhNhan=@IDBenhNhan and STTCLS.CanLamSang=TH.DichVuCLSThucHien 
	group by  IDBenhNhan,STTCLS.STT,PCLS.SoPhong,L.TenLau,Khu.TenKhuVuc,DV.TenDichVu,convert(time, STTCLS.Gio),STTCLS.TinhTrang;

	select PK.IDBenhNhan,STT.STT as STTXetNghiem,P.SoPhong,L.TenLau,Khu.TenKhuVuc,HT.ChuoiSTT as CacSTTHienTai,HT.ThoiGian,STT.TinhTrang
	from PhieuKham as PK inner join SoThuTuPhongXetNghiem as STT on STT.IDPhieuKham=PK.IDPhieuKham
						 inner join PhongCanLamSang as P on P.ID=STT.PhongXetNghiem
						 inner join HienThiSTTXetNghiem as HT on HT.IDPhongXN= STT.PhongXetNghiem
						 inner join ChuyenKhoa as CK on CK.IDChuyenKhoa=P.TrucThuoc
						 inner join KhuVuc as Khu on Khu.IDKhuVuc=Ck.IDKhuVuc
						 inner join Lau as L on L.IDLau=P.Lau
	where PK.IDBenhNhan=@IDBenhNhan and HT.ThoiGian >=all(select ThoiGian from HienThiSTTXetNghiem)
	
	end;

GO
/****** Object:  StoredProcedure [dbo].[TaoHoSoBenhNhan]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[TaoLichSuTimKiem]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[TaoPhieuKham]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[TimBenhNhanTheoHoTenDiaChi]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[TimBenhNhanTheoHoTenGioiTinh]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[TimBenhNhanTheoID]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[TimBenhNhanTheoSDT]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[TinhTrangConChoTheoChuyenKhoa]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[TinhTrangConChoTheoPhongKhamThuocChuyenKhoa]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[TinhTrangConChoTheoPhongThuocChuyenKhoa]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[TinhTrangHienTaiTheoChuyenKhoa]    Script Date: 5/27/2019 2:27:45 PM ******/
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
select  pkck.ChuyenKhoa,lk.Phong as IDPhongKham,pkck.SoPhong,bk.IDBan,bk.SoBan,bs.ID as IDBacSi,  bs.HovaTen as BacSi,0 as SoHienTai, N'Chưa có bệnh nhân' AS BenhNhan
	from LichKhamBacSi lk 
	inner join BanKham bk on bk.IDBan=lk.IDBan and bk.Phong=lk.Phong
	inner join BacSi bs on bs.ID=lk.IDBacSi
	inner join PhongKhamChuyenKhoa pkck on pkck.ID= bk.Phong
	where pkck.ChuyenKhoa=@IDchuyenKhoa and lk.CaKham=@Cakham
	order by  pkck.ChuyenKhoa,lk.Phong ,bk.SoBan;
end;

else if(@temp=0  and @temp2!=0)
begin
select  pkck.ChuyenKhoa,lk.Phong as IDPhongKham,pkck.SoPhong,bk.IDBan,bk.SoBan,bs.ID as IDBacSi,  bs.HovaTen as BacSi,0 as SoHienTai, N'Chưa có bệnh nhân' AS BenhNhan
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
select  distinct pkck.ChuyenKhoa,lk.Phong as  IDPhongKham,pkck.SoPhong,bk.IDBan ,bk.SoBan,bs.ID as IDBacSi,  bs.HovaTen as BacSi,0 as SoHienTai, N'Chưa có bệnh nhân' AS BenhNhan
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
/****** Object:  StoredProcedure [dbo].[TinhTrangHienTaiTheoPhongKhamThuocChuyenKhoa]    Script Date: 5/27/2019 2:27:45 PM ******/
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
select  distinct pkck.ChuyenKhoa,lk.Phong as IDPhongKham,pkck.SoPhong,bk.IDBan,bk.SoBan,bs.ID as IDBacSi,  bs.HovaTen as BacSi,0 as SoHienTai, N'Chưa có bệnh nhân' AS BenhNhan
	from LichKhamBacSi lk 
	inner join BanKham bk on bk.IDBan=lk.IDBan and bk.Phong=lk.Phong
	inner join BacSi bs on bs.ID=lk.IDBacSi
	inner join PhongKhamChuyenKhoa pkck on pkck.ID= bk.Phong
	where pkck.ID=@IDPhong
	order by  pkck.ChuyenKhoa,lk.Phong ,bk.SoBan;
end;
else if(@temp = 0 and @temp2!=0)
begin 
select distinct  pkck.ChuyenKhoa,bk.Phong as IDPhongKham,pkck.SoPhong,bk.IDBan ,bk.SoBan, bs.ID as IDBacSi, bs.HoVaTen as BacSi, 0 as SoHienTai,  N'Chưa có bệnh nhân' AS BenhNhan
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
select  distinct pkck.ChuyenKhoa,lk.Phong as  IDPhongKham,pkck.SoPhong,bk.IDBan ,bk.SoBan,bs.ID as IDBacSi,  bs.HovaTen as BacSi,0 as SoHienTai, N'Chưa có bệnh nhân' AS BenhNhan
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
/****** Object:  StoredProcedure [dbo].[XuatDanhSachChuyenKhoa]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[XuatDanhSachPhongKhamTheoChuyenKhoa]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[XuatDichVuCanLamSang]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[XuatLoaiDichVuCanLamSang]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Trigger [dbo].[tr_AUTO_IDTraCuu]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Trigger [dbo].[Xulylichsu]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Trigger [dbo].[UpdateTinhTrangSTTPhongCLS]    Script Date: 5/27/2019 2:27:45 PM ******/
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
	set TinhTrang=N'Đang khám'
	where  PhongCanLamSang=@IDPhongCLS and STT=@STT;
	update SoThuTuPhongCLS
	set TinhTrang=N'Đã qua'
	where  PhongCanLamSang=@IDPhongCLS and STT=@STTpre;
GO
ALTER TABLE [dbo].[SoHienThiPhongCanLamSang] ENABLE TRIGGER [UpdateTinhTrangSTTPhongCLS]
GO
/****** Object:  Trigger [dbo].[UpdateTinhTrangSTTPhongKham]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Trigger [dbo].[UpdateTinhTrangSTTPhongXetNghiem]    Script Date: 5/27/2019 2:27:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------
create trigger [dbo].[UpdateTinhTrangSTTPhongXetNghiem] on [dbo].[SoHienThiPhongXetNghiem] for insert
as 
	declare @STT int, @PhongXN nvarchar(10),@IDPK nvarchar(10),@STTpre int;
	select @STT =STT,@PhongXN=IDPhongXetNghiem,@IDPK=IDPhieuKham
	from inserted;
	set @STTpre=@STT -10;
	update SoThuTuPhongXetNghiem
	set TinhTrang=N'Đang khám'
	where   PhongXetNghiem=@PhongXN and STT=@STT;
	update SoThuTuPhongXetNghiem
	set TinhTrang=N'Đã qua'
	where   PhongXetNghiem=@PhongXN and STT=@STTpre;
GO
ALTER TABLE [dbo].[SoHienThiPhongXetNghiem] ENABLE TRIGGER [UpdateTinhTrangSTTPhongXetNghiem]
GO
/****** Object:  Trigger [dbo].[SetCaKhamCLS]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Trigger [dbo].[SetCaKhamPK]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Trigger [dbo].[XulySTTOvertime]    Script Date: 5/27/2019 2:27:45 PM ******/
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
/****** Object:  Trigger [dbo].[XulySTTBacSiOvertime]    Script Date: 5/27/2019 2:27:45 PM ******/
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
