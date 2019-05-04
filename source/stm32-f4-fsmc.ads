with Interfaces;
package STM32.F4.FSMC is
	pragma Pure;
	type Memory_Type is (
		SRAM,
		PSRAM,
		NOR_Flash
	);

	type Memory_Databus_Width is (
		Databus_8_bit,
		Databus_16_bit
	);

	for Memory_Databus_Width use (
		Databus_8_bit => 2#00#,
		Databus_16_bit => 2#01#
	);

	type CRAM_Page_Size is (
		CRAM_No_Burst_Split,
		CRAM_Page_128_Bytes,
		CRAM_Page_256_Bytes,
		CRAM_Page_512_Bytes,
		CRAM_Page_1024_Bytes
	);

	for CRAM_Page_Size use (
		CRAM_No_Burst_Split => 2#000#,
		CRAM_Page_128_Bytes => 2#001#,
		CRAM_Page_256_Bytes => 2#010#,
		CRAM_Page_512_Bytes => 2#011#,
		CRAM_Page_1024_Bytes => 2#100#
	);

	type FSMC_BCR is record
		MBKEN: Boolean;
		MUXEN: Boolean;
		MTYP: Memory_Type;
		MWID: Memory_Databus_Width;
		FACCEN: Boolean;
		Reserved_7: Integer range 0 .. 2**1 - 1;
		BURSTEN: Boolean;
		WAITPOL: Boolean;
		WRAPMOD: Boolean;
		WAITCFG: Boolean;
		WREN: Boolean;
		WAITEN: Boolean;
		EXTMOD: Boolean;
		ASYNCWAIT: Boolean;
		CPSIZE: CRAM_Page_Size;
		CBURSTRW: Boolean;
		Reserved_20: Integer range 0 .. 2**12 - 1;
	end record with Size => 32;

	for FSMC_BCR use record
		MBKEN at 0 range 0 .. 0;
		MUXEN at 0 range 1 .. 1;
		MTYP at 0 range 2 .. 3;
		MWID at 0 range 4 .. 5;
		FACCEN at 0 range 6 .. 6;
		Reserved_7 at 0 range 7 .. 7;
		BURSTEN at 0 range 8 .. 8;
		WAITPOL at 0 range 9 .. 9;
		WRAPMOD at 0 range 10 .. 10;
		WAITCFG at 0 range 11 .. 11;
		WREN at 0 range 12 .. 12;
		WAITEN at 0 range 13 .. 13;
		EXTMOD at 0 range 14 .. 14;
		ASYNCWAIT at 0 range 15 .. 15;
		CPSIZE at 0 range 16 .. 18;
		CBURSTRW at 0 range 19 .. 19;
		Reserved_20 at 0 range 20 .. 31;
	end record;

	type FSMC_Access_Mode is (
		Access_Mode_A,
		Access_Mode_B,
		Access_Mode_C,
		Access_Mode_D
	);

	for FSMC_Access_Mode use (
		Access_Mode_A => 0,
		Access_Mode_B => 1,
		Access_Mode_C => 2,
		Access_Mode_D => 3
	);

	type FSMC_BTR is record
		ADDSET: Integer range 0 .. 2**4 - 1; -- Address setup duration
		ADDHLD: Integer range 1 .. 2**4 - 1; -- Address hold phase duration
		DATAST: Integer range 1 .. 2**8 - 1; -- Data phase duration
		BUSTURN: Integer range 0 .. 2**4 - 1; -- Bus turnaround delay
		CLKDIV: Integer range 0 .. 2**4 - 1; -- Clock divide ratio (offset by 1)
		DATLAT: Integer range 0 .. 2**4 - 1; -- Data latenct (offset by 2)
		ACCMOD: FSMC_Access_Mode;
		Reserved_30: Integer range 0 .. 2**2 - 1;
	end record with Size => 32;

	for FSMC_BTR use record
		ADDSET at 0 range 0 .. 3;
		ADDHLD at 0 range 4 .. 7;
		DATAST at 0 range 8 .. 15;
		BUSTURN at 0 range 16 .. 19;
		CLKDIV at 0 range 20 .. 23;
		DATLAT at 0 range 24 .. 27;
		ACCMOD at 0 range 28 .. 29;
		Reserved_30 at 0 range 30 .. 31;
	end record;

	type FSMC_BWTR is record
		ADDSET: Integer range 0 .. 2**4 - 1;
		ADDHLD: Integer range 0 .. 2**4 - 1;
		DATAST: Integer range 0 .. 2**8 - 1;
		BUSTURN: Integer range 0 .. 2**4 - 1;
		Reserved_20: Integer range 0 .. 2**8 - 1;
		ACCMOD: Integer range 0 .. 2**2 - 1;
		Reserved_30: Integer range 0 .. 2**2 - 1;
	end record with Size => 32;

	for FSMC_BWTR use record
		ADDSET at 0 range 0 .. 3;
		ADDHLD at 0 range 4 .. 7;
		DATAST at 0 range 8 .. 15;
		BUSTURN at 0 range 16 .. 19;
		Reserved_20 at 0 range 20 .. 27;
		ACCMOD at 0 range 28 .. 29;
		Reserved_30 at 0 range 30 .. 31;
	end record;

	type P_Memory_Type is (
		PC_Card,
		NAND_Flash
	);

	for P_Memory_Type use (
		PC_Card => 0,
		NAND_Flash => 1
	);

	type ECC_Page_Size is (
		ECC_Page_256_Bytes,
		ECC_Page_512_Bytes,
		ECC_Page_1024_Bytes,
		ECC_Page_2048_Bytes,
		ECC_Page_4096_Bytes,
		ECC_Page_8192_Bytes
	);

	for ECC_Page_Size use (
		ECC_Page_256_Bytes => 2#000#,
		ECC_Page_512_Bytes => 2#001#,
		ECC_Page_1024_Bytes => 2#010#,
		ECC_Page_2048_Bytes => 2#011#,
		ECC_Page_4096_Bytes => 2#100#,
		ECC_Page_8192_Bytes => 2#101#
	);

	-- PC Card / NAND flash control registers
	type FSMC_PCR is record
		Reserved_0: Integer range 0 .. 1;
		PWAITEN: Boolean;
		PBKEN: Boolean;
		PTYP: P_Memory_Type;
		PWID: Memory_Databus_Width;
		ECCEN: Boolean; -- ECC computation enable
		Reserved_7: Integer range 0 .. 2**2 - 1;
		TCLR: Integer range 0 .. 2**4 - 1; -- CLE-RE delay (offset by 1)
		TAR: Integer range 0 .. 2**4 - 1; -- ALE-RE delay (offset by 1)
		ECCPS: ECC_Page_Size;
		Reserved_20: Integer range 0 .. 2**12 - 1;
	end record with Size => 32;

	for FSMC_PCR use record
		Reserved_0 at 0 range 0 .. 0;
		PWAITEN at 0 range 1 .. 1;
		PBKEN at 0 range 2 .. 2;
		PTYP at 0 range 3 .. 3;
		PWID at 0 range 4 .. 5;
		ECCEN at 0 range 6 .. 6;
		Reserved_7 at 0 range 7 .. 8;
		TCLR at 0 range 9 .. 12;
		TAR at 0 range 13 .. 16;
		ECCPS at 0 range 17 .. 19;
		Reserved_20 at 0 range 20 .. 31;
	end record;

	type FSMC_SR is record
		IRS: Boolean;
		ILS: Boolean;
		IFS: Boolean;
		IREN: Boolean;
		ILEN: Boolean;
		IFEN: Boolean;
		FEMPT: Boolean;
		Reserved_7: Integer range 0 .. 2**25 - 1;
	end record with Size => 32;

	for FSMC_SR use record
		IRS        at 0 range 0 .. 0;
		ILS        at 0 range 1 .. 1;
		IFS        at 0 range 2 .. 2;
		IREN       at 0 range 3 .. 3;
		ILEN       at 0 range 4 .. 4;
		IFEN       at 0 range 5 .. 5;
		FEMPT      at 0 range 6 .. 6;
		Reserved_7 at 0 range 7 .. 31;
	end record;

	type FSMC_PMEM is record
		MEMSET: Integer range 0 .. 2**8 - 1;
		MEMWAIT: Integer range 0 .. 2**8 - 1;
		MEMHOLD: Integer range 0 .. 2**8 - 1;
		MEMHIZ: Integer range 0 .. 2**8 - 1;
	end record with Size => 32;

	for FSMC_PMEM use record
		MEMSET  at 0 range  0 .. 7;
		MEMWAIT at 0 range  8 .. 15;
		MEMHOLD at 0 range 16 .. 23;
		MEMHIZ  at 0 range 24 .. 31;
	end record;

	type FSMC_PATT is record
		ATTSET: Integer range 0 .. 2**8 - 1;
		ATTWAIT: Integer range 0 .. 2**8 - 1;
		ATTHOLD: Integer range 0 .. 2**8 - 1;
		ATTHIZ: Integer range 0 .. 2**8 - 1;
	end record with Size => 32;

	for FSMC_PATT use record
		ATTSET  at 0 range  0 .. 7;
		ATTWAIT at 0 range  8 .. 15;
		ATTHOLD at 0 range 16 .. 23;
		ATTHIZ  at 0 range 24 .. 31;
	end record;

	type FSMC_PIO is record
		IOSET: Integer range 0 .. 2**8 - 1;
		IOWAIT: Integer range 0 .. 2**8 - 1;
		IOHOLD: Integer range 0 .. 2**8 - 1;
		IOHIZ: Integer range 0 .. 2**8 - 1;
	end record with Size => 32;

	for FSMC_PIO use record
		IOSET  at 0 range  0 .. 7;
		IOWAIT at 0 range  8 .. 15;
		IOHOLD at 0 range 16 .. 23;
		IOHIZ  at 0 range 24 .. 31;
	end record;

	type FSMC_Registers is record
		BCR1: FSMC_BCR;
		BCR2: FSMC_BCR;
		BCR3: FSMC_BCR;
		BCR4: FSMC_BCR;
		BTR1: FSMC_BTR;
		BTR2: FSMC_BTR;
		BTR3: FSMC_BTR;
		BTR4: FSMC_BTR;
		BWTR1: FSMC_BWTR;
		BWTR2: FSMC_BWTR;
		BWTR3: FSMC_BWTR;
		BWTR4: FSMC_BWTR;
		PCR2: FSMC_PCR;
		PCR3: FSMC_PCR;
		PCR4: FSMC_PCR;
		SR2: FSMC_SR;
		SR3: FSMC_SR;
		SR4: FSMC_SR;
		PMEM2: FSMC_PMEM;
		PMEM3: FSMC_PMEM;
		PMEM4: FSMC_PMEM;
		PATT2: FSMC_PATT;
		PATT3: FSMC_PATT;
		PATT4: FSMC_PATT;
		PIO4: FSMC_PIO;
		ECCR2: Interfaces.Unsigned_32;
		ECCR3: Interfaces.Unsigned_32;
	end record with Volatile;

	for FSMC_Registers use record
		BCR1  at 16#0000# range 0 .. 31;
		BCR2  at 16#0008# range 0 .. 31;
		BCR3  at 16#0010# range 0 .. 31;
		BCR4  at 16#0018# range 0 .. 31;
		BTR1  at 16#0004# range 0 .. 31;
		BTR2  at 16#000C# range 0 .. 31;
		BTR3  at 16#0014# range 0 .. 31;
		BTR4  at 16#001C# range 0 .. 31;
		BWTR1 at 16#0104# range 0 .. 31;
		BWTR2 at 16#010C# range 0 .. 31;
		BWTR3 at 16#0114# range 0 .. 31;
		BWTR4 at 16#011C# range 0 .. 31;
		PCR2  at 16#0060# range 0 .. 31;
		PCR3  at 16#0080# range 0 .. 31;
		PCR4  at 16#00A0# range 0 .. 31;
		SR2   at 16#0064# range 0 .. 31;
		SR3   at 16#0084# range 0 .. 31;
		SR4   at 16#00A4# range 0 .. 31;
		PMEM2 at 16#0068# range 0 .. 31;
		PMEM3 at 16#0088# range 0 .. 31;
		PMEM4 at 16#00A8# range 0 .. 31;
		PATT2 at 16#006C# range 0 .. 31;
		PATT3 at 16#008C# range 0 .. 31;
		PATT4 at 16#00AC# range 0 .. 31;
		PIO4  at 16#00B0# range 0 .. 31;
		ECCR2 at 16#0074# range 0 .. 31;
		ECCR3 at 16#0094# range 0 .. 31;
	end record;

end STM32.F4.FSMC;
