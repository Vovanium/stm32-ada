with System;
with STM32.F4.GPIO;
with STM32.F4.RCC;
with STM32.F4.EXTI;
with STM32.F4.SYSCFG;
with STM32.F4.FSMC;
with STM32.F4.Address_Map;

package STM32.F407Z is
	pragma Preelaborate;

	package Address_Map renames STM32.F4.Address_Map;
	package Modules is
		package EXTI renames STM32.F4.EXTI;
		package FSMC renames STM32.F4.FSMC;
		package GPIO renames STM32.F4.GPIO;
		--package GPIO_Ports renames STM32.STM32F4.GPIO.Ports;
		package RCC renames STM32.F4.RCC;
		package SYSCFG renames STM32.F4.SYSCFG;
	end Modules;
	
	--pragma Warnings (Off, "* may call Last_Chance_Handler");
	--pragma Warnings (Off, "* may be incompatible with alignment of object");

	EXTI: Modules.EXTI.EXTI_Registers
	 with Volatile, Import, Address => System'To_Address(Address_Map.EXTI);

	FSMC: Modules.FSMC.FSMC_Registers
	 with Volatile, Import, Address => System'To_Address(Address_Map.FMC_FSMC);

	GPIOA: Modules.GPIO.GPIO_Registers
	 with Volatile, Import, Address => System'To_Address(Address_Map.GPIOA);

	GPIOC: Modules.GPIO.GPIO_Registers
	 with Volatile, Import, Address => System'To_Address(Address_Map.GPIOC);

	GPIOD: Modules.GPIO.GPIO_Registers
	 with Volatile, Import, Address => System'To_Address(Address_Map.GPIOD);

	GPIOE: Modules.GPIO.GPIO_Registers
	 with Volatile, Import, Address => System'To_Address(Address_Map.GPIOE);

	GPIOF: Modules.GPIO.GPIO_Registers
	 with Volatile, Import, Address => System'To_Address(Address_Map.GPIOF);

	GPIOG: Modules.GPIO.GPIO_Registers
	 with Volatile, Import, Address => System'To_Address(Address_Map.GPIOG);

	RCC: Modules.RCC.RCC_Registers
	 with Volatile, Import, Address => System'To_Address(Address_Map.RCC);

	SYSCFG: Modules.SYSCFG.SYSCFG_Registers
	 with Volatile, Import, Address => System'To_Address(Address_Map.SYSCFG);

	--pragma Warnings (On, "* may call Last_Chance_Handler");
	--pragma Warnings (On, "* may be incompatible with alignment of object");

end STM32.F407Z;
