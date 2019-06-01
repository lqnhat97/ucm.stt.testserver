--------------------TEST SINH SỐ
----TAO PHIEU KHAM
exec TaoPhieuKham 'BN21136', 'PH';
exec TaoPhieuKham 'BN21444', 'PH';
exec TaoPhieuKham 'BN21451', 'PH';
exec TaoPhieuKham 'BN21456', 'PH';
exec TaoPhieuKham 'BN21464', 'PH';
exec TaoPhieuKham 'BN21466', 'PH';
exec TaoPhieuKham 'BN21511', 'PH';
exec TaoPhieuKham 'BN21512', 'PH';
exec TaoPhieuKham 'BN21114','PH';
exec TaoPhieuKham 'BN21122','PH';
exec TaoPhieuKham 'BN21123','PH';
--------------------------
exec TaoPhieuKham 'BN21635','PH';
exec TaoPhieuKham 'BN21641','PH';
exec TaoPhieuKham 'BN21642','PH';
exec TaoPhieuKham 'BN21644','PH';
exec TaoPhieuKham 'BN21645','PH';
exec TaoPhieuKham 'BN21646','PH';
exec TaoPhieuKham 'BN21652','PH';
exec TaoPhieuKham 'BN21661','PH';
exec TaoPhieuKham 'BN21676','PH';
exec TaoPhieuKham 'BN21677','PH';
exec TaoPhieuKham 'BN21678','PH';
exec TaoPhieuKham 'BN21679','PH';
exec TaoPhieuKham 'BN21556','PH';

--------------------PHONG KHAM LAM SANG

exec PhatSinhSTTPhongKhamCa1 'PKPH10003','PH';
exec PhatSinhSTTPhongKhamCa1 'PKPH10002','PH';
exec PhatSinhSTTPhongKhamCa2 'PKPH10001','PH';
exec PhatSinhSTTPhongKham_BacSiCa1 'PKPH10004','PH','BS819';
exec PhatSinhSTTPhongKham_BacSiCa1 'PKPH10005','PH','BS819'; -- ban1 phong 1;
exec PhatSinhSTTPhongKham_BacSiCa1 'PKPH10006','PH','BS298'; -- ban 2 phong 1
exec PhatSinhSTTPhongKhamCa1 'PKPH10007','PH';
exec PhatSinhSTTPhongKhamCa1 'PKPH10008','PH';
exec PhatSinhSTTPhongKhamCa2 'PKPH10009','PH';
exec PhatSinhSTTPhongKhamCa1 'PKPH10010','PH';
exec PhatSinhSTTPhongKhamCa1 'PKPH10011','PH';
---------QUA SO
exec BamSoHienThiPhongKham 'Bk1','1',1;
exec BamSoHienThiPhongKham 'Bk2','1',1;

-------------------------- STT CAN LAM SANG

exec PhatSinhSTTCLSCa1 'PKPH10001','TZ02';
exec PhatSinhSTTCLSCa1 'PKPH10002','TZ02';
exec PhatSinhSTTCLSCa1 'PKPH10003','TZ02';
exec PhatSinhSTTCLSCa1 'PKPH10004','TZ02';
exec PhatSinhSTTCLSCa1 'PKPH10005','TZ01';
exec PhatSinhSTTCLSCa1 'PKPH10006','TZ02';
exec PhatSinhSTTCLSCa1 'PKPH10007','TZ01';
exec PhatSinhSTTCLSCa1 'PKPH10008','TZ02';
exec PhatSinhSTTCLSCa1 'PKPH10009','TZ01';
exec PhatSinhSTTCLSCa1 'PKPH10024','TZ01';
------QUA SO
exec BamSoHienThiPhongCLS 'TMH2',1;
exec BamSoHienThiPhongCLS 'TMH1',1;

-----------STT XET NGHIEM
exec CheckCanLamSang 'GGJ5','PKPH10001';
exec CheckCanLamSang 'GGJ5','PKPH10002';
exec CheckCanLamSang 'GGJ5','PKPH10003';
exec CheckCanLamSang 'GGJ5','PKPH10004';
exec CheckCanLamSang 'GGJ5','PKPH10005';
exec CheckCanLamSang 'GGJ5','PKPH10006';
exec CheckCanLamSang 'GGJ5','PKPH10007';
exec CheckCanLamSang 'GGJ5','PKPH10008';
exec CheckCanLamSang 'GGJ5','PKPH10009';
exec CheckCanLamSang 'GGJ5','PKPH10010';
exec CheckCanLamSang 'GGJ5','PKPH10011';
exec CheckCanLamSang 'GGJ5','PKPH10012';
exec CheckCanLamSang 'GGJ5','PKPH10013';
exec CheckCanLamSang 'GGJ5','PKPH10014';
exec CheckCanLamSang 'GGJ5','PKPH10015';
exec CheckCanLamSang 'GGJ5','PKPH10016';
exec CheckCanLamSang 'GGJ5','PKPH10017';
exec CheckCanLamSang 'GGJ5','PKPH10018';
exec CheckCanLamSang 'GGJ5','PKPH10019';
exec CheckCanLamSang 'GGJ5','PKPH10020';
exec CheckCanLamSang 'GGJ5','PKPH10021';
exec CheckCanLamSang 'GGJ5','PKPH10022';
exec CheckCanLamSang 'GGJ5','PKPH10023';
exec CheckCanLamSang 'GGJ5','PKPH10024';
exec CheckCanLamSang 'NZ34','PKPH10001';
exec CheckCanLamSang 'NZ35','PKPH10001';
exec CheckCanLamSang 'NZ38','PKPH10001';

exec CheckCanLamSang 'MZ09','PKPH10001';
exec CheckCanLamSang 'TN08','PKPH10001';
exec CheckCanLamSang 'TN05','PKPH10001';
exec CheckCanLamSang 'MF58','PKPH10001';

---------------
exec PhatSinhSTTXetNghiemCa1'PKPH10001';
exec PhatSinhSTTXetNghiemCa1'PKPH10002';
exec PhatSinhSTTXetNghiemCa1'PKPH10003';
exec PhatSinhSTTXetNghiemCa1'PKPH10004';
exec PhatSinhSTTXetNghiemCa1'PKPH10005';
exec PhatSinhSTTXetNghiemCa1'PKPH10006';
exec PhatSinhSTTXetNghiemCa1'PKPH10007';
exec PhatSinhSTTXetNghiemCa1'PKPH10008';
exec PhatSinhSTTXetNghiemCa1'PKPH10009';
exec PhatSinhSTTXetNghiemCa1'PKPH10010';
exec PhatSinhSTTXetNghiemCa1'PKPH10011';
exec PhatSinhSTTXetNghiemCa1'PKPH10012';
exec PhatSinhSTTXetNghiemCa1'PKPH10013';
exec PhatSinhSTTXetNghiemCa1'PKPH10014';
exec PhatSinhSTTXetNghiemCa1'PKPH10015';
exec PhatSinhSTTXetNghiemCa1'PKPH10016';
exec PhatSinhSTTXetNghiemCa1'PKPH10017';
exec PhatSinhSTTXetNghiemCa1'PKPH10018';
exec PhatSinhSTTXetNghiemCa1'PKPH10019';
exec PhatSinhSTTXetNghiemCa1'PKPH10020';
exec PhatSinhSTTXetNghiemCa1'PKPH10021';
exec PhatSinhSTTXetNghiemCa1'PKPH10022';
exec PhatSinhSTTXetNghiemCa1'PKPH10023';
exec PhatSinhSTTXetNghiemCa1'PKPH10024';
------------
exec CapNhatSTTPhongXetNghiem 'XN1',1;
exec CapNhatSTTPhongXetNghiem 'XN3',1;
exec CapNhatSTTPhongXetNghiem 'XN2',1;



