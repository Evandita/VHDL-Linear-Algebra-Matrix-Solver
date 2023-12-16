library IEEE;
<<<<<<< HEAD
use IEEE.STD_LOGIC_1164.ALL;

entity MatrixProcessor is
    port (
        CPU_CLK : in std_logic; 
        ENABLE : in std_logic; 
        INSTRUCTION_IN : in std_logic_vector(17 downto 0)
=======
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MatrixProcessor is
    port (
        
>>>>>>> fce736ebebb9046ea53d987ddf953287e6b6855c
    );
end entity MatrixProcessor;

architecture rtl of MatrixProcessor is
<<<<<<< HEAD
    -- Components definition here 
    COMPONENT DECODER
        port (
            PRG_CNT : in integer;
            INSTRUCTION : in std_logic_vector(17 downto 0);
            OPCODE : out std_logic_vector(2 downto 0);
            OP1_ADDR, OP2_ADDR, OP3_ADDR : out std_logic_vector(4 downto 0)
        );
    end component;

    COMPONENT ALU
        port (
            PRG_CNT : in integer;
            OPCODE : in std_logic_vector(2 downto 0);
            DETER_MAT_A, DETER_MAT_B, DETER_MAT_D : out std_logic_vector(7 downto 0);
            OPERAND_11_D, OPERAND_12_D, OPERAND_21_D, OPERAND_22_D : out std_logic_vector(7 downto 0);
            OPERAND_11_A, OPERAND_12_A, OPERAND_21_A, OPERAND_22_A : in std_logic_vector(7 downto 0);
            OPERAND_11_B, OPERAND_12_B, OPERAND_21_B, OPERAND_22_B : in std_logic_vector(7 downto 0)
        );
    end component;

    COMPONENT RAM
        port (
            PRG_CNT : in integer;
            RAM_ADDR_A, RAM_ADDR_B : in std_logic_vector(4 downto 0);
            RAM_MATRIX_IN_11, RAM_MATRIX_IN_12, RAM_MATRIX_IN_21, RAM_MATRIX_IN_22 : in std_logic_vector(7 downto 0);
            RAM_WR : in std_logic;
            RAM_MATRIX_OUT_11_A, RAM_MATRIX_OUT_12_A, RAM_MATRIX_OUT_21_A, RAM_MATRIX_OUT_22_A : out std_logic_vector(7 downto 0);
            RAM_MATRIX_OUT_11_B, RAM_MATRIX_OUT_12_B, RAM_MATRIX_OUT_21_B, RAM_MATRIX_OUT_22_B : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Utility signal definitions here
    signal PRG_CNT_DECODER, PRG_CNT_ALU, PRG_CNT_RAM : integer;
    -- Deklarasi sinyal utilitas
    signal OPCODE : std_logic_vector(2 downto 0);
    signal OP1_ADDR, OP2_ADDR, OP3_ADDR : std_logic_vector(4 downto 0);
    signal RAM_MATRIX_OUT_11_A, RAM_MATRIX_OUT_12_A, RAM_MATRIX_OUT_21_A, RAM_MATRIX_OUT_22_A : std_logic_vector(7 downto 0);
    signal RAM_MATRIX_OUT_11_B, RAM_MATRIX_OUT_12_B, RAM_MATRIX_OUT_21_B, RAM_MATRIX_OUT_22_B : std_logic_vector(7 downto 0);
    signal OPERAND_11_D, OPERAND_12_D, OPERAND_21_D, OPERAND_22_D : std_logic_vector(7 downto 0);

    -- Create state types for FSM here (according to FSM diagram) 
    type CPU_State is (IDLE, FETCH, DECODE, READ_MEM, EXECUTE, COMPLETE);
    signal current_state, next_state : CPU_State;

    -- Initialize Program counter
    signal program_counter : integer := 0;

    -- Initialize other signals as needed

begin
    -- Port Map components here
    ALU1 : ALU port map (
        PRG_CNT => 0,
        OPCODE => OPCODE,
        OPERAND_11_A => RAM_MATRIX_OUT_11_A,
        OPERAND_12_A => RAM_MATRIX_OUT_12_A,
        OPERAND_21_A => RAM_MATRIX_OUT_21_A,
        OPERAND_22_A => RAM_MATRIX_OUT_22_A,
        OPERAND_11_B => RAM_MATRIX_OUT_11_B,
        OPERAND_12_B => RAM_MATRIX_OUT_12_B,
        OPERAND_21_B => RAM_MATRIX_OUT_21_B,
        OPERAND_22_B => RAM_MATRIX_OUT_22_B,
        OPERAND_11_D => OPERAND_11_D,
        OPERAND_12_D => OPERAND_12_D,
        OPERAND_21_D => OPERAND_21_D,
        OPERAND_22_D => OPERAND_22_D
    );

    DECODER1 : DECODER port map (
        PRG_CNT => 0,
        INSTRUCTION => INSTRUCTION_IN,
        OPCODE => OPCODE,
        OP1_ADDR => OP1_ADDR,
        OP2_ADDR => OP2_ADDR,
        OP3_ADDR => OP3_ADDR
    );

    RAM1 : RAM port map (
        PRG_CNT => 0,
        RAM_ADDR_A => OP1_ADDR,
        RAM_ADDR_B => OP2_ADDR,
        RAM_MATRIX_IN_11 => OPERAND_11_D,
        RAM_MATRIX_IN_12 => OPERAND_12_D,
        RAM_MATRIX_IN_21 => OPERAND_21_D,
        RAM_MATRIX_IN_22 => OPERAND_22_D,
        RAM_WR => '0',
        RAM_MATRIX_OUT_11_A => RAM_MATRIX_OUT_11_A,
        RAM_MATRIX_OUT_12_A => RAM_MATRIX_OUT_12_A,
        RAM_MATRIX_OUT_21_A => RAM_MATRIX_OUT_21_A,
        RAM_MATRIX_OUT_22_A => RAM_MATRIX_OUT_22_A,
        RAM_MATRIX_OUT_11_B => RAM_MATRIX_OUT_11_B,
        RAM_MATRIX_OUT_12_B => RAM_MATRIX_OUT_12_B,
        RAM_MATRIX_OUT_21_B => RAM_MATRIX_OUT_21_B,
        RAM_MATRIX_OUT_22_B => RAM_MATRIX_OUT_22_B
    );


-- CPU Process here, use the CPU clock as the sensitivity list and have the process run on rising edge triggered
CPU_Process : process (CPU_CLK)
begin
    if rising_edge(CPU_CLK) then
        -- FSM logic here
        case current_state is
            when IDLE =>
                -- When idle state, wait for enable to be '1'
                if ENABLE = '1' then
                    next_state <= FETCH;
                else
                    next_state <= IDLE;
                end if;

            when FETCH =>
                -- When fetch, receive instruction input
                -- Implement the logic to fetch the instruction and update program_counter
                -- Assuming INSTRUCTION_IN is a 19-bit instruction
                program_counter <= program_counter + 1;
                next_state <= DECODE;

            when DECODE =>
                -- When decode, pass arguments to decoder component
                -- Implement the logic to pass arguments to the DECODER component
                PRG_CNT_DECODER <= program_counter;
                next_state <= READ_MEM;

            when READ_MEM =>
                -- When read memory, read from RAM and store as operands
                -- Implement the logic to read from RAM and update the operands
                PRG_CNT_RAM <= program_counter;
                next_state <= EXECUTE;

            when EXECUTE =>
                -- When execute, pass arguments to ALU component, then write back to RAM
                -- Implement the logic to pass arguments to the ALU component and write back to RAM
                PRG_CNT_ALU <= program_counter;
                next_state <= COMPLETE;

            when COMPLETE =>
                -- When complete, print report statement to notify instruction complete
                -- Implement the logic to print a report statement or perform other actions
                report "Instruction complete at Program Counter " & integer'image(program_counter);
                next_state <= IDLE;

            when others =>
                next_state <= IDLE;
        end case;

        current_state <= next_state;
    end if;
end process;

end architecture rtl;
=======
    
begin
    
    
    
end architecture rtl;
>>>>>>> fce736ebebb9046ea53d987ddf953287e6b6855c
