with Interfaces;
use Interfaces;

package body STM32.General_Purpose_IO is

	package body GPIO_Port_Boolean is

		procedure Set(Value: Boolean) is
		begin
			Register.BSRR := (
				BR => 2**Bit,
				BS => 2**Bit * Boolean'Pos(Value)
			);
		end;

		function Value return Boolean is
		begin
			return (Register.IDR and 2**Bit) /= 0;
		end;

	end GPIO_Port_Boolean;

	package body GPIO_Port_Modular is

		Size: constant Positive := 1 + Last_Bit - First_Bit;
		Mask: constant Unsigned_16 := 2**(Last_Bit + 1) - 2**First_Bit;

		procedure Set(Value: Format) is
		begin
			Register.BSRR := (
				BR => Mask,
				BS => 2**First_Bit * Unsigned_16(Value)
			);
		end;

		function Value return Format is
		begin
			return Format((Register.IDR / 2**First_Bit) and (2**Size - 1));
		end;

	end GPIO_Port_Modular;

end STM32.General_Purpose_IO;
