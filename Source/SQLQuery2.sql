---------------------
-----------------------KIEM TRA DU LIEU -----------------------
USE QLSV_BAI3_3 ;
GO 
SELECT * FROM LOP ; 
SELECT * FROM SINHVIEN ;
SELECT * FROM MONHOC ;
SELECT * FROM KETQUA ;
GO
-----------------------------------
----------------------------------------
---------------------------------------------
-------------TRUY VAN DU LIEU CO BAN - ---------------
SELECT * 
FROM SINHVIEN 
WHERE QUEQUAN NOT IN (
					SELECT QUEQUAN
					FROM SINHVIEN 
					WHERE QUEQUAN = N'Cần Thơ'
);	
--------
--tìm  sinh viên có điểm lớn hơn tất cả sinh viên 

SELECT * 
FROM SINHVIEN
WHERE DIEMTB = (
				SELECT MAX(DIEMTB)
				FROM SINHVIEN);
--------
SELECT MASV, HOTEN , DIEMTB , COUNT(MASV)  AS SoLuongSV
FROM SINHVIEN 
WHERE DIEMTB > 6.5
GROUP BY MASV, HOTEN , DIEMTB

-----------------------------------
----------------------------------------
---------------------------------------------
-----------------CHUONG HAI  ---------------
DECLARE @DIEM_MAX INT 
SET @DIEM_MAX = (
				SELECT MAX(DIEMTB)
				FROM SINHVIEN
);
---------
DECLARE @SUM_DIEMTB FLOAT
SET  @SUM_DIEMTB = 



