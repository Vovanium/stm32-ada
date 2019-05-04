with STM32.F429Z;          use STM32.F429Z;
use STM32.F429Z.Modules.GPIO;
use STM32.F429Z.Modules.USART;
use STM32.F429Z.Modules.RCC;

with Ada.Real_Time;        use Ada.Real_Time;

procedure UART_429Disco is
	UART_Port: GPIO_Registers renames GPIOA;
	UART_TX_Bit: constant Port_Bit_Number := 9;
	UART_RX_Bit: constant Port_Bit_Number := 10;

	APB2_Frequency : constant := 42_000_000; -- Set by board support
	Baud_Rate : constant := 19_200;
	--Ratio : constant := (APB2_Frequency + Baud_Rate / 2) / Baud_Rate;
	Ratio : constant := 128;

	Period: constant Time_Span := Milliseconds(500);
	Now: Time := Clock;


begin
	-- clock test
	RCC.AHB1ENR.GPIOC := True;
	RCC.CFGR.MCO2PRE := MCO_Prescaler_5;
	RCC.CFGR.MCO2 := Clock_Output_2_SYSCLK;
	
	GPIOC.OTYPER(9) := Push_Pull_Type;
	GPIOC.OSPEEDR(9) := Very_High_Speed;
	GPIOC.AFR(9) := Alternate_Functions.SYS;
	GPIOC.MODER(9) := Alternate_Mode;

	--


	RCC.AHB1ENR.GPIOA := True;

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

	--RCC.CFGR.PPRE2 := APB_Prescaler_4;

	RCC.APB2ENR.USART1 := True;
	
	USART1.CR2.STOP := Stop_1_Bit;
	USART1.CR1.M := Word_8_Bits;
	USART1.CR1.PCE := False;
	USART1.CR1.TE := True;
	USART1.CR1.RE := True;
	USART1.CR3.CTSE := False;
	USART1.CR3.RTSE := False;

	USART1.BRR.DIV_Mantissa := Ratio / 16;
	USART1.BRR.DIV_Fraction := Ratio mod 16;

	USART1.CR1.UE := True;
	
	loop
		USART1.DR := 16#55#; --Character'Pos('!');
		Now := Now + Period;
		delay until Now;
	end loop;

end UART_429Disco;