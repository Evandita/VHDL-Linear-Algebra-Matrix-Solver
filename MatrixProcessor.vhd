LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY MatrixProcessor IS
    PORT (
        CPU_CLK : IN STD_LOGIC;
        ENABLE : IN STD_LOGIC;
        INSTRUCTION_IN : IN STD_LOGIC_VECTOR(17 DOWNTO 0)
    );
END ENTITY MatrixProcessor;

ARCHITECTURE rtl OF MatrixProcessor IS
    -- Components definition 
    COMPONENT DECODER
        PORT (
            PRG_CNT : IN INTEGER; -- Program counter
            INSTRUCTION : IN STD_LOGIC_VECTOR(17 DOWNTO 0); -- Instruksi yang akan di-decode
            OPCODE : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- Bentuk operasi yang akan dilakukan pada matriks
            OP1_ADDR, OP2_ADDR, OP3_ADDR : OUT STD_LOGIC_VECTOR(4 DOWNTO 0) -- Alamat dari operand pertama sampai ketiga
        );
    END COMPONENT;

    COMPONENT ALU
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
            OPERAND_13_D : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_21_D : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_22_D : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_23_D : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_31_D : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_32_D : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_33_D : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);

            -- Operand A untuk melakukan operasi matriks 
            OPERAND_11_A : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_12_A : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_13_A : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_21_A : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_22_A : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_23_A : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_31_A : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_32_A : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_33_A : IN STD_LOGIC_VECTOR (7 DOWNTO 0);

            -- Operand B untuk melakukan operasi matriks 
            OPERAND_11_B : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_12_B : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_13_B : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_21_B : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_22_B : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_23_B : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_31_B : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_32_B : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            OPERAND_33_B : IN STD_LOGIC_VECTOR (7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT RAM
        PORT (
            PRG_CNT : IN INTEGER; -- Program counter

            -- Address untuk melakukan READ/WRITE pada register RAM
            RAM_ADDR_A : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            RAM_ADDR_B : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

            -- Nilai input matriks 3x3 untuk register RAM
            RAM_MATRIX_IN_11 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_IN_12 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_IN_13 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_IN_21 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_IN_22 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_IN_23 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_IN_31 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_IN_32 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_IN_33 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

            -- Sinyal enable untuk RAM
            RAM_WR : IN STD_LOGIC;

            -- Nilai output matriks 3x3 dari register RAM yang dipilih
            RAM_MATRIX_OUT_11_A : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_OUT_12_A : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_OUT_13_A : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_OUT_21_A : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_OUT_22_A : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_OUT_23_A : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_OUT_31_A : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_OUT_32_A : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_OUT_33_A : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);

            RAM_MATRIX_OUT_11_B : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_OUT_12_B : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_OUT_13_B : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_OUT_21_B : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_OUT_22_B : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_OUT_23_B : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_OUT_31_B : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_OUT_32_B : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            RAM_MATRIX_OUT_33_B : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    -- Utility signal definitions
    SIGNAL INSTRUCTION_s : STD_LOGIC_VECTOR(17 DOWNTO 0);
    SIGNAL RAM_WR_s : STD_LOGIC;
    SIGNAL OPCODE_s : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL OP_ADDR1_s, OP_ADDR2_s : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL RAM_ADDR_A_s, RAM_ADDR_B_s : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL RAM_MATRIX_OUT_11_A_s, RAM_MATRIX_OUT_12_A_s, RAM_MATRIX_OUT_13_A_s, RAM_MATRIX_OUT_21_A_s, RAM_MATRIX_OUT_22_A_s, RAM_MATRIX_OUT_23_A_s, RAM_MATRIX_OUT_31_A_s, RAM_MATRIX_OUT_32_A_s, RAM_MATRIX_OUT_33_A_s : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL RAM_MATRIX_OUT_11_B_s, RAM_MATRIX_OUT_12_B_s, RAM_MATRIX_OUT_13_B_s, RAM_MATRIX_OUT_21_B_s, RAM_MATRIX_OUT_22_B_s, RAM_MATRIX_OUT_23_B_s, RAM_MATRIX_OUT_31_B_s, RAM_MATRIX_OUT_32_B_s, RAM_MATRIX_OUT_33_B_s : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL RAM_MATRIX_IN_11_s, RAM_MATRIX_IN_12_s, RAM_MATRIX_IN_13_s, RAM_MATRIX_IN_21_s, RAM_MATRIX_IN_22_s, RAM_MATRIX_IN_23_s, RAM_MATRIX_IN_31_s, RAM_MATRIX_IN_32_s, RAM_MATRIX_IN_33_s : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL DETER_MAT_A_s, DETER_MAT_B_s, DETER_MAT_D_s : STD_LOGIC_VECTOR(7 DOWNTO 0);
    -- Create state types for FSM
    TYPE CPU_State IS (IDLE, FETCH, DECODE, READ_MEM, EXECUTE, COMPLETE);
    -- Initialize CPU state
    SIGNAL current_state : CPU_State := IDLE;
    SIGNAL next_state : CPU_State := IDLE;
    -- Initialize Program counter
    SIGNAL Program_Counter : INTEGER := 0;

BEGIN
    -- Port Map components
    DECODER1 : DECODER PORT MAP(
        Program_Counter,
        INSTRUCTION_IN,
        OPCODE_s,
        OP_ADDR1_s,
        OP_ADDR2_s,
        RAM_ADDR_B_s
    );

    RAM1 : RAM PORT MAP(
        Program_Counter,
        RAM_ADDR_A_s,
        RAM_ADDR_B_s,
        RAM_MATRIX_IN_11_s,
        RAM_MATRIX_IN_12_s,
        RAM_MATRIX_IN_13_s,
        RAM_MATRIX_IN_21_s,
        RAM_MATRIX_IN_22_s,
        RAM_MATRIX_IN_23_s,
        RAM_MATRIX_IN_31_s,
        RAM_MATRIX_IN_32_s,
        RAM_MATRIX_IN_33_s,
        RAM_WR_s,
        RAM_MATRIX_OUT_11_A_s, RAM_MATRIX_OUT_12_A_s, RAM_MATRIX_OUT_13_A_s, RAM_MATRIX_OUT_21_A_s, RAM_MATRIX_OUT_22_A_s, RAM_MATRIX_OUT_23_A_s, RAM_MATRIX_OUT_31_A_s, RAM_MATRIX_OUT_32_A_s, RAM_MATRIX_OUT_33_A_s,
        RAM_MATRIX_OUT_11_B_s, RAM_MATRIX_OUT_12_B_s, RAM_MATRIX_OUT_13_B_s, RAM_MATRIX_OUT_21_B_s, RAM_MATRIX_OUT_22_B_s, RAM_MATRIX_OUT_23_B_s, RAM_MATRIX_OUT_31_B_s, RAM_MATRIX_OUT_32_B_s, RAM_MATRIX_OUT_33_B_s
    );

    ALU1 : ALU PORT MAP(
        Program_Counter,
        OPCODE_s,
        DETER_MAT_A_s,
        DETER_MAT_B_s,
        DETER_MAT_D_s,
        RAM_MATRIX_IN_11_s, RAM_MATRIX_IN_12_s, RAM_MATRIX_IN_13_s, RAM_MATRIX_IN_21_s, RAM_MATRIX_IN_22_s, RAM_MATRIX_IN_23_s, RAM_MATRIX_IN_31_s, RAM_MATRIX_IN_32_s, RAM_MATRIX_IN_33_s,
        RAM_MATRIX_OUT_11_A_s, RAM_MATRIX_OUT_12_A_s, RAM_MATRIX_OUT_13_A_s, RAM_MATRIX_OUT_21_A_s, RAM_MATRIX_OUT_22_A_s, RAM_MATRIX_OUT_23_A_s, RAM_MATRIX_OUT_31_A_s, RAM_MATRIX_OUT_32_A_s, RAM_MATRIX_OUT_33_A_s,
        RAM_MATRIX_OUT_11_B_s, RAM_MATRIX_OUT_12_B_s, RAM_MATRIX_OUT_13_B_s, RAM_MATRIX_OUT_21_B_s, RAM_MATRIX_OUT_22_B_s, RAM_MATRIX_OUT_23_B_s, RAM_MATRIX_OUT_31_B_s, RAM_MATRIX_OUT_32_B_s, RAM_MATRIX_OUT_33_B_s
    );

    -- CPU Process, use the CPU clock as the sensitivity list and have the process run on rising edge triggered
    PROCESS (current_state, ENABLE) IS
    BEGIN
        -- FSM logic
        CASE current_state IS
            WHEN IDLE =>
                -- When idle state, wait for enable to be '1'
                IF ENABLE = '1' THEN
                    next_state <= FETCH;
                    Program_Counter <= Program_Counter + 1;
                ELSE
                    next_state <= IDLE;
                END IF;

            WHEN FETCH =>
                -- When fetch, receive instruction input
                Program_Counter <= Program_Counter + 1;
                next_state <= DECODE;

            WHEN DECODE =>
                -- When decode, pass arguments to decoder component
                Program_Counter <= Program_Counter + 1;
                next_state <= READ_MEM;
            WHEN READ_MEM =>
                -- When read memory, read from RAM and store as operands
                RAM_ADDR_A_s <= OP_ADDR2_s;
                RAM_WR_s <= '0';
                next_state <= EXECUTE;
                Program_Counter <= Program_Counter + 1;

            WHEN EXECUTE =>
                -- When execute, pass arguments to ALU component, then write back to RAM
                RAM_WR_s <= '1';
                RAM_ADDR_A_s <= OP_ADDR1_s;
                next_state <= COMPLETE;
                Program_Counter <= Program_Counter + 1;

            WHEN COMPLETE =>
                -- When complete, print report statement to notify instruction complete
                REPORT "Instruction complete at Program Counter " & INTEGER'image(program_counter);
                next_state <= IDLE;
                Program_Counter <= 0;

            WHEN OTHERS =>
                next_state <= IDLE;
        END CASE;

    END PROCESS;

    PROCESS (CPU_CLK) IS
    BEGIN
        IF rising_edge(CPU_CLK) THEN
            current_state <= next_state;
        END IF;
    END PROCESS;

END ARCHITECTURE rtl;