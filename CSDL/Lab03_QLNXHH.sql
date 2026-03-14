/*	HP: Cơ sở dữ liệu
	Lab03: Quản lý Sản xuất hàng hóa
	SV:	Ngô Quyền Linh
	Mã SV: 2411871
	Lớp: CTK48B
	Thời gian: 31/01/2026 - kết thúc
*/
create database Lab3_QLNXHH
go
use Lab3_QLNXHH
go
create table HANGHOA
(
MAHH varchar(5) primary key,
TENHH varchar(100) not null unique,
DVT nchar(3) not null,
SOLUONGTON tinyint check(SOLUONGTON >0)
)
go
create table DOITAC
(
MADT char(5) primary key,
TENDT nvarchar(100) not null unique,
DIACHI nvarchar(100) not null unique,
DIENTHOAI varchar(10) not null unique
)

go
create table HOADON
(
SOHD char(5) primary key,
NGAYLAPHD datetime not null,
MADT char(5) not null,
TONGTG int check(TONGTG >0)
)
create table KHANANGCC
(
MADT char(5) references DOITAC(MADT),
MAHH varchar(5) references HANGHOA(MAHH)
)
create table CT_HOADON
(
SOHD char(5) references HOADON(SOHD),
MAHH varchar(5) references HANGHOA(MAHH),
DONGIA tinyint check (DONGIA >0),
SOLUONG tinyint check (SOLUONG >0),
Primary Key(MAHH,SOHD)
)

go

delete from HANGHOA
delete from DOITAC
delete from HOADON
delete from KHANANGCC
delete from CT_HOADON
go
set dateformat dmy
go
-- 1. Chèn dữ liệu vào bảng HangHoa
INSERT INTO HangHoa (MAHH, TENHH, DVT, SOLUONGTON) VALUES
('CPU01', 'CPU INTEL,CELERON 600 BOX', N'CÁI', 5),
('CPU02', 'CPU INTEL,PIII 700', N'CÁI', 10),
('CPU03', 'CPU AMD K7 ATHL,ON 600', N'CÁI', 8),
('HDD01', 'HDD 10.2 GB QUANTUM', N'CÁI', 15),
('HDD02', 'HDD 13.6 GB SEAGATE', N'CÁI', 6),
('HDD03', 'HDD 20 GB QUANTUM', N'CÁI', 12),
('KB01', 'KB GENIUS', N'CÁI', 5),
('KB02', 'KB MITSUMI', N'CÁI', 10),
('MB01', 'GIGABYTE CHIPSET INTEL', N'CÁI', 10),
('MB02', 'ACOPR BX CHIPSET VIA', N'CÁI', 10),
('MB03', 'INTEL PHI CHIPSET INTEL', N'CÁI', 10),
('MB04', 'ECS CHIPSET SIS', N'CÁI', 10),
('MB05', 'ECS CHIPSET VIA', N'CÁI', 5),
('MNT01', 'SAMSUNG 14" SYNCMASTER', N'CÁI', 5),
('MNT02', 'LG 14"', N'CÁI', 8),
('MNT03', 'ACER 14"', N'CÁI', 6),
('MNT04', 'PHILIPS 14"', N'CÁI', 7),
('MNT05', 'VIEWSONIC 14"', N'CÁI', 7);

-- 2. Chèn dữ liệu vào bảng DoiTac
INSERT INTO DoiTac (MADT, TENDT, DIACHI, DIENTHOAI) VALUES
('CC001', N'Pty TNC', N'176 BTX Q1 - TPHCM', '088250259'),
('CC002', N'Pty Hoàng Long', N'15A TTT Q1 - TP. HCM', '088250898'),
('CC003', N'Pty Hợp Nhất', N'152 BTX Q1 - TP. HCM', '088252376'),
('K0001', N'Nguyễn Minh Hải', N'91 Nguyễn Văn Trỗi Tp. Đà Lạt', '063831129'),
('K0002', N'Như Quỳnh', N'21 Điện Biên Phủ, N.Trang', '058590270'),
('K0003', N'Trần nhật Duật', N'Lê Lợi TP. Huế', '054848376'),
('K0004', N'Phan Nguyễn Hùng Anh', N'11 Nam Kỳ Khởi nghĩa - TP. Đà lạt', '063823409');

-- 3. Chèn dữ liệu vào bảng KhaNangCC
INSERT INTO KhaNangCC (MADT,MAHH) VALUES
('CC001', 'CPU01'),
('CC001', 'HDD03'),
('CC001', 'KB01'),
('CC001', 'MB02'),
('CC001', 'MB04'),
('CC001', 'MNT01'),
('CC001', 'CPU01'),
('CC002', 'CPU02'),
('CC002', 'CPU03'),
('CC002', 'KB02'),
('CC002', 'MB01'),
('CC002', 'MB05'),
('CC002', 'MNT03'),
('CC003', 'HDD01'),
('CC003', 'HDD02'),
('CC003', 'HDD03'),
('CC003', 'MB03');

-- 4. Chèn dữ liệu vào bảng HoaDon
-- Lưu ý: TONGTG có thể NULL, ngày tháng được chuyển thành định dạng DATETIME hợp lệ
INSERT INTO HoaDon (SOHD, NGAYLAPHD, MADT, TONGTG) VALUES
('N0001', '25/01/2006', 'CC001', NULL),
('N0002', '01/05/2006', 'CC002', NULL),
('X0001', '12/05/2006', 'K0001', NULL),
('X0002', '16/06/2006', 'K0002', NULL),
('X0003', '20/04/2006', 'K0001', NULL);

-- 5. Chèn dữ liệu vào bảng CTHoaDon
INSERT INTO CT_HOADON(SOHD, MaHH, DONGIA, SOLUONG) VALUES
('N0001', 'CPU01', 63, 10),
('N0001', 'HDD03', 97, 7),
('N0001', 'KB01', 3, 5),
('N0002', 'MB02', 57, 5),
('N0001', 'MNT01', 112, 3),
('N0002', 'CPU02', 115, 3),
('N0002', 'KB02', 5, 7),
('N0002', 'MNT03', 111, 5),
('X0001', 'CPU01', 67, 2),
('X0001', 'HDD03', 100, 2),
('X0001', 'KB01', 5, 2),
('X0001', 'MB02', 62, 1),
('X0002', 'CPU01', 67, 1),
('X0002', 'KB02', 7, 3),
('X0002', 'MNT01', 115, 2),
('X0003', 'CPU01', 67, 1),
('X0003', 'MNT03', 115, 2);

select * from HANGHOA
select * from DOITAC
select * from HOADON
select * from KHANANGCC
select * from CT_HOADON



--1) liet ke cac mat hang thuoc loai dia cung
select *
from HANGHOA
where MAHH like 'HDD%'

--2) liet ke cac mat hang co so luong ton tren 10
select *
from HANGHOA
where SOLUONGTON > 10

--3) cho biet thong tin ve cac ncc o tpHCM
select *
from DOITAC
where DIACHI like '%TP. HCM'

--4) liet ke cac hoa don trong thang 5/2006 
select	B.SOHD, NGAYLAPHD, TENDT, DIACHI, DIENTHOAI, COUNT(distinct C.MAHH) as SoMatHang
from	DOITAC A, HOADON B, HANGHOA C, CT_HOADON D
where	MONTH(B.ngaylaphd) = 5 and YEAR(B.ngaylaphd) = 2006 and A.MADT = B.MADT  and D.MAHH = C.MAHH and D.SOHD = B.SOHD
group by B.SOHD, B.NGAYLAPHD, A.TENDT, A.DIACHI, A.DIENTHOAI

--5) cho biet ten cac ncc co cung cap dia cung
select distinct TENDT
from HANGHOA A, KHANANGCC B, DOITAC C
where A.MAHH like 'HDD%' and B.MADT = C.MADT and A.MAHH = B.MAHH

--6) cho biet ten cac ncc co the cung cap tat ca cac loai dia cung
select	TENDT
from	DOITAC A, KHANANGCC B, HANGHOA C
where	a.MADT = B.MADT and B.MAHH = C.MAHH and C.MAHH like 'HDD%'
group by A.TENDT, A.MADT
having	count(distinct C.MAHH) = (select count(*)
									from	HANGHOA
									where	MAHH like 'HDD%')

--7) cho biet ten NCC ko CC dia cung
SELECT TENDT
FROM DOITAC A
WHERE NOT EXISTS (
    SELECT 1
    FROM KHANANGCC B, HANGHOA C
    WHERE B.MADT = A.MADT and B.MAHH = C.MAHH and C.MAHH like 'HDD%'
	)

--8) thong tin cua cac mat hang chua ban duoc
select	*
from	HANGHOA A
where	NOT EXISTS	(select 1
						from	CT_HOADON B
						where	A.MAHH = B.MAHH)

--9) cho biet ten va tong so luong ban cua mat hang ban chay nhat (tinh theo so luong)
select	TENHH, SOLUONG
from	HANGHOA A, CT_HOADON B
where	a.MAHH = b.MAHH and B.SOLUONG = (select max(SoLuong)
						from CT_HOADON)
--10) cho biet ten va so luong mat hang nhap ve it nhat
select	TENHH, SOLUONG
from	HANGHOA A, CT_HOADON B
where	a.MAHH = b.MAHH and B.SOLUONG = (select min(SoLuong)
						from CT_HOADON)
--11) cho biet hoa don nhap nhieu hang hoa nhat
select	B.SOHD, B.NGAYLAPHD, B.MADT, COUNT(A.MAHH) as SoMatHang
from	CT_HOADON A, HOADON B
where	A.SOHD = B.SOHD and A.SOHD like 'N%'
group by B.SOHD, B.NGAYLAPHD, B.MADT
having COUNT(A.MaHH) = (select Max(SoMatHang)
						from(
								select	A1.SOHD, COUNT(A1.MAHH) as SoMatHang
							from	CT_HOADON A1, HOADON B1
							where	B1.SOHD = A1.SOHD AND B1.SOHD LIKE 'N%'
							group by A1.SOHD
							)as ThongKeSoMatHangNhap
						)
--12)  cho biet ten cac cac mat hang ko duoc nhap trong thang 1/2006
select	C.MAHH, TENHH
from	HANGHOA C
where   not exists(
select	MAHH
from	CT_HOADON A, HOADON B
where	A.SOHD = B.SOHD  and A.MAHH = C.MAHH and B.SOHD like 'N%'
		and MONTH(B.NGAYLAPHD) = 1
		and year(B.NGAYLAPHD) = 2006)
--13) cho biet ten cac mang hang khong ban duoc trong thang 6/2006
select	C.MAHH, TENHH
from	HANGHOA C
where   not exists(
select	MAHH
from	CT_HOADON A, HOADON B
where	A.SOHD = B.SOHD  and A.MAHH = C.MAHH and B.SOHD like 'X%'
		and MONTH(B.NGAYLAPHD) = 6
		and year(B.NGAYLAPHD) = 2006)
--14) cho biet cua hang ban bao nhieu mat hang 
SELECT A.TenDT, COUNT(DISTINCT MAHH) AS SoLuongMaHH
FROM DOITAC A, HOADON B, CT_HOADON C 
WHERE A.MADT LIKE 'K%' and A.MADT = B.MADT and B.SOHD = C.SOHD
group by A.MADT, A.TENDT

SELECT COUNT(DISTINCT MAHH) AS SoMatHangBan
FROM CT_HOADON
WHERE SOHD LIKE 'X%';

--15) cho biet so mat hang ma tung NCC co kha nang cung cap
SELECT A.MADT, A.TENDT, COUNT(B.MAHH) as SoMatHangCoTheCC
FROM DOITAC A, KHANANGCC B
WHERE A.MADT = B.MADT
GROUP BY A.MADT, A.TENDT
ORDER BY SoMatHangCoTheCC DESC
--16) cho biet thong tin cua khach hang co giao dich voi cua hang nhieu nhat
SELECT DT.MADT, DT.TENDT, DT.DIACHI, DT.DIENTHOAI
FROM DOITAC DT, HOADON HD
WHERE DT.MADT LIKE 'K%' and DT.MADT = HD.MADT
GROUP BY DT.MADT, DT.TENDT, DT.DIACHI, DT.DIENTHOAI
HAVING COUNT(HD.SOHD) =
(
    SELECT MAX(SL)
    FROM
    (
        SELECT COUNT(SOHD) AS SL
        FROM HOADON
        WHERE MADT LIKE 'K%'
        GROUP BY MADT
    )  as TimMax
)
--17) tinh tong doanh thu nam 2006
select	Sum(CAST(B.SOLUONG AS INT) * CAST(B.DONGIA AS INT)) as DoanhThuNam_2006
from	HOADON A, CT_HOADON B
where	A.SOHD = B.SOHD and YEAR(A.NGAYLAPHD) = 2006
--18) cho biet loai mat hang ban chay nhat
SELECT C.MAHH, C.TENHH, C.SOLUONGTON, SUM(B.SOLUONG) AS TongSoLuongBan
FROM HOADON A, CT_HOADON B, HANGHOA C
WHERE A.SOHD = B.SOHD and B.MAHH = C.MAHH   
GROUP BY C.MAHH, C.TENHH, C.SOLUONGTON
HAVING SUM(B.SOLUONG) = (
    SELECT MAX(TongBan)
    FROM (
        SELECT SUM(SOLUONG) AS TongBan
        FROM CT_HOADON
        GROUP BY MAHH
    ) AS ThongKe
)
