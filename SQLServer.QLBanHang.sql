create database QLBanHang
go
use QLBanHang
go
create table tblLoaiHang
(
	sMaloaihang varchar(10) primary key,
	sTenloaihang nvarchar(30)
)
go
create table tblNhaCungCap
(
	iMaNCC int identity(1, 1) primary key,
	sTenNCC nvarchar(50),
	sTengiaodich nvarchar(50),
	sDiachi nvarchar(50),
	sDienthoai char(12)
)
go
create table tblMatHang
(
	sMahang varchar(10) primary key,
	sTenhang nvarchar(30),
	iMaNCC int foreign key references tblNhaCungCap(iMaNCC),
	sMaloaihang varchar(10) foreign key references tblLoaiHang(sMaloaihang),
	fSoluong float,
	sDonvitinh varchar(10)
)
alter table tblMatHang
add fGiahang float
go
create table tblKhachHang
(
	iMaKH int primary key,
	sTenKH nvarchar(30),
	sDiachi nvarchar(50),
	sDienthoai char(12) unique
)
go
create table tblNhanVien
(
	iMaNV int primary key,
	sTenNV nvarchar(30),
	sDiachi nvarchar(50),
	sDienthoai char(12) unique,
	dNgaysinh datetime,
	dNgayvaolam datetime,
	fLuongcoban float,
	fPhucap float
)
go
create table tblDonDatHang
(
	iSoHD int primary key,
	iMaNV int foreign key references tblNhanVien(iMaNV),
	iMaKH int foreign key references tblKhachHang(iMaKH),
	dNgaydathang datetime,
	dNgaygiaohang datetime
)
alter table tblDonDatHang
add sDiachigiaohang nvarchar(50)
go
create table tblChiTietDatHang
(
	iSoHD int references tblDonDatHang(iSoHD),
	sMahang varchar(10) references tblMatHang(sMahang),
	fGiaban float,
	fSoluongmua float,
	fMucgiamgia float,
	primary key(iSoHD, sMahang)
)
go
create table tblDonNhapHang
(
	iSoHD int primary key,
	iMaNV int foreign key references tblNhanVien(iMaNV),
	dNgaynhaphang datetime
)
go
create table tblChiTietNhapHang
(
	iSoHD int references tblDonNhapHang(iSoHD),
	sMahang varchar(10) references tblMatHang(sMahang),
	fGianhap float,
	fSoluongnhap float,
	primary key(iSoHD, sMahang)
)
go
/* Câu 4: (2 điểm) Tạo update trigger cho table NhanVien 
để kiểm tra ràng buộc: Khi nâng bậc lương (Bac) của một nhân viên thì 
bậc lương mới không lớn hơn bậc lương cao nhất trong ngạch lương của nhân viên 
(ví dụ, ngạch lương mã số 15113 có số thứ tự bậc lương từ 1 đến 10 thì 
bậc lương mới của nhân viên có mã ngạch 15113 không đượt lớn hơn 10).
*/
CREATE TRIGGER trg_NhanVien_UpdateLuong
ON BNhanVien
FOR Update
AS
If Update(Luong)
Print ‘Luong Updated’
-- Kiểm tra với các câu lệnh:
UPDATE BNhanVien
SET Bac=Bac_moi
WHERE MaNV = 'nv1'
-- và
UPDATE BNhanVien
SET Luong=Luong_moi’
WHERE MaNV = 'nv1'
group by Bac, Luong
having Bac_moi < max(Bac)
