with System;
with STM32.Registers.GPIO;
with STM32.Registers.EXTI;
with STM32.Registers.SYSCFG;
with STM32.Registers.STM32F4_Map;

package STM32.STM32F429Z is
	pragma Preelaborate;

	EXTI: Registers.EXTI.EXTI_Registers
	with Volatile, Import,
	Address => System'To_Address(Registers.STM32F4_Map.EXTI);

	GPIOA: Registers.GPIO.GPIO_Registers
	with Volatile, Import,
	Address => System'To_Address(Registers.STM32F4_Map.GPIOA);

	GPIOB: Registers.GPIO.GPIO_Registers
	with Volatile, Import,
	Address => System'To_Address(Registers.STM32F4_Map.GPIOB);

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

	GPIOH: Registers.GPIO.GPIO_Registers
	with Volatile, Import,
	Address => System'To_Address(Registers.STM32F4_Map.GPIOH);

	GPIOI: Registers.GPIO.GPIO_Registers
	with Volatile, Import,
	Address => System'To_Address(Registers.STM32F4_Map.GPIOI);

	GPIOJ: Registers.GPIO.GPIO_Registers
	with Volatile, Import,
	Address => System'To_Address(Registers.STM32F4_Map.GPIOJ);

	GPIOK: Registers.GPIO.GPIO_Registers
	with Volatile, Import,
	Address => System'To_Address(Registers.STM32F4_Map.GPIOK);

	RCC: Registers.RCC.RCC_Registers
	with Volatile, Import,
	Address => System'To_Address(Registers.STM32F4_Map.RCC);

	SYSCFG: Registers.SYSCFG.SYSCFG_Registers
	with Volatile, Import,
	Address => System'To_Address(Registers.STM32F4_Map.SYSCFG);

end STM32.STM32F429Z;
