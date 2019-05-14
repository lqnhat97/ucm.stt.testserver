-----------------------CLEAR STT PHONG KHAM
update ThongKePhongKham set SoLuongDoi=0 where SoLuongDoi>0;
delete SoThuTuPhongKham where CaKham=1;
delete SoHienThiPhongKham where BanKham='BK1';
delete SoHienThiPhongKham where BanKham='BK2';
delete SoHienThiPhongKham where BanKham='BK3';
-----------------------CLEAR STT PHONG CLS
update ThongKePhongCLS set SoLuongDoi=0 where SoLuongDoi>0;
delete SoThuTuPhongCLS where CaKham=1;
delete SoHienThiPhongCanLamSang where IDPhongCanLamSang='TMH1';
delete SoHienThiPhongCanLamSang where IDPhongCanLamSang='TMH2';
