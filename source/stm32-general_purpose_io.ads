with Interfaces;
with STM32.Registers.GPIO;

package STM32.General_Purpose_IO is
	-- Single GPIO pin
	generic
		Register: in out Registers.GPIO.GPIO_Registers;
		Bit: Registers.GPIO.Port_Bit_Number;
	package GPIO_Port_Boolean is
		procedure Set(Value: Boolean) with Inline; -- Output to port
		function Value return Boolean with Inline; -- Read port
	end GPIO_Port_Boolean;

	-- Multi-pin GPIO
	generic
		type Format is mod <>;
		Register: in out Registers.GPIO.GPIO_Registers;
		First_Bit: Registers.GPIO.Port_Bit_Number;
		Last_Bit: Registers.GPIO.Port_Bit_NUmber;
	package GPIO_Port_Modular is
		procedure Set(Value: Format) with Inline;
		function Value return Format with Inline;
	end GPIO_Port_Modular;

end STM32.General_Purpose_IO;
