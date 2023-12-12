LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ALU IS
    PORT (
        PRG_CNT : IN INTEGER; -- Program counter
        OPCODE : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- Bentuk operasi yang akan dilakukan pada matriks
        OPERAND1 : OUT STD_LOGIC_VECTOR (31 DOWNTO 0); -- Operand untuk menyimpan hasil matriks
        OPERAND2, OPERAND3 : IN STD_LOGIC_VECTOR (15 DOWNTO 0) -- Operand untuk melakukan operasi matriks
    );
END ENTITY ALU;

ARCHITECTURE rtl OF ALU IS
BEGIN
    ALU_PROC : PROCESS (PRG_CNT)
    BEGIN
        CASE OPCODE IS
            WHEN "000" =>
                
            WHEN "001" =>

            WHEN "010" =>

            WHEN "011" =>

            WHEN "100" =>

            WHEN "101" =>

            WHEN "110" =>

            WHEN "111" =>
        END CASE;
    END PROCESS;
END ARCHITECTURE rtl;