# Linear Algebra Matrix Solver
Linear Algebra Matrix Solver merupakan simple computer yang dirancang khusus untuk menyelesaikan berbagai permasalahan matriks pada aljabar linear. Rangkaian matriks prosesor ini memiliki ISA yang dapat memberikan solusi atas permasalahan matriks berordo 3x3. ISA tersebut terdiri dari penjumlahan matriks A dan B, pengurangan matriks A dan B, perkalian matriks A dan B, pencerminan matriks A terhadap sumbu x, pencerminan matriks A terhadap sumbu y, pencerminan matriks A terhadap sumbu z, transpose matriks A, dan kofaktor matriks A. Selain itu, terdapat tambahan determinan matriks yang ditempatkan pada bagian dataflow. 

## Rangkaian 
![Rangkaian_ProyekAkhir](https://github.com/Evandita/Proyek-Akhir-PSD-Kelompok-BP06/assets/144194402/ef0e65c0-f3c2-4703-b3e2-22e7363ddcdb)

## Control Word
![CW_ProyekAkhir](https://github.com/Evandita/Proyek-Akhir-PSD-Kelompok-BP06/assets/144194402/62a35c9d-7681-4d86-a03e-9deb1a644d69)

## Function Select
|  Bit  |          Function           |
|-------|-----------------------------|
|  000  |     Penjumlahan matriks     |
|  001  |     Pengurangan matriks     |
|  010  | Pencerminan matriks sumbu x |
|  011  | Pencerminan matriks sumbu y |
|  100  | Pencerminan matriks sumbu z |
|  101  |      Transpose matriks      |
|  110  |       Kofaktor matriks      |
|  111  |      Perkalian matriks      |

## Contoh Input/Output
|   FS  |    DA    |    AA    |    BA    |  
|-------|----------|----------|----------|
|  000  |          |          |          |
|  001  |          |          |          |
|  010  |          |          | XXXXXXXX |
|  011  |          |          | XXXXXXXX |
|  100  |          |          | XXXXXXXX |
|  101  |          |          | XXXXXXXX |
|  110  |          |          | XXXXXXXX |
|  111  |          |          |          |
