-- 1. Tạo CSDL (fTongTienDaNop, iSoThangDaNop mặc định = 0)
create database QUANLYPHICHUNGCHU
use QUANLYPHICHUNGCHU
go
create table tblCuDan
(
	sMaCuDan varchar(10) primary key,
	sTenCuDan nvarchar(50),
	sDienThoai char(10) UNIQUE,
	sTenPhong nvarchar(50),
	fDienTich float,
	fTongTienDaNop float default 0,
	iSoThangDaNop int default 0
)
go
create table tblDichVu
(
	sMaDichVu varchar(10) primary key,
	sTenDichVu nvarchar(50),
	sDonViTinh varchar(10),
	fDonGia float
)
go
create table tblHoaDon
(
	sSoHoaDon varchar(10) primary key,
	dNgayLap date,
	iThang int,
	iNam int,
	sMaCuDan varchar(10)
)
alter table tblHoaDon
add constraint FK_cudan_hd foreign key(sMaCuDan) references tblCuDan(sMaCuDan)
go
create table tblChiTietHoaDon
(
	sSoHoaDon varchar(10) references tblHoaDon(sSoHoaDon),
	sMaDichVu varchar(10) references tblDichVu(sMaDichVu),
	iSoLuong int,
	primary key(sSoHoaDon, sMaDichVu)
)
go
-- 2. Tạo trigger sao cho mỗi khi chèn thêm 1 hóa đơn mới thì Tổng số tháng đã nộp iSoThangDaNop phí của từng cư dân tăng lên tương ứng
create trigger trg_insert_hd
on tblHoaDon
for insert
as
begin
	declare @MaCD varchar(10)
	select @MaCD = sMaCuDan
	from inserted
	if exists (select * 
			   from tblCuDan 
			   where sMaCuDan = @MaCD)
		begin 
			update tblCuDan set iSoThangDaNop = iSoThangDaNop + 1
			where sMaCuDan = @MaCD
		end;
	else
		begin
		RAISERROR('Ma cu dan %s khong ton tai', 16, 10, @MaCD)
		ROLLBACK TRANSACTION 
		end;
end;

insert into tblHoaDon
values ('HD010', '2021-07-22', 8, 2021, 'CD001')

select * from tblCuDan

-- 3. Tạo trigger sao cho mỗi khi chèn 1 chi tiết hóa đơn mới thì tổng tiền đã nộp của từng cư dân fTongTienDaNop của cư dân tăng lên tương ứng với số lượng dịch vụ mà cư dân sử dụng
alter trigger trg_insert_cthd
on tblChiTietHoaDon
for insert, update
as
begin
	declare @soL int
	select @soL = iSoLuong from inserted
	declare @sohd varchar(10)
	select @sohd = sSoHoaDon from inserted
	declare @madv varchar(10)
	select @madv = sMaDichVu from inserted
	if exists(select * from tblChiTietHoaDon where sSoHoaDon = @sohd)
		begin
			update tblCuDan set fTongTienDaNop = fTongTienDaNop + (@soL * fDonGia)
			from tblDichVu,tblHoaDon
			where tblCuDan.sMaCuDan = tblHoaDon.sMaCuDan and tblHoaDon.sSoHoaDon = @sohd and tblDichVu.sMaDichVu = @madv
		end
	else
		begin
			raiserror('So hoa don %s khong ton tai', 16, 10, @sohd)
			rollback tran
		end;
end;

insert into tblHoaDon
values
	('HD014', '2022-05-21', 5, 2022, 'CD005')

insert into tblChiTietHoaDon
values
	('HD013', 'DV001', 10),
	('HD014', 'DV003', 14)

select * from tblCuDan
insert into tblHoaDon
values 
	('HD020', '2022-11-25', 11, 2022, 'CD005')

insert into tblChiTietHoaDon
values
	('HD020', 'DV004', 10)
-- 4. Chèn ít nhất 2 dòng vào tblDichVu, tblCuDan và tblHoaDon
--	  Chèn một số dòng vào bảng tblChiTietHoaDon
insert into tblDichVu
values 
	('DV003', N'Chăm sóc khách hàng', 'VND', 258.912),
	('DV004', N'Vệ sinh', 'VND', 105.048);
select * from tblDichVu

insert into tblCuDan
values
	('CD004', N'Nguyễn Đình Tuấn', '0323267428', N'Phòng 102', 32.055, 0, 0),
	('CD006', N'Nguyễn Thu Huyền', '0245466492', N'Phòng 206', 31.333, 0, 0)
select * from tblCuDan

insert into tblHoaDon
values 
	('HD011', '2021-10-15', 10, 2021, 'CD001'),
	('HD012', '2022-05-28', 06, 2022, 'CD004')
select * from tblHoaDon

insert into tblChiTietHoaDon
values
	('HD011', 'DV003', 5),
	('HD012', 'DV002', 7)
select * from tblChiTietHoaDon

-- 5. Tạo thủ tục cho danh sách tên các cư dân đã nộp phí của 1 tháng - 1 năm nào đó
alter proc Cu_dan_da_nop_phi @month int, @year int
as
begin
	select sTenCuDan
	from tblCuDan, tblHoaDon
	where tblCuDan.sMaCuDan = tblHoaDon.sMaCuDan
	and iThang = @month
	and iNam = @year
end;

exec Cu_dan_da_nop_phi @month = 03, @year = 2021;

-- 6. Tạo view cho biết tên của cư dân chưa nộp phí của tháng hiện tại
alter view vvCu_dan_chua_nop_phi as
	select sTenCuDan
	from tblCuDan
	where sMaCuDan NOT IN (select sMaCuDan 
						   from tblHoaDon 
						   where iThang = month(GETDATE()));

select * from vvCu_dan_chua_nop_phi

select * from tblDichVu
select * from tblCuDan
select * from tblHoaDon
select * from tblChiTietHoaDon