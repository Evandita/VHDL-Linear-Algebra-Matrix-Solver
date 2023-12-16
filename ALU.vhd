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
        DETER_MAT_D : OUT STD_LOGIC_VECTOR (7 DOWNTO 0); 

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
    signal Result_det_A, Result_det_B, Result_det_D : signed(7 downto 0) := (others => '0');
    signal Result_D_11, Result_D_12, Result_D_21, Result_D_22 : signed(7 downto 0) := (others => '0');
BEGIN
    
    -- Determinan matriks

    Result_det_A <= resize(SIGNED(OPERAND_11_A) * SIGNED(OPERAND_22_A) - SIGNED(OPERAND_12_A) * SIGNED(OPERAND_21_A), Result_det_A'length);
    Result_det_B <= resize(SIGNED(OPERAND_11_B) * SIGNED(OPERAND_22_B) - SIGNED(OPERAND_12_B) * SIGNED(OPERAND_21_B), Result_det_B'length);
    Result_det_D <= resize(Result_D_11 * Result_D_22 - Result_D_12 * Result_D_21, Result_det_D'length);

    -- Data Flow

    DETER_MAT_A <= STD_LOGIC_VECTOR(Result_det_A);
    DETER_MAT_B <= STD_LOGIC_VECTOR(Result_det_B);
    DETER_MAT_D <= STD_LOGIC_VECTOR(Result_det_D);

    OPERAND_11_D <= STD_LOGIC_VECTOR(Result_D_11);
    OPERAND_12_D <= STD_LOGIC_VECTOR(Result_D_12);
    OPERAND_21_D <= STD_LOGIC_VECTOR(Result_D_21);
    OPERAND_22_D <= STD_LOGIC_VECTOR(Result_D_22);

    ALU_PROC : PROCESS (PRG_CNT)
    BEGIN
        
        
        CASE OPCODE IS
            -- Penjumlahan matriks
            WHEN "000" =>
                Result_D_11 <= (SIGNED(OPERAND_11_A) + SIGNED(OPERAND_11_B));
                Result_D_12 <= (SIGNED(OPERAND_12_A) + SIGNED(OPERAND_12_B));
                Result_D_21 <= (SIGNED(OPERAND_21_A) + SIGNED(OPERAND_21_B));
                Result_D_22 <= (SIGNED(OPERAND_22_A) + SIGNED(OPERAND_22_B));
            -- Pengurangan matriks
            WHEN "001" =>
                Result_D_11 <= (SIGNED(OPERAND_11_A) - SIGNED(OPERAND_11_B));
                Result_D_12 <= (SIGNED(OPERAND_12_A) - SIGNED(OPERAND_12_B));
                Result_D_21 <= (SIGNED(OPERAND_21_A) - SIGNED(OPERAND_21_B));
                Result_D_22 <= (SIGNED(OPERAND_22_A) - SIGNED(OPERAND_22_B));
            -- Pencerminan matriks sumbu x
            WHEN "010" =>
                Result_D_11 <= (SIGNED(OPERAND_11_A));
                Result_D_12 <= (SIGNED(NOT OPERAND_12_A) + 1);
                Result_D_21 <= (SIGNED(OPERAND_21_A));
                Result_D_22 <= (SIGNED(NOT OPERAND_22_A) + 1);
            -- Pencerminan matriks sumbu y
            WHEN "011" =>
                Result_D_11 <= (SIGNED(NOT OPERAND_11_A) + 1);
                Result_D_12 <= (SIGNED(OPERAND_12_A));
                Result_D_21 <= (SIGNED(NOT OPERAND_21_A) + 1);
                Result_D_22 <= (SIGNED(OPERAND_22_A));
            -- Pencerminan matriks A terhadap garis y = x
            WHEN "100" =>
                Result_D_11 <= (SIGNED(NOT OPERAND_11_A) + 1);
                Result_D_12 <= (SIGNED(NOT OPERAND_12_A) + 1);
                Result_D_21 <= (SIGNED(NOT OPERAND_21_A) + 1);
                Result_D_22 <= (SIGNED(NOT OPERAND_22_A) + 1);
            -- Transpose matriks A
            WHEN "101" =>
                Result_D_11 <= (SIGNED(OPERAND_11_A));
                Result_D_12 <= (SIGNED(OPERAND_21_A));
                Result_D_21 <= (SIGNED(OPERAND_12_A));
                Result_D_22 <= (SIGNED(OPERAND_22_A));
            -- Kofaktor matriks A
            WHEN "110" =>
                Result_D_11 <= (SIGNED(OPERAND_22_A));
                Result_D_12 <= (SIGNED(NOT OPERAND_12_A) + 1);
                Result_D_21 <= (SIGNED(NOT OPERAND_21_A) + 1);
                Result_D_22 <= (SIGNED(OPERAND_11_A));
            -- Perkalian Matriks
            WHEN "111" =>
                Result_D_11 <= resize(SIGNED(OPERAND_11_A) * SIGNED(OPERAND_11_B) + SIGNED(OPERAND_12_A) * SIGNED(OPERAND_21_B), Result_D_11'length);
                Result_D_12 <= resize(SIGNED(OPERAND_11_A) * SIGNED(OPERAND_12_B) + SIGNED(OPERAND_12_A) * SIGNED(OPERAND_22_B), Result_D_12'length);
                Result_D_21 <= resize(SIGNED(OPERAND_21_A) * SIGNED(OPERAND_11_B) + SIGNED(OPERAND_22_A) * SIGNED(OPERAND_21_B), Result_D_21'length);
                Result_D_22 <= resize(SIGNED(OPERAND_21_A) * SIGNED(OPERAND_12_B) + SIGNED(OPERAND_22_A) * SIGNED(OPERAND_22_B), Result_D_22'length);
            WHEN OTHERS =>

        END CASE;
    END PROCESS;
END ARCHITECTURE rtl;
