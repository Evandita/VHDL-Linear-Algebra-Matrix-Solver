# Linear Algebra Matrix Solver
Linear Algebra Matrix Solver merupakan simple computer yang dirancang khusus untuk menyelesaikan berbagai permasalahan matriks pada aljabar linear. Rangkaian matriks prosesor ini memiliki ISA yang dapat memberikan solusi atas permasalahan matriks berordo 3x3. ISA tersebut terdiri dari penjumlahan matriks A dan B, pengurangan matriks A dan B, perkalian matriks A dan B, pencerminan matriks A terhadap sumbu x, pencerminan matriks A terhadap sumbu y, pencerminan matriks A terhadap sumbu z, transpose matriks A, dan kofaktor matriks A. Selain itu, terdapat tambahan determinan matriks yang ditempatkan pada bagian dataflow. 

## Rangkaian 
![Rangkaian_PSD_PA](https://github.com/Evandita/Proyek-Akhir-PSD-Kelompok-BP06/assets/144194402/8eea290c-3778-47a8-99fb-530f40d9b9ae)
Rangkaian Linear Algebra Matrix Solver memiliki empat komponen utama, yakni Matrix Processor, Decoder, ALU, dan RAM. Alur kerjanya dimulai dari **Matrix Processor** yang bertugas mengatur alur eksekusi program dan menerima instruksi. Instruksi yang diterima akan dipecah menjadi beberapa bagian oleh **Decoder**. Instruksi yang sudah dipecah akan dieksekusi oleh **ALU**, sehingga didapatkan solusi dari permasalahan matriks Aljabar Linear. Pada akhirnya, solusi tersebut akan disimpan ke dalam **RAM**. 

## State Diagram
![StateDiagram_PSD_PA](https://github.com/Evandita/Proyek-Akhir-PSD-Kelompok-BP06/assets/144194402/5074f818-d5e7-4fec-8202-a8047bbbac85)
Dalam program Linear Algebra Matrix Solver terdapat penerapan microprogramming yang berisi state-state yang terlampir pada gambar di atas. **IDLE** merupakan kondisi awal program yang tidak melakukan apapun. Program akan lanjut ke state **FETCH** untuk mengambil instruksi yang akan dilakukan. Setelah mendapatkan instruksi, instruksi akan di-decode pada state **DECODE** menjadi beberapa bagian. Selanjutnya, akan dilakukan pembacaan memori pada state **READ_MEM** untuk mengisi operand. Setelah operand terisi, program akan dieksekusi pada state **EXECUTE** dan hasilnya akan ditulis ke dalam memori. Setelah proses ekseskusi berakhir, program akan menuju ke state **COMPLETE** yang bertugas memunculkan report statement dan akan kembali ke state awal.

## Control Word
![CW_PSD_PA](https://github.com/Evandita/Proyek-Akhir-PSD-Kelompok-BP06/assets/144194402/8d3f8697-e82f-4937-8516-af3fd80ca2e9)
Program Linear Algebra Matrix Solver memiliki control word berukuran 18 bit yang terdiri dari FS berukuran 3 bit, DA berukuran 5 bit, AA berukuran 5 bit, dan BA berukuran 5 bit. FS berfungi untuk menyimpan operand yang akan mengeksekusi operasi matriks Aljabar Linear sesuai instruksi yang dimasukkan. Sementara itu, DA, AA, dan BA bertugas untuk menyimpan alamat register yang akan digunakan untuk menyimpan data operand. 

## Control Word Encoding
![Table_PSD_PA](https://github.com/Evandita/Proyek-Akhir-PSD-Kelompok-BP06/assets/144194402/833d21e4-51e2-472e-b19c-3e293b43ca3f)
Tabel di atas merupakan rincian dari bit code yang terdata dalam program Linear Algebra Matrix Solver. FS memiliki 8 kode yang bisa dijalankan, sedangan DA, AA, dan BA memiliki 32 kode yang bisa digunakan sebagai register. 

## Snippet Code 
### MatrixProcessor
Entitas utama yang mengoordinasikan semua komponen. MatrixProcessor mendefinisikan dan menghubungkan semua komponen lain (ALU, DECODER, dan RAM). MatrixProcessor juga mengontrol alur eksekusi program menggunakan Finite State Machine (FSM) dengan state IDLE, FETCH, DECODE, READ_MEM, EXECUTE, dan COMPLETE.
```vhdl
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
                INSTRUCTION_s <= INSTRUCTION_IN;
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
```

### Decoder
Komponen ini menerima ISA dan program counter sebagai input. Decoder menghasilkan opcode dan alamat untuk tiga operand. Opcode menentukan operasi yang akan dilakukan pada matriks, dan alamat menunjukkan lokasi operand di memori.
```vhdl
        INSTRUCTION <= INSTRUCTION_IN;
        OPCODE <= INSTRUCTION(17 DOWNTO 15); -- Function select
        OP1_ADDR <= INSTRUCTION(14 DOWNTO 10); -- Register DA
        OP2_ADDR <= INSTRUCTION(9 DOWNTO 5); -- Register AA
        OP3_ADDR <= INSTRUCTION(4 DOWNTO 0); -- Register BA
```

### ALU
Komponen ini melakukan operasi aritmatika pada matriks. ALU menerima beberapa input termasuk program counter, opcode, dan dua set operand (A dan B). ALU menghasilkan determinan matriks dan hasil operasi-operasi matriks yang dipilih sesuai opcode.
```vhdl
        CASE OPCODE IS
                -- Penjumlahan matriks
            WHEN "000" =>
                Result_D_11 <= (SIGNED(OPERAND_11_A) + SIGNED(OPERAND_11_B));
                Result_D_12 <= (SIGNED(OPERAND_12_A) + SIGNED(OPERAND_12_B));
                Result_D_13 <= (SIGNED(OPERAND_13_A) + SIGNED(OPERAND_13_B));
                Result_D_21 <= (SIGNED(OPERAND_21_A) + SIGNED(OPERAND_21_B));
                Result_D_22 <= (SIGNED(OPERAND_22_A) + SIGNED(OPERAND_22_B));
                Result_D_23 <= (SIGNED(OPERAND_23_A) + SIGNED(OPERAND_23_B));
                Result_D_31 <= (SIGNED(OPERAND_31_A) + SIGNED(OPERAND_31_B));
                Result_D_32 <= (SIGNED(OPERAND_32_A) + SIGNED(OPERAND_32_B));
                Result_D_33 <= (SIGNED(OPERAND_33_A) + SIGNED(OPERAND_33_B));
                -- Pengurangan matriks
            WHEN "001" =>
                Result_D_11 <= (SIGNED(OPERAND_11_A) - SIGNED(OPERAND_11_B));
                Result_D_12 <= (SIGNED(OPERAND_12_A) - SIGNED(OPERAND_12_B));
                Result_D_13 <= (SIGNED(OPERAND_13_A) - SIGNED(OPERAND_13_B));
                Result_D_21 <= (SIGNED(OPERAND_21_A) - SIGNED(OPERAND_21_B));
                Result_D_22 <= (SIGNED(OPERAND_22_A) - SIGNED(OPERAND_22_B));
                Result_D_23 <= (SIGNED(OPERAND_23_A) - SIGNED(OPERAND_23_B));
                Result_D_31 <= (SIGNED(OPERAND_31_A) - SIGNED(OPERAND_31_B));
                Result_D_32 <= (SIGNED(OPERAND_32_A) - SIGNED(OPERAND_32_B));
                Result_D_33 <= (SIGNED(OPERAND_33_A) - SIGNED(OPERAND_33_B));
                -- Pencerminan matriks sumbu x
            WHEN "010" =>
                Result_D_11 <= (SIGNED(OPERAND_11_A));
                Result_D_12 <= (SIGNED(NOT OPERAND_12_A) + 1);
                Result_D_13 <= (SIGNED(OPERAND_13_A));
                Result_D_21 <= (SIGNED(OPERAND_21_A));
                Result_D_22 <= (SIGNED(NOT OPERAND_22_A) + 1);
                Result_D_23 <= (SIGNED(OPERAND_23_A));
                Result_D_31 <= (SIGNED(OPERAND_31_A));
                Result_D_32 <= (SIGNED(NOT OPERAND_32_A) + 1);
                Result_D_33 <= (SIGNED(OPERAND_33_A));
                -- Pencerminan matriks sumbu y
            WHEN "011" =>
                Result_D_11 <= (SIGNED(NOT OPERAND_11_A) + 1);
                Result_D_12 <= (SIGNED(OPERAND_12_A));
                Result_D_13 <= (SIGNED(OPERAND_13_A));
                Result_D_21 <= (SIGNED(NOT OPERAND_21_A) + 1);
                Result_D_22 <= (SIGNED(OPERAND_22_A));
                Result_D_23 <= (SIGNED(OPERAND_23_A));
                Result_D_31 <= (SIGNED(NOT OPERAND_31_A) + 1);
                Result_D_32 <= (SIGNED(OPERAND_32_A));
                Result_D_33 <= (SIGNED(OPERAND_33_A));
                -- Pencerminan matriks A terhadap sumbu z
            WHEN "100" =>
                Result_D_11 <= (SIGNED(NOT OPERAND_11_A) + 1);
                Result_D_12 <= (SIGNED(NOT OPERAND_12_A) + 1);
                Result_D_13 <= (SIGNED(OPERAND_13_A));
                Result_D_21 <= (SIGNED(NOT OPERAND_21_A) + 1);
                Result_D_22 <= (SIGNED(NOT OPERAND_22_A) + 1);
                Result_D_23 <= (SIGNED(OPERAND_23_A));
                Result_D_31 <= (SIGNED(NOT OPERAND_31_A) + 1);
                Result_D_32 <= (SIGNED(NOT OPERAND_32_A) + 1);
                Result_D_33 <= (SIGNED(OPERAND_33_A));
                -- Transpose matriks A
            WHEN "101" =>
                Result_D_11 <= (SIGNED(OPERAND_11_A));
                Result_D_12 <= (SIGNED(OPERAND_21_A));
                Result_D_13 <= (SIGNED(OPERAND_31_A));
                Result_D_21 <= (SIGNED(OPERAND_12_A));
                Result_D_22 <= (SIGNED(OPERAND_22_A));
                Result_D_23 <= (SIGNED(OPERAND_32_A));
                Result_D_31 <= (SIGNED(OPERAND_13_A));
                Result_D_32 <= (SIGNED(OPERAND_23_A));
                Result_D_33 <= (SIGNED(OPERAND_33_A));
                -- Kofaktor matriks A
            WHEN "110" =>
                Result_D_11 <= resize((SIGNED(OPERAND_22_A) * SIGNED(OPERAND_33_A)) - (SIGNED(OPERAND_23_A) * SIGNED(OPERAND_32_A)), Result_D_11'length);
                Result_D_12 <= resize(-1 * ((SIGNED(OPERAND_21_A) * SIGNED(OPERAND_33_A)) - (SIGNED(OPERAND_23_A) * SIGNED(OPERAND_31_A))), Result_D_12'length);
                Result_D_13 <= resize((SIGNED(OPERAND_21_A) * SIGNED(OPERAND_32_A)) - (SIGNED(OPERAND_22_A) * SIGNED(OPERAND_31_A)), Result_D_13'length);

                Result_D_21 <= resize(-1 * ((SIGNED(OPERAND_12_A) * SIGNED(OPERAND_33_A)) - (SIGNED(OPERAND_13_A) * SIGNED(OPERAND_32_A))), Result_D_21'length);
                Result_D_22 <= resize((SIGNED(OPERAND_11_A) * SIGNED(OPERAND_33_A)) - (SIGNED(OPERAND_13_A) * SIGNED(OPERAND_31_A)), Result_D_22'length);
                Result_D_23 <= resize(-1 * ((SIGNED(OPERAND_11_A) * SIGNED(OPERAND_32_A)) - (SIGNED(OPERAND_12_A) * SIGNED(OPERAND_31_A))), Result_D_23'length);

                Result_D_31 <= resize((SIGNED(OPERAND_12_A) * SIGNED(OPERAND_23_A)) - (SIGNED(OPERAND_13_A) * SIGNED(OPERAND_22_A)), Result_D_31'length);
                Result_D_32 <= resize(-1 * ((SIGNED(OPERAND_11_A) * SIGNED(OPERAND_23_A)) - (SIGNED(OPERAND_13_A) * SIGNED(OPERAND_21_A))), Result_D_32'length);
                Result_D_33 <= resize((SIGNED(OPERAND_11_A) * SIGNED(OPERAND_22_A)) - (SIGNED(OPERAND_12_A) * SIGNED(OPERAND_21_A)), Result_D_33'length);
                -- Perkalian Matriks
            WHEN "111" =>
                Result_D_11 <= resize(SIGNED(OPERAND_11_A) * SIGNED(OPERAND_11_B) + SIGNED(OPERAND_12_A) * SIGNED(OPERAND_21_B) + SIGNED(OPERAND_13_A) * SIGNED(OPERAND_31_B), Result_D_11'length);
                Result_D_12 <= resize(SIGNED(OPERAND_11_A) * SIGNED(OPERAND_12_B) + SIGNED(OPERAND_12_A) * SIGNED(OPERAND_22_B) + SIGNED(OPERAND_13_A) * SIGNED(OPERAND_32_B), Result_D_12'length);
                Result_D_13 <= resize(SIGNED(OPERAND_11_A) * SIGNED(OPERAND_13_B) + SIGNED(OPERAND_12_A) * SIGNED(OPERAND_23_B) + SIGNED(OPERAND_13_A) * SIGNED(OPERAND_33_B), Result_D_13'length);
                Result_D_21 <= resize(SIGNED(OPERAND_21_A) * SIGNED(OPERAND_11_B) + SIGNED(OPERAND_22_A) * SIGNED(OPERAND_21_B) + SIGNED(OPERAND_23_A) * SIGNED(OPERAND_31_B), Result_D_21'length);
                Result_D_22 <= resize(SIGNED(OPERAND_21_A) * SIGNED(OPERAND_12_B) + SIGNED(OPERAND_22_A) * SIGNED(OPERAND_22_B) + SIGNED(OPERAND_23_A) * SIGNED(OPERAND_32_B), Result_D_22'length);
                Result_D_23 <= resize(SIGNED(OPERAND_21_A) * SIGNED(OPERAND_13_B) + SIGNED(OPERAND_22_A) * SIGNED(OPERAND_23_B) + SIGNED(OPERAND_23_A) * SIGNED(OPERAND_33_B), Result_D_23'length);
                Result_D_31 <= resize(SIGNED(OPERAND_31_A) * SIGNED(OPERAND_11_B) + SIGNED(OPERAND_32_A) * SIGNED(OPERAND_21_B) + SIGNED(OPERAND_33_A) * SIGNED(OPERAND_31_B), Result_D_31'length);
                Result_D_32 <= resize(SIGNED(OPERAND_31_A) * SIGNED(OPERAND_12_B) + SIGNED(OPERAND_32_A) * SIGNED(OPERAND_22_B) + SIGNED(OPERAND_33_A) * SIGNED(OPERAND_32_B), Result_D_32'length);
                Result_D_33 <= resize(SIGNED(OPERAND_31_A) * SIGNED(OPERAND_13_B) + SIGNED(OPERAND_32_A) * SIGNED(OPERAND_23_B) + SIGNED(OPERAND_33_A) * SIGNED(OPERAND_33_B), Result_D_33'length);
            WHEN OTHERS =>

        END CASE;
```

### RAM
Komponen ini berfungsi sebagai memori program. RAM menerima beberapa input termasuk program counter, dua alamat RAM, nilai input matriks 3x3, dan sinyal enable untuk write. RAM menghasilkan nilai output matriks 3x3 dari register RAM yang dipilih.
```vhdl
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
```

### TestBench
Program ini digunakan untuk memverifikasi fungsionalitas dari MatrixProcessor. Di sini terdapat clock dan memberikan serangkaian instruksi (ISA) kepada MatrixProcessor, mensimulasikan bagaimana sistem akan beroperasi. Hasilnya kemudian dapat diamati untuk memastikan bahwa sistem berfungsi seperti yang diharapkan.
```vhdl
        enable <= '1';
        INSTRUCTION_IN <= "000000100000000001";
        WAIT FOR period;

        INSTRUCTION_IN <= "001000110000000001";
        WAIT FOR period;

        INSTRUCTION_IN <= "010001000000000000";
        WAIT FOR period;

        INSTRUCTION_IN <= "011001010000000000";
        WAIT FOR period;

        INSTRUCTION_IN <= "100001100000000000";
        WAIT FOR period;

        INSTRUCTION_IN <= "101001110000000000";
        WAIT FOR period;

        INSTRUCTION_IN <= "110010000000000000";
        WAIT FOR period;

        INSTRUCTION_IN <= "111010010000000001";
        WAIT;
```
