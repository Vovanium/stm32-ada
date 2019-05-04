with STM32.F429Z;          use STM32.F429Z;
use STM32.F429Z.Modules.GPIO;
with STM32.F4.GPIO.Ports;  use STM32.F4.GPIO.Ports;
with Ada.Real_Time;        use Ada.Real_Time;

procedure LED_Flasher_429disco is
	Period: constant Time_Span := Milliseconds(250);
	On_Time: constant Time_Span := Milliseconds(10);
	Now: Time := Clock;
	LED_Port: GPIO_Registers renames GPIOG;
	LED_Bit: constant Port_Bit_Number := 13;
	LED_On: constant Boolean := True;
	package LED is new GPIO_Port_Boolean(LED_Port, LED_Bit);
begin
	RCC.AHB1ENR.GPIOG := True;
	LED_Port.MODER(LED_Bit)   := Output_Mode;
	LED_Port.OTYPER(LED_Bit)  := Push_Pull_Type;
	LED_Port.OSPEEDR(LED_Bit) := Very_High_Speed;
	LED_Port.PUPDR(LED_Bit)   := No_Pull;
	loop
		LED.Set(LED_On);
		delay until Now + On_Time;
		LED.Set(not LED_On);
		Now := Now + Period;
		delay until Now;
	end loop;
end Led_Flasher_429disco;

