﻿Create database Lab04_QLDB
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
(N'TT01', 123, '15/12/2005'),
(N'KT01', 70,  '15/12/2005'),
(N'TT01', 124, '16/12/2005'),
(N'TN01', 256, '17/12/2005'),
(N'PN01', 45,  '23/12/2005'),
(N'PN02', 111, '18/12/2005'),
(N'PN02', 112, '19/12/2005'),
(N'TT01', 125, '17/12/2005'),
(N'PN01', 46,  '30/12/2005');
go
-----Nhập bảng khách hàng
insert into KHACHHANG values
(N'KH01', N'LAN', N'2 NCT'),
(N'KH02', N'NAM', N'32 THĐ'),
(N'KH03', N'NGỌC', N'16 LHP')
go
-----Nhập bảng đặt báo
insert into DATBAO values
(N'KH01', N'TT01', 100, '12/01/2000'),
(N'KH02', N'TN01', 150, '01/05/2001'),
(N'KH01', N'PN01', 200, '25/06/2001'),
(N'KH03', N'KT01', 50,  '17/03/2002'),
(N'KH03', N'PN02', 200, '26/08/2003'),
(N'KH02', N'TT01', 250, '15/01/2004'),
(N'KH01', N'KT01', 300, '14/10/2004')
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

--7) Cho biết số khách hàng đặt mua báo trong năm 2004.\
SELECT COUNT(DISTINCT MaKH) AS SoKH
FROM DATBAO
WHERE YEAR(NgayDM) = 2004;
--8) Cho biết thông tin đặt mua báo của các khách hàng (TenKH, TeN, DinhKy, SLMua, SoTien), trong đó SoTien = SLMua x DonGia.
SELECT KH.TenKH, B.Ten, B.DinhKy, DB.SLMua,
       DB.SLMua * B.GiaBan AS SoTien
FROM DATBAO DB
JOIN KHACHHANG KH ON DB.MaKH = KH.MaKH
JOIN BAO_TCHI B ON DB.MaBaoTC = B.MaBaoTC;
--9) Cho biết các tờ báo, tạp chí (Ten, DinhKy) và tổng số lượng đặt mua của các khách hàng đối với tờ báo, tạp chí đó.
SELECT KH.TenKH, B.Ten, B.DinhKy, DB.SLMua, DB.SLMua * B.GiaBan AS SoTien
FROM KHACHHANG KH, BAO_TCHI B, DATBAO DB
WHERE KH.MaKH = DB.MaKH AND B.MaBaoTC = DB.MaBaoTC;
--10) Cho biết tên các tờ báo dành cho học sinh, sinh viên (mã báo tạp chí bắt đầu bằng HS).
SELECT Ten
FROM BAO_TCHI
WHERE MaBaoTC LIKE 'HS%';
--11) Cho biết những tờ báo không có người đặt mua.
SELECT Ten
FROM BAO_TCHI
WHERE MaBaoTC NOT IN (
    SELECT MaBaoTC
    FROM DATBAO
)
--12) Cho biết tên, định kỳ của những tờ báo có nhiều người đặt mua nhất.
SELECT Ten, DinhKy
FROM BAO_TCHI
WHERE MaBaoTC IN (
    SELECT MaBaoTC
    FROM DATBAO
    GROUP BY MaBaoTC
    HAVING COUNT(DISTINCT MaKH) = (
        SELECT MAX(SoNguoi)
        FROM (
            SELECT COUNT(DISTINCT MaKH) AS SoNguoi
            FROM DATBAO
            GROUP BY MaBaoTC
        ) AS TimMax
    )
)
--13) Cho biết khách hàng đặt mua nhiều báo, tạp chí nhất.
SELECT TenKH
FROM KHACHHANG
WHERE MaKH IN (
    SELECT MaKH
    FROM DATBAO
    GROUP BY MaKH
    HAVING COUNT(DISTINCT MaBaoTC) = (
        SELECT MAX(SoBao)
        FROM (
            SELECT COUNT(DISTINCT MaBaoTC) AS SoBao
            FROM DATBAO
            GROUP BY MaKH
        ) AS TimMax
    )
)
--14) Cho biết các tờ báo phát hành định kỳ một tháng 2 lần.
SELECT * 
FROM BAO_TCHI 
WHERE DinhKy = N'Bán nguyệt san'
--15) Cho biết các tờ báo, tạp chi có từ 3 khách hàng đặt mua trở lên.
SELECT Ten
FROM BAO_TCHI
WHERE MaBaoTC IN (
    SELECT MaBaoTC
    FROM DATBAO
    GROUP BY MaBaoTC
    HAVING COUNT(DISTINCT MaKH) >= 3
)