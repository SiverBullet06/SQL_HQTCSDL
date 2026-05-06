CREATE DATABASE QLSV
ON PRIMARY (
    NAME = 'QLSV_PRIMARY',
    FILENAME = 'E:\LuuDuLieuSinhVien\toithu3_buoi1_17_3_26\QLSV_PRIMARY.mdf', -- Bạn hãy kiểm tra lại đường dẫn thư mục này
    SIZE = 15MB,
    MAXSIZE = 30MB,
    FILEGROWTH = 10%
)
LOG ON (
    NAME = 'QLSV_LOG',
    FILENAME = 'E:\LuuDuLieuSinhVien\toithu3_buoi1_17_3_26\QLSV_LOG.ldf',
    SIZE = 10MB,
    MAXSIZE = 20MB,
    FILEGROWTH = 15%
);

-- 1. Bảng KHOA
CREATE TABLE KHOA (
    MAKHOA CHAR(10) PRIMARY KEY,
    TENKHOA NVARCHAR(100)
);

-- 2. Bảng LOP
CREATE TABLE LOP (
    MALOP CHAR(10) PRIMARY KEY,
    TENLOP NVARCHAR(50),
    SISODK INT,
    MAKHOA CHAR(10),
    CONSTRAINT FK_LOP_KHOA FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA)
);

-- 3. Bảng SINHVIEN
CREATE TABLE SINHVIEN (
    MASV CHAR(10) PRIMARY KEY,
    HOTEN NVARCHAR(100),
    NGSINH DATE,
    DCHI NVARCHAR(200),
    GIOITINH NVARCHAR(5),
    MALOP CHAR(10),
    CONSTRAINT FK_SV_LOP FOREIGN KEY (MALOP) REFERENCES LOP(MALOP)
);

-- 4. Bảng MONHOC
CREATE TABLE MONHOC (
    MAMH CHAR(10) PRIMARY KEY,
    TENMH NVARCHAR(100),
    SOTC INT
);

-- 5. Bảng KETQUA
CREATE TABLE KETQUA (
    MASV CHAR(10),
    MAMH CHAR(10),
    DIEM FLOAT,
    PRIMARY KEY (MASV, MAMH),
    CONSTRAINT FK_KQ_SV FOREIGN KEY (MASV) REFERENCES SINHVIEN(MASV),
    CONSTRAINT FK_KQ_MH FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH)
);
GO
-- Chèn KHOA
INSERT INTO KHOA VALUES ('01', N'Công nghệ thông tin'), ('02', N'Điện - Điện tử'), ('03', N'Công nghệ Thực phẩm');

-- Chèn LOP
INSERT INTO LOP (MALOP, TENLOP, MAKHOA) VALUES 
('L001', '15CNTT1', '01'), ('L002', '15CNTT2', '01'), ('L003', '14ATTT', '01'),
('L004', '14DTVT', '02'), ('L005', '16ATTP1', '03'), ('L006', '16ATTP2', '03');

-- Chèn SINHVIEN
INSERT INTO SINHVIEN VALUES 
('SV01', N'Nguyễn Thị Lan', '2005-07-15', N'TPHCM', N'Nam', 'L001'),
('SV02', N'Trần Thanh Tùng', '2005-05-19', N'Vũng Tàu', N'Nam', 'L001'),
('SV03', N'Trương Thị Huệ', '2002-08-31', N'Đà Nẵng', N'Nữ', 'L001'),
('SV04', N'Lê Văn Khánh', '2002-01-18', N'Vũng Tàu', N'Nam', 'L002'),
('SV05', N'Ngô Đình Việt', '2004-09-27', N'Đà Nẵng', N'Nam', 'L003'),
('SV06', N'Trần Thị Liễu', '2003-02-18', N'TPHCM', N'Nữ', 'L003'),
('SV07', N'Trần Thanh Nam', '2004-06-22', N'Đồng Nai', N'Nam', 'L004'),
('SV08', N'Phạm Hoài Phong', '2003-12-08', N'Tiền Giang', N'Nam', 'L004'),
('SV09', N'Trần Thị Tú Anh', '2004-11-28', N'TPHCM', N'Nữ', 'L005'),
('SV10', N'Đỗ Thị Hạnh', '2004-04-26', N'Đồng Nai', N'Nữ', 'L006');

-- Chèn MONHOC
INSERT INTO MONHOC VALUES 
('M001', N'Toán cao cấp A1', 3), ('M002', N'Lịch sử đảng', 2), ('M003', N'Chính trị', 2),
('M004', N'Cơ sở dữ liệu', 4), ('M005', N'Hệ quản trị CSDL', 4), ('M006', N'Lập trình C', 3),
('M007', N'Xử lý ảnh', 2), ('M008', N'Tin học cơ bản', 3), ('M009', N'Mạng máy tính', 2),
('M010', N'Toán rời rạc', 2), ('M011', N'Lập trình web', 3), ('M012', N'Công nghệ Java', 3);

-- Chèn KETQUA
INSERT INTO KETQUA VALUES 
('SV01', 'M001', 8), ('SV01', 'M002', 4), ('SV01', 'M003', 6),
('SV02', 'M001', 4), ('SV02', 'M004', 5),
('SV03', 'M002', 7), ('SV03', 'M006', 9),
('SV04', 'M004', 10), ('SV05', 'M005', 6),
('SV06', 'M006', 9), ('SV07', 'M008', 7),
('SV08', 'M001', 3), ('SV08', 'M002', 8),
('SV09', 'M003', 6), ('SV10', 'M002', 5);