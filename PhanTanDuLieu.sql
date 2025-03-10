-- Tạo Database mới trên máy chính (Trạm 1)
CREATE DATABASE QLKetQuaSinhVien1
USE QLKetQuaSinhVien1
-- Tạo bảng với điều kiện Giới tính là nam trên trạm 1
CREATE TABLE SinhVien
(
	MaSV VARCHAR(20) PRIMARY KEY,
	HoTenSV NVARCHAR(50) NOT NULL,
	NgaySinh DATE NOT NULL,
	QueQuan NVARCHAR(50) NOT NULL,
	GioiTinh BIT CHECK(GioiTinh = 1) ,
	MaLop VARCHAR(10),
	SDT VARCHAR(12) UNIQUE,
	Email VARCHAR(100)
);
ALTER TABLE dbo.SinhVien
ADD CONSTRAINT Check_SĐT UNIQUE (SDT);
ALTER TABLE dbo.SinhVien
ADD CONSTRAINT Check_email CHECK (Email LIKE '%@%');
-- Ghi dữ liệu trên Trạm 1 và Trạm 2
-- Trạm 1
INSERT INTO dbo.SinhVien 
	(MaSV, HoTenSV, NgaySinh, QueQuan, GioiTinh, MaLop, SDT, Email)
VALUES
	('SV01', N'Nguyễn Việt Hoàng', '2004-09-24', N'Vinhome Oceanpark Hà Nội', 1, '2210A03', '0979947889', '789Club@gmail.com'),
	('SV03', N'Nguyễn Hồng Phúc', '2004-05-24', N'Royal City', 1, '2310A06', '0945785423', 'fabet@gmail.com'),
	('SV04', N'Nguyễn Duy Anh', '2004-09-20', N'Phú Quốc', 1, '1810A02', '0962696969', 'lucky88@gmail.com'),
	('SV05', N'Phùng Thanh Đô', '2003-01-23', N'Yên Lãng, Hà Nội', 1, '2110A02', '0979695939', 'One88@gmail.com'),
	('SV08', N'Nguyễn Thanh Tùng', '1999-04-13', N'Định Công Hạ, Hà Nội', 1, '1910A03', '0973416578', 'zingmp3@gmail.com'),
	('SV10', N'Nguyễn Văn Vinh', '2003-12-10', N'Long Biên, Hà Nội', 1, '1810A01' , '0987631452', 'Vebo@gmail.com');
-- Truy van du lieu
SELECT * FROM dbo.SinhVien
-- Gan quyen
CREATE LOGIN TH WITH PASSWORD = '09032004';
CREATE USER UserHien FOR LOGIN TH
USE QLKetQuaSinhVien1 
GRANT ALL
ON SinhVien 
TO UserHien
-- Phân tán dọc
SELECT * FROM QLKetQuaSinhVien1.dbo.SinhVien
UNION
select * from LINKHIEN.QLKetQuaSinhVien.dbo.SinhVien
CREATE TABLE KetQua
(
	MaSV VARCHAR(20),
	MaMH VARCHAR(20),
	LanThi INT NOT NULL
);
INSERT INTO dbo.KetQua 
	(MaSV, MaMH, LanThi)
VALUES
	('SV01', 'QTNL', 1),
	('SV01', 'TRR', 1),
	('SV02', 'CTDL', 2),
	('SV03', 'TACN', 1), 
	('SV04', 'CTDL', 2),
	('SV04', 'LSVH', 2),
	('SV04', 'THDC', 1),
	('SV05', 'KTS', 1),
	('SV05', 'LHC', 1),
	('SV05', 'SQLS', 1),
	('SV06', 'TLH', 1), 
	('SV07', 'SHPT', 1),
	('SV08', 'GSKS', 1),
	('SV09', 'TRR', 1),      
	('SV10', 'TTNT', 1);
select * from KetQua;
-- Tạo bí danh
CREATE SYNONYM KQ_Tram1 FOR QLKetQuaSinhVien1.dbo.KetQua
CREATE SYNONYM KQ_Tram2 FOR LINKHIEN.QLKetQuaSinhVien.dbo.KetQua1
-- Phân tán ngang
SELECT Distinct KQ_Tram1.MaSV, KQ_Tram1.MaMH, LanThi, DiemCC, DiemGK, DiemCK
FROM KQ_Tram1 FULL JOIN KQ_Tram2 
ON KQ_Tram1.MaSV = KQ_Tram2.MaSV 
AND KQ_Tram1.MaMH = KQ_Tram2.MaMH