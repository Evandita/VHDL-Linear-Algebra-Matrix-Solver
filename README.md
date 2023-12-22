# Linear Algebra Matrix Solver
Linear Algebra Matrix Solver merupakan simple computer yang dirancang khusus untuk menyelesaikan berbagai permasalahan matriks pada aljabar linear. Rangkaian matriks prosesor ini memiliki ISA yang dapat memberikan solusi atas permasalahan matriks berordo 3x3. ISA tersebut terdiri dari penjumlahan matriks A dan B, pengurangan matriks A dan B, perkalian matriks A dan B, pencerminan matriks A terhadap sumbu x, pencerminan matriks A terhadap sumbu y, pencerminan matriks A terhadap sumbu z, transpose matriks A, dan kofaktor matriks A. Selain itu, terdapat tambahan determinan matriks yang ditempatkan pada bagian dataflow. 

## Rangkaian 

## Control Word
  17 16 15   14 13 12 11 10   09 08 07 06 05   04 03 02 01 00
|    FS    |       DA       |       AA       |       BA       |

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
