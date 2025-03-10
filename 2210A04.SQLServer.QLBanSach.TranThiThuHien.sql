CREATE DATABASE QLBanSach_TranThiThuHien
GO
USE QLBanSach_TranThiThuHien
GO
-- Thực hành buổi 1
-- Tạo bảng
CREATE TABLE tblBoPhan
(
	sMabophan varchar(10) NOT NULL,
	sTenbophan nvarchar(50)
)
-- Sửa bảng, sửa cột
ALTER TABLE tblBoPhan
ALTER COLUMN sTenbophan nvarchar(100)

ALTER TABLE tblBoPhan
ADD CONSTRAINT PK_sMabophan PRIMARY KEY(sMabophan) -- Thêm ràng buộc khóa chính
GO
CREATE TABLE tblNhanVien
(
	sMaNV varchar(10) NOT NULL,
	sTenNV nvarchar(50),
	bGioitinh bit,
	sQuequan nvarchar(50),
	sDiachi nvarchar(50),
	sSDT char(10) UNIQUE,
	fHSL float,
	fPC float,
	sMabophan varchar(10) NOT NULL,
	sTenchucvu nvarchar(50),
	dNgayvaolam date
)
ALTER TABLE tblNhanVien
ADD CONSTRAINT CHK_HSL CHECK (fHSL BETWEEN 2.34 AND 8)
ALTER TABLE tblNhanVien
ADD CONSTRAINT DF_ngayvaolam DEFAULT GETDATE() FOR dNgayvaolam		-- Ngay vao lam phai la ngay hien tai
-- Thêm khóa chính, khóa ngoại
ALTER TABLE tblNhanVien 
ADD CONSTRAINT PK_sMANV PRIMARY KEY(sMaNV), 
	CONSTRAINT FK_nhanvien_bophan FOREIGN KEY(sMabophan) REFERENCES tblBoPhan(sMabophan)
GO
CREATE TABLE tblNXB
(
	sMaNXB varchar(10) NOT NULL,
	sTenNXB nvarchar(50),
	sSDT char(10) UNIQUE,	-- UNIQUE: đảm bảo các hàng trong một cột có giá trị không trùng nhau
	sDC varchar(50)
)
ALTER TABLE tblNXB 
alter column sDC nvarchar(100)

ALTER TABLE tblNXB 
ADD CONSTRAINT PK_sMaNXB PRIMARY KEY(sMaNXB)
GO
CREATE TABLE tblSach
(
	sMasach varchar(10) NOT NULL,
	sTensach nvarchar(50),
	sMaNXB varchar(10) NOT NULL,
	sTacgia nvarchar(50),
	sTheloai nvarchar(50)
)
/*
ALTER TABLE tblSach
MODIFY sTheloai DEFAULT N'%SGK%' AND N'%Sách tham khảo%' AND N'%Tiểu thuyết%' AND N'%Khác%';
*/
ALTER TABLE tblSach
ADD CONSTRAINT PK_sMasach PRIMARY KEY(sMasach), 
	CONSTRAINT FK_sach_NXB FOREIGN KEY(sMaNXB) REFERENCES tblNXB(sMaNXB)
GO
CREATE TABLE tblHoaDon
(
	sMaHD varchar(10) NOT NULL,
	sMaNV varchar(10) NOT NULL,
	dNgayLap date
)
ALTER TABLE tblPhieuNhap
ADD CONSTRAINT PK_sMaHD PRIMARY KEY(sMaHD), 
	CONSTRAINT FK_hoadon_nv FOREIGN KEY(sMaNV) REFERENCES tblNhanVien(sMaNV)
GO
CREATE TABLE tblChiTietHD
(
	sMaHD varchar(10) REFERENCES tblHoaDon(sMaHD),		-- Tạo 2 khóa chính trong 1 bảng 
	sMasach varchar(10) REFERENCES tblSach(sMasach),
	iSL int,
	fDGban float,
	PRIMARY KEY(sMaHD, sMasach)
)
GO
ALTER TABLE tblChiTietHD
ADD CONSTRAINT CHK_soL_dg CHECK (iSL > 0 AND fDGban > 0)
GO
CREATE TABLE tblPhieuNhap
(
	sMaPhieu varchar(10) NOT NULL,
	sMaNV varchar(10) NOT NULL,
	dNgaynhap date
)
ALTER TABLE tblPhieuNhap
ADD CONSTRAINT PK_sMaPhieu PRIMARY KEY(sMaPhieu), 
	CONSTRAINT FK_phieu_nv FOREIGN KEY(sMaNV) REFERENCES tblNhanVien(sMaNV)
GO
CREATE TABLE tblCTPhieuNhap
(
	sMaphieu varchar(10) REFERENCES tblPhieuNhap(sMaphieu),
	sMasach varchar(10) REFERENCES tblSach(sMasach),
	iSoLuong int,
	fDonGia float,
	fThanhTien float,
	PRIMARY KEY(sMaphieu, sMasach)
)

-- Thực hành buổi 2
USE QLBanSach_TranThiThuHien
-- 1. Chèn 5 bản ghi vào tblBoPhan, tblNXB
INSERT INTO tblBoPhan 
	(sMabophan, sTenbophan)
VALUES 
	('MBP01', N'Nhân sự'),
	('MBP02', N'Kế toán'),
	('MBP03', N'Kinh doanh'),
	('MBP04', N'Tài vụ'),
	('MBP05', N'Sản xuất');
SELECT * FROM tblBoPhan

INSERT INTO tblNXB 
	(sMaNXB, sTenNXB, sSDT, sDC)
VALUES 
	('NXB01', N'Kim Đồng', '0924735642', N'Hai Bà Trưng, Hà Nội'),
	('NXB02', N'Hội Nhà văn', '0283563525', N'Hà Nội'),
	('NXB03', N'Lao Động', '0927483583', N'Cầu Giấy, Hà Nội'),
	('NXB04', N'Trẻ', '0921459801', N'Hà Nội'),
	('NXB05', N'Phụ nữ Việt Nam', '0397650294', N'Hai Bà Trưng, Hà Nội');
SELECT * FROM tblNXB

-- 2. Chèn 10 bản ghi vào tblNhanVien
INSERT INTO tblNhanVien
	(sMaNV, sTenNV, bGioitinh, sQuequan, sDiachi, sSDT, fHSL, fPC, sMabophan, sTenchucvu, dNgayvaolam)
VALUES 
	('NV01', N'Nguyễn Văn Anh', 0, N'Hưng Yên', N'Hoàng Mai, Hà Nội', '0923560521', 3.645, 300, 'MBP01', N'Nhân viên', '01/21/2019'),
	('NV02', N'Nguyễn Thị Hà', 1, N'Hải Dương', N'Thanh Xuân, Hà Nội', '0942768103', 3.405, 250, 'MBP02', N'Quản lý', '04/05/2020'),
	('NV03', N'Nguyễn Văn Vũ', 0, N'Phú Thọ', N'Thanh Xuân, Hà Nội', '0926352173', 5.435, 300, 'MBP04', N'Giám đôc', '08/12/2019'),
	('NV04', N'Trần Hải Nam', 0, N'Nam Định', N'Cầu Giấy, Hà Nội', '0954752251', 3.547, 230, 'MBP02', N'Nhân viên', '05/10/2020'),
	('NV05', N'Bùi Hải Như', 1, N'Phú Thọ', N'Hoàng Mai, Hà Nội', '0356735727', 6.367, 300, 'MBP05', N'Quản lý', '05/20/2018'),
	('NV06', N'Nguyễn Xuân Khánh', 0, N'Nam Định', N'Thanh Xuân, Hà Nội', '0365775645', 4.646, 200, 'MBP02', N'Nhân viên', '10/12/2019'),
	('NV07', N'Trần Thị Thanh Nhàn', 1, N'Hưng Yên', N'Hoàng Mai, Hà Nội', '0954679032', 5.747, 280, 'MBP03', N'Nhân viên', '09/04/2020'),
	('NV08', N'Bùi Duy Khánh', 0, N'Phú Thọ', N'Tân Mai, Hà Nội', '0964352627', 5.831, 200, 'MBP04', N'Nhân viên', '11/11/2020'),
	('NV09', N'Dương Xuân Quý', 0, N'Vinh', N'Hoàng Mai, Hà Nội', '0364678011', 4.354, 200, 'MBP05', N'Nhân viên', '06/12/2020'),
	('NV10', N'Trần Thị Hạnh', 1, N'Hải Dương', N'Cầu Giấy, Hà Nội', '0625674793', 3.647, 230, 'MBP02', N'Nhân viên', '11/23/2020');
SELECT * FROM tblNhanVien

-- 3. Chèn 15 bản ghi vào tblSach
INSERT INTO tblSach
	(sMasach, sTensach, sMaNXB, sTacgia, sTheloai)
VALUES 
	('MS01', N'Tôi đi học', 'NXB04', N'Nguyễn Ngọc Ký', N'SGK'),
	('MS02', N'Thất tình không sao', 'NXB02', N'Nguyễn Ngọc Thạch', N'Sách tham khảo'),
	('MS03', N'Chú gà nuôi mèo ú', N'NXB01','Sakurai Umi', N'Tiểu thuyết'),
	('MS04', N'Vợ chồng A Phủ', 'NXB05', N'Tô Hoài', N'SGK'),
	('MS05', N'Ngôi nhà ấm áp', 'NXB01', N'Nhiều tác giả', N'Khác'),
	('MS06', N'Tuổi thơ dữ dội', 'NXB01', N'Phùng Quán', N'Tiểu thuyết'),
	('MS07', N'Tình khúc mưa thơ', 'NXB02', N'Lê Thị Phù Sa', N'Tiểu thuyết'),
	('MS08', N'Chưa kịp lớn', 'NXB04', N'Tớ là Mây', N'Tiểu thuyết'),
	('MS09', N'Qua những miền yêu', 'NXB02', N'Nhiều tác giả', N'Sách tham khảo'),
	('MS10', N'Tuổi trẻ đáng giá bao nhiêu', 'NXB01', N'Rosie Nguyễn', N'Tiểu thuyết'),
	('MS11', N'Cho tôi xin một vé đi tuổi thơ', 'NXB04', N'Nguyễn Nhật Ánh', N'Sách tham khảo'),
	('MS12', N'Cô gái đến từ hôm qua', 'NXB05', N'Nguyễn Nhật Ánh', N'Sách tham khảo'),
	('MS13', N'Vợ nhặt', 'NXB02', N'Kim Lân', N'SGK'),
	('MS14', N'Trên đường băng', 'NXB04', N'Tony Buổi Sáng', N'Sách tham khảo'),
	('MS15', N'Chiếc thuyền ngoài xa', 'NXB01', N'Nguyễn Minh Châu', N'SGK');
SELECT * FROM tblSach

-- 4. Chèn 8 bản ghi vào tblHoaDon
INSERT INTO tblHoaDon 
	(sMaHD, sMaNV, dNgayLap)
VALUES 
	('HD001', 'NV05', '2021-03-24'),
	('HD002', 'NV07', '2022-12-28'),
	('HD003', 'NV01', '2021-09-16'),
	('HD004', 'NV08', '2021-07-20'),
	('HD005', 'NV09', '2022-11-30'),
	('HD006', 'NV10', '2022-03-19'),
	('HD007', 'NV09', '2021-12-09'),
	('HD008', 'NV02', '2022-01-04');
SELECT * FROM tblHoaDon

-- 5. Chèn các bản ghi vào bảng tblChiTietHD (chèn cho 5 hóa đơn)
INSERT INTO tblChiTietHD
VALUES 
	('HD001', 'MS03', 20, 25.705),
	('HD002', 'MS05', 28, 39.358),
	('HD003', 'MS01', 9, 15.594),
	('HD004', 'MS08', 7, 30.259),
	('HD005', 'MS10', 15, 24.506);
SELECT * FROM tblChiTietHD

-- 6. Sửa giá bán của các quyển sách do NXB Kim Đồng giảm đi 10%
UPDATE tblChiTietHD
SET fDGban = fDGban - fDGban * 0.1
FROM tblNXB, tblSach
WHERE sTenNXB = N'Kim Đồng'
	AND tblChiTietHD.sMasach = tblSach.sMasach
	AND tblSach.sMaNXB = tblNXB.sMaNXB

-- 7. Bổ sung thêm thuộc tính fTyleGiamGia vào tblChiTietHD
ALTER TABLE tblChiTietHD
ADD fTyleGiamGia float

-- 8. Bổ sung thêm thuộc tính fTongSoTien vào tblHoaDon
ALTER TABLE tblHoaDon
ADD fTongSoTien float

-- 9. Sửa số lượng sách đã mua với hóa đơn 'HD001' giảm đi 1
UPDATE tblChiTietHD
SET iSL = iSL - 1
WHERE sMaHD = 'HD001'

-- 10. Xóa chi tiết hóa đơn của 'HD002'
DELETE FROM tblChiTietHD
WHERE sMaHD = 'HD002'

-- 11. Tăng phụ cấp của nhân viên thêm gấp 2 đối với các nhân viên của bộ phận "Tài vụ"
UPDATE tblNhanVien
SET fPC = fPC * 2
FROM tblBoPhan
WHERE sTenbophan = N'Tài vụ'
	AND tblNhanVien.sMabophan = tblBoPhan.sMabophan

-- Thực hành buổi 3
-- Viết câu lệnh truy vấn
-- 1. Cho danh sách các nhân viên nam có chức vụ nào đó (SV tự xác định điều kiện)
SELECT *
FROM tblNhanVien
WHERE bGioitinh = 0 AND sTenchucvu = N'Nhân viên';

-- 2. Cho danh sách các nhân viên nữ có hệ số lương trong một khoảng xác định
SELECT *
FROM tblNhanVien
WHERE bGioitinh = 1 AND (fHSL BETWEEN 2.8 AND 6);

-- 3. Cho danh sách tên sách, tên tác giả của các quyển sách được mua của hóa đơn có mã "HD001"
SELECT * FROM tblChiTietHD
SELECT * FROM tblHoaDon
SELECT * FROM tblSach
-- Cach 1
SELECT sTensach, sTacgia
FROM tblSach S INNER JOIN tblChiTietHD C
ON S.sMasach = C.sMasach
WHERE sMaHD = 'HD001'
-- Cach 2
SELECT sTensach, sTacgia
FROM tblSach S, tblChiTietHD C
WHERE sMaHD = 'HD001' AND S.sMasach = C.sMasach

-- 4. Cho danh sách tên sách, tên tác giả, tên NXB của các quyển sách thuộc NXB Kim Đồng
SELECT sTensach, sTacgia, sTenNXB
FROM tblSach, tblNXB
WHERE  sTenNXB = N'Kim Đồng'
	 AND tblSach.sMaNXB = tblNXB.sMaNXB

-- 5. Cho danh sách tên các quyển sách được mua năm nào đó 
SELECT sTensach
FROM tblSach S, tblHoaDon H, tblChiTietHD C
WHERE S.sMasach = C.sMasach
AND	  C.sMaHD = H.sMaHD 
AND   year(dNgayLap) = 2022;

-- 6. Cho danh sách tên các nhân viên đã bán hàng trong một năm nào đó 
SELECT sTenNV
FROM tblNhanVien
WHERE sMaNV IN 
		(SELECT sMaNV
		 FROM tblHoaDon
		 WHERE year(dNgayLap) = 2022);

-- 7. Cho biết tên sách có giá bán cao nhất
SELECT sTensach
FROM tblSach, tblChiTietHD
WHERE tblSach.sMasach = tblChiTietHD.sMasach
	AND fDGban = (SELECT MAX(fDGban) as Max
				  FROM tblChiTietHD);
	
-- Tạo các view 
-- 8. Thống kê số lượng đầu sách của từng NXB (Mã NXB, Tên NXB, Tổng SL) <-> vvTKNhaXuatBan_MSV
create view vvTKNhaXuatBan_MSV as 
	select tblNXB.sMaNXB, sTenNXB, iSL
	from tblNXB, tblSach, tblChiTietHD, tblHoaDon
	where tblNXB.sMaNXB = tblSach.sMaNXB
	and tblSach.sMasach = tblChiTietHD.sMasach
	and tblChiTietHD.sMaHD = tblHoaDon.sMaHD

select * from vvTKNhaXuatBan_MSV

-- 9. Thống kê đầu sách từng thể loại (Mã Thể Loại, tên thể loại, tổng đầu sách) <-> vvTKTheLoai_MSV
create view vvTKTheLoai_MSV as
	select tblSach.sMasach, sTheloai, iSL
	from tblSach, tblChiTietHD, tblHoaDon
	where tblSach.sMasach = tblChiTietHD.sMasach
	and tblChiTietHD.sMaHD = tblHoaDon.sMaHD

select * from vvTKTheLoai_MSV

-- 10. Thống kê tổng tiền của từng hóa đơn (mã hóa đơn, tổng số tiền) <-> vvTKHoaDon_MSV
create view vvTKHoaDon_MSV as 
	select sMaHD, iSL*fDGban as SUM
	from tblChiTietHD

select * from vvTKHoaDon_MSV

-- 11. Thống kê số tiền đã bán của từng đầu sách <-> vvTKSach_TongTien_MSV
create view vvTKSach_TongTien_MSV as
	select tblChiTietHD.sMasach, sTensach, iSL*fDGban as SUM
	from tblSach, tblChiTietHD, tblHoaDon 
	where tblSach.sMasach = tblChiTietHD.sMasach
	and tblChiTietHD.sMaHD = tblHoaDon.sMaHD

select * from vvTKSach_TongTien_MSV

-- 12. Thống kê doanh thu bán hàng theo từng tháng, từng năm <-> vvTKThang_Nam_MSV
create view vvTKThang_Nam_MSV as
	select month(dNgayLap) as Thang, year(dNgayLap) as Nam, sum(iSL*fDGban) as DoanhThu
	from tblChiTietHD C, tblHoaDon H
	where H.sMaHD = C.sMaHD
	group by month(dNgayLap), year(dNgayLap)

select * from vvTKThang_Nam_MSV

-- Doanh thu từng năm	
create view vTungNam as
	select year(dNgayLap) as Nam, sum(iSL*fDGban) as DoanhThu
	from tblChiTietHD C, tblHoaDon H
	where H.sMaHD = C.sMaHD
	group by year(dNgayLap)

select * from vTungNam

-- Doanh thu từng tháng trong năm 2021
create view vThang_Nam2021 as
	select month(dNgayLap) as Thang, sum(iSL*fDGban) as DoanhThu
	from tblChiTietHD C, tblHoaDon H
	where H.sMaHD = C.sMaHD
	and year(dNgayLap) = 2021
	group by month(dNgayLap)

select * from vThang_Nam2021

-- 13. Cho biết tên đầu sách đã bán được > 20tr trong năm 2022 <-> vvTK2022_20tr_MSV
create view vvTK2022_20tr_MSV as
	select sTensach
	from tblSach, tblChiTietHD, tblHoaDon
	where tblSach.sMasach = tblChiTietHD.sMasach
	and tblHoaDon.sMaHD = tblChiTietHD.sMaHD
	and (iSL*fDGban) > 20
	and year(dNgayLap) = 2022;

select * from vvTK2022_20tr_MSV

-- 14. Cho biết tên sách đã bán được nhiều nhất <-> vvTenSach_Max_MSV
alter view vvTenSach_Max_MSV as
	select sTensach
	from tblSach, tblChiTietHD
	where tblSach.sMasach= tblChiTietHD.sMasach
	and iSL = (select MAX(iSL)
			   from tblChiTietHD)

select * from vvTenSach_Max_MSV 


-- Thực hành buổi 4 (Thủ tục - PROC)
-- 1. Tạo thủ tục chèn thêm một Quyển sách mới (kiểm tra điều kiện thỏa mãn)
CREATE PROC Sach_moi 
	(@sMasach varchar(10),
	 @sTensach nvarchar(50),
	 @sMaNXB varchar(10),
	 @sTacgia nvarchar(50),
	 @sTheloai nvarchar(50))
AS 
BEGIN
	INSERT INTO tblSach
	values (@sMasach, @sTensach, @sMaNXB, @sTacgia, @sTheloai)
END;

EXEC Sach_moi @sMasach = 'MS16', @sTensach = N'Lão Hạc', @sMaNXB = 'NXB01', @sTacgia = N'Nam Cao', @sTheloai = 'SGK'
select * from tblSach

-- 2. Tạo thủ tục chèn thêm một Nhân viên mới (kiểm tra điều kiện thỏa mãn)
CREATE PROC Nhan_vien_moi
	(@sMaNV varchar(10),
	 @sTenNV nvarchar(50),
	 @bGioitinh bit,
	 @sQuequan nvarchar(50),
	 @sDiachi nvarchar(50),
	 @sSDT char(10),
	 @fHSL float,
	 @fPC float,
	 @sMabophan varchar(10),
	 @sTenchucvu nvarchar(50),
	 @dNgayvaolam date)
as
begin
	insert into tblNhanVien
	values (@sMaNV, @sTenNV, @bGioitinh, @sQuequan, @sDiachi, @sSDT, @fHSL, @fPC, @sMabophan, @sTenchucvu, @dNgayvaolam)
end;

exec Nhan_vien_moi @sMaNV = 'NV11',  @sTenNV = N'Nguyễn Thu Hương', @bGioitinh = 1, @sQuequan = N'Hưng Yên', @sDiachi = N'Thanh Xuân, Hà Nội', @sSDT = '0932451387', @fHSL = 3.252, @fPC = 300, @sMabophan = 'MBP03', @sTenchucvu = N'Nhân viên', @dNgayvaolam = '2019-03-20'

select * from tblNhanVien

-- 3. Tạo thủ tục chèn thêm một Chi tiết hóa đơn mới (kiểm tra điều kiện thỏa mãn)
create proc Chi_tiet_hoa_don_moi
	(@sMaHD varchar(10),
	 @sMasach varchar(10),
	 @iSL int,
	 @fDGban float,
	 @fTyleGiamGia float)
as
begin
	insert into tblChiTietHD
	values (@sMaHD, @sMasach, @iSL, @fDGban, @fTyleGiamGia)
end;

exec Chi_tiet_hoa_don_moi @sMaHD = 'HD006', @sMasach = 'MS07', @iSL = 22, @fDGban = 20.349, @fTyleGiamGia = 0.2

select * from tblChiTietHD

-- 4. Tạo thủ tục cho danh sách tên các quyển sách của một nhà xuất bản nào đó theo Tên nhà xuất bản.
create proc Ds_ten_sach @sTenNXB nvarchar(50)
as
begin
	select sTensach
	from tblSach S, tblNXB N
	where S.sMaNXB = N.sMaNXB
	and sTenNXB = @sTenNXB
end;

exec Ds_ten_sach N'Kim Đồng'

-- 5. Tạo thủ tục cho danh sách các quyển sách được bán trong năm nào đó, với năm là tham số truyền vào.
create proc Ds_sach_da_ban @year char(4)
as
begin
	select sTensach
	from tblSach S, tblHoaDon H, tblChiTietHD C
	where S.sMasach = C.sMasach
	and H.sMaHD = C.sMaHD
	and year(dNgayLap) = @year
end;

exec Ds_sach_da_ban 2022

-- 6. Tạo thủ tục cho danh sách các quyển sách không bán được trong năm nào đó, với năm là tham số truyền vào.
create proc Ds_sach_khong_ban_duoc @year char(4)
as
begin
	select sTensach
	from tblSach S, tblHoaDon H, tblChiTietHD C
	where S.sMasach = C.sMasach
	and H.sMaHD = C.sMaHD
	and year(dNgayLap) != @year
end;

exec Ds_sach_khong_ban_duoc 2022

-- 7. Tạo thủ tục thực hiện tăng lương lên gấp rưỡi cho các nhân viên đã bán hàng với tổng số lượng sách nhiều hơn số lượng hàng được truyền vào, số lượng hàng là tham số truyền vào.
CREATE PROC Tang_luong @SoLuong int
as
begin
	update tblNhanVien
	set fHSL = fHSL * 1.5
	where tblNhanVien.sMaNV IN
		(select tblNhanVien.sMaNV
		 from tblNhanVien, tblHoaDon, tblChiTietHD
		 where tblHoaDon.sMaNV = tblNhanVien.sMaNV 
		 and tblChiTietHD.sMaHD = tblHoaDon.sMaHD 
		 group by tblNhanVien.sMaNV
		 having SUM(tblChiTietHD.iSL) > @SoLuong)
end;

exec Tang_luong 1

-- 8. Tạo thủ tục cho biết tên các thông tin gồm: tên sách, số lượng, đơn giá, thành tiền của các quyển sách trong một hóa đơn nào đó theo mã hóa đơn.
create proc Sach_theo_maHD @sMaHD varchar(10)
as
begin
	select S.sTensach, C.iSL, C.fDGban, sum(iSL*fDGban) as fTongSoTien
	from tblSach S, tblHoaDon H, tblChiTietHD C
	where S.sMasach = C.sMasach
	and H.sMaHD = C.sMaHD
	and C.sMaHD = @sMaHD
	group by sTensach, iSL, fDGban, fTongSoTien
end;
exec Sach_theo_maHD 'HD003'

-- 9. Tạo thủ tục cho biết tên các nhân viên đã bán hàng trong một tháng - một năm nào đó.
create proc Nhan_vien_ban_hang @dNgayLap date
as
begin
	select sTenNV
	from tblNhanVien, tblHoaDon
	where tblNhanVien.sMaNV = tblHoaDon.sMaNV
	and dNgayLap = @dNgayLap
end;
exec Nhan_vien_ban_hang '2021-07-20'

-- 10. Tạo thủ tục cho biết tên, tổng số lượng đã bán, tổng tiền đã bán của các mặt sách trong một năm nào đó.
create proc SP_da_ban @year char(4)
as
begin
	select sTensach, iSL, sum(iSL*fDGban) as fTongSoTien
	from tblSach S, tblChiTietHD C, tblHoaDon H
	where S.sMasach = C.sMasach
	and H.sMaHD = C.sMaHD
	and year(dNgayLap) = @year
	group by sTensach, iSL, fTongSoTien
end;
exec SP_da_ban 2021

-- Thực hành buổi 5 (Trigger)
-- 1. Thêm cột iTSSach (mặc định = 0) vào bảng tblNXB; Thực hiện cập nhật giá trị cho cột iTSSach của các NXB đã có trong dữ liệu
alter table tblNXB
add iTSSach int default 0;

-- 2. Tạo trigger mỗi khi thêm một quyển sách mới thì tổng số sách (iTSSach) của NXB tăng lên tương ứng
create trigger trg_capnhat
on tblSach
for insert 
as
begin
	declare @manxb varchar(10)
	select @manxb = sMaNXB 
	from inserted
	if exists  (select * 
				from tblNXB 
				where sMaNXB = @manxb)
		begin 
			update tblNXB set iTSSach = iTSSach + 1
			where sMaNXB = @manxb
		end;
	else 
		begin
		raiserror('Ma NXB %s chua ton tai', 16, 10, @manxb)
		ROLLBACK TRANSACTION 
		end;
end;
Insert into tblSach
values ('MS20', N'Tuổi trẻ', 'NXB03', N'Phùng Văn Quán', N'Khác', 0)

select * from tblNXB
/* 3. Thêm cột iTSDaBan (mặc định = 0) vào bảng tblSach
	  Thêm cột fTongTienHangBan (float, mặc định = 0) vào bảng tblNhanVien
	  Thêm cột fTongTienHang (float, mặc định = 0) vào bảng tblHoaDon
	  Thực hiện cập nhật cho các cột iTSDaBan, fTongTienHangBan, fTongTienHang của các bảng tương ứng với các dữ liệu đã có */
alter table tblSach
add iTSDaBan int default 0;
alter table tblNhanVien
add fTongTienHangBan float default 0;
alter table tblHoaDon
add fTongTienHang float default 0;

-- 4. Tạo Trigger sao cho mỗi khi thêm một dòng mới trong tblChiTietHD thì các giá trị iTSDaBan trong tblSach, giá trị fTongTienHangBan trong tblNhanVien, giá trị fTongTienHang trong tblHoaDon được tăng thêm t/ứ (theo ngtac = gtri cũ + iSL * fDGBan)
create trigger trg_CTHD
on tblChiTietHD
for insert
as
begin
	declare @masach varchar(10)
	declare @manv varchar(10)
	declare @mahd varchar(10)
	select @masach = sMasach, @manv = sMaNV, @mahd = sMaHD
	from inserted
	if exists  (select * 
				from tblChiTietHD 
				where sMaHD = @mahd)
		begin 
			update tblSach 
			set iTSDaBan = iTSDaBan + iSL
			where sMasach = @masach
			update tblNhanVien 
			set fTongTienHangBan = fTongTienHangBan + iSL * fDGban
			where sMaNV = @manv
			update tblHoaDon
			set fTongTienHang = fTongTienHang + iSL * fDGban
			where sMaHD = @mahd
		end;
	else 
		begin
			raiserror('Ma sach %s chua ton tai', 16, 10, @masach)
			raiserror('Ma NV %s chua ton tai', 16, 10, @manv)
			raiserror('Ma HD %s chua ton tai', 16, 10, @mahd)
			ROLLBACK TRANSACTION 
		end;
end;

select * from tblChiTietHD

-- 5. Tạo Trigger khi chỉnh sửa NXB của 1 quyển sách nào đó thì iTSSach của NXB được điều chỉnh t/ứ
create trigger trg_chinhsua
on tblSach
for update
as
begin
	if update(sMaNXB)
	begin
		declare @manxbcu varchar(10) = (select sMaNXB 
										from deleted)
		declare @manxbmoi varchar(10) = (select sMaNXB 
										 from inserted)
		update tblNXB 
		set iTSSach = iTSSach - 1 
		where @manxbcu = sMaNXB
		update tblNXB 
		set iTSSach = iTSSach + 1 
		where @manxbmoi = sMaNXB
	end
end;

select * from tblSach
select * from tblNXB

update tblSach
set sMaNXB = 'NXB04'
where sMasach = 'MS05'

/* 6. Tạo Trigger sao cho mỗi khi xóa 1 dòng mới trong tblChiTietHD thì các gtri iTSDaBan trong tblSach, gtri fTongTienHangBan trong tblNV, gtri fTongTienHang trong tblHD đc điều chỉnh t/ứ
create trigger trg_xoa
on tblChiTietHD
for delete
as
begin
	update tblSach
	set iTSDaBan = iTSDaBan + (SELECT iSL FROM deleted WHERE sMasach = tblSach.sMasach)
	from tblSach
	JOIN deleted ON tblSach.sMasach = deleted.sMasach */

-- Thuc hanh buoi 7 (Phan quyen, phan tan)
-- 1. Tao nhom nguoi dung "Quan tri" (Login)
Create login Capnhat
With password = 'hien123'  

Create User QuanTri For Login Capnhat
Grant insert, update, delete to Capnhat

-- 9. Tao view lay thong tin day du cua tat ca cac nha xuat ban
create view tblNXB