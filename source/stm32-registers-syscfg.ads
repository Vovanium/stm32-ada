package STM32.Registers.SysCfg is
	pragma Pure;

	type Memory_Mapping is (
		Main_Flash,
		System_Flash,
		FSMC_Bank_1,
		Embedded_SRAM
	);

	for Memory_Mapping use (
		Main_Flash => 2#00#,
		System_Flash => 2#01#,
		FSMC_Bank_1 => 2#10#,
		Embedded_SRAM => 2#11#
	);

	type Memory_Remap_Register is record
		MEM_MODE: Memory_Mapping;
		Reserved_2: Integer range 0 .. 2**30 - 1;
	end record with Size => 32;

	for Memory_Remap_Register use record
		MEM_MODE at 0 range 0 .. 1;
		Reserved_2 at 0 range 2 .. 31;
	end record;

	type Ethernet_Phy_Interface is (
		MII,
		RMII
	);

	for Ethernet_Phy_Interface use (
		MII => 0,
		RMII => 1
	);
	type Peripherial_Mode_Register is record
		Reserved_0: Integer range 0 .. 2**23 - 1;
		MII_RMII_SEL: Ethernet_Phy_Interface;
		Reserved_24: Integer range 0 .. 2**8 - 1;
	end record with Size => 32;

	for Peripherial_Mode_Register use record
		Reserved_0 at 0 range 0 .. 22;
		MII_RMII_SEL at 0 range 23 .. 23;
		Reserved_24 at 0 range 24 .. 31;
	end record;

	type Peripherial_Interrupt_Pin is (
		PA_Pin, PB_Pin, PC_Pin, PD_Pin,
		PE_Pin, PF_Pin, PG_Pin, PH_Pin,
		PI_Pin
	);

	for Peripherial_Interrupt_Pin use (
		PA_Pin => 2#0000#, PB_Pin => 2#0001#,
		PC_Pin => 2#0010#, PD_Pin => 2#0011#,
		PE_Pin => 2#0100#, PF_Pin => 2#0101#,
		PG_Pin => 2#0110#, PH_Pin => 2#0111#,
		PI_Pin => 2#1000#
	);

	generic
		Base: Integer;
	package External_Interrupt_Configuration is
		type Configuration_Array is
		array (Base .. Base+3) of Peripherial_Interrupt_Pin with Pack, Size => 16;

		type Register is record
			EXTI: Configuration_Array;
			Reserved_16: Integer range 0 .. 2**16 - 1;
		end record with Size => 32;

		for Register use record
			EXTI at 0 range 0 .. 15;
			Reserved_16 at 0 range 16 .. 31;
		end record;
	end External_Interrupt_Configuration;

	package External_Interrupt_Configuration_1 is
	new External_Interrupt_Configuration(0);

	package External_Interrupt_Configuration_2 is
	new External_Interrupt_Configuration(4);

	package External_Interrupt_Configuration_3 is
	new External_Interrupt_Configuration(8);

	package External_Interrupt_Configuration_4 is
	new External_Interrupt_Configuration(12);

	type Compensation_Cell_Power_Down_Mode is (
		Compensation_Cell_Power_Down,
		Compensation_Cell_Enabled
	);

	for Compensation_Cell_Power_Down_Mode use (
		Compensation_Cell_Power_Down => 0,
		Compensation_Cell_Enabled => 1
	);

	type Compensation_Cell_Control_Register is record
		CMP_PD: Compensation_Cell_Power_Down_Mode;
		Reserved_1: Integer range 0 .. 2**7 - 1;
		READY: Boolean;
		Reserved_9: Integer range 0 .. 2**23 - 1;
	end record with Size => 32;

	for Compensation_Cell_Control_Register use record
		CMP_PD at 0 range 0 .. 0;
		Reserved_1 at 0 range 1 .. 7;
		READY at 0 range 8 .. 8;
		Reserved_9 at 0 range 9 .. 31;
	end record;

	type SYSCFG_Registers is record
		MEMRMP: Memory_Remap_Register;
		PMC: Peripherial_Mode_Register;
		EXTICR1: External_Interrupt_Configuration_1.Register;
		EXTICR2: External_Interrupt_Configuration_2.Register;
		EXTICR3: External_Interrupt_Configuration_3.Register;
		EXTICR4: External_Interrupt_Configuration_4.Register;
		CMPCR: Compensation_Cell_Control_Register;
	end record;

	for SYSCFG_Registers use record
		MEMRMP  at 16#00# range 0 .. 31;
		PMC     at 16#04# range 0 .. 31;
		EXTICR1 at 16#08# range 0 .. 31;
		EXTICR2 at 16#0C# range 0 .. 31;
		EXTICR3 at 16#10# range 0 .. 31;
		EXTICR4 at 16#14# range 0 .. 31;
		CMPCR   at 16#20# range 0 .. 31;
	end record;

end STM32.Registers.SysCfg;
