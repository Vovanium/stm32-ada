package STM32.F4.EXTI is
	pragma Preelaborate;

	type Event_Number is range 0 .. 22;
	package Events is
		PVD:               constant Event_Number := 16;
		RTC_Alarm:         constant Event_Number := 17;
		USB_OTG_FS_Wakeup: constant Event_Number := 18;
		Ethernet_Wakeup:   constant Event_Number := 19;
		USB_OTG_HS_Wakeup: constant Event_Number := 20;
		RTC_Tamper:        constant Event_Number := 21;
		RTC_Timestamp:     constant Event_Number := 21; -- alias for RTC_Tamper
		RTC_Wakeup:        constant Event_Number := 22;
	end Events;

	type Event_Array is array (Event_Number) of Boolean
	with Pack, Size=>23;

	type Event_Set_Register is record
		MR: Event_Array;
		Reserved_23: Integer range 0 .. 2**9-1;
	end record with Size => 32;

	for Event_Set_Register use record
		MR at 0 range 0 .. 22;
		Reserved_23 at 0 range 23 .. 31;
	end record;

	type EXTI_Registers is record
		IMR:   Event_Set_Register;
		EMR:   Event_Set_Register;
		RTSR:  Event_Set_Register;
		FTSR:  Event_Set_Register;
		SWIER: Event_Set_Register;
		PR:    Event_Set_Register;
	end record;

	for EXTI_Registers use record
		IMR   at 16#00# range 0 .. 31;
		EMR   at 16#04# range 0 .. 31;
		RTSR  at 16#08# range 0 .. 31;
		FTSR  at 16#0C# range 0 .. 31;
		SWIER at 16#10# range 0 .. 31;
		PR    at 16#14# range 0 .. 31;
	end record;

end STM32.F4.EXTI;
