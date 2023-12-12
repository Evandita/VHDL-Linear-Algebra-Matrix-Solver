LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ALU IS
    PORT (
        -- Program counter
        PRG_CNT : IN INTEGER; 
        
        -- Bentuk operasi yang akan dilakukan pada matriks
        OPCODE : IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
        
        -- Output untuk menyimpan hasil determinan matriks
        DETER_MAT_A : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        DETER_MAT_B : OUT STD_LOGIC_VECTOR (7 DOWNTO 0); 

        -- Operand D untuk menyimpan hasil matriks
        OPERAND_11_D : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        OPERAND_12_D : OUT STD_LOGIC_VECTOR (7 DOWNTO 0); 
        OPERAND_21_D : OUT STD_LOGIC_VECTOR (7 DOWNTO 0); 
        OPERAND_22_D : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);

        -- Operand A untuk melakukan operasi matriks 
        OPERAND_11_A : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        OPERAND_12_A : IN STD_LOGIC_VECTOR (7 DOWNTO 0); 
        OPERAND_21_A : IN STD_LOGIC_VECTOR (7 DOWNTO 0); 
        OPERAND_22_A : IN STD_LOGIC_VECTOR (7 DOWNTO 0);

        -- Operand B untuk melakukan operasi matriks 
        OPERAND_11_B : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        OPERAND_12_B : IN STD_LOGIC_VECTOR (7 DOWNTO 0); 
        OPERAND_21_B : IN STD_LOGIC_VECTOR (7 DOWNTO 0); 
        OPERAND_22_B : IN STD_LOGIC_VECTOR (7 DOWNTO 0)
    );
END ENTITY ALU;

ARCHITECTURE rtl OF ALU IS
BEGIN
    -- Determinan matriks A dan B
    DETER_MAT_A <= STD_LOGIC_VECTOR((SIGNED(OPERAND_11_A(3 downto 0)) * SIGNED(OPERAND_22_A(3 downto 0))) - (SIGNED(OPERAND_12_A(3 downto 0)) * SIGNED(OPERAND_21_A(3 downto 0))));
    DETER_MAT_B <= STD_LOGIC_VECTOR((SIGNED(OPERAND_11_B(3 downto 0)) * SIGNED(OPERAND_22_B(3 downto 0))) - (SIGNED(OPERAND_12_B(3 downto 0)) * SIGNED(OPERAND_21_B(3 downto 0))));

    ALU_PROC : PROCESS (PRG_CNT)
    BEGIN
        CASE OPCODE IS
            -- Penjumlahan matriks
            WHEN "000" =>
                OPERAND_11_D <= STD_LOGIC_VECTOR(SIGNED(OPERAND_11_A) + SIGNED(OPERAND_11_B));
                OPERAND_12_D <= STD_LOGIC_VECTOR(SIGNED(OPERAND_12_A) + SIGNED(OPERAND_12_B));
                OPERAND_21_D <= STD_LOGIC_VECTOR(SIGNED(OPERAND_21_A) + SIGNED(OPERAND_21_B));
                OPERAND_22_D <= STD_LOGIC_VECTOR(SIGNED(OPERAND_22_A) + SIGNED(OPERAND_22_B));
            -- Pengurangan matriks
            WHEN "001" =>
                OPERAND_11_D <= STD_LOGIC_VECTOR(SIGNED(OPERAND_11_A) - SIGNED(OPERAND_11_B));
                OPERAND_12_D <= STD_LOGIC_VECTOR(SIGNED(OPERAND_12_A) - SIGNED(OPERAND_12_B));
                OPERAND_21_D <= STD_LOGIC_VECTOR(SIGNED(OPERAND_21_A) - SIGNED(OPERAND_21_B));
                OPERAND_22_D <= STD_LOGIC_VECTOR(SIGNED(OPERAND_22_A) - SIGNED(OPERAND_22_B));
            -- Pencerminan matriks sumbu x
            WHEN "010" =>
                OPERAND_11_D <= OPERAND_11_A;
                OPERAND_12_D <= STD_LOGIC_VECTOR(SIGNED(NOT OPERAND_12_A) + 1);
                OPERAND_21_D <= OPERAND_21_A;
                OPERAND_22_D <= STD_LOGIC_VECTOR(SIGNED(NOT OPERAND_22_A) + 1);
            -- Pencerminan matriks sumbu y
            WHEN "011" =>
                OPERAND_11_D <= STD_LOGIC_VECTOR(SIGNED(NOT OPERAND_11_A) + 1);
                OPERAND_12_D <= OPERAND_12_A;
                OPERAND_21_D <= STD_LOGIC_VECTOR(SIGNED(NOT OPERAND_21_A) + 1);
                OPERAND_22_D <= OPERAND_22_A;
            -- Pencerminan matriks A terhadap garis y <= x
            WHEN "100" =>
                OPERAND_11_D <= STD_LOGIC_VECTOR(SIGNED(NOT OPERAND_11_A) + 1);
                OPERAND_12_D <= STD_LOGIC_VECTOR(SIGNED(NOT OPERAND_12_A) + 1);
                OPERAND_21_D <= STD_LOGIC_VECTOR(SIGNED(NOT OPERAND_21_A) + 1);
                OPERAND_22_D <= STD_LOGIC_VECTOR(SIGNED(NOT OPERAND_22_A) + 1);
            -- Transpose matriks A
            WHEN "101" =>
                OPERAND_11_D <= OPERAND_11_A;
                OPERAND_12_D <= OPERAND_21_A;
                OPERAND_21_D <= OPERAND_12_A;
                OPERAND_22_D <= OPERAND_22_A;
            -- Kofaktor matriks A
            WHEN "110" =>
                OPERAND_11_D <= OPERAND_22_A;
                OPERAND_12_D <= STD_LOGIC_VECTOR(SIGNED(NOT OPERAND_12_A) + 1);
                OPERAND_21_D <= STD_LOGIC_VECTOR(SIGNED(NOT OPERAND_21_A) + 1);
                OPERAND_22_D <= OPERAND_11_A;
            -- Perkalian Matriks
            WHEN "111" =>
                OPERAND_11_D <= STD_LOGIC_VECTOR(SIGNED(OPERAND_11_A(3 downto 0)) * SIGNED(OPERAND_11_B(3 downto 0)) + SIGNED(OPERAND_12_A(3 downto 0)) * SIGNED(OPERAND_21_B(3 downto 0)));
                OPERAND_12_D <= STD_LOGIC_VECTOR(SIGNED(OPERAND_11_A(3 downto 0)) * SIGNED(OPERAND_12_B(3 downto 0)) + SIGNED(OPERAND_12_A(3 downto 0)) * SIGNED(OPERAND_22_B(3 downto 0)));
                OPERAND_21_D <= STD_LOGIC_VECTOR(SIGNED(OPERAND_21_A(3 downto 0)) * SIGNED(OPERAND_11_B(3 downto 0)) + SIGNED(OPERAND_22_A(3 downto 0)) * SIGNED(OPERAND_21_B(3 downto 0)));
                OPERAND_22_D <= STD_LOGIC_VECTOR(SIGNED(OPERAND_21_A(3 downto 0)) * SIGNED(OPERAND_12_B(3 downto 0)) + SIGNED(OPERAND_22_A(3 downto 0)) * SIGNED(OPERAND_22_B(3 downto 0)));
            WHEN OTHERS =>

        END CASE;
    END PROCESS;
END ARCHITECTURE rtl;
