library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

-- A 32x2x2x8 RAM in VHDL
entity RAM is
    port(
        PRG_CNT : in integer; -- Program counter

        -- Address untuk melakukan READ/WRITE pada register RAM
        RAM_ADDR_A : in std_logic_vector(4 downto 0); 
        RAM_ADDR_B : in std_logic_vector(4 downto 0); 

        -- Nilai input matriks 3x3 untuk register RAM
        RAM_MATRIX_IN_11 : in std_logic_vector(7 downto 0);
        RAM_MATRIX_IN_12 : in std_logic_vector(7 downto 0);
        RAM_MATRIX_IN_13 : in std_logic_vector(7 downto 0);
        RAM_MATRIX_IN_21 : in std_logic_vector(7 downto 0);
        RAM_MATRIX_IN_22 : in std_logic_vector(7 downto 0);
        RAM_MATRIX_IN_23 : in std_logic_vector(7 downto 0);
        RAM_MATRIX_IN_31 : in std_logic_vector(7 downto 0);
        RAM_MATRIX_IN_32 : in std_logic_vector(7 downto 0);
        RAM_MATRIX_IN_33 : in std_logic_vector(7 downto 0);
        
        -- Sinyal enable untuk RAM
        RAM_WR : in std_logic; 

        -- Nilai output matriks 3x3 dari register RAM yang dipilih
        RAM_MATRIX_OUT_11_A : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_12_A : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_13_A : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_21_A : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_22_A : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_23_A : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_31_A : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_32_A : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_33_A : out std_logic_vector(7 downto 0);

        RAM_MATRIX_OUT_11_B : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_12_B : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_13_B : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_21_B : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_22_B : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_23_B : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_31_B : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_32_B : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_33_B : out std_logic_vector(7 downto 0)
    );
end entity RAM;

architecture rtl of RAM is

    type RegisterArray is array (31 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
    
    signal registers_11 : RegisterArray:= (
        "00000101", "00000100", "00000001", "00000100",
        "00001000", "00001001", "00000111", "00000000",
        "00000010", "00000010", "00000010", "00000100",
        "00000110", "00000000", "00000001", "00000100",
        "00000011", "00001000", "00001000", "00000101",
        "00000001", "00000110", "00000101", "00000100",
        "00000010", "00000001", "00001001", "00000010",
        "00000001", "00000110", "00000110", "00000000"
    );

    signal registers_12 : RegisterArray:= (
        "00001001", "00000000", "00000101", "00000111", 
        "00000010", "00000001", "00000110", "00000011", 
        "00000001", "00000001", "00000110", "00000010", 
        "00000100", "00000011", "00000101", "00001001", 
        "00000111", "00001001", "00000101", "00001000", 
        "00000101", "00001001", "00000001", "00000011", 
        "00000000", "00000011", "00000011", "00001001", 
        "00000010", "00000011", "00001001", "00000100"
    );

    signal registers_13 : RegisterArray:= (
        "00001000", "00001001", "00001000", "00001000", 
        "00000010", "00000011", "00000110", "00000101", 
        "00000100", "00000010", "00000100", "00000010", 
        "00000000", "00000100", "00000101", "00000101", 
        "00000100", "00000010", "00001000", "00000100", 
        "00001000", "00000010", "00001001", "00000011", 
        "00000110", "00000010", "00000111", "00000110", 
        "00000010", "00000010", "00000100", "00000010"
    );

    signal registers_21 : RegisterArray:= (
        "00000101", "00000010", "00001000", "00000000", 
        "00000010", "00000000", "00001001", "00000010", 
        "00000101", "00000010", "00000100", "00000010", 
        "00000101", "00000001", "00000000", "00000111", 
        "00000101", "00000001", "00000100", "00000101", 
        "00000110", "00000001", "00000110", "00001000", 
        "00000011", "00000110", "00000011", "00000010",
        "00001000", "00000100", "00000101", "00000000"
    );

    signal registers_22 : RegisterArray:= (
        "00000110", "00000000", "00001001", "00000100",
        "00000110", "00000010", "00000100", "00000001", 
        "00000010", "00001001", "00000100", "00000101",
        "00000010", "00000101", "00000100", "00001001",
        "00000000", "00000001", "00000001", "00000011",
        "00000011", "00001000", "00000010", "00000000",
        "00000001", "00001000", "00001001", "00000111",
        "00000000", "00000010", "00000000", "00000001"
    );

    signal registers_23 : RegisterArray:= (
        "00000111", "00000001", "00001001", "00000010", 
        "00000101", "00000001", "00000100", "00000111",
        "00001000", "00000100", "00000011", "00000010",
        "00001001", "00000011", "00000010", "00000011",
        "00000110", "00000110", "00000001", "00000100",
        "00001000", "00000010", "00000000", "00000000",
        "00000010", "00000010", "00000100", "00001001",
        "00000110", "00000011", "00001000", "00000101"
    );

    signal registers_31 : RegisterArray:= (
        "00001001", "00000011", "00000100", "00000010",
        "00000111", "00001000", "00000011", "00000100",
        "00000000", "00000100", "00000000", "00000000",
        "00000000", "00000100", "00000100", "00000111",
        "00001001", "00001001", "00000010", "00000100",
        "00000100", "00001000", "00000001", "00000001",
        "00000011", "00000011", "00000001", "00000000",
        "00000011", "00000010", "00000100", "00001000"
    );

    signal registers_32 : RegisterArray:= (
        "00001001", "00000011", "00000000", "00000000",
        "00001001", "00000011", "00000100", "00000111",
        "00000110", "00001001", "00000001", "00000010",
        "00000111", "00000101", "00000011", "00000101",
        "00000011", "00001001", "00000001", "00000111",
        "00000001", "00000110", "00000101", "00000111",
        "00000100", "00000011", "00000111", "00001000", 
        "00000111", "00000101", "00000000", "00000000"
    );

    signal registers_33 : RegisterArray:= (
        "00000110", "00000101", "00001001", "00000110",
        "00000101", "00000101", "00000011", "00000110",
        "00000010", "00000100", "00000000", "00000000",
        "00000000", "00000001", "00000100", "00000101",
        "00000001", "00001000", "00000000", "00000111",
        "00000101", "00001001", "00000010", "00000101",
        "00001001", "00000101", "00000111", "00000000", 
        "00000010", "00000001", "00000001", "00000000"
    );

begin
    process(PRG_CNT)
    begin
        -- Ketika sinyal enable bernilai '1', maka memasukkan nilai matriks 3x3 pada register memori yang dituju
        if RAM_WR = '1' then
            registers_11(to_integer(unsigned(RAM_ADDR_A))) <= RAM_MATRIX_IN_11;
            registers_12(to_integer(unsigned(RAM_ADDR_A))) <= RAM_MATRIX_IN_12;
            registers_13(to_integer(unsigned(RAM_ADDR_A))) <= RAM_MATRIX_IN_13;
            registers_21(to_integer(unsigned(RAM_ADDR_A))) <= RAM_MATRIX_IN_21;
            registers_22(to_integer(unsigned(RAM_ADDR_A))) <= RAM_MATRIX_IN_22;
            registers_23(to_integer(unsigned(RAM_ADDR_A))) <= RAM_MATRIX_IN_23;
            registers_31(to_integer(unsigned(RAM_ADDR_A))) <= RAM_MATRIX_IN_31;
            registers_32(to_integer(unsigned(RAM_ADDR_A))) <= RAM_MATRIX_IN_32;
            registers_33(to_integer(unsigned(RAM_ADDR_A))) <= RAM_MATRIX_IN_33;
        -- Ketika sinyal enable bernilai '0', maka mengeluarkan 2 buah nilai matriks 3x3 dari register memori yang dipilih
        else 
            RAM_MATRIX_OUT_11_A <= registers_11(to_integer(unsigned(RAM_ADDR_A)));
            RAM_MATRIX_OUT_12_A <= registers_12(to_integer(unsigned(RAM_ADDR_A)));
            RAM_MATRIX_OUT_13_A <= registers_13(to_integer(unsigned(RAM_ADDR_A)));
            RAM_MATRIX_OUT_21_A <= registers_21(to_integer(unsigned(RAM_ADDR_A)));
            RAM_MATRIX_OUT_22_A <= registers_22(to_integer(unsigned(RAM_ADDR_A)));
            RAM_MATRIX_OUT_23_A <= registers_23(to_integer(unsigned(RAM_ADDR_A)));
            RAM_MATRIX_OUT_31_A <= registers_31(to_integer(unsigned(RAM_ADDR_A)));
            RAM_MATRIX_OUT_32_A <= registers_32(to_integer(unsigned(RAM_ADDR_A)));
            RAM_MATRIX_OUT_33_A <= registers_33(to_integer(unsigned(RAM_ADDR_A)));

            RAM_MATRIX_OUT_11_B <= registers_11(to_integer(unsigned(RAM_ADDR_B)));
            RAM_MATRIX_OUT_12_B <= registers_12(to_integer(unsigned(RAM_ADDR_B)));
            RAM_MATRIX_OUT_13_B <= registers_13(to_integer(unsigned(RAM_ADDR_B)));
            RAM_MATRIX_OUT_21_B <= registers_21(to_integer(unsigned(RAM_ADDR_B)));
            RAM_MATRIX_OUT_22_B <= registers_22(to_integer(unsigned(RAM_ADDR_B)));
            RAM_MATRIX_OUT_23_B <= registers_23(to_integer(unsigned(RAM_ADDR_B)));
            RAM_MATRIX_OUT_31_B <= registers_31(to_integer(unsigned(RAM_ADDR_B)));
            RAM_MATRIX_OUT_32_B <= registers_32(to_integer(unsigned(RAM_ADDR_B)));
            RAM_MATRIX_OUT_33_B <= registers_33(to_integer(unsigned(RAM_ADDR_B)));
        end if;

    end process;
end architecture rtl;



