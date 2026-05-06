CREATE DATABASE so35_QLSV_BAI3_3
CREATE TABLE LOP (
    MALOP VARCHAR(10) PRIMARY KEY,
    TENLOP NVARCHAR(50),
    SISO INT
);

CREATE TABLE SINHVIEN (
    MASV VARCHAR(10) PRIMARY KEY,
    HOTEN NVARCHAR(50),
    NGSINH DATE,
    GIOITINH NVARCHAR(10),
    QUEQUAN NVARCHAR(50),
    MALOP VARCHAR(10),
    DIEMTB DECIMAL(4, 2),
    XEPLOAI NVARCHAR(20),
    FOREIGN KEY (MALOP) REFERENCES LOP(MALOP)
);

CREATE TABLE MONHOC (
    MAMH VARCHAR(10) PRIMARY KEY,
    TENMH NVARCHAR(50),
    SOTC INT,
    BATBUOC BIT
);

CREATE TABLE KETQUA (
    MASV VARCHAR(10),
    MAMH VARCHAR(10),
    HOCKY INT,
    DIEMTHI DECIMAL(4, 2),
    PRIMARY KEY (MASV, MAMH, HOCKY),
    FOREIGN KEY (MASV) REFERENCES SINHVIEN(MASV),
    FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH)
);

-- Dữ liệu cho bảng LOP
INSERT INTO LOP (MALOP, TENLOP, SISO) VALUES
('CNTT01', 'Công nghệ thông tin 01', 50),
('CNTT02', 'Công nghệ thông tin 02', 45),
('KT01', 'Kế toán 01', 55),
('KT02', 'Kế toán 02', 60),
('TMDT01', 'Thương mại điện tử 01', 48),
('TMDT02', 'Thương mại điện tử 02', 52), 
('XD01', 'Xây dựng 01', 40),
('XD02', 'Xây dựng 02', 38),
('DL01', 'Du lịch 01', 35),
('QTKD01', 'Quản trị kinh doanh 01', 50);

-- Dữ liệu cho bảng SINHVIEN
INSERT INTO SINHVIEN (MASV, HOTEN, NGSINH, GIOITINH, QUEQUAN, MALOP, DIEMTB, XEPLOAI) VALUES
('SV001', N'Nguyễn Văn A', '2004-01-15', N'Nam', N'Hà Nội', 'CNTT01', 8.5, N'Giỏi'),
('SV002', N'Trần Thị B', '2004-02-20', N'Nữ', N'TP. Hồ Chí Minh', 'CNTT01', 7.8, N'Khá'),
('SV003', N'Lê Văn C', '2003-11-10', N'Nam', N'Đà Nẵng', 'KT01', 9.0, N'Xuất sắc'),
('SV004', N'Phạm Thị D', '2004-05-05', N'Nữ', N'Hải Phòng', 'KT01', 7.2, N'Khá'),
('SV005', N'Hoàng Văn E', '2003-08-25', N'Nam', N'Nghệ An', 'TMDT01', 6.5, N'Trung bình'),
('SV006', N'Đinh Thị F', '2004-03-30', N'Nữ', N'Hà Tĩnh', 'TMDT01', 8.9, N'Giỏi'),
('SV007', N'Vũ Văn G', '2004-06-18', N'Nam', N'Thanh Hóa', 'XD01', 7.5, N'Khá'),
('SV008', N'Mai Thị H', '2003-12-01', N'Nữ', N'Quảng Ninh', 'XD01', 6.8, N'Khá'),
('SV009', N'Ngô Văn I', '2004-04-12', N'Nam', N'Huế', 'CNTT02', 8.0, N'Giỏi'),
('SV010', N'Bùi Thị K', '2003-10-22', N'Nữ', N'Cần Thơ', 'QTKD01', 9.2, N'Xuất sắc');

-- Dữ liệu cho bảng MONHOC
INSERT INTO MONHOC (MAMH, TENMH, SOTC, BATBUOC) VALUES
('MH01', N'Cơ sở dữ liệu', 3, 1),
('MH02', N'Lập trình C++', 4, 1),
('MH03', N'Mạng máy tính', 3, 1),
('MH04', N'Kinh tế vi mô', 2, 0),
('MH05', N'Kế toán tài chính', 3, 1),
('MH06', N'Thống kê ứng dụng', 3, 0),
('MH07', N'Quản trị Marketing', 3, 1),
('MH08', N'Kiến trúc máy tính', 3, 1),
('MH09', N'An toàn thông tin', 2, 0),
('MH10', N'Pháp luật đại cương', 2, 0);

-- Dữ liệu cho bảng KETQUA
INSERT INTO KETQUA (MASV, MAMH, HOCKY, DIEMTHI) VALUES
('SV001', 'MH01', 1, 8.5),
('SV001', 'MH02', 1, 7.5),
('SV002', 'MH01', 1, 8.0),
('SV002', 'MH03', 1, 7.0),
('SV003', 'MH04', 2, 9.5),
('SV003', 'MH05', 2, 8.8),
('SV004', 'MH05', 2, 7.0),
('SV004', 'MH06', 2, 7.5),
('SV005', 'MH07', 3, 6.5),
('SV005', 'MH08', 3, 5.0);

--Câu a.
CREATE FUNCTION fn_SoTinChi (@MaMon CHAR(10))
RETURNS INT
AS
	BEGIN
		DECLARE @STC INT;
		SELECT @STC = SOTC FROM MONHOC WHERE MAMH = @MaMon;
		RETURN @STC;
END;

DECLARE @stc int
SET @stc = dbo.fn_SoTinChi('MH01')
PRINT @stc

--Câu b.
CREATE FUNCTION fn_DiemTrungBinh (@MaSV VARCHAR(10))
RETURNS FLOAT
AS
	BEGIN
		DECLARE @DTB FLOAT;
		SELECT @DTB = AVG(DIEMTHI) FROM KETQUA WHERE MaSV = @MaSV;
		RETURN @DTB;
END;

DECLARE @dtb float
SET @dtb = dbo.fn_DiemTrungBinh('SV001')
PRINT @dtb

--Câu c.
CREATE FUNCTION fn_TongSV_MonHoc (@MaMon VARCHAR(10), @HocKy INT)
RETURNS INT
AS
	BEGIN
		DECLARE @TongSV INT;
		SELECT @TongSV = COUNT(DISTINCT MaSV) 
		FROM KETQUA 
		WHERE MAMH = @MaMon AND HocKy = @HocKy;
		RETURN @TongSV;
END;

DECLARE @tongsv int
SET @tongsv = dbo.fn_TongSV_MonHoc('MH01', '2')
PRINT @tongsv

--Câu d.
CREATE FUNCTION fn_LayDiemThi (@MaSV VARCHAR(10), @MaMon VARCHAR(10), @HocKy INT)
RETURNS FLOAT
AS
	BEGIN
		DECLARE @Diem FLOAT;
		SELECT @Diem = DIEMTHI 
		FROM KETQUA 
		WHERE MaSV = @MaSV AND MAMH = @MaMon AND HocKy = @HocKy;
		RETURN @Diem;
END;

DECLARE @diem int
SET @diem = dbo.fn_LayDiemThi('SV001', 'MH01', '1')
PRINT @diem

--Câu e.
CREATE FUNCTION fn_TongTCDat (@MaSV CHAR(10), @HocKy INT)
RETURNS INT
AS
	BEGIN
		DECLARE @TongTC INT;
		SELECT @TongTC = sum(SOTC)
		FROM KETQUA k, MONHOC M
		WHERE k.MAMH = m.MAMH and k.MASV = @MaSV and k.HOCKY = @HocKy and k.DIEMTHI >= 5
		RETURN isnull(@TongTC, 0)
END;

DECLARE @tongtcdat int
SET @tongtcdat = dbo.fn_TongTCDat('SV001', '1')
PRINT @tongtcdat

--Câu f.
CREATE FUNCTION fn_Lop (@MaLop CHAR(10))
RETURNS TABLE
AS
	RETURN
	(	
		SELECT MASV, HOTEN, NGSINH
		FROM SINHVIEN
		WHERE MALOP = @MaLop
	);

SELECT * FROM dbo.fn_Lop('CNTT01')

--Câu g.
CREATE FUNCTION fn_NoMon (@MaMon CHAR(10), @HocKy INT)
RETURNS TABLE
AS
	RETURN
	(	
		SELECT sv.MASV, sv.HOTEN, sv.NGSINH, l.TENLOP
		FROM SINHVIEN sv, KETQUA k, LOP l
		WHERE sv.MASV = k.MASV
			AND sv.MALOP = l.MALOP
			AND k.MAMH = @MaMon
			AND k.HOCKY = @HocKy
			AND k.DIEMTHI < 5
	);

SELECT * FROM dbo.fn_NoMon('MH04', '2')





-- Tạo CSDL
CREATE DATABASE so_35_QLTV_3_4;
GO
USE QLTV;
GO

-- Tạo bảng SACH
CREATE TABLE SACH (
    MASH VARCHAR(10) PRIMARY KEY,
    TENSH NVARCHAR(100),
    TACGIA NVARCHAR(100),
    LOAI NVARCHAR(50),
    TINHTRANG NVARCHAR(20)
);

-- Tạo bảng DOCGIA
CREATE TABLE DOCGIA (
    MADG VARCHAR(10) PRIMARY KEY,
    TENDG NVARCHAR(100),
    NGAYSINH DATE,
    PHAI NVARCHAR(5)
);

-- Thêm cột DIACHI vào bảng DOCGIA
ALTER TABLE DOCGIA
ADD DIACHI NVARCHAR(200);

-- Thêm cột SoLanMuon vào bảng DOCGIA
ALTER TABLE DOCGIA
ADD SoLanMuon INT DEFAULT 0;

-- Tạo bảng MUONSACH
CREATE TABLE MUONSACH (
    MADG VARCHAR(10),
    MASH VARCHAR(10),
    NGAYMUON DATE,
    NGAYTRA DATE,
    PRIMARY KEY (MADG, MASH, NGAYMUON),
    FOREIGN KEY (MADG) REFERENCES DOCGIA(MADG),
    FOREIGN KEY (MASH) REFERENCES SACH(MASH)
);

-- Thêm cột QuaHan vào bảng MUONSACH
ALTER TABLE MUONSACH
ADD QuaHan NVARCHAR(20);


-- Dữ liệu cho bảng SACH
INSERT INTO SACH (MASH, TENSH, TACGIA, LOAI, TINHTRANG) VALUES
('S001', N'Nhà giả kim', N'Paulo Coelho', N'Truyện', N'Chưa mượn'),
('S002', N'Đắc nhân tâm', N'Dale Carnegie', N'Xã hội', N'Đã mượn'),
('S003', N'Vật lý đại cương', N'GS. Trần Văn A', N'Khoa học tự nhiên', N'Chưa mượn'),
('S004', N'Sài Gòn một thời vang bóng', N'Nguyễn Nhật Ánh', N'Truyện', N'Chưa mượn'),
('S005', N'Kinh tế vĩ mô', N'ThS. Lê Thị B', N'Kinh tế', N'Đã mượn'),
('S006', N'Hạt giống tâm hồn', N'Jack Canfield', N'Xã hội', N'Chưa mượn'),
('S007', N'Toán cao cấp', N'TS. Nguyễn Văn C', N'Khoa học tự nhiên', N'Chưa mượn'),
('S008', N'Làm giàu không khó', N'Robert Kiyosaki', N'Kinh tế', N'Chưa mượn'),
('S009', N'Những người khốn khổ', N'Victor Hugo', N'Truyện', N'Chưa mượn'),
('S010', N'Thiên nga đen', N'Nassim Nicholas Taleb', N'Kinh tế', N'Chưa mượn');

-- Dữ liệu cho bảng DOCGIA
INSERT INTO DOCGIA (MADG, TENDG, NGAYSINH, PHAI, DIACHI) VALUES
('DG001', N'Nguyễn Thanh Nam', '2000-05-10', N'Nam', N'TP. Hồ Chí Minh'),
('DG002', N'Trần Thị Mai', '1999-08-22', N'Nữ', N'Hà Nội'),
('DG003', N'Lê Văn Tùng', '2001-03-15', N'Nam', N'Đà Nẵng'),
('DG004', N'Phạm Thị Hoài', '2002-11-30', N'Nữ', N'Cần Thơ'),
('DG005', N'Hoàng Văn Việt', '1998-01-20', N'Nam', N'Hải Phòng'),
('DG006', N'Đinh Thị Thu', '2003-07-07', N'Nữ', N'Nghệ An'),
('DG007', N'Vũ Văn An', '2000-09-01', N'Nam', N'Hà Tĩnh'),
('DG008', N'Mai Thị Yến', '2001-04-18', N'Nữ', N'Quảng Ninh'),
('DG009', N'Bùi Văn Hùng', '1997-12-25', N'Nam', N'Huế'),
('DG010', N'Ngô Thị Hương', '2002-02-14', N'Nữ', N'TP. Hồ Chí Minh');

-- Dữ liệu cho bảng MUONSACH
INSERT INTO MUONSACH (MADG, MASH, NGAYMUON, NGAYTRA) VALUES
('DG001', 'S002', '2023-10-25', NULL),
('DG001', 'S005', '2023-10-26', NULL),
('DG002', 'S001', '2023-10-27', '2023-11-05'),
('DG002', 'S003', '2023-10-28', NULL),
('DG003', 'S004', '2023-10-29', '2023-11-10'),
('DG004', 'S006', '2023-10-30', '2023-11-15'),
('DG005', 'S007', '2023-11-01', NULL),
('DG006', 'S008', '2023-11-02', NULL),
('DG007', 'S009', '2023-11-03', '2023-11-03'),
('DG008', 'S010', '2023-11-04', '2023-11-04');

--Thủ tục thường trú
--Câu a.
CREATE PROCEDURE sp_ThongTinDocGia
    @MaDG VARCHAR(10)
AS
BEGIN
    SELECT TENDG, DIACHI
    FROM DOCGIA
    WHERE MADG = @MaDG;
END;
EXEC sp_ThongTinDocGia 'DG001';

--Câu b.
CREATE PROCEDURE sp_ThongTinSach
    @MaSH VARCHAR(10)
AS
BEGIN
    SELECT TENSH, TACGIA -- Thêm cột NamXB nếu bảng của bạn có
    FROM SACH
    WHERE MASH = @MaSH;
END;
EXEC sp_ThongTinSach 'SH001';

--Câu c.
CREATE PROCEDURE sp_SoSachChuaTra
    @MaDG VARCHAR(10)
AS
BEGIN
    SELECT COUNT(*) AS SoLuongChuaTra
    FROM MUONSACH
    WHERE MADG = @MaDG AND NGAYTRA IS NULL;
END;
EXEC sp_SoSachChuaTra 'DG001';

--Câu d.
CREATE PROCEDURE sp_AiDangMuonSach
    @MaSH VARCHAR(10)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM MUONSACH WHERE MASH = @MaSH AND NGAYTRA IS NULL)
    BEGIN
        SELECT D.TENDG
        FROM DOCGIA D
        JOIN MUONSACH M ON D.MADG = M.MADG
        WHERE M.MASH = @MaSH AND M.NGAYTRA IS NULL;
    END
    ELSE
    BEGIN
        SELECT N'Chưa mượn' AS ThongBao;
    END
END;
EXEC sp_AiDangMuonSach 'SH001';

--Câu e.
CREATE PROCEDURE sp_SoSachMuonTrongNgay
    @MaDG VARCHAR(10),
    @NgayMuon DATE
AS
BEGIN
    SELECT COUNT(*) AS SoLuongMuon
    FROM MUONSACH
    WHERE MADG = @MaDG AND NGAYMUON = @NgayMuon;
END;
EXEC sp_SoSachMuonTrongNgay 'DG001', '2023-10-25';

--Câu f.
CREATE PROCEDURE sp_NgayMuonGanNhat
    @MaSH VARCHAR(10)
AS
BEGIN
    SELECT MAX(NGAYMUON) AS NgayMuonGanNhat
    FROM MUONSACH
    WHERE MASH = @MaSH;
END;
EXEC sp_NgayMuonGanNhat 'SH001';


