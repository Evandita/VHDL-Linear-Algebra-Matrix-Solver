LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY DECODER IS
    PORT (
        PRG_CNT : IN INTEGER; -- Program counter
        INSTRUCTION : IN STD_LOGIC_VECTOR(17 DOWNTO 0); -- Instruksi yang akan di-decode
        OPCODE : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- Bentuk operasi yang akan dilakukan pada matriks
        OP1_ADDR, OP2_ADDR, OP3_ADDR : OUT STD_LOGIC_VECTOR(4 DOWNTO 0) -- Alamat dari operand pertama sampai ketiga
    );
END ENTITY DECODER;

ARCHITECTURE rtl OF DECODER IS
BEGIN
    DEC_PROC : PROCESS (PRG_CNT)
    BEGIN
        OPCODE <= INSTRUCTION(17 DOWNTO 15); -- Function select
        OP1_ADDR <= INSTRUCTION(14 DOWNTO 10); -- Register DA
        OP2_ADDR <= INSTRUCTION(9 DOWNTO 5); -- Register AA
        OP3_ADDR <= INSTRUCTION(4 DOWNTO 0); -- Register BA
    END PROCESS;
END ARCHITECTURE rtl;