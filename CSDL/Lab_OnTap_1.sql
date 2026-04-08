create database QLThuVien
go
use QLThuVien
go

-- 1. Lệnh tạo bảng NhaXuatBan
Create table NhaXuatBan
(
MANXB   char(10) primary key,   -- Khai báo khóa chính
TenNXB  nvarchar(50) not null   -- Tên nhà xuất bản không được để trống
)
go

-- 2. Lệnh tạo bảng TheLoai
Create table TheLoai
(
MATL    char(10) primary key,   -- Khai báo khóa chính
TENTL   nvarchar(50) not null   -- Tên thể loại không được để trống
)
go

-- 3. Lệnh tạo bảng Sach
Create table Sach
(
MaSach    char(10) primary key,             -- Khai báo khóa chính
TuaDe     nvarchar(100) not null,
MANXB     char(10) references NhaXuatBan(MANXB), -- Khóa ngoại nối tới NhaXuatBan
TacGia    nvarchar(50),
SoLuong   int check (SoLuong >= 0),
NgayNhap  Datetime,
MaTL      char(10) references TheLoai(MATL)      -- Khóa ngoại nối tới TheLoai
)
go

-- 4. Lệnh tạo bảng BanDoc
Create table BanDoc
(
MaThe       char(10) primary key,   -- Khai báo khóa chính
TenBanDoc   nvarchar(50) not null,
DiaChi      nvarchar(100),
SoDT        varchar(15)
)
go

-- 5. Lệnh tạo bảng MuonSach
Create table MuonSach
(
MaThe       char(10) references BanDoc(MaThe),   -- Khóa ngoại
MaSach      char(10) references Sach(MaSach),     -- Khóa ngoại
NgayMuon    Datetime,
NgayTra     Datetime,
Primary key (MaThe, MaSach, NgayMuon)             -- Khóa chính tổ hợp 3 thuộc tính
)
go

---------------------------------------------------------
------------ NHẬP DỮ LIỆU (INSERT DATA) -----------------
---------------------------------------------------------

-- Nhập bảng NhaXuatBan
insert into NhaXuatBan values('N001', N'Giáo dục')
insert into NhaXuatBan values('N002', N'Khoa học kỹ thuật')
insert into NhaXuatBan values('N003', N'Thống kê')

-- Nhập bảng TheLoai
insert into TheLoai values('TH', N'Tin học')
insert into TheLoai values('HH', N'Hoá học')
insert into TheLoai values('KT', N'Kinh tế')
insert into TheLoai values('TN', N'Toán học')

-- Nhập bảng Sach
set dateformat dmy
go
insert into Sach values('TH0001', N'Sử dụng Corel Draw', 'N002', N'Đậu Quang Tuấn', 3, '08/09/2005', 'TH')
insert into Sach values('TH0002', N'Lập trình mạng', 'N003', N'Phạm Vĩnh Hưng', 2, '03/12/2003', 'TH')
insert into Sach values('TH0003', N'Thiết kế mạng chuyên nghiệp', 'N002', N'Phạm Vĩnh Hưng', 5, '04/05/2003', 'TH')
insert into Sach values('TH0004', N'Thực hành mạng', 'N003', N'Trần Quang', 3, '06/05/2004', 'TH')
insert into Sach values('TH0005', N'3D Studio kỹ xảo hoạt hình T1', 'N001', N'Trương Bình', 2, '05/02/2004', 'TH')
insert into Sach values('TH0006', N'3D Studio kỹ xảo hoạt hình T2', 'N001', N'Trương Bình', 3, '05/06/2004', 'TH')
insert into Sach values('TH0007', N'Giáo trình Access 2000', 'N001', N'Thiện Tâm', 5, '11/12/2005', 'TH')

-- Nhập bảng BanDoc
insert into BanDoc values('050001', N'Trần Xuân', N'17 Yersin', null)
insert into BanDoc values('050002', N'Lê Nam', N'5 Hai Bà Trưng', null)
insert into BanDoc values('060001', N'Nguyễn Năm', N'10 Lý Tự Trọng', null)
insert into BanDoc values('060002', N'Trần Hùng', N'20 Trần Phú', null)

-- Nhập bảng MuonSach
insert into MuonSach values('050001', 'TH0006', '12/12/2016', '01/03/2017')
insert into MuonSach (MaThe, MaSach, NgayMuon) values('050001', 'TH0007', '12/12/2016') -- NgayTra để trống (Null)
insert into MuonSach values('050002', 'TH0001', '08/03/2016', '15/04/2017')
insert into MuonSach (MaThe, MaSach, NgayMuon) values('050002', 'TH0004', '04/03/2017')
insert into MuonSach values('050002', 'TH0002', '04/03/2017', '04/04/2017')
insert into MuonSach values('050002', 'TH0003', '02/04/2017', '15/04/2017')
insert into MuonSach (MaThe, MaSach, NgayMuon) values('060002', 'TH0001', '08/04/2017')
insert into MuonSach values('060002', 'TH0007', '15/03/2017', '15/04/2017')
go

--- Xem các bảng để kiểm tra dữ liệu
Select * from NhaXuatBan
Select * from TheLoai
Select * from Sach
Select * from BanDoc
Select * from MuonSach



--﻿﻿﻿﻿Cho biết tên thể loại thư viện chưa nhập sách.
select	a.TENTL --hiển thị tên thể loại ra bàng phía dưới 
from	TheLoai a  --lấy từ bảng TheLoai 
where	not exists (  ---ở chỗ nào không thỏa mãn điều kiện thì lấy 
						select	TENTL
						from	Sach b
						where	a.MATL = b.MaTL
						) --hàm trong ngoặc này minh họa cho điều kiện là nếu trong TheLoai có đối tượng nào có trùng MaTL với Sach thì sẽ loại 



--﻿﻿﻿﻿Cho biết những quyển sách được bạn đọc mượn nhiều nhất, thông tin cần hiển thị bao gồm MaSach, TuaDe, TacGia, TenNXB, SoNguoiMuon (số người mượn).
SELECT	S.MaSach, S.TuaDe, S.TacGia, NXB.TenNXB, COUNT(MS.MaThe) as SoNguoiMuon
FROM	Sach S, NhaXuatBan NXB, MuonSach MS
WHERE	S.MANXB = NXB.MANXB AND S.MaSach = MS.MaSach
GROUP BY S.MaSach, S.TuaDe, S.TacGia, NXB.TenNXB
HAVING COUNT(MS.MaThe) = (
    SELECT MAX(SoLuotMuon)
    FROM (
        SELECT   S1.MaSach, COUNT(MS1.MaThe) as SoLuotMuon
        FROM     Sach S1, MuonSach MS1
        WHERE    S1.MaSach = MS1.MaSach
        GROUP BY S1.MaSach
    ) as ThongKeMuonSach
)
--﻿﻿﻿﻿Cho biết tựa đề những cuốn sách đang không có bạn đọc mượn.
SELECT TuaDe 
FROM Sach 
WHERE MaSach NOT IN (SELECT MaSach FROM MuonSach)

select	TuaDe
from	Sach a
where	not exists ( select MaSach from MuonSach b where a.MaSach = b.MaSach)


---ham cho biet so luong muon sach trong 1 khoang thoi gian cho truoc
create function fn_TongSoLuongMuonTrongKhoangThoiGianChoTruoc (@NgayBD datetime, @NgayKT datetime)
returns table
as
return(
		select	COUNT(b.MaSach) as SoLuong, @NgayBD as TuNgay, @NgayKT as DenNgay
		from	Sach a, MuonSach b
		where	a.MaSach = b.MaSach and b.NgayMuon between @NgayBD and @NgayKT
		)
go


SELECT * FROM dbo.fn_TongSoLuongMuonTrongKhoangThoiGianChoTruoc('01/01/2016', '31/12/2017')


---mau cua co 
Create trigger tr_CaHoc_ins_upd_GioBD_GioKT
On CaHoc  for insert, update
As
if  update(GioBatDau) or update (GioKetThuc)
	     if exists(select * from inserted i where i.GioKetThuc<i.GioBatDau)	
	      begin
	    	 raiserror (N'Giờ kết thúc ca học không thể nhỏ hơn giờ bắt đầu',15,1)--Thông báo lỗi cho người dùng
		     rollback tran	--Hũy thao tác gây ra vi phạm ràng buộc toàn vẹn & đưa CSDL về tình trạng trước khi thao tác
	      end


---dung Trigger cai dat RBTV "ngay tra sach ko duoc truoc ngay muon sach"
create trigger tr_NgayTra_Sau_NgayMuon
on MuonSach  
for insert, update
as
if update(NgayMuon) or update (NgayTra)
	if exists (select * from inserted i where i.NgayTra < i.NgayMuon)
		begin
			raiserror (N'ngày trả không thể nào bắt đầu trước ngày mượn', 15, 1)
			rollback tran
		end
--drop trigger tr_NgayTra_Sau_NgayMuon

---test case
UPDATE MuonSach 
SET NgayTra = '01/03/2017' 
WHERE MaThe = '050002' AND MaSach = 'TH0004' AND NgayMuon = '04/03/2017';