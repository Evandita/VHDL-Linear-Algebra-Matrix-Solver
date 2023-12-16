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


        -- Nilai input matriks 2x2 untuk register RAM
        RAM_MATRIX_IN_11 : in std_logic_vector(7 downto 0);
        RAM_MATRIX_IN_12 : in std_logic_vector(7 downto 0);
        RAM_MATRIX_IN_21 : in std_logic_vector(7 downto 0);
        RAM_MATRIX_IN_22 : in std_logic_vector(7 downto 0);
        
        -- Sinyal enable untuk RAM
        RAM_WR : in std_logic; 

        -- Nilai output matriks 2x2 dari register RAM yang dipilih
        RAM_MATRIX_OUT_11_A : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_12_A : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_21_A : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_22_A : out std_logic_vector(7 downto 0);

        RAM_MATRIX_OUT_11_B : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_12_B : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_21_B : out std_logic_vector(7 downto 0);
        RAM_MATRIX_OUT_22_B : out std_logic_vector(7 downto 0)
    );
end entity RAM;

architecture rtl of RAM is

    type RegisterArray is array (31 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
    
    signal registers_11 : RegisterArray := (others => (others => '0'));
    signal registers_12 : RegisterArray := (others => (others => '0'));
    signal registers_21 : RegisterArray := (others => (others => '0'));
    signal registers_22 : RegisterArray := (others => (others => '0'));

    -- initial values in the RAM, set defaults to 0

begin
    process(PRG_CNT)
    begin
        -- Ketika sinyal enable bernilai '1', maka memasukkan nilai matriks 2x2 pada register memori yang dituju
        if RAM_WR = '1' then
            registers_11(to_integer(unsigned(RAM_ADDR_A))) <= RAM_MATRIX_IN_11;
            registers_12(to_integer(unsigned(RAM_ADDR_A))) <= RAM_MATRIX_IN_12;
            registers_21(to_integer(unsigned(RAM_ADDR_A))) <= RAM_MATRIX_IN_21;
            registers_22(to_integer(unsigned(RAM_ADDR_A))) <= RAM_MATRIX_IN_22;
        -- Ketika sinyal enable bernilai '0', maka mengeluarkan 2 buah nilai matriks 2x2 dari register memori yang dipilih
        else 
            RAM_MATRIX_OUT_11_A <= registers_11(to_integer(unsigned(RAM_ADDR_A)));
            RAM_MATRIX_OUT_12_A <= registers_12(to_integer(unsigned(RAM_ADDR_A)));
            RAM_MATRIX_OUT_21_A <= registers_21(to_integer(unsigned(RAM_ADDR_A)));
            RAM_MATRIX_OUT_22_A <= registers_22(to_integer(unsigned(RAM_ADDR_A)));

            RAM_MATRIX_OUT_11_B <= registers_11(to_integer(unsigned(RAM_ADDR_B)));
            RAM_MATRIX_OUT_12_B <= registers_12(to_integer(unsigned(RAM_ADDR_B)));
            RAM_MATRIX_OUT_21_B <= registers_21(to_integer(unsigned(RAM_ADDR_B)));
            RAM_MATRIX_OUT_22_B <= registers_22(to_integer(unsigned(RAM_ADDR_B)));
        end if;

    end process;
end architecture rtl;



