with STM32.STM32F407Z;          use STM32.STM32F407Z;
with STM32.General_Purpose_IO;  use STM32.General_Purpose_IO;
with STM32.Registers.GPIO;      use STM32.Registers.GPIO;
with Ada.Real_Time;             use Ada.Real_Time;

procedure LED_Flasher is
	Period: constant Time_Span := Milliseconds(250);
	On_Time: constant Time_Span := Milliseconds(10);
	Now: Time := Clock;
	LED_Port: GPIO_Registers renames GPIOD;
	LED_Bit: constant Port_Bit_Number := 3;
	package LED is new GPIO_Port_Boolean(LED_Port, LED_Bit);
begin
	RCC.AHB1ENR.GPIOD := True;
	LED_Port.MODER(LED_Bit)   := Output_Mode;
	LED_Port.OTYPER(LED_Bit)  := Push_Pull_Type;
	LED_Port.OSPEEDR(LED_Bit) := Very_High_Speed;
	LED_Port.PUPDR(LED_Bit)   := No_Pull;
	loop
		LED.Set(False);
		delay until Now + On_Time;
		LED.Set(True);
		Now := Now + Period;
		delay until Now;
	end loop;
end Led_Flasher;

