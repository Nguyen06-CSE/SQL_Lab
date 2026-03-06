/*	HP: Cơ sở dữ liệu
	Lab02: Quản lý sản xuất
	SV:	Cao Khôi Nguyên
	Mã SV: 2411887
	Lớp: CTK48B
	Thời gian: 31/1/2026 - kết thúc
*/
Create database	Lab02_QLSX
go
use Lab02_QLSX
go


create table ToSanXuat
(
MaTSX char(4) primary key,
TenTSX nvarchar(4) not null unique
)
go
create table CongNhan 
(
MaCN char(5) primary key,
Ho nvarchar(20) not null,
Ten nvarchar(8) not null,
Phai nvarchar(3) not null,
NS DateTime not null,
MaTSX char(4) references ToSanXuat(MaTSX)
)
go

create table SanPham
(
MaSP char(5) primary key,
TenSP nvarchar(max) not null,
DVT nchar(3) not null,
TienCong int check(TienCong > 0) not null
)
go

create table ThanhPham
(
MaCN char(5) references CongNhan(MaCN),
MaSP char(5) references SanPham(MaSP),
Ngay DateTime not null,
SoLuong int check(SoLuong >=0) not null,
primary key(MaCN, MaSP, Ngay)
)
go
 


select * from CongNhan
select * from ToSanXuat
select * from SanPham
select * from ThanhPham

set dateformat dmy
go


insert into ToSanXuat values (N'TS01', N'Tổ 1')
insert into ToSanXuat values (N'TS02', N'Tổ 2')

go
select * from ToSanXuat
go

insert into CongNhan values (N'CN001',N'Nguyễn Trường',N'An', N'Nam','12/05/1981',N'TS01')
insert into CongNhan values (N'CN002',N'Lê Thị Hồng',N'Gấm',N'Nữ','04/06/1981',N'TS01')
insert into CongNhan values (N'CN003',N'Nguyễn Công',N'Thành',N'Nam','04/05/1981',N'TS02')
insert into CongNhan values (N'CN004',N'Vô Hữu',N'Hạnh',N'Nam','15/02/1980',N'TS02')
insert into CongNhan values (N'CN005',N'Lý Thanh',N'Hân',N'Nữ','03/12/1981',N'TS01')

go

select * from CongNhan

go

insert into SanPham values (N'SP001',N'Nồi Đất',N'cái','10000')
insert into SanPham values (N'SP002',N'Chén',N'cái','2000')
insert into SanPham values (N'SP003',N'Bình Gốm Lớn',N'cái','20000')
insert into SanPham values (N'SP004',N'Bình Gốm Nhỏ',N'cái','25000')


go
select * from SanPham

go
insert into ThanhPham values (N'CN001', N'SP001', '01/02/2007', '10')
insert into ThanhPham values (N'CN002', N'SP001', '01/02/2007', '5')
insert into ThanhPham values (N'CN003', N'SP002', '10/01/2007', '50')
insert into ThanhPham values (N'CN004', N'SP003', '12/01/2007', '10')
insert into ThanhPham values (N'CN005', N'SP002', '12/01/2007', '100')
insert into ThanhPham values (N'CN002', N'SP004', '13/02/2007', '10')
insert into ThanhPham values (N'CN001', N'SP003', '14/02/2007', '15')
insert into ThanhPham values (N'CN003', N'SP001', '15/01/2007', '20')
insert into ThanhPham values (N'CN003', N'SP004', '14/02/2007', '15')
insert into ThanhPham values (N'CN004', N'SP002', '30/01/2007', '100')
insert into ThanhPham values (N'CN005', N'SP003', '01/02/2007', '50')
insert into ThanhPham values (N'CN001', N'SP001', '20/02/2007', '30')

go
select * from ThanhPham

--1)Liet ke cac cong nhan theo to san xuat va xep thu tu tang dan
select B.TenTSX, A.Ho+' '+A.Ten as HoTen, convert(char(10),A.NS,103) as NgaySinh, A.Phai
from CongNhan A, ToSanXuat B
order by B.TenTSX, A.Ten
--2)liet ke cac san pham ma cong nhan 'Nguyen Truong An' da lam duoc
select TenSP, Ngay, SoLuong, SoLuong * TienCong as ThanhTien
from CongNhan A, ThanhPham B, SanPham SP
where A.MaCN = B.MaCN and B.MaSP = SP.MaSP and A.Ho = N'Nguyễn Trường' and A.Ten = N'An'
--5)thong ke so luong cong nhan theo tung to san xuat
select MaTSX, count(MaCN) as SoLuong
from CongNhan
Group by MaTSX
--6) tong so luong thanh pham theo tung loaima moi cong nhan lam duoc
select A.Ho, A.Ten, B.TenSP,COUNT(
from CongNhan A, SanPham B, ThanhPham C

----delete from CongNhan
----delete from  SanPham
----delete from ToSanXuat
----delete from ThanhPham