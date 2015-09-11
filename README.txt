This code is made by 
Fitria Nur Andini

*************************** System Requirement :  *********************************************

Minimal dibutuhkan Matlab 6.5 untuk menjalankan program.
===============================================================================================
***************************  User Guide :  ****************************************************

Untuk PS-Based-NN, cara pakai :
ketik 
>> gui_mainform;
di Command window Matlab atau 
klik kanan "gui_mainform.m" pilih "Run"

Untuk Sphere, cara pakai :
ketik 
>> synsphere;
di Command window Matlab

Untuk Sombrero, cara pakai :
ketik 
>> synsombrero(tilt, slant);
di Command window Matlab
parameter "tilt" dan "slant" adalah sudut posisi pencahayaan (satuan: derajat/degree), 
dapat diisi angka antara -360 sampai 360.

===============================================================================================
***************************  Folders Content Information : ************************************

Folder "PS-Based-NN" berisi code utama program Sistem Rekonstruksi 3D. 
  Di dalam folder "PS-Based-NN" terdapat folder "database" dan "result",
  folder "database" berisi data citra,
  folder "result" berisi file .mat hasil run program.

Folder "Sombrero" dan "sphere" berisi code untuk membuat objek sintesis sombrero dan sphere.

*) data citra wajah diambil dari database YalefacesB

===============================================================================================