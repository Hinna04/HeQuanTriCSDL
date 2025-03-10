create database QLSinhVien_TTTH
use QLSinhVien_TTTH
go
create table tblKhoaHoc_TTTH
(
	sMaKhoaHoc_TTTH nchar(50) primary key
);
create table tblGIAOVIEN_TTTH
(
	sMaGV_TTTH varchar(50) primary key,
	sHoTen_TTTH nvarchar(255) not null
);
create table tblLOP_TTTH
(
	sMaLop_TTTH varchar(50) primary key,
	sMaGV_TTTH varchar(50) foreign key references tblGIAOVIEN_TTTH(sMaGV_TTTH) not null,
	sMaKhoaHoc_TTTH nchar(50) foreign key references tblKhoaHoc_TTTH(sMaKhoaHoc_TTTH) null
);
create table tblSINHVIEN_TTTH
(
	sMaSV_TTTH varchar(50) primary key,
	sHoTen_TTTH nvarchar(255) not null,
	dNgaySinh_TTTH date null,
	sMaLop_TTTH varchar(50) foreign key references tblLOP_TTTH(sMaLop_TTTH) null,
);
insert into tblKhoaHoc_TTTH
values
	('KH01'),
	('KH02'),
	('KH03'),
	('KH04'),
	('KH05'),
	('KH06')

insert into tblGIAOVIEN_TTTH
values
	('GV01', N'Nguyễn Thị Hạnh'),
	('GV02', N'Bùi Thị Huyền'),
	('GV03', N'Nguyễn Văn Tuyển'),
	('GV04', N'Trần Thị Hằng'),
	('GV05', N'Nguyễn Ngọc Ánh'),
	('GV06', N'Bá Phương Lan')

insert into tblLOP_TTTH
values
	('LOP01', 'GV04', 'KH02'),
	('LOP02', 'GV01', 'KH01'),
	('LOP03', 'GV03', 'KH02'),
	('LOP04', 'GV02', 'KH03'),
	('LOP05', 'GV06', 'KH04'),
	('LOP06', 'GV05', 'KH01')

insert into tblSINHVIEN_TTTH
values
	('SV01', N'Bùi Thị Lan Anh', '2004-12-04', 'LOP01'),
	('SV02', N'Nguyễn Thị Hà', '2003-04-24', 'LOP03'),
	('SV03', N'Trần Văn Đông', '2003-11-10', 'LOP05'),
	('SV04', N'Trần Thu Trang', '2002-03-01', 'LOP06'),
	('SV05', N'Bùi Ngọc Quyên', '2005-10-12', 'LOP02'),
	('SV06', N'Nguyễn Văn Nam', '2001-07-17', 'LOP04')

alter proc Select_tblSINHVIEN_TTTH
as
select sv.sMaSV_TTTH as N'Mã sinh viên', sv.sHoTen_TTTH as N'Họ và tên', sv.dNgaySinh_TTTH as N'Ngày sinh', l.sMaLop_TTTH as N'Lớp hành chính', gv.sHoTen_TTTH as N'Tên CVHT'
from tblSINHVIEN_TTTH sv, tblLOP_TTTH l, tblGIAOVIEN_TTTH gv
where sv.sMaLop_TTTH = l.sMaLop_TTTH
and l.sMaGV_TTTH = gv.sMaGV_TTTH;


alter proc Select_KhoaHoc_TTTH @maKH_TTTH nchar(50)
as
select sv.sMaSV_TTTH as N'Mã sinh viên', sv.sHoTen_TTTH as N'Họ và tên', sv.dNgaySinh_TTTH as N'Ngày sinh', l.sMaLop_TTTH as N'Lớp hành chính', gv.sHoTen_TTTH as N'Tên CVHT'
from tblKhoaHoc_TTTH kh, tblSINHVIEN_TTTH sv, tblLOP_TTTH l, tblGIAOVIEN_TTTH gv
where sv.sMaLop_TTTH = l.sMaLop_TTTH
and l.sMaGV_TTTH = gv.sMaGV_TTTH
and kh.sMaKhoaHoc_TTTH = l.sMaKhoaHoc_TTTH
and kh.sMaKhoaHoc_TTTH = @maKH_TTTH;