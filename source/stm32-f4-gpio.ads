with Interfaces;
use Interfaces;

package STM32.F4.GPIO is
	pragma Pure;

	subtype Port_Bit_Number is Natural range 0 .. 15;

	--  MODER
	type Port_Mode is (
		Input_Mode,
		Output_Mode,
		Alternate_Mode,
		Analog_mode
	) with Size => 2;

	for Port_Mode use (
		Input_Mode => 2#00#,
		Output_Mode => 2#01#,
		Alternate_Mode => 2#10#,
		Analog_Mode => 2#11#
	);
	
	type Port_Mode_Register is array(Port_Bit_Number) of Port_Mode
	with Pack, Size => 32;

	--  OTYPER
	type Output_Type is (
		Push_Pull_Type,
		Open_Low_Type
	) with Size => 1;

	for Output_Type use (
		Push_Pull_Type => 2#0#,
		Open_Low_Type => 2#1#
	);

	pragma Warnings(Off, "16 bits of ""Output_Type_Register"" unused");

	type Output_Type_Register is array(Port_Bit_Number) of Output_Type
	with Pack, Size => 32;

	pragma Warnings(On, "16 bits of ""Output_Type_Register"" unused");

	--  OSPEEDR
	type Output_Speed is (
		Low_Speed,      -- 50pF ---100--- ns
		Medium_Speed,   -- 50pF  20 10 6  ns
		High_Speed,     -- 40pF  10  6 4  ns
		Very_High_Speed -- 30pF   6  4 2.5ns
	) with Size => 2;

	for Output_Speed use (
		Low_Speed       => 2#00#,
		Medium_Speed    => 2#01#,
		High_Speed      => 2#10#,
		Very_High_Speed => 2#11#
	);

	type Output_Speed_Register is array(Port_Bit_Number) of Output_Speed
	with Pack, Size => 32;

	--  PUPDR
	type Port_Pull is (
		No_Pull,
		Pull_Up,
		Pull_Down
	) with Size => 2;

	for Port_Pull use (
		No_Pull   => 2#00#,
		Pull_Up   => 2#01#,
		Pull_Down => 2#10#
	);

	type Port_Pull_Register is array(Port_Bit_Number) of Port_Pull
	with Pack, Size => 32;

	-- BSRR
	type Bit_Set_Reset_Register is record
		BS: Unsigned_16;
		BR: Unsigned_16;
	end record with Size => 32;

	for Bit_Set_Reset_Register use record
		BS at 0 range 0 .. 15;
		BR at 0 range 16 .. 31;
	end record;

	-- LCKR
	type Lock_Bit_Array is array (Port_Bit_Number) of Boolean with Pack, Size => 16;
	type Configuration_Lock_Register is record
		LCK: Lock_Bit_Array;
		LCKK: Boolean;
	end record with Size => 32;

	for Configuration_Lock_Register use record
		LCK  at 0 range  0 .. 15;
		LCKK at 0 range 16 .. 16;
	end record;

	-- AFRL/AFRH
	type Alternate_Function is mod 16;

	package Alternate_Functions is

		--  AFL constants
		SYS       : constant Alternate_Function :=  0;
		TIM1      : constant Alternate_Function :=  1;
		TIM2      : constant Alternate_Function :=  1;
		TIM3      : constant Alternate_Function :=  2;
		TIM4      : constant Alternate_Function :=  2;
		TIM5      : constant Alternate_Function :=  2;
		TIM8      : constant Alternate_Function :=  3;
		TIM9      : constant Alternate_Function :=  3;
		TIM10     : constant Alternate_Function :=  3;
		TIM11     : constant Alternate_Function :=  3;
		I2C1      : constant Alternate_Function :=  4;
		I2C2      : constant Alternate_Function :=  4;
		I2C3      : constant Alternate_Function :=  4;
		SPI1      : constant Alternate_Function :=  5;
		SPI2      : constant Alternate_Function :=  5;
		I2S2      : constant Alternate_Function :=  5;
		I2S2Ext   : constant Alternate_Function :=  5;
		SPI3      : constant Alternate_Function :=  6;
		I2SExt    : constant Alternate_Function :=  6;
		I2S3      : constant Alternate_Function :=  6;
		USART1    : constant Alternate_Function :=  7;
		USART2    : constant Alternate_Function :=  7;
		USART3    : constant Alternate_Function :=  7;
		I2S3Ext   : constant Alternate_Function :=  7;
		UART4     : constant Alternate_Function :=  8;
		UART5     : constant Alternate_Function :=  8;
		USART6    : constant Alternate_Function :=  8;
		CAN1      : constant Alternate_Function :=  9;
		CAN2      : constant Alternate_Function :=  9;
		TIM12     : constant Alternate_Function :=  9;
		TIM13     : constant Alternate_Function :=  9;
		TIM14     : constant Alternate_Function :=  9;
		OTG_FS    : constant Alternate_Function := 10;
		OTG_HS    : constant Alternate_Function := 10;
		ETH       : constant Alternate_Function := 11;
		FSMC      : constant Alternate_Function := 12;
		SDIO      : constant Alternate_Function := 12;
		OTG_FS_B  : constant Alternate_Function := 12;
		DCMI      : constant Alternate_Function := 13;
		EVENTOUT  : constant Alternate_Function := 15;
	
	end Alternate_Functions;

	type Alternate_Function_Register is array (0 .. 15) of Alternate_Function
	with Pack, Size => 64;

	type GPIO_Registers is record
		MODER: Port_Mode_Register;
		OTYPER: Output_Type_Register;
		OSPEEDR: Output_Speed_Register;
		PUPDR: Port_Pull_Register;
		IDR: Interfaces.Unsigned_32;
		ODR: Interfaces.Unsigned_32;
		BSRR: Bit_Set_Reset_Register;
		LCKR: Configuration_Lock_Register;
		AFR: Alternate_Function_Register;
	end record with Volatile;

	for GPIO_Registers use record
		MODER   at 16#00# range 0 .. 31;
		OTYPER  at 16#04# range 0 .. 31;
		OSPEEDR at 16#08# range 0 .. 31;
		PUPDR   at 16#0C# range 0 .. 31;
		IDR     at 16#10# range 0 .. 31;
		ODR     at 16#14# range 0 .. 31;
		BSRR    at 16#18# range 0 .. 31;
		LCKR    at 16#1C# range 0 .. 31;
		AFR     at 16#20# range 0 .. 63;
	end record;

end STM32.F4.GPIO;