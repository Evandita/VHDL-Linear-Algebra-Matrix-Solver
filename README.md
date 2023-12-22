# Linear Algebra Matrix Solver
Linear Algebra Matrix Solver merupakan simple computer yang dirancang khusus untuk menyelesaikan berbagai permasalahan matriks pada aljabar linear. Rangkaian matriks prosesor ini memiliki ISA yang dapat memberikan solusi atas permasalahan matriks berordo 3x3. ISA tersebut terdiri dari penjumlahan matriks A dan B, pengurangan matriks A dan B, perkalian matriks A dan B, pencerminan matriks A terhadap sumbu x, pencerminan matriks A terhadap sumbu y, pencerminan matriks A terhadap sumbu z, transpose matriks A, dan kofaktor matriks A. Selain itu, terdapat tambahan determinan matriks yang ditempatkan pada bagian dataflow. 

## Rangkaian 
![Rangkaian_PSD](https://github.com/Evandita/Proyek-Akhir-PSD-Kelompok-BP06/assets/144194402/a986b9fe-59a0-4468-a7be-51d3aa50ce48)

## Control Word
![CW_PSD drawio](https://github.com/Evandita/Proyek-Akhir-PSD-Kelompok-BP06/assets/144194402/7358946d-c029-4d79-aa01-a5d9cdef3df0)

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
