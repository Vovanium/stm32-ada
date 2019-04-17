with Interfaces;

package STM32.STM32F4.GPIO.Ports is
	-- Single GPIO pin
	generic
		Register: in out GPIO_Registers;
		Bit: Port_Bit_Number;
	package GPIO_Port_Boolean is
		procedure Set(Value: Boolean) with Inline; -- Output to port
		function Value return Boolean with Inline; -- Read port
	end GPIO_Port_Boolean;

	-- Multi-pin GPIO
	generic
		type Value_Type is mod <>;
		Register: in out GPIO_Registers;
		First_Bit: Port_Bit_Number;
		Last_Bit: Port_Bit_Number;
	package GPIO_Port_Modular is
		procedure Set(Value: Value_Type) with Inline;
		function Value return Value_Type with Inline;
	end GPIO_Port_Modular;

end STM32.STM32F4.GPIO.Ports;
