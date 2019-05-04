with Interfaces;
use Interfaces;
package STM32.F4.USART is
	pragma Pure;

	type Status_Register is record
		PE: Boolean; -- Psrity error
		FE: Boolean; -- Framing error
		NF: Boolean; -- Noise detection flag
		ORE: Boolean; -- Overrun error
		IDLE: Boolean; -- IDLE line detected
		RXNE: Boolean; -- Read data register not empty
		TC: Boolean; -- Transmission complete
		TXE: Boolean; -- Transmit data register empty
		LBD: Boolean; -- LIN break detection flag
		CTS: Boolean; -- CTS flag
		Reserved: Integer range 0 .. 2**22 - 1;
	end record with Size => 32;
	for Status_Register use record
		PE at 0 range 0 .. 0;
		FE at 0 range 1 .. 1;
		NF at 0 range 2 .. 2;
		ORE at 0 range 3 .. 3;
		IDLE at 0 range 4 .. 4;
		RXNE at 0 range 5 .. 5;
		TC at 0 range 6 .. 6;
		TXE at 0 range 7 .. 7;
		LBD at 0 range 8 .. 8;
		CTS at 0 range 9 .. 9;
		Reserved at 0 range 10 .. 31;
	end record;

	type Baud_Rate_Register is record
		DIV_Fraction: Integer range 0 .. 2**4 - 1; -- Fraction of USARTDIV
		DIV_Mantissa: Integer range 0 .. 2**12 - 1; -- Mantissa of USARTDIV
		Reserved: Integer range 0 .. 2**16 - 1;
	end record with Size => 32;
	for Baud_Rate_Register use record
		DIV_Fraction at 0 range 0 .. 3;
		DIV_Mantissa at 0 range 4 .. 15;
		Reserved at 0 range 16 .. 31;
	end record;

	-- Parity selection bit field
	type Parity is (
		Even_Parity, -- Parity bit is cleared when even number of data bits is set, set otherwise
		Odd_Parity -- Parity bit is set when even number of data bits is set, cleared otherwise
	);
	for Parity use (
		Even_Parity => 2#0#,
		Odd_Parity  => 2#1#
	);

	-- Wakeup method field
	type Wakeup_Method is (
		Idle_Line, -- Wakeup on IDLE line detect
		Address_Mark -- Wakeup on address mark detect
	);
	for Wakeup_Method use (
		Idle_Line    => 2#0#,
		Address_Mark => 2#1#
	);

	-- Data word length
	type Word_Length is (
		Word_8_Bits, -- Data word (with parity bit if enabled) consists of 8 bits
		Word_9_Bits -- Data word (with parity bit if enabled) consists of 9 bits
	);
	for Word_Length use (
		Word_8_Bits => 2#0#,
		Word_9_Bits => 2#1#
	);

	type Control_Register_1 is record
		SBK: Boolean; -- Send break
		RWU: Boolean; -- Receiver wakeup
		RE: Boolean; -- Receiver enable
		TE: Boolean; -- Trnsmitter enable
		IDLEIE: Boolean; -- IDLE interrupt enable
		RXNEIE: Boolean; -- RXNE interrupt enable
		TCIE: Boolean; -- Transmission complete interrupt enable
		TXEIE: Boolean; -- TXE interrupt enable
		PEIE: Boolean; -- PE interrupt enable
		PS: Parity; -- Parity selection
		PCE: Boolean; -- Parity control enable
		WAKE: Wakeup_Method; -- Wakeup method
		M: Word_Length; -- Word length
		UE: Boolean; -- USART enable
		Reserved_14: Integer range 0 .. 2**1 - 1;
		OVER8: Boolean; -- Oversampling mode
		Reserved: Integer range 0 .. 2**16 - 1;
	end record with Size => 32;
	for Control_Register_1 use record
		SBK at 0 range 0 .. 0;
		RWU at 0 range 1 .. 1;
		RE at 0 range 2 .. 2;
		TE at 0 range 3 .. 3;
		IDLEIE at 0 range 4 .. 4;
		RXNEIE at 0 range 5 .. 5;
		TCIE at 0 range 6 .. 6;
		TXEIE at 0 range 7 .. 7;
		PEIE at 0 range 8 .. 8;
		PS at 0 range 9 .. 9;
		PCE at 0 range 10 .. 10;
		WAKE at 0 range 11 .. 11;
		M at 0 range 12 .. 12;
		UE at 0 range 13 .. 13;
		Reserved_14 at 0 range 14 .. 14;
		OVER8 at 0 range 15 .. 15;
		Reserved at 0 range 16 .. 31;
	end record;

	-- Line break detection length
	type Lin_Break_Detection_Length is (
		Lin_10_Bit_Break_Detection, -- 10 bits break is detected
		Lin_11_Bit_Break_Detection -- 11 bits break is detected
	);
	for Lin_Break_Detection_Length use (
		LIN_10_Bit_Break_Detection => 2#0#,
		LIN_11_Bit_Break_Detection => 2#1#
	);

	type Clock_Phase is (
		First_Edge_Capture, -- Data captured on first clock edge
		Second_Edge_Capture -- Deta set on first clock edge, captured on second edge
	);
	for Clock_Phase use (
		First_Edge_Capture => 2#0#,
		Second_Edge_Capture => 2#1#
	);
	
	type Clock_Polarity is (
		Positive_Pulse, -- Steady low value on CK outside transmission window
		Negative_Pulse -- Steady high value on CK outside transmission window
	);
	for Clock_Polarity use (
		Positive_Pulse => 2#0#,
		Negative_Pulse => 2#1#
	);

	-- Number of stop bits
	type Stop_Bit_Count is(
		Stop_1_Bit, -- 1 stop bit
		Stop_0_5_Bits, -- 0.5 stop bits
		Stop_2_Bits, -- 2 stop bits
		Stop_1_5_Bits -- 1.5 stop bits
	);
	for Stop_Bit_Count use (
		Stop_1_Bit    => 2#00#,
		Stop_0_5_Bits => 2#01#,
		Stop_2_Bits   => 2#10#,
		Stop_1_5_Bits => 2#11#
	);

	type Control_Register_2 is record
		ADD: Integer range 0 .. 2**4 - 1; -- Address of the USART node
		Reserved_4: Integer range 0 .. 1;
		LBDL: LIN_Break_Detection_Length; -- LIN break detection length selection
		LBDIE: Boolean; -- LIN break detection interrupt enable
		Reserved_7: Integer range 0 .. 1;
		LBCL: Boolean; -- Last bit clock pulse output (this bit is not available for UART4 and UART5)
		CPHA: Clock_Phase; -- Clock phase
		CPOL: Clock_Polarity; -- Clock polarity
		CLKEN: Boolean; -- Clock enable
		STOP: Stop_Bit_Count; -- STOP bits
		LINEN: Boolean; -- LIN mode enable
		Reserved: Integer range 0 .. 2**17 - 1;
	end record with Size => 32;
	for Control_Register_2 use record
		ADD at 0 range 0 .. 3;
		Reserved_4 at 0 range 4 .. 4;
		LBDL at 0 range 5 .. 5;
		LBDIE at 0 range 6 .. 6;
		Reserved_7 at 0 range 7 .. 7;
		LBCL at 0 range 8 .. 8;
		CPHA at 0 range 9 .. 9;
		CPOL at 0 range 10 .. 10;
		CLKEN at 0 range 11 .. 11;
		STOP at 0 range 12 .. 13;
		LINEN at 0 range 14 .. 14;
		Reserved at 0 range 15 .. 31;
	end record;

	type Control_Register_3 is record
		EIE: Boolean; -- Error interrupt enable
		IREN: Boolean; -- IrDA mode enable
		IRLP: Boolean; -- IrDA low power
		HDSEL: Boolean; -- Half duplex selection
		NACK: Boolean; -- Smartcard NACK enable
		SCEN: Boolean; -- Smartcard mode enable
		DMAR: Boolean; -- DMA enable receiver
		DMAT: Boolean; -- DMA enable transmitter
		RTSE: Boolean; -- RTS enable
		CTSE: Boolean; -- CTS enable
		CTSIE: Boolean; -- CTS interrupt enable
		ONEBIT: Boolean; -- One bit sampling enable
		Reserved: Integer range 0 .. 2 ** 20 - 1;
	end record with Size => 32;
	for Control_Register_3 use record
		EIE at 0 range 0 .. 0;
		IREN at 0 range 1 .. 1;
		IRLP at 0 range 2 .. 2;
		HDSEL at 0 range 3 .. 3;
		NACK at 0 range 4 .. 4;
		SCEN at 0 range 5 .. 5;
		DMAR at 0 range 6 .. 6;
		DMAT at 0 range 7 .. 7;
		RTSE at 0 range 8 .. 8;
		CTSE at 0 range 9 .. 9;
		CTSIE at 0 range 10 .. 10;
		ONEBIT at 0 range 11 .. 11;
		Reserved at 0 range 12 .. 31;
	end record;

	type Guard_Time_and_Prescaler_Register is record
		PSC: Integer range 0 .. 2**8 - 1; -- Prescaler value
		GT: Integer range 0 .. 2**8 - 1; -- Guard time value in baud clocks
		Reserved: Integer range 0 .. 2**16 - 1;
	end record with Size => 32;
	for Guard_Time_and_Prescaler_Register use record
		PSC at 0 range 0 .. 7;
		GT at 0 range 8 .. 15;
		Reserved at 0 range 16 .. 31;
	end record;

	type USART_Registers is record
		SR: Status_Register; -- Status register
		DR: Unsigned_32; -- Data register
		BRR: Baud_Rate_Register; -- Baud rate register
		CR1: Control_Register_1; -- Control register 1
		CR2: Control_Register_2; -- Control register 2
		CR3: Control_Register_3; -- Control register 3
		GTPR: Guard_Time_and_Prescaler_Register; -- Guard time and prescaler register
	end record with Volatile;
	for USART_Registers use record
		SR   at 16#00# range 0 .. 31;
		DR   at 16#04# range 0 .. 31;
		BRR  at 16#08# range 0 .. 31;
		CR1  at 16#0C# range 0 .. 31;
		CR2  at 16#10# range 0 .. 31;
		CR3  at 16#14# range 0 .. 31;
		GTPR at 16#18# range 0 .. 31;
	end record;

end STM32.F4.USART;
