with System;
with STM32.STM32F4.GPIO;
with STM32.Registers.EXTI;
with STM32.Registers.RCC;
with STM32.Registers.SYSCFG;
with STM32.STM32F4.Address_Map;

package STM32.STM32F429Z is
	pragma Preelaborate;

	package Address_Map renames STM32.STM32F4.Address_Map;
	package Modules is
		package EXTI renames STM32.Registers.EXTI;
		package GPIO renames STM32.STM32F4.GPIO;
		package RCC renames STM32.Registers.RCC;
		package SYSCFG renames STM32.Registers.SYSCFG;
	end Modules;

	EXTI: Modules.EXTI.EXTI_Registers
	with Volatile, Import, Address => System'To_Address(Address_Map.EXTI);

	GPIOA: Modules.GPIO.GPIO_Registers
	with Volatile, Import, Address => System'To_Address(Address_Map.GPIOA);

	GPIOB: Modules.GPIO.GPIO_Registers
	with Volatile, Import, Address => System'To_Address(Address_Map.GPIOB);

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

	GPIOH: Modules.GPIO.GPIO_Registers
	with Volatile, Import, Address => System'To_Address(Address_Map.GPIOH);

	GPIOI: Modules.GPIO.GPIO_Registers
	with Volatile, Import, Address => System'To_Address(Address_Map.GPIOI);

	GPIOJ: Modules.GPIO.GPIO_Registers
	with Volatile, Import, Address => System'To_Address(Address_Map.GPIOJ);

	GPIOK: Modules.GPIO.GPIO_Registers
	with Volatile, Import, Address => System'To_Address(Address_Map.GPIOK);

	RCC: Modules.RCC.RCC_Registers
	with Volatile, Import, Address => System'To_Address(Address_Map.RCC);

	SYSCFG: Modules.SYSCFG.SYSCFG_Registers
	with Volatile, Import, Address => System'To_Address(Address_Map.SYSCFG);

end STM32.STM32F429Z;
