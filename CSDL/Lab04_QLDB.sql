Create database Lab04_QLDB
go
use Lab04_QLDB
go
----------------------Tạo bảng---------------------------
-----Tạo bảng báo tạp chí
create table BAO_TCHI
(
MaBaoTC char(4) primary key,
Ten nvarchar(50) not null,
DinhKy nvarchar(50) not null,
SoLuong smallint check(SoLuong > 0),
GiaBan int check(GiaBan >0)
)
go
-----Tạo bảng phát thanh
create table PHATTHANH
(
MaBaoTC char(4) references Bao_TCHI(MaBaoTC),
SoBaoTC smallint check(SoBaoTC>0),
NgayPH datetime not null,
primary key(MaBaoTC,SoBaoTC,NgayPH)
)
go
------Tạo bảng khách hàng
create table KHACHHANG
(
MAKH varchar(7) primary key,
TenKH nvarchar(8) not null,
DiaChi nvarchar(40) not null
)
go
------Tạo bảng đặt báo
create table DATBAO
(
MAKH varchar(7) references KHACHHANG(MAKH),
MaBaoTC char(4) references Bao_TCHI(MaBaoTC),
SLMua smallint check(SLMua >0),
NgayDM datetime not null,
primary key (MAKH,MaBaoTC,NgayDM)
)
go
----------------Hiển thị thông tin-----------------
SELECT * from BAO_TCHI
SELECT * from PHATTHANH
SELECT * from KHACHHANG
SELECT * from DATBAO
-----------------Nhập Dữ Liệu--------------------
set dateformat dmy
-----Nhập bảng Báo tạp chí
insert into BAO_TCHI values
(N'TT01', N'Tuổi trẻ', N'Nhật báo', 1000, 1500),
(N'KT01', N'Kiến thức ngày nay', N'Bán nguyệt san', 3000, 6000),
(N'TN01', N'Thanh niên', N'Nhật báo', 1000, 2000),
(N'PN01', N'Phụ nữ', N'Tuần báo', 2000, 4000),
(N'PN02', N'Phụ nữ', N'Nhật báo', 1000, 2000)
go
-----Nhập bảng Phát thanh
insert into PHATTHANH values
(N'TT01', 123, '2005-12-15'),
(N'KT01', 70,  '2005-12-15'),
(N'TT01', 124, '2005-12-16'),
(N'TN01', 256, '2005-12-17'),
(N'PN01', 45,  '2005-12-23'),
(N'PN02', 111, '2005-12-18'),
(N'PN02', 112, '2005-12-19'),
('TT01', 125, '2005-12-17'),
('PN01', 46,  '2005-12-30')
go
-----Nhập bảng khách hàng
insert into KHACHHANG values
(N'KH01', N'LAN', N'2 NCT'),
(N'KH02', N'NAM', N'32 THĐ'),
(N'KH03', N'NGỌC', N'16 LHP')
go
-----Nhập bảng đặt báo
insert into DATBAO values
(N'KH01', N'TT01', 100, '2000-01-12'),
(N'KH02', N'TN01', 150, '2001-05-01'),
(N'KH01', N'PN01', 200, '2001-06-25'),
(N'KH03', N'KT01', 50,  '2002-03-17'),
(N'KH03', N'PN02', 200, '2003-08-26'),
(N'KH02', N'TT01', 250, '2004-01-15'),
(N'KH01', N'KT01', 300, '2004-10-14')
go

--delete from DATBAO
--delete from KHACHHANG
--delete from PHATTHANH
--delete from BAO_TCHI

--1) Cho biết các tờ báo, tạp chí (MABAOTC, TEN, GIABAN) có định kỳ phát hành hàng tuần (Tuần báo). 
SELECT MaBaoTC, Ten, GiaBan
FROM BAO_TCHI
WHERE DinhKy = N'Tuần báo'
--2) Cho biết thông tin về các tờ báo thuộc loại báo phụ nữ (mã báo tạp chí bắt đầu bằng PN).
SELECT MaBaoTC, Ten, DinhKy, SoLuong, GiaBan
FROM BAO_TCHI
WHERE MaBaoTC LIKE 'PN%'
--3) Cho biết tên các khách hàng có đặt mua báo phụ nữ (mã báo tạp chí bắt đầu bằng PN), không liệt kê khách hàng trùng.
SELECT DISTINCT B.TenKH
FROM DATBAO A, KHACHHANG B
WHERE A.MAKH = B.MAKH 
  AND A.MaBaoTC LIKE 'PN%'
ORDER BY B.TenKH
--4) Cho biết tên các khách hàng có đặt mua tất cả các báo phụ nữ (mã báo tạp chí bắt đầu bằng PN).
SELECT B.TenKH
FROM KHACHHANG B, DATBAO A
WHERE B.MAKH = A.MAKH 
  AND A.MaBaoTC LIKE 'PN%'
GROUP BY B.MAKH, B.TenKH
HAVING COUNT(DISTINCT A.MaBaoTC) = (
    SELECT COUNT(*)
    FROM BAO_TCHI
    WHERE MaBaoTC LIKE 'PN%'
)
--5) Cho biết các khách hàng không đặt mua báo thanh niên.
SELECT MAKH, TenKH
FROM KHACHHANG A
WHERE NOT EXISTS (
    SELECT 1
    FROM DATBAO B
    WHERE B.MAKH = A.MAKH 
      AND B.MaBaoTC = 'TN01'
)
--6) Cho biết số tờ báo mà mỗi khách hàng đã đặt mua.
SELECT A.MAKH, A.TenKH, COUNT(B.MaBaoTC) as SoBaoDaDat
FROM KHACHHANG A, DATBAO B
WHERE A.MAKH = B.MAKH
GROUP BY A.MAKH, A.TenKH
ORDER BY SoBaoDaDat DESC
--7) Cho biết số khách hàng đặt mua báo trong năm 2004.
--8) Cho biết thông tin đặt mua báo của các khách hàng (TenKH, TeN, DinhKy, SLMua, SoTien), trong đó SoTien = SLMua x DonGia.
--9) Cho biết các tờ báo, tạp chí (Ten, DinhKy) và tổng số lượng đặt mua của các khách hàng đối với tờ báo, tạp chí đó.
--10) Cho biết tên các tờ báo dành cho học sinh, sinh viên (mã báo tạp chí bắt đầu bằng HS).
--11) Cho biết những tờ báo không có người đặt mua.
--12) Cho biết tên, định kỳ của những tờ báo có nhiều người đặt mua nhất.
--13) Cho biết khách hàng đặt mua nhiều báo, tạp chí nhất.
--14) Cho biết các tờ báo phát hành định kỳ một tháng 2 lần.
--15) Cho biết các tờ báo, tạp chi có từ 3 khách hàng đặt mua trở lên.