with STM32.F429Z;          use STM32.F429Z;
use STM32.F429Z.Modules.GPIO;
use STM32.F429Z.Modules.USART;
use STM32.F429Z.Modules.RCC;

with Ada.Real_Time;        use Ada.Real_Time;

procedure UART_429Disco is
	UART_Port: GPIO_Registers renames GPIOA;
	UART_TX_Bit: constant Port_Bit_Number := 9;
	UART_RX_Bit: constant Port_Bit_Number := 10;

	APB2_Frequency : constant := 90_000_000; -- Set by board support
	Baud_Rate : constant := 115_200;
	Ratio : constant := (APB2_Frequency + Baud_Rate / 2) / Baud_Rate;
	--Ratio : constant := 128;

	Period: constant Time_Span := Milliseconds(10);
	Now: Time := Clock;


begin
	-- clock test

	--RCC.CFGR.HPRE := AHB_Prescaler_1;
	--RCC.CFGR.PPRE2 := APB_Prescaler_2;

	
	RCC.AHB1ENR.GPIOC := True;
	RCC.CFGR.MCO2PRE := MCO_Prescaler_5;
	RCC.CFGR.MCO2 := Clock_Output_2_SYSCLK;
	
	GPIOC.OTYPER(9) := Push_Pull_Type;
	GPIOC.OSPEEDR(9) := Very_High_Speed;
	GPIOC.AFR(9) := Alternate_Functions.SYS;
	GPIOC.MODER(9) := Alternate_Mode;

	RCC.AHB1ENR.GPIOA := True;


	RCC.APB2ENR.USART1 := True;

	RCC.APB2RSTR.USART1 := True;

	RCC.APB2RSTR.USART1 := False;
	

	--

	UART_Port.OTYPER(UART_TX_Bit) := Push_Pull_Type;
	UART_Port.OSPEEDR(UART_TX_Bit) := Very_High_Speed;
	UART_Port.PUPDR(UART_TX_Bit) := Pull_Down;
	UART_Port.AFR(UART_TX_Bit) := Alternate_Functions.USART1;
	UART_Port.MODER(UART_TX_Bit) := Alternate_Mode;

	UART_Port.OTYPER(UART_RX_Bit) := Push_Pull_Type;
	UART_Port.OSPEEDR(UART_RX_Bit) := Very_High_Speed;
	UART_Port.PUPDR(UART_RX_Bit) := No_Pull;
	UART_Port.AFR(UART_RX_Bit) := Alternate_Functions.USART1;
	UART_Port.MODER(UART_RX_Bit) := Alternate_Mode;

	-- UART initialisation (close to ST's HAL)

	USART1.CR1.UE := False;


	declare
		CR1: Control_Register_1 := USART1.CR1;
	begin
		CR1.M := Word_8_Bits;
		CR1.PCE := False;
		CR1.PS := Even_Parity;
		CR1.TE := True;
		CR1.RE := True;
		CR1.OVER8 := False;
		
		USART1.CR1 := CR1;
	end;

	declare
		CR3: Control_Register_3 := USART1.CR3;
	begin
		CR3.CTSE := False;
		CR3.RTSE := False;
		USART1.CR3 := CR3;
	end;

	declare
		BRR: STM32.F429Z.Modules.USART.Baud_Rate_Register := USART1.BRR;
	begin
		--USART1.BRR := (DIV_Mantissa: Ratio / 16, DIV_Fraction: Ratio mod 16, others => 0);
		BRR.DIV_Mantissa := Ratio / 16;
		BRR.DIV_Fraction := Ratio mod 16;

		USART1.BRR := BRR;
	end;

	declare
		CR2: Control_Register_2 := USART1.CR2;
	begin
		CR2.LINEN := False;
		CR2.CLKEN := False;
		CR2.STOP := Stop_1_Bit;

		USART1.CR2 := CR2;
	end;

	declare
		CR3: Control_Register_3 := USART1.CR3;
	begin
		CR3.SCEN := False;
		CR3.HDSEL := False;
		CR3.IREN := False;

		USART1.CR3 := CR3;
	end;

	--USART1.GTPR.PSC := 1;

	USART1.CR1.UE := True;
	
	loop
		USART1.DR := 16#40#; --Character'Pos('!');
		Now := Now + Period;
		delay until Now;
	end loop;

end UART_429Disco;