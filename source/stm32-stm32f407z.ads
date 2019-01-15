with System;
with STM32.Registers.GPIO;
with STM32.Registers.RCC;
with STM32.Registers.EXTI;
with STM32.Registers.SYSCFG;
with STM32.Registers.FSMC;
with STM32.Registers.STM32F4_Map;

package STM32.STM32F407Z is
	pragma Preelaborate;

	--pragma Warnings (Off, "* may call Last_Chance_Handler");
	--pragma Warnings (Off, "* may be incompatible with alignment of object");

	EXTI: Registers.EXTI.EXTI_Registers
	with Volatile, Import,
	Address => System'To_Address(Registers.STM32F4_Map.EXTI);

	FSMC: Registers.FSMC.FSMC_Registers
	with Volatile, Import,
	Address => System'To_Address(Registers.STM32F4_Map.FSMC);

	GPIOA: Registers.GPIO.GPIO_Registers
	with Volatile, Import,
	Address => System'To_Address(Registers.STM32F4_Map.GPIOA);

	GPIOC: Registers.GPIO.GPIO_Registers
	with Volatile, Import,
	Address => System'To_Address(Registers.STM32F4_Map.GPIOC);

	GPIOD: Registers.GPIO.GPIO_Registers
	with Volatile, Import,
	Address => System'To_Address(Registers.STM32F4_Map.GPIOD);

	GPIOE: Registers.GPIO.GPIO_Registers
	with Volatile, Import,
	Address => System'To_Address(Registers.STM32F4_Map.GPIOE);

	GPIOF: Registers.GPIO.GPIO_Registers
	with Volatile, Import,
	Address => System'To_Address(Registers.STM32F4_Map.GPIOF);

	GPIOG: Registers.GPIO.GPIO_Registers
	with Volatile, Import,
	Address => System'To_Address(Registers.STM32F4_Map.GPIOG);

	RCC: Registers.RCC.RCC_Registers
	with Volatile, Import,
	Address => System'To_Address(Registers.STM32F4_Map.RCC);

	SYSCFG: Registers.SYSCFG.SYSCFG_Registers
	with Volatile, Import,
	Address => System'To_Address(Registers.STM32F4_Map.SYSCFG);

	--pragma Warnings (On, "* may call Last_Chance_Handler");
	--pragma Warnings (On, "* may be incompatible with alignment of object");

end STM32.STM32F407Z;