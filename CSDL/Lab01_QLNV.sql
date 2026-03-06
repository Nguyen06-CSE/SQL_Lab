/*	HP: Cơ sở dữ liệu
	Lab01: Quản lý nhân viên
	SV:	<điền họ tên SV>
	Mã SV: <điền mã SV>
	Lớp: <điền lớp>
	Thời gian: bắt đầu - kết thúc
*/
---------I. TẠO | XÂY DỰNG CƠ SỞ DỮ LIỆU-----------
Create database	Lab01_QLNV	--lệnh tạo CSDL Lab01_QLNV trống
go
Use	Lab01_QLNV				--lệnh gọi sử dụng CSDL Lab01_QLNV
go
--Lệnh tạo bảng ChiNhanh
Create table ChiNhanh
(
MSCN	char(2) primary key,	--khai báo khóa chính
TenCN	nvarchar(30)	not null unique --khai báo tên CN không được để trống và không trùng nhau
)
go
--Lệnh tạo bảng NhanVien
Create table NhanVien
(
MaNV	char(4) primary key,	--khai báo khóa chính
Ho		nvarchar(20)	not null,	--khai báo tên CN không được để trống
Ten		nvarchar(10) not null,
NgaySinh Datetime	not null,
NgayVaoLam	Datetime not null,
MSCN	char(2) references ChiNhanh(MSCN) --khai báo khóa ngoại 
)
go
--Lệnh tạo bảng KyNang
Create table KyNang
(
MSKN	char(2) primary key,	--khai báo khóa chính
TenKN	nvarchar(20)	not null unique --khai báo tên CN không được để trống và không trùng nhau
)
go
--Lệnh tạo bảng NhanVienKyNang
Create table NhanVienKyNang
(
MaNV	char(4) references NhanVien(MaNV),	--khai báo MaNV là khóa ngoại
MSKN	char(2) references KyNang(MSKN),	--khai báo MSKN là khóa ngoại
MucDo	tinyint check(MucDo>=1 and MucDo<=9),--Khai báo RBTV miền giá trị cho MucDo
Primary key(MaNV, MSKN)						--khai báo khóa chính gồm nhiều (>=2) thuộc tính
)
go
---Xem các bảng
Select * from ChiNhanh
Select * from NhanVien
Select * from KyNang
Select * from NhanVienKyNang

------------NHẬP DỮ LIỆU---------
---Nhập bảng ChiNhanh
insert into ChiNhanh values('01',N'Quận 1')
insert into ChiNhanh values('02',N'Quận 5')
insert into ChiNhanh values('03',N'Bình Thạnh')
---Xem bảng ChiNhanh
Select * from ChiNhanh
---Nhập bảng NhanVien
set dateformat dmy	--khai báo với SQL Server nhập ngày tháng theo dạng ngày/tháng/năm
go
insert into NhanVien values('0001',N'Lê Văn', N'Minh', '10/06/1960', '02/05/1986','01')
insert into NhanVien values('0002',N'Nguyễn Thị',N'Mai','20/04/1970','04/07/2001','01')
insert into NhanVien values('0003',N'Lê Anh',N'Tuấn','25/06/1975','01/09/1982','02')
insert into NhanVien values('0004',N'Vương Tuấn',N'Vũ','25/03/1975','12/01/1986','02')
insert into NhanVien values('0005',N'Lý Anh',N'Hân','01/12/1980','15/05/2004','02')
insert into NhanVien values('0006',N'Phan Lê',N'Tuấn','04/06/1976','25/10/2002','03')
insert into NhanVien values('0007',N'Lê Tuấn',N'Tú','15/08/1975','15/08/2000','03')
go
---Xem bảng NhanVien
Select * from NhanVien
--Nhập bảng KyNang
insert into KyNang values('01',N'Word')
insert into KyNang values('02',N'Excel')
insert into KyNang values('03',N'Access')
insert into KyNang values('04',N'Power Point')
insert into KyNang values('05','SPSS')
--xem bảng KyNang
select * from KyNang
--nhap bang nhanvienkynang
insert into NhanVienKyNang values('0001','01',2)
insert into NhanVienKyNang values('0001','02',1)
insert into NhanVienKyNang values('0002','01',2)
insert into NhanVienKyNang values('0002','03',2)
insert into NhanVienKyNang values('0003','02',1)
insert into NhanVienKyNang values('0003','03',2)
insert into NhanVienKyNang values('0004','01',5)
insert into NhanVienKyNang values('0004','02',4)
insert into NhanVienKyNang values('0004','03',1)
insert into NhanVienKyNang values('0004','04',3)
insert into NhanVienKyNang values('0004','05',4)
insert into NhanVienKyNang values('0005','02',4)
insert into NhanVienKyNang values('0005','04',4)
insert into NhanVienKyNang values('0006','05',4)
insert into NhanVienKyNang values('0006','02',4)
insert into NhanVienKyNang values('0006','03',2)
insert into NhanVienKyNang values('0007','03',4)
insert into NhanVienKyNang values('0007','04',3)
--Xem bảng NhanVienKyNang
Select * from NhanVienKyNang





-----------II. TRUY VẤN DỮ LIỆU--------
---1. Phép chọn
--q1: Cho biết các nhân viên làm việc tại chi nhánh có mã chi nhánh '03'
Select	*
From	NhanVien
Where	MSCN = '03'
--q2:  Cho biết các nhân viên làm việc tại chi nhánh có mã chi nhánh '03' sinh sau năm 1975
Select	*
From	NhanVien
Where	MSCN = '03' and year(NgaySinh)>1975
--q3: Cho biết các nhân viên họ 'Lê'
---Cách 1: dùng hàm Left
Select	*
From	NhanVien
Where	Left(Ho,2) = N'Lê'
---Cách 2: dùng hàm Like
Select	*
From	NhanVien
Where	Ho like N'Lê %'
---
select getdate()




----2. Phép chiếu
--q4: Cho biết các thông tin sau của nhân viên: mã nhân viên, ho, tên , mscn, ngày vào làm.
Select	MaNV, HO, Ten, MSCN, NgayVaoLam
From	NhanVien
--q4': Cho biết các thông tin sau của nhân viên: mã nhân viên, Họ tên, mscn, ngày vào làm.
Select	MaNV, Ho+' '+Ten as HoTen, MSCN, convert(char(10),NgayVaoLam,103) as NgayVL
From	NhanVien
--q5: Cho biết các thông tin sau của nhân viên: Mã NV, HoTen, MSCN, Số năm công tác
--Cách 1
Select	MaNV, Ho+' '+Ten as HoTen, MSCN, year(getdate())-year(NgayVaoLam) as SoNamCT
From	NhanVien
--Cách 2
Select	MaNV, Ho+' '+Ten as HoTen, MSCN, datediff(yy,NgayVaoLam , getdate()) as SoNamCT
From	NhanVien
----Biểu thức đại số quan hệ
--q6: Cho biết các thông tin sau của nhân viên làm việc tại chi nhánh '02': Mã NV, HoTen, MSCN, Số năm công tác
Select	MaNV, Ho+' '+Ten as HoTen, MSCN, year(getdate())-year(NgayVaoLam) as SoNamCT
From	NhanVien
Where	MSCN='02'
----3. Truy vấn trên nhiều quan hệ (bảng)
---Phép tích
Select	*
From	NhanVien, ChiNhanh
Order by MaNV
---
Select	*
From	NhanVien, ChiNhanh
Where	NhanVien.MSCN = ChiNhanh.MSCN
--Q1b) Liệt kê các thông tin về nhân viên: HoTen, NgaySinh, NgayVaoLam, TenCN (sắp xếp theo tên chi nhánh). 
Select	Ho+' '+Ten as HoTen,  convert(char(10),NgaySinh,103) as NgaySinh,
		convert(char(10),NgayVaoLam,103) as NgayVL, TenCN
From	NhanVien, ChiNhanh
Where	NhanVien.MSCN = ChiNhanh.MSCN
Order by TenCN, Ten, Ho
--Q1c)  Liệt kê các nhân viên (HoTen, TenKN, MucDo) của những nhân viên biết sử dụng ‘Word’. 
Select		Ho+' '+Ten as HoTen, TenKN, MucDo
From		NhanVien A, NhanVienKyNang B, KyNang C
Where		A.MaNV = B.MaNV and B.MSKN = C.MSKN and C.TenKN = 'Word'
--Q1d)   Liệt kê các kỹ năng (TenKN, MucDo) mà nhân viên ‘Lê Anh Tuấn’ biết sử dụng 
Select		TenKN, MucDo
From		NhanVien A, NhanVienKyNang B, KyNang C
Where		A.MaNV = B.MaNV and B.MSKN = C.MSKN and Ho = N'Lê Anh' and Ten = N'Tuấn'

---4. Gom nhóm & Hàm kết hợp
--q7: cho biết số lượng nhân viên làm việc ở từng chi nhánh.
Select		MSCN, count(MaNV) as SoNV
From		NhanVien
Group by	MSCN
--Q3a) Với mỗi chi nhánh, hãy cho biết các thông tin sau TenCN, SoNV (số nhân viên của chi nhánh đó). 
Select		TenCN, count(MaNV) as SoNV
From		NhanVien A, ChiNhanh B
Where		A.MSCN = B.MSCN
Group by	A.MSCN, TenCN
--Q3b) Với mỗi kỹ năng, hãy cho biết TenKN, SoNguoiDung (số nhân viên biết sử dụng kỹ năng đó). 
Select		TenKN, count(MaNV) as SoNguoiDung
From		NhanVienKyNang A,KyNang B
Where		A.MSKN = B.MSKN
Group by	TenKN
--Q3b) Cho biết TenKN có từ 3 nhân viên trong công ty sử dụng trở lên.  
Select		TenKN, count(MaNV) as SoNguoiDung
From		NhanVienKyNang A,KyNang B
Where		A.MSKN = B.MSKN
Group by	TenKN
Having		COUNT(MaNV) >=3		--Điều kiện chọn nhóm (dùng hàm kết hợp count| sum để tính rồi mới so sánh)
--Q3f) Với mỗi nhân viên, hãy cho biết số kỹ năng tin học mà nhân viên đó sử dụng được.   
Select		Ho+' '+ Ten as HoTen, MSCN, count(MSKN) as SoKN
From		NhanVienKyNang A,NhanVien B
Where		A.MaNV = B.MaNV
Group by	Ho, Ten, MSCN










---1)truy van lua chon tren nhieu bang
--a) hien thi MSNV, HoTen (Ho+Ten as HoTen), so nam lam viec (SoNamLamViec)
select MaNV, Ho+ ' ' +Ten as HoTen,  convert(char(10),NgayVaoLam,103) as NgayVaoLam
from NhanVien
--b) liet ke cac thong tin ve nhan vien: HoTen, NgaySinh, NgayVaoLam, TenCN(sap xep theo ten CN)
select Ho+ ' ' +Ten as HoTen, convert(char(10),NgaySinh,103) as NgaySinh, convert(char(10),NgayVaoLam,103) as NgayVaoLam, TenCN
from NhanVien, ChiNhanh
where NhanVien.MSCN = ChiNhanh.MSCN
order by TenCN
--c) liet ke cac NV (HoTen, TenKN, MucDo) cua nhung nhan vien biet SD Word
select  Ho+ ' ' +Ten as HoTen, TenKN, MucDo
from NhanVien, KyNang, NhanVienKyNang
where NhanVien.MaNV = NhanVienKyNang.MaNV and KyNang.MSKN = NhanVienKyNang.MSKN and KyNang.TenKN = 'Word'
--d) liet ke cac ky nang (TenKN, MucDo) ma nhan vien 'Le Tuan Anh' biet su dung
select TenKN, MucDo
from NhanVien, NhanVienKyNang, KyNang
where NhanVien.MaNV = NhanVienKyNang.MaNV and KyNang.MSKN = NhanVienKyNang.MSKN and NhanVien.Ho = N'Lê Anh' and NhanVien.Ten = N'Tuấn'


---2)Truy van long
--a)Liệt kê MaNV, HoTen, MaCN, TenCN của các nhân viên có mức độ thành thạo Excel cao nhất
select A.MaNV, A.Ho +' '+ A.Ten as HoTen, CN.MSCN, CN.TenCN
from NhanVien A, NhanVienKyNang B, KyNang C, ChiNhanh CN
where A.MaNV = B.MaNV and B.MSKN = C.MSKN and A.MSCN = CN.MSCN and C.TenKN = 'Excel'
	and B.MucDo = ( select MAX(B2.MucDo)
					from NhanVienKyNang B2, KyNang C2
					where B2.MSKN = C2.MSKN and C2.TenKN = 'Excel'
					);

--b) liet ke MaNV, HoTen, MSCN, TenCN cua cac nhan vien vua biet 'Word' vua biet 'Excel' (truy van long)
--select A.MaNV, A.Ho+' '+A.Ten as HoTen, CN.MSCN, CN.TenCN
--from NhanVien A, ChiNhanh CN
--where A.MSCN = CN.MSCN and A.MaNV in (
--										select B.MaNV
--										from NhanVienKyNang B, KyNang C
--										where B.MSKN = C.MSKN and C.TenKN = 'Word'
--										)
--						and A.MaNV in (
--										select B.MaNV
--										from NhanVienKyNang B, KyNang C
--										where B.MSKN = C.MSKN and C.TenKN = 'Excel'
--										);

select	A.MaNV, Ho +' ' +Ten as HoTen, D.TenCN
from	NhanVien A, KyNang B, NhanVienKyNang C, ChiNhanh D
where	A.MaNV = C.MaNV and	D.MSCN = a.MSCN and C.MSKN = B.MSKN and TenKN = 'Word'
		and A.MaNV in (select	E.MaNV
						from	NhanVienKyNang E, KyNang F
						where	E.MSKN = F.MSKN and TenKN = 'Excel')

--c)voi tung ky nang hay liet ke cac thong tin (MaNV, HoTen, TenCN, TenKN, MucDo) cua nhung nhan vien thanh thao ky nang do nhat
select A.MaNV, A.Ho+' '+A.Ten as HoTen, CN.TenCN, KN.TenKN, B.MucDo
from NhanVien A, NhanVienKyNang B, KyNang KN, ChiNhanh CN
where A.MaNV = B.MaNV and B.MSKN = KN.MSKN and A.MSCN = CN.MSCN 
						and B.MucDo = (
										select MAX(B2.MucDo)
										from NhanVienKyNang B2
										where B2.MSKN = B.MSKN
										);
--select	A.MaNV, Ho +' '+Ten as HoTen, TenCN, TenKN, MucDo
--from	NhanVien A, KyNang B, NhanVienKyNang C, ChiNhanh D
--where	A.MaNV = C.MaNV and B.MSKN = C.MSKN and A.MSCN = D.MSCN
--		and C.MucDo = ( select	max(E.MucDo)
--						from	NhanVienKyNang E
--						where	C.MSKN = E.MSKN)


--d) liet ke cac chi nhanh ma moi nhan vien trong do deu biet Word
select A.MSCN, TenCN, count(C.MaNV) as SoLuong
from	NhanVien A, KyNang B, NhanVienKyNang C, ChiNhanh D
where	A.MaNV = C.MaNV and B.MSKN = C.MSKN and A.MSCN = D.MSCN and TenKN = 'Word'
group by a.MSCN, TenCN
having count(C.MaNV) = (select	count(E.MaNV)
						from	NhanVien E
						where	E.MSCN = A.MSCN)
--delete from ChiNhanh
--delete from KyNang
--delete from NhanVienKyNang
--delete from NhanVien