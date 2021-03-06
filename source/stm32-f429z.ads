with System;
with STM32.F4.GPIO;
with STM32.F4.EXTI;
with STM32.F4.RCC;
with STM32.F4.SYSCFG;
with STM32.F4.USART;
with STM32.F4.Address_Map;

package STM32.F429Z is
	pragma Preelaborate;

	package Address_Map renames STM32.F4.Address_Map;
	package Modules is
		package EXTI renames STM32.F4.EXTI;
		package GPIO renames STM32.F4.GPIO;
		package RCC renames STM32.F4.RCC;
		package SYSCFG renames STM32.F4.SYSCFG;
		package USART renames STM32.F4.USART;
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


	USART1: Modules.USART.USART_Registers
	with Volatile, Import, Address => System'To_Address(Address_Map.USART1);

	USART2: Modules.USART.USART_Registers
	with Volatile, Import, Address => System'To_Address(Address_Map.USART2);

	USART3: Modules.USART.USART_Registers
	with Volatile, Import, Address => System'To_Address(Address_Map.USART3);

	UART4: Modules.USART.USART_Registers
	with Volatile, Import, Address => System'To_Address(Address_Map.UART4);

	UART5: Modules.USART.USART_Registers
	with Volatile, Import, Address => System'To_Address(Address_Map.UART5);

	USART6: Modules.USART.USART_Registers
	with Volatile, Import, Address => System'To_Address(Address_Map.USART6);

	UART7: Modules.USART.USART_Registers
	with Volatile, Import, Address => System'To_Address(Address_Map.UART7);

	UART8: Modules.USART.USART_Registers
	with Volatile, Import, Address => System'To_Address(Address_Map.UART8);

end STM32.F429Z;
