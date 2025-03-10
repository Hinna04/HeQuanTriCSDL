-- Tạo database
CREATE DATABASE QLKetQuaSinhVien
USE QLKetQuaSinhVien
GO

-- Tạo bảng Khoa và ràng buộc
CREATE TABLE Khoa
(
	MaKhoa VARCHAR(10) PRIMARY KEY,
	TenKhoa NVARCHAR(50) NOT NULL,
	DiaChi NVARCHAR(50) NOT NULL
);

-- Tạo bảng Khóa Học và ràng buộc
CREATE TABLE KhoaHoc
(
	MaKhoaHoc VARCHAR(10) PRIMARY KEY,
	NamBatDau date NOT NULL,
	NamKetThuc date NOT NULL
);

-- Tạo bảng Lớp và các ràng buộc
CREATE TABLE LopTinChi
(
	MaLop VARCHAR(10) PRIMARY KEY,
	MaKhoa VARCHAR(10) FOREIGN KEY REFERENCES Khoa(MaKhoa),
	MaKhoaHoc VARCHAR(10) FOREIGN KEY REFERENCES KhoaHoc(MaKhoaHoc),
	SoLuongSV INT DEFAULT 0
);

-- Tạo bảng Sinh Viên và các ràng buộc
CREATE TABLE SinhVien
(
	MaSV VARCHAR(20) PRIMARY KEY,
	HoTenSV NVARCHAR(50) NOT NULL,
	NgaySinh DATE NOT NULL,
	QueQuan NVARCHAR(50) NOT NULL,
	GioiTinh BIT,
	MaLop VARCHAR(10) FOREIGN KEY REFERENCES LopTinChi(MaLop),
	SDT VARCHAR(12) UNIQUE,
	Email VARCHAR(100),
);
ALTER TABLE SinhVien
ADD CONSTRAINT CK_Email CHECK (Email LIKE '%@%');

-- Tạo bảng Môn Học và ràng buộc
CREATE TABLE MonHoc
(
	MaMH VARCHAR(20) PRIMARY KEY,
	TenMH NVARCHAR(50) NOT NULL,
	SoTinChi INT NOT NULL
);

-- Tạo bảng Kết Quả và các ràng buộc
CREATE TABLE KetQua
(
	MaSV VARCHAR(20) REFERENCES SinhVien(MaSV),
	MaMH VARCHAR(20) REFERENCES MonHoc(MaMH),
	LanThi INT NOT NULL,
	DiemCC FLOAT,
	DiemGK FLOAT,
	DiemCK FLOAT,
	PRIMARY KEY (MaSV, MaMH)
);

-- Chèn bản ghi vào bảng Khoa
INSERT INTO dbo.Khoa 
	(MaKhoa, TenKhoa, DiaChi)
VALUES
	('HOU01', N'Công Nghệ Thông Tin', N'96A Định Công, Hoàng Mai, Hà Nội'),
	('HOU02', N'Tạo Dáng Công Nghiệp', N'422 Vĩnh Hưng, Hoàng Mai, Hà Nội'),
	('HOU03', N'Công Nghệ Sinh Học', N'301 Nguyễn Trãi, Thanh Xuân, Hà Nội'),
	('HOU04', N'Kinh Tế', N'193 Vĩnh Hưng, Hoàng Mai, Hà Nội'),
	('HOU05', N'Tiếng Trung Quốc', N'193 Vĩnh Hưng, Hoàng Mai, Hà Nội'),
	('HOU06', N'Tiếng Anh', N'301 Nguyễn Trãi, Thanh Xuân ,Hà Nội'),
	('HOU07', N'Luật', N'193 Vĩnh Hưng, Hoàng Mai, Hà Nội'),
	('HOU08', N'Du Lịch', N'301 Nguyễn Trãi, Thanh Xuân, Hà Nội');
SELECT * 
FROM Khoa

-- Chèn bản ghi vào bảng Khóa Học
INSERT INTO dbo.KhoaHoc 
	(MaKhoaHoc, NamBatDau, NamKetThuc)
VALUES
	('K23', '2023-08-25', '2027-08-25'),
	('K22', '2022-09-27', '2026-09-27'),
	('K21', '2021-08-26', '2025-08-26'),
	('K20', '2020-07-21', '2024-07-21'),
	('K19', '2019-08-23', '2023-08-23'),
	('K18', '2018-08-25', '2022-08-29'),
	('K17', '2017-09-25', '2021-08-23');
SELECT * 
FROM KhoaHoc

-- Chèn bản ghi vào bảng Lop
INSERT INTO dbo.LopTinChi 
	(MaLop, MaKhoa, MaKhoaHoc, SoLuongSV)
VALUES 
	('2210A03', 'HOU01', 'K22', 65),
	('2210A04', 'HOU01', 'K22', 71),
	('2110A02', 'HOU03', 'K21', 67),
	('1990A01', 'HOU04', 'K19', 45),
	('2310A06', 'HOU08', 'K23', 62),
	('1810A02', 'HOU02', 'K18', 60),
	('1710A03', 'HOU05', 'K17', 62),
	('2010A04', 'HOU07', 'K20', 65),
	('1810A05', 'HOU06', 'K18', 59),
	('2110A01', 'HOU04', 'K21', 64),
	('1710A06', 'HOU05', 'K17', 58),
	('1910A03', 'HOU02', 'K19', 60),
	('2310A05', 'HOU03', 'K23', 61),
	('1810A01', 'HOU04', 'K18', 62);

INSERT INTO dbo.LopTinChi
(MaLop, MaKhoa, MaKhoaHoc, SoLuongSV)
VALUES ('2210A05', 'HOU01', 'K22',60)

SELECT *
FROM LopTinChi

-- Chèn bản ghi vào bảng Sinh Viên
INSERT INTO dbo.SinhVien
	(MaSV, HoTenSV, NgaySinh, QueQuan, GioiTinh, MaLop, SDT, Email)
VALUES
	('SV01', N'Nguyễn Việt Hoàng', '2004-09-24', N'Vinhome Oceanpark Hà Nội', 1, '2210A03', '0979947889', '789Club@gmail.com'),
	('SV02', N'Trần Thị Thu Hiền', '2004-03-09', N'AEON Hà Đông', 0, '2210A04', '0920247249', 'sunwin@gmail.com'),
	('SV03', N'Nguyễn Hồng Phúc', '2004-05-24', N'Royal City', 1, '2310A06', '0945785423', 'fabet@gmail.com'),
	('SV04', N'Nguyễn Duy Anh', '2004-09-20', N'Phú Quốc', 1, '1810A02', '0962696969', 'lucky88@gmail.com'),
	('SV05', N'Phùng Thanh Đô', '2003-01-23', N'Yên Lãng, Hà Nội', 1, '2110A02', '0979695939', 'One88@gmail.com'),
	('SV06', N'Trần Thị Huyền', '2000-06-21', N'Bắc Từ Liêm, Hà Nội', 0, '1710A03' , '0976146712', 'FB88@gmail.com'),
	('SV07', N'Nguyễn Khánh Thu', '2002-01-28', N'Hai Bà Trưng , Hà Nội', 0, '1990A01', '0964214567', 'Club69@gmail.com'),
	('SV08', N'Nguyễn Thanh Tùng', '1999-04-13', N'Định Công Hạ, Hà Nội', 1, '1910A03', '0973416578', 'zingmp3@gmail.com'),
	('SV09', N'Trần Khánh Linh', '2001-02-12', N'Thanh Xuân, Hà Nội', 0, '2310A05' , '0371843516', '8xbet@gmail.com'),
	('SV10', N'Nguyễn Văn Vinh', '2003-12-10', N'Long Biên, Hà Nội', 1, '1810A01' , '0987631452', 'Vebo@gmail.com');

INSERT INTO dbo.SinhVien
(MaSV, HoTenSV, NgaySinh, QueQuan, GioiTinh, MaLop, SDT, Email)
VALUES ('SV11',N'Nguyễn Hồng Long', '2004-04-12', N'Đống Đa, Hà Nội', 1, '2210A05', '0961422551', 'dabet@gmail.com');

SELECT *
FROM SinhVien

-- Chèn bản ghi vào bảng Môn Học
INSERT INTO dbo.MonHoc
	(MaMH, TenMH, SoTinChi)
VALUES
	('CTDL', N'Cấu Trúc Dữ Liệu Và Giải Thuật', 4),
	('SQLS', N'Hệ Quản Trị Cơ Sở Dữ Liệu', 4),
	('SHPT', N'Sinh Học Phân Tử', 3),
	('TACN', N'Tiếng Anh Chuyên Ngành', 3),
	('KTS', N'Kỹ Thuật Số', 3),
	('THDC', N'Tín Hiệu Điều Chế', 3),
	('TRR', N'Toán Rời Rạc', 4),
	('LSVH', N'Lịch Sử Văn Hóa Thế Giới', 2),
	('GSKS', N'Giám Sát Khách Sạn', 3),
	('TLH', N'Tâm Lý Học Đại Cương', 2),
	('LHC', N'Luật Hành Chính', 3),
	('QTNL', N'Quản Trị Nhân Lực', 3),
	('TTNT', N'Trang Trí Nội Thất', 3);
SELECT *
FROM MonHoc

-- Chèn bản ghi vào bảng Kết Quả
INSERT INTO dbo.KetQua 
	(MaSV, MaMH, LanThi, DiemCC, DiemGK, DiemCK)
VALUES
	('SV01', 'QTNL', 1, 10.0, 9.0, 7.0),
	('SV04', 'CTDL', 2, 9.0, 5.0, 6.0),
	('SV01', 'TRR', 1, 10.0, 6.0,5.0),
	('SV05', 'KTS', 1, 8.0, 7.0, 4.0),
	('SV02', 'CTDL', 2, 10.0, 9.0, 3.0),
	('SV05', 'SQLS', 1, 10.0, 9.0, 8.0),
	('SV06', 'TLH', 1, 10.0, 5.0, 7.0), 
	('SV03', 'TACN', 1, 10.0, 9.0, 6.5), 
	('SV09', 'TRR', 1, 10.0, 9.0, 7.0), 
	('SV04', 'THDC', 1, 10.0, 8.0, 8.0), 
	('SV07', 'SHPT', 1, 10.0, 6.0, 9.0),
	('SV04', 'LSVH', 2, 10.0, 7.0, 6.0),
	('SV08', 'GSKS', 1, 10.0, 9.0, 5.5),
	('SV05', 'LHC', 1, 10.0, 9.0, 9.0),
	('SV10', 'TTNT', 1, 8.0, 9.0, 7.0);
SELECT *
FROM KetQua

---- Truy vấn dữ liệu từ 1 bảng
-- Lấy kết quả môn học của sinh viên có mã sinh viên SV05
SELECT * 
FROM KetQua
WHERE MaSV LIKE 'SV05'

-- Lấy thông tin các khoa ở 301 Nguyễn Trãi, Thanh Xuân, Hà Nội
SELECT * 
FROM Khoa
WHERE DiaChi = N'301 Nguyễn Trãi, Thanh Xuân, Hà Nội' 

-- Lấy thông tin các sinh viên thuộc K22
SELECT * 
FROM LopTinChi
WHERE MaKhoaHoc LIKE 'K22'

-- Lấy thông tin sinh viên sinh năm 2004
SELECT * 
FROM SinhVien
WHERE year(NgaySinh) = 2004

-- Lấy thông tin mã khóa học có tháng bắt đầu là tháng 8
SELECT MaKhoaHoc 
FROM KhoaHoc
WHERE month(NamBatDau) = 08

---- Truy vấn dữ liệu từ nhiều bảng
-- Lấy ra tên sinh viên có điểm cuối kì trên 5 đầu tiên
SELECT Top 1 HoTenSV
FROM KetQua a , SinhVien b
WHERE a.MaSV = b.MaSV AND DiemCK >= 5;

-- Lấy ra thông tin các lớp thuộc khoa Kinh Tế
SELECT *
FROM LopTinChi INNER JOIN Khoa
ON Khoa.MaKhoa = LopTinChi.MaKhoa
WHERE TenKhoa LIKE N'Kinh Tế'

-- Lấy thông tin khoa và số sinh viên
SELECT a.MaKhoa , TenKhoa , COUNT(MaSV) AS SoSinhVien
FROM Khoa a, SinhVien b, LopTinChi c
WHERE a.MaKhoa = c.MaKhoa AND b.MaLop = c.MaLop
GROUP BY a.MaKhoa, TenKhoa

-- Lấy thông tin khoa có năm bắt đầu là 2022
SELECT a.MaKhoa, a.TenKhoa, a.DiaChi
FROM dbo.Khoa a, dbo.LopTinChi b, dbo.KhoaHoc c
WHERE a.MaKhoa=b.MaKhoa and b.MaKhoaHoc=c.MaKhoaHoc and YEAR(NamBatDau)=2022
GROUP BY a.MaKhoa, a.TenKhoa, a.DiaChi

-- Lấy thông tin bảng kết quả và bảng môn học với môn học có số tín chỉ nhiều hơn 2
SELECT *
FROM dbo.KetQua a, dbo.MonHoc b
WHERE a.MaMH = b.MaMH and b.SoTinChi > 2

----- TẠO VIEW -----
-- 2.1. Danh sách các sinh viên sinh trước năm 2004
CREATE VIEW SV_TRUOC_KHOA_2210A
AS
SELECT *
FROM dbo.SinhVien
WHERE YEAR(NgaySinh) < 2004

SELECT *
FROM SV_TRUOC_KHOA_2210A

-- 2.2. Cho biết số lượng sinh viên của mỗi khoa
CREATE VIEW SOLUONG_SV
AS
SELECT dbo.Khoa.MaKhoa, dbo.Khoa.TenKhoa, COUNT (MaSV) as SoLuongSV
FROM dbo.LopTinChi,dbo.SinhVien,dbo.Khoa
WHERE dbo.LopTinChi.MaKhoa=dbo.Khoa.MaKhoa
and dbo.LopTinChi.MaLop=dbo.SinhVien.MaLop
GROUP BY dbo.Khoa.MaKhoa,TenKhoa;

SELECT * 
FROM SOLUONG_SV

-- 2.3. Cho biết danh sách sinh viên có điểm thi cao nhất
CREATE VIEW DIEM_MAX 
AS
SELECT SinhVien.MaSV, HoTenSV, DiemCK AS [ĐIỂM]
FROM SinhVien INNER JOIN KetQua ON SinhVien.MaSV = KetQua.MaSV
WHERE DiemCK >= ALL (SELECT DiemCK FROM KetQua);

SELECT * FROM DIEM_MAX

-- 2.4. Cho biết danh sách sinh viên đã thi 2 lần
CREATE VIEW SV_THI_2_LAN
AS
SELECT SinhVien.MaSV, HoTenSV
FROM SinhVien INNER JOIN KetQua ON SinhVien.MaSV = KetQua.MaSV
WHERE KetQua.LanThi=2
GROUP BY SinhVien.MaSV, HoTenSV;

SELECT * FROM SV_THI_2_LAN

-- 2.5. Cho biết khoa nhiều sinh viên nhất
CREATE VIEW SV_KHOAMax
AS
SELECT Khoa.MaKhoa, TenKhoa, COUNT(MaSV) AS [SỐ LƯỢNG]
FROM (Khoa INNER JOIN LopTinChi On Khoa.MaKhoa = LopTinChi.MaKhoa)
INNER JOIN	 SinhVien ON LopTinChi.MaLop = SinhVien.MaLop
GROUP BY 	Khoa.MaKhoa, TenKhoa
HAVING COUNT (MaSV) >= ALL
(
	SELECT COUNT(MaSV)
	FROM(
	SinhVien INNER JOIN LopTinChi ON LopTinChi.MaLop = SinhVien.MaLop)
	INNER JOIN 	Khoa ON Khoa.MaKhoa = LopTinChi.MaKhoa
	GROUP BY Khoa.MaKhoa
);
	
SELECT * FROM SV_KHOAMax

-- 2.6. Hiển thị tổng số sinh viên mỗi lớp
CREATE VIEW SLSV_LOP
AS
SELECT LopTinChi.MaLop, COUNT(MaSV) AS [SỐ LƯỢNG]
FROM LopTinChi INNER JOIN SinhVien ON LopTinChi.MaLop = SinhVien.MaLop
GROUP BY LopTinChi.MaLop;

SELECT * FROM SLSV_LOP

-- 2.7. Hiển thị danh sách sinh viên khoa CNTT
CREATE VIEW SV_CNTT 
AS
SELECT Khoa.TenKhoa, LopTinChi.MaLop, SinhVien.HoTenSV
FROM SinhVien
JOIN LopTinChi ON SinhVien.MaLop = LopTinChi.MaLop
JOIN Khoa ON LopTinChi.MaKhoa = Khoa.MaKhoa
WHERE Khoa.MaKhoa = 'HOU01';

SELECT * FROM SV_CNTT

-- 2.8. Hiển thị bảng điểm tổng kết của sinh viên 
CREATE VIEW BangDiem
AS
SELECT dbo.SinhVien.HoTenSV, dbo.MonHoc.TenMH, (DiemCC * 0.1 + DiemGK * 0.2 + DiemCK * 0.7)  AS [Điểm Tổng Kết]
FROM dbo.KetQua
INNER JOIN dbo.MonHoc ON MonHoc.MaMH = KetQua.MaMH
INNER JOIN dbo.SinhVien ON SinhVien.MaSV = KetQua.MaSV

SELECT * FROM BangDiem

-- 2.9. Hiển thị điểm cuối kì và tên sinh viên với số tín chỉ lớn hơn 2
CREATE VIEW DiemSV
AS
SELECT b.HoTenSV, a.DiemCK
FROM dbo.KetQua a, dbo.SinhVien b, dbo.MonHoc c
WHERE a.MaSV = b.MaSV
AND a.MaMH = c.MaMH
AND c.SoTinChi > 2
           
SELECT * FROM DiemSV

--2.10. Hiển thị sinh viên thuộc khóa 22
CREATE VIEW vvSVK22 
AS
SELECT dbo.SinhVien.HoTenSV, dbo.LopTinChi.MaKhoaHoc
FROM dbo.SinhVien, dbo.LopTinChi
WHERE dbo.SinhVien.MaLop = dbo.LopTinChi.MaLop
AND dbo.LopTinChi.MaKhoaHoc = 'K22'
  
SELECT * FROM vvSVK22

----- TẠO PROC -----
-- 3.1. Thủ tục xóa môn học với tham số truyền vào là mã môn học
CREATE PROC xoa_monHoc @maMH VARCHAR(10)
AS
BEGIN
	IF EXISTS (SELECT MaMH FROM dbo.MonHoc WHERE MaMH LIKE @maMH)
	BEGIN
		DELETE
		FROM dbo.MonHoc
		WHERE MaMH LIKE @maMH
	END
	ELSE
	BEGIN
		PRINT N'Không có mã môn học nào trùng với mã sinh viên được nhập!'
	END
END;

INSERT INTO dbo.MonHoc (MaMH, TenMH, SoTinChi)
VALUES ('JAVA' , N'Lập trình hướng đối tượng', 4);

EXEC xoa_monHoc 'JAVA';

SELECT *
FROM dbo.MonHoc;

-- 3.2. Tạo thủ xóa một lớp với tham số truyền vào là MaLop
CREATE PROC xoa_lop @maL VARCHAR(10)
AS
BEGIN
IF EXISTS (SELECT MaLop FROM dbo.LopTinChi WHERE MaLop LIKE @maL)
	BEGIN
		DELETE
		FROM dbo.LopTinChi
		WHERE MaLop LIKE @maL
	END
	ELSE
	BEGIN
		PRINT N'Không có mã lớp nào trùng với mã lớp được nhập!'
	END
END;

INSERT INTO dbo.LopTinChi
VALUES ('2010A06', 'HOU02', 'K20', 61)

EXEC xoa_lop '2010A06'

SELECT * FROM dbo.LopTinChi

-- 3.3. Thủ tục đếm số sinh viên trong một lớp với tham số truyền vào là mã lớp
CREATE PROC Dem_SV @MaLop VARCHAR(10)
AS
BEGIN
	IF EXISTS (SELECT MaLop FROM dbo.LopTinChi WHERE MaLop LIKE @MaLop)
		BEGIN
			SELECT SinhVien.MaLop, COUNT(MaSV) AS N'Số sinh viên'
			FROM dbo.SinhVien , dbo.LopTinChi
			WHERE SinhVien.MaLop LIKE LopTinChi.MaLop AND SinhVien.MaLop LIKE @MaLop
			GROUP BY SinhVien.MaLop
		END
	ELSE
		BEGIN
			PRINT N'Mã lớp không tồn tại!'
		END
END;

EXEC Dem_SV '2410A01';

-- 3.4. Thủ tục đếm số lượng sinh viên và danh sách SV của khoa đó với tham số truyền vào là mã khoa
CREATE PROC Dem_SV_Khoa @maKhoa VARCHAR(10), @ListSV NVARCHAR(MAX) OUTPUT, @CountSV INT OUTPUT
AS
BEGIN
	IF EXISTS (SELECT MaKhoa FROM dbo.Khoa WHERE MaKhoa LIKE @maKhoa)
		BEGIN
			DECLARE @hoten NVARCHAR(100)
			SET @hoten = ''
			SELECT @hoten = @hoten + HoTenSV +', '
			FROM dbo.SinhVien INNER JOIN dbo.LopTinChi ON SinhVien.MaLop LIKE LopTinChi.MaLop INNER JOIN dbo.Khoa ON Khoa.MaKhoa LIKE LopTinChi.MaKhoa
			WHERE Khoa.MaKhoa = @maKhoa
			ORDER BY HoTenSV
			SET @CountSV = @@ROWCOUNT
			SET @ListSV = @hoten
		END
	ELSE
		BEGIN
			PRINT N'Không có khoa nào trùng với mã khoa nhập vào'
		END
END;

DECLARE @Count_SV_Out INT , @List_SV_Out NVARCHAR(MAX)
EXEC Dem_SV_Khoa @maKhoa = 'HOU01', @CountSV = @Count_SV_Out OUTPUT , @ListSV = @List_SV_Out OUTPUT
SELECT @Count_SV_Out AS N'Số Lượng SV' , @List_SV_Out AS N'Danh sách sinh viên';

-- 3.5. Tạo thủ tục chèn thêm một khóa học mới
CREATE PROC insert_Khoa_Hoc 
	(@MaKhoaHoc VARCHAR(10), 
	 @NamBatDau DATE, 
	 @NamKetThuc DATE)
AS
BEGIN
INSERT INTO dbo.KhoaHoc
VALUES (@MaKhoaHoc, @NamBatDau, @NamKetThuc)
END;

EXEC insert_Khoa_Hoc @MaKhoaHoc = 'K24', @NamBatDau = '2024-09-05', @NamKetThuc = '2028-10-17';

SELECT *
FROM dbo.KhoaHoc

-- 3.6. Tạo thủ tục chèn thêm một lớp tín chỉ mới
CREATE PROC insert_Lop 
	(@MaLop VARCHAR(10),
	 @MaKhoa VARCHAR(10),
	 @MaKhoaHoc VARCHAR(10),
	 @SoLuongSV INT)
AS
BEGIN
	INSERT INTO dbo.LopTinChi
	VALUES (@MaLop, @MaKhoa, @MaKhoaHoc, @SoLuongSV)
END;

EXEC insert_Lop @MaLop = '1910A02', @MaKhoa = 'HOU06', @MaKhoaHoc = 'K19', @SoLuongSV = '82';

SELECT *
FROM dbo.LopTinChi

-- 3.7. Tạo thủ tục chèn thêm một sinh viên
ALTER PROC insert_Sinh_Vien
	(@MaSV VARCHAR(20),
	 @HoTenSV NVARCHAR(50),
	 @NgaySinh DATE,
	 @QueQuan NVARCHAR(50),
	 @GioiTinh BIT,
	 @MaLop VARCHAR(10),
	 @SDT VARCHAR(12),
	 @Email VARCHAR(100))
AS
BEGIN
	INSERT INTO dbo.SinhVien
	VALUES (@MaSV, @HoTenSV, @NgaySinh, @QueQuan, @GioiTinh, @MaLop, @SDT, @Email)
END;

EXEC insert_Sinh_Vien @MaSV = 'SV12', @HoTenSV = N'Nguyễn Thị Hạnh', @NgaySinh = '2002-10-22', @QueQuan = N'Thanh Xuân, Hà Nội', @GioiTinh = 0, @MaLop = '2210A04', @SDT = '0937236233', @Email = 'nguyenthihanh@gmail.com';

SELECT *
FROM dbo.SinhVien

-- 3.8. Tạo thủ tục chèn thêm một môn học mới
CREATE PROC insert_Mon_Hoc
	(@MaMH VARCHAR(20),
	 @TenMH nVARCHAR(50),
	 @SoTinChi  INT)
AS
BEGIN
	INSERT INTO dbo.MonHoc
	VALUES (@MaMH, @TenMH, @SoTinChi)
END;

EXEC insert_Mon_Hoc @MaMH = 'GT1', @TenMH = N'Giải Tích 1', @SoTinChi = 3;

SELECT *
FROM dbo.MonHoc

-- 3.9. Tạo thủ tục cho danh sách các sinh viên bắt đầu tham gia học trong năm nào đó, với năm là tham số truyền vào.
CREATE PROC ds_sv_bat_dau @year char(4)
AS
BEGIN
	SELECT HoTenSV
	FROM dbo.SinhVien S, dbo.LopTinChi L, dbo.KhoaHoc K
	WHERE S.MaLop = L.MaLop
	AND L.MaKhoaHoc = K.MaKhoaHoc
	AND year(NamBatDau) = @year
END;

EXEC ds_sv_bat_dau 2021;

-- 3.10. Tạo thủ tục hiện những sinh viên có điểm cuối kỳ môn lớn hơn tham số truyền vào 
CREATE PROC Hien_SV @DiemCK float
AS
BEGIN
	SELECT *
	FROM dbo.SinhVien , dbo.KetQua
	WHERE SinhVien.MaSV LIKE KetQua.MaSV AND KetQua.DiemCK > @DiemCK
END

EXEC Hien_SV 7

-- 3.11. Tạo thủ tục in ra màn hình danh sách sinh viên một lớp nào đó, với tham số truyền vào là mã lớp.
CREATE PROC ds_SV_Lop @maL VARCHAR(10)
AS
BEGIN
	SELECT *
	FROM dbo.SinhVien
	WHERE MaLop = @maL
END;

EXEC ds_SV_Lop '2210A04'

-- 3.12. Tạo thủ tục đếm sinh viên có điểm tổng kết môn học lớn hơn giá trị truyền vào
CREATE PROC sv_diemTB @diemTB float =0
AS
BEGIN
	DECLARE @count int=0
	SELECT @count = count(*) from BangDiem
	WHERE dbo.BangDiem.[Điểm Tổng Kết] > @diemTB
	RETURN @count
END;
GO
DECLARE @dem int
EXEC  @dem= sv_diemTB @diemTB = 7
PRINT  N'Tổng số sinh viên thỏa mãn là: ' + convert(char, @dem);

-- 3.13. Tạo thủ tục in ra kết quả của một sinh viên nào đó, với tham số truyền vào là mã SV.
CREATE PROC in_ket_qua @masv VARCHAR(10)
AS
BEGIN
	SELECT S.MaSV, MaLop, HoTenSV, MaMH, LanThi, DiemCC, DiemGK, DiemCK
	FROM dbo.SinhVien S INNER JOIN dbo.KetQua KQ
	ON S.MaSV = KQ.MaSV
	WHERE S.MaSV = @masv
END;

EXEC in_ket_qua 'SV07'

-- 3.14. Tạo thủ tục cập nhật dữ liệu sinh viên
CREATE PROC update_SV 
	(@masv VARCHAR(20),
	 @hotensv NVARCHAR(50),
	 @ngaysinh DATE,
	 @quequan NVARCHAR(50),
	 @gioitinh BIT,
	 @malop VARCHAR(10),
	 @sdt VARCHAR(12),
	 @email VARCHAR(100))
AS
BEGIN
	IF EXISTS(SELECT MaSV FROM dbo.SinhVien
	WHERE MaSV = @masv)
	UPDATE dbo.SinhVien
	SET HoTenSV = @hotensv, NgaySinh = @ngaysinh, QueQuan = @quequan, GioiTinh = @gioitinh, MaLop = @malop, SDT = @sdt, Email = @email
    WHERE MaSV = @masv

END    

EXEC  update_SV  'SV10', N'Nguyễn Văn Vinh', '2003-12-10', N'Nam Từ Liêm, Hà Nội', 1, '1810A01', '0987631452', 'Vebo@gmail.com'

SELECT *
FROM SinhVien

-- 3.15. Tạo thủ tục hiện ra thông tin sinh viên, số lần thi và tên môn với tham số truyền vào là mã sinh viên
CREATE PROC TimSV_Thi @masv VARCHAR(20)
AS
BEGIN
		SELECT a.MaSV, a.HoTenSV, a.MaLop, a.GioiTinh, a.QueQuan, a.NgaySinh, a.SDT, a.Email, b.LanThi, c.TenMH
		FROM dbo.SinhVien a, dbo.KetQua b, dbo.MonHoc c
		WHERE a.MaSV = b.MaSV and c.MaMH = b.MaMH and a.MaSV = @masv
END

EXEC TimSV_Thi 'SV04';

-- 3.16. Tạo thủ tục cho biết danh sách tên các sinh viên của một khoa nào đó theo tên khoa
CREATE PROC Ds_ten_sv @TenKhoa nvarchar(50)
AS
BEGIN
	SELECT HoTenSV
	FROM dbo.SinhVien S, dbo.Khoa K , dbo.LopTinChi L
	WHERE S.MaLop = L.MaLop AND L.MaKhoa = K.MaKhoa
	AND TenKhoa = @TenKhoa
END;

EXEC Ds_ten_sv N'Công nghệ thông tin'

-- 3.17. Tạo thủ tục cho biết thông tin các sinh viên nam
CREATE PROC SV_nam @gtinhh bit
AS
BEGIN
	SELECT *
	FROM SinhVien
	WHERE @gtinhh = GioiTinh
END

EXEC SV_nam @gtinhh = 1

-- 3.18 Tạo thủ tục in sinh viên đã học môn nào với tham số truyền vào là mã môn học
CREATE PROC SV_monhoc @mamon varchar(20)
AS
BEGIN
	SELECT a.HoTenSV
	FROM dbo.SinhVien a,dbo.KetQua b
	WHERE a.MaSV=b.MaSV and @mamon=B.MaMH 
END

EXEC SV_monhoc 'CTDL';

-- 3.19. Tạo thủ tục tăng điểm cho sinh viên với tham số truyền vào là mã sinh viên, mã môn học và số điểm tăng thêm vào điểm nào(điểm cc, gk , ck)
CREATE PROC TangDiem_SV @masv VARCHAR(20) , @mamh VARCHAR(20) , @diem FLOAT , @sl INT
AS
BEGIN
	IF EXISTS (SELECT MaSV FROM dbo.SinhVien WHERE @masv = MaSV)
	BEGIN
		IF EXISTS (SELECT MaMH FROM dbo.MonHoc WHERE @mamh = MaMH)
		BEGIN
			UPDATE dbo.KetQua
			SET DiemCC = DiemCC + @diem
			FROM dbo.SinhVien
			WHERE @sl = 1 AND MaMH = @mamh AND dbo.SinhVien.MaSV = @masv AND dbo.SinhVien.MaSV = dbo.KetQua.MaSV
			UPDATE dbo.KetQua
			SET DiemCK = DiemCK + @diem
			FROM dbo.SinhVien
			WHERE @sl = 2 AND MaMH = @mamh AND dbo.SinhVien.MaSV = @masv AND dbo.SinhVien.MaSV = dbo.KetQua.MaSV
			UPDATE dbo.KetQua
			SET DiemGK = DiemGK + @diem
			FROM dbo.SinhVien
			WHERE @sl = 3 AND MaMH = @mamh AND dbo.SinhVien.MaSV = @masv AND dbo.SinhVien.MaSV = dbo.KetQua.MaSV
		END;
		ELSE
		BEGIN
			PRINT N'Không có mã môn học'
		END;
	END;
	ELSE
	BEGIN
		PRINT N'Không có mã sinh viên'
	END;
END

EXEC TangDiem_SV 'SV08', 'GSKS', 1, 2;

SELECT * FROM dbo.KetQua;

-- 3.20. Tạo thủ tục cho biết họ tên sinh viên, tên môn học, số lần thi của một sinh viên nào đó, với tham số truyền vào là mã môn học
CREATE PROC Tong_lan_thi @mamh VARCHAR(10)
AS
BEGIN
	SELECT HoTenSV AS [Tên sinh viên], TenMH AS [Môn học], Sum(LanThi) AS [Tổng số lần thi]
	FROM SinhVien S, MonHoc M, KetQua K
	WHERE S.MaSV = K.MaSV
		AND M.MaMH = K.MaMH
		AND @mamh = M.MaMH
	GROUP BY S.HoTenSV, M.TenMH
END

EXEC Tong_lan_thi @mamh = 'TACN';

------ TẠO TRIGGER ------
-- 4.1 Trigger đảm bảo khi thêm 1 bản ghi trên bảng MonHoc phải đảm bảo SoTinChi <= 4 và >= 0
CREATE TRIGGER trMonHocInsert
ON dbo.MonHoc INSTEAD OF INSERT
AS
BEGIN
	DECLARE @SoTinChi int = (SELECT SoTinChi FROM Inserted)
	IF (@SoTinChi >4 OR @SoTinChi <0 )
	BEGIN
		PRINT N'Số tín chỉ sai quy định'
	END
	ELSE
	BEGIN 
		INSERT INTO dbo.MonHoc
		(MaMH, TenMH, SoTinChi)
		SELECT * FROM Inserted
	END
END
GO

INSERT INTO dbo.MonHoc (MaMH, TenMH, SoTinChi)
VALUES ('NLHDH', N'Nguyên Lý Hệ Điều Hành', 6)

SELECT *
FROM MonHoc

-- 4.2. Trigger đảm bảo khi xóa một môn học thì các bản ghi kết quả của môn học đó cũng bị xóa
CREATE TRIGGER trMonHocDelete
ON dbo.MonHoc INSTEAD OF Delete
AS
BEGIN
	DECLARE @MaMH VARCHAR(10)
	SET @MaMH = (SELECT MaMH FROM Deleted)
	DELETE dbo.KetQua WHERE MaMH = @MaMH
	DELETE dbo.MonHoc WHERE MaMH = @MaMH
END
GO

SELECT * FROM KetQua WHERE MaMH = 'TACN'
GO
DELETE FROM MonHoc WHERE MaMH = 'TACN'
GO
SELECT * FROM KetQua WHERE MaMH = 'TACN'
GO

-- 4.3. Trigger đảm bảo không cho phép sửa mã sinh viên
CREATE TRIGGER kosuamasv
ON dbo.SinhVien
FOR UPDATE 
AS
BEGIN
	IF UPDATE (MaSV)
	RAISERROR('Khong duoc sua ma sinh vien', 16, 1)
	ROLLBACK TRAN
END;

UPDATE dbo.SinhVien
SET MaSV = 'SV16'
WHERE HoTenSV = 'Nguyễn Việt Hoàng'

-- 4.4. Trigger đảm bảo khi thêm dữ liệu vào bảng SinhVien, cột MaSV là không rỗng	
CREATE TRIGGER trg_InsertSV
ON SinhVien
FOR INSERT
AS
BEGIN
	IF ((SELECT MaSV FROM INSERTED) = '')
	BEGIN
		PRINT N'Mã sinh viên phải được nhập!'
		ROLLBACK TRANSACTION
	END
END;

INSERT INTO dbo.SinhVien
VALUES 
	('', N'Nguyễn Việt Hà', '2003-02-10', N'Thanh Xuân, Hà Nội', 1, '2210A03', '0988392452', 'nguyenvietha@gmail.com')

-- 4.5. Trigger đảm bảo Sinh Viên học ít nhất 2 môn, xóa sinh viên học ít hơn 1 môn		//chưa test
CREATE TRIGGER tr_SinhVien2
ON dbo.SinhVien
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (SELECT 1 FROM inserted)
	BEGIN
		DECLARE @MaSVToDelete VARCHAR(20);
		SELECT @MaSVToDelete = MaSV
		FROM deleted;
		IF @MaSVToDelete IS NOT NULL
			BEGIN
				DECLARE @SubjectCount INT;
				SELECT @SubjectCount = COUNT(MaLop)
				FROM dbo.SinhVien
				WHERE MaSV = @MaSVToDelete
				GROUP BY MaSV;
				IF @SubjectCount < 2
					BEGIN
						DELETE FROM dbo.SinhVien
						WHERE MaSV = @MaSVToDelete;
						UPDATE dbo.LopTinChi
						SET SoLuongSV = SoLuongSV - 1
						WHERE MaLop IN (SELECT MaLop FROM deleted);
					END
				ELSE
					BEGIN
						PRINT N'Số môn học đủ';
					END
				END
	END
	ELSE
		BEGIN
			INSERT INTO dbo.SinhVien
			SELECT MaSV, HoTenSV, NgaySinh, QueQuan, GioiTinh, MaLop, SDT, Email
			FROM inserted;
		END
END;

-- 4.6. Trigger đảm bảo khi thêm, sửa, xóa các bảng ghi trong bảng kết quả thì điểm chuyên cần, điểm giữa kì, điểm cuối kì >=0, <=10
-- Tạo trigger trước khi thêm dữ liệu vào bảng kết quả
CREATE TRIGGER tr_EnforceGradeRange
ON KetQua
INSTEAD OF INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM INSERTED)
    BEGIN
        UPDATE KetQua
        SET DiemCC = CASE
                               WHEN i.DiemCC < 0 THEN 0
                               WHEN i.DiemCC > 10 THEN 10
                               ELSE i.DiemCC
                          END,
            DiemGK = CASE
                               WHEN i.DiemGK < 0 THEN 0
                               WHEN i.DiemGK > 10 THEN 10
                               ELSE i.DiemGK
                          END,
            DiemCK = CASE
                               WHEN i.DiemCK < 0 THEN 0
                               WHEN i.DiemCK > 10 THEN 10
                               ELSE i.DiemCK
                          END
        FROM KetQua r
        INNER JOIN INSERTED i ON r.MaSV = i.MaSV;
    END
END;

INSERT INTO KetQua (MaSV, DiemCC, DiemGK, DiemCK)
VALUES ('SV006', 12, 8, 9);

UPDATE KetQua
SET DiemCC = 5, DiemGK = 15, DiemCK = 8
WHERE MaSV = 'SV006';

SELECT * FROM KetQua;

-- 4.7. Tạo trigger sao cho mỗi khi chèn thêm một sinh viên mới vào một lớp tín chỉ thì số lượng lớp đó tăng lên tương ứng
CREATE TRIGGER trgSinhVienInsert
ON dbo.SinhVien      
FOR INSERT
AS
BEGIN
	DECLARE @masv varchar(10)
	SELECT @masv = MaSV FROM INSERTED
             IF exists (SELECT * FROM dbo.SinhVien WHERE MaSV = @masv)
	BEGIN
		UPDATE dbo.LopTinChi
		SET SoLuongSV = SoLuongSV + 1
		FROM INSERTED,dbo.SinhVien
		WHERE  INSERTED.MaSV = @masv  
   		AND dbo.LopTinChi.MaLop = dbo.SinhVien.MaLop
	END
	ELSE 
		BEGIN
			RAISERROR('Ma sinh vien da ton tai!', 16, 1)
			ROLLBACK TRAN
		END
END;

INSERT INTO dbo.SinhVien
VALUES ('SV13', N'Trần Thanh Hà', '2001-05-29', N'Nam Từ Liêm, Hà Nội', 0, '1810A05', '0987421722', 'tranthanhha@gmail.com')

SELECT *
FROM dbo.LopTinChi

-- 4.8. Tạo trigger đảm bảo tuổi của sinh viên >= 18
CREATE TRIGGER trgTuoiSV
ON dbo.SinhVien
FOR INSERT
AS
BEGIN
	DECLARE @ngaysinh DATE = (SELECT NgaySinh FROM INSERTED)
	IF (year(GETDATE()) - year(@ngaysinh) <= 18)
	BEGIN
	  RAISERROR('Sinh vien chua du 18 tuoi!', 16, 1)
	  ROLLBACK TRAN
	END
END;

INSERT INTO dbo.SinhVien
VALUES ('SV14', N'Bùi Duy Hùng', '2007-10-13', N'Thanh Xuân, Hà Nội', 1, '1810A01' , '0913184662', 'buiduyhung@gmail.com')
	
SELECT * FROM dbo.SinhVien

SELECT * FROM dbo.SinhVien WHERE MaSV = 'SV14'
DELETE FROM dbo.SinhVien WHERE MaSV = 'SV14'

-- 4.9. Tạo trigger kiểm tra trùng lặp thông tin sinh viên trước khi thêm mới
CREATE TRIGGER kiemtraSV
ON dbo.SinhVien
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @masv VARCHAR(10) = (SELECT MaSV FROM INSERTED)
    IF EXISTS (SELECT MaSV FROM dbo.SinhVien WHERE  @masv = MaSV)
	BEGIN
	RAISERROR('Ma sinh vien da ton tai',16,1)
	ROLLBACK TRAN
	END
	ELSE
	BEGIN
    -- Nếu không có trùng lặp, thực hiện thêm mới
    INSERT INTO SinhVien (MaSV, HoTenSV, NgaySinh, QueQuan, GioiTinh, MaLop, SDT, Email)
    SELECT MaSV, HoTenSV, NgaySinh, QueQuan, GioiTinh, MaLop, SDT, Email FROM inserted;
    END
END

INSERT INTO SinhVien (MaSV, HoTenSV, NgaySinh, QueQuan, GioiTinh, MaLop, SDT, Email)
VALUES ('SV02', N'Nguyễn Văn Nam', '2004-08-24', N'Vinhome Oceanpark Hà Nội', 1, '2210A03', '0979947884', '786Club@gmail.com');
SELECT * FROM SinhVien

-- 4.10. Tạo trigger khi sửa lớp của 1 sinh viên nào đó thì số lượng sinh viên lớp đó thay đổi tương ứng
CREATE TRIGGER trg_sualop
ON dbo.SinhVien
FOR UPDATE
AS
BEGIN
	IF UPDATE (MaLop)
	BEGIN
		DECLARE @Malopcu VARCHAR(10) = (SELECT MaLop FROM DELETED)
		DECLARE @Malopmoi VARCHAR(10) = (SELECT MaLop FROM INSERTED)
		UPDATE dbo.LopTinChi SET SoLuongSV = SoLuongSV - 1 WHERE @Malopcu = MaLop
		UPDATE dbo.LopTinChi SET SoLuongSV = SoLuongSV + 1 WHERE @Malopmoi = MaLop
	END
END

UPDATE dbo.SinhVien
SET MaLop = '2010A04'
WHERE MaSV = 'SV06'
SELECT * FROM dbo.SinhVien
SELECT * FROM dbo.LopTinChi

-- 5. Tạo tài khoản người dùng
CREATE LOGIN Hien WITH PASSWORD = '09032004';
CREATE USER Hien FOR LOGIN Hien;
Grant insert, update, delete to Hien;

-- 6. Cấp quyền sử dụng các thành phần trong CSDL
USE QLKetQuaSinhVien
GRANT ALL
ON dbo.SinhVien
TO Hien -- Kiem tra phan quyen

GRANT ALL
ON dbo.KetQua
TO Hien -- Kiem tra phan quyen

GRANT ALL
ON dbo.Khoa
TO Hien -- Kiem tra phan quyen

GRANT ALL
ON dbo.KhoaHoc
TO Hien -- Kiem tra phan quyen

GRANT ALL
ON dbo.LopTinChi
TO Hien -- Kiem tra phan quyen	

GRANT ALL
ON dbo.MonHoc
TO Hien -- Kiem tra phan quyen

-- 7. Thu hồi/ cấm sử dụng một số thành phần trong CSDL với từng người dùng
-- Thu hồi quyền
REVOKE Insert, Update, Delete 
ON dbo.SinhVien
FROM Hien;

-- Cấm quyền
DENY Insert, Update, Delete 
ON dbo.KetQua
TO Hien
CASCADE;

-- 2. Tao view tinh toan du lieu co su dung ham tinh toan, loc nhom, sap xep
alter VIEW vvKetQua_SV
AS
SELECT dbo.SinhVien.HoTenSV, dbo.MonHoc.TenMH, (DiemCC * 0.1 + DiemGK * 0.2 + DiemCK * 0.7)  AS [Điểm Tổng Kết]
FROM dbo.KetQua
INNER JOIN dbo.MonHoc ON MonHoc.MaMH = KetQua.MaMH
INNER JOIN dbo.SinhVien ON SinhVien.MaSV = KetQua.MaSV
group by HoTenSV, TenMH, DiemCC, DiemGK, DiemCK
--order by KetQua DESC

SELECT * FROM vvKetQua_SV

-- 3. Them 1 thuoc tinh truy dan vao 1 bang, viet trigger insert dam bao tinh dung dan
alter table Khoa
add TongSoLop int default 0;

create TRIGGER trg_Lop_Insert
ON LopTinChi  
FOR INSERT
AS
BEGIN
	DECLARE @makhoa varchar(10)
	SELECT @makhoa = MaKhoa FROM INSERTED
             IF exists (SELECT * FROM Khoa WHERE MaKhoa = @makhoa)
	BEGIN
		UPDATE Khoa
		SET TongSoLop = TongSoLop + 1
		WHERE MaKhoa = @makhoa
	END
	ELSE 
		BEGIN
			RAISERROR('Ma khoa khong ton tai!', 16, 1)
			ROLLBACK TRAN
		END
END;

INSERT INTO LopTinChi
VALUES ('5510A04', 'HOU01', 'K22', 20)

SELECT * FROM Khoa
SELECT * FROM LopTinChi