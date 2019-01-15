with Interfaces;

package STM32.Registers.RCC is
	pragma Preelaborate;

	-- CR
	type Clock_Control_Register is record
		HSION: Boolean;
		HSIRDY: Boolean;
		HSITRIM: Integer range 0 .. 2**5 - 1;
		HSICAL: Integer range 0 .. 2**8 - 1;
		HSEON: Boolean;
		HSERDY: Boolean;
		HSEBYP: Boolean;
		CSSON: Boolean;
		PLLON: Boolean;
		PLLRDY: Boolean;
		PLLI2SON: Boolean;
		PLLI2SRDY: Boolean;
	end record with Size => 32;

	for Clock_Control_Register use record
		HSION     at 0 range 0 .. 0;
		HSIRDY    at 0 range 1 .. 1;
		HSITRIM   at 0 range 3 .. 7;
		HSICAL    at 0 range 8 .. 15;
		HSEON     at 0 range 16 .. 16;
		HSERDY    at 0 range 17 .. 17;
		HSEBYP    at 0 range 18 .. 18;
		CSSON     at 0 range 19 .. 19;
		PLLON     at 0 range 24 .. 24;
		PLLRDY    at 0 range 25 .. 25;
		PLLI2SON  at 0 range 26 .. 26;
		PLLI2SRDY at 0 range 27 .. 27;
	end record;

	--- PLLCFGR
	type PLL_Division_Factor is (
		PLL_DIV_2,
		PLL_DIV_4,
		PLL_DIV_6,
		PLL_DIV_8
	);

	for PLL_Division_Factor use (
		PLL_DIV_2 => 2#00#,
		PLL_DIV_4 => 2#01#,
		PLL_DIV_6 => 2#10#,
		PLL_DIV_8 => 2#11#
	);

	type PLL_Clock_Source is (
		PLLSRC_HSI,
		PLLSRC_HSE
	);

	for PLL_Clock_Source use (
		PLLSRC_HSI => 0,
		PLLSRC_HSE => 1
	);

	type PLL_Configuration_Register is record
		PLLM: Integer range 2 .. 63;
		PLLN: Integer range 50 .. 432;
		PLLP: PLL_Division_Factor;
		PLLSRC: PLL_Clock_Source;
		PLLQ: Integer range 2 .. 15;
	end record with Size => 32;

	for PLL_Configuration_Register use record
		PLLM at 0 range 0 .. 5;
		PLLN at 0 range 6 .. 14;
		PLLP at 0 range 16 .. 17;
		PLLSRC at 0 range 22 .. 22;
		PLLQ at 0 range 24 .. 27;
	end record;

	-- CFGR
	type System_Clock_Switch is (
		System_Clock_HSI,
		System_Clock_HSE,
		System_Clock_PLL
	) with Size => 2;

	for System_Clock_Switch use (
		System_Clock_HSI => 2#00#,
		System_Clock_HSE => 2#01#,
		System_Clock_PLL => 2#10#
	);

	type AHB_Prescaler_Factor is (
		AHB_Prescaler_1,
		AHB_Prescaler_2,
		AHB_Prescaler_4,
		AHB_Prescaler_8,
		AHB_Prescaler_16,
		AHB_Prescaler_32,
		AHB_Prescaler_64,
		AHB_Prescaler_128,
		AHB_Prescaler_256
	) with Size => 4;

	for AHB_Prescaler_Factor use (
		AHB_Prescaler_1 => 2#0000#,
		AHB_Prescaler_2 => 2#1000#,
		AHB_Prescaler_4 => 2#1001#,
		AHB_Prescaler_8 => 2#1010#,
		AHB_Prescaler_16 => 2#1011#,
		AHB_Prescaler_32 => 2#1100#,
		AHB_Prescaler_64 => 2#1101#,
		AHB_Prescaler_128 => 2#1110#,
		AHB_Prescaler_256 => 2#1111#
	);

	type APB_Prescaler_Factor is (
		APB_Prescaler_1,
		APB_Prescaler_2,
		APB_Prescaler_4,
		APB_Prescaler_8,
		APB_Prescaler_16
	) with Size => 3;

	for APB_Prescaler_Factor use (
		APB_Prescaler_1 => 2#000#,
		APB_Prescaler_2 => 2#100#,
		APB_Prescaler_4 => 2#101#,
		APB_Prescaler_8 => 2#110#,
		APB_Prescaler_16 => 2#111#
	);

	type Clock_Output_1 is (
		Clock_Output_1_HSI,
		Clock_Output_1_LSE,
		Clock_Output_1_HSE,
		Clock_Output_1_PLL
	) with Size => 2;

	for Clock_Output_1 use (
		Clock_Output_1_HSI => 2#00#,
		Clock_Output_1_LSE => 2#01#,
		Clock_Output_1_HSE => 2#10#,
		Clock_Output_1_PLL => 2#11#
	);

	type I2S_Clock_Source is (
		I2S_Clock_PLLI2S,
		I2S_Clock_CLKIN
	) with Size => 1;

	for I2S_Clock_Source use (
		I2S_Clock_PLLI2S => 0,
		I2S_Clock_CLKIN => 1
	);

	type Clock_Output_Prescaler_Factor is (
		MCO_Prescaler_1,
		MCO_Prescaler_2,
		MCO_Prescaler_3,
		MCO_Prescaler_4,
		MCO_Prescaler_5
	) with Size => 3;

	for Clock_Output_Prescaler_Factor use (
		MCO_Prescaler_1 => 2#000#,
		MCO_Prescaler_2 => 2#100#,
		MCO_Prescaler_3 => 2#101#,
		MCO_Prescaler_4 => 2#110#,
		MCO_Prescaler_5 => 2#111#
	);

	type Clock_Output_2 is (
		Clock_Output_2_SYSCLK,
		Clock_Output_2_PLLI2S,
		Clock_Output_2_HSE,
		Clock_Output_2_PLL
	) with Size => 2;

	for Clock_Output_2 use (
		Clock_Output_2_SYSCLK => 2#00#,
		Clock_Output_2_PLLI2S => 2#01#,
		Clock_Output_2_HSE => 2#10#,
		Clock_Output_2_PLL => 2#11#
	);

	type Clock_Configuration_Register is record
		SW: System_Clock_Switch;
		SWS: System_Clock_Switch;
		HPRE: AHB_Prescaler_Factor;
		Reserved_8: Integer range 0 .. 3;
		PPRE1: APB_Prescaler_Factor;
		PPRE2: APB_Prescaler_Factor;
		RTCPRE: Integer range 0 .. 31;
		MCO1: Clock_Output_1;
		I2SSCR: I2S_Clock_Source;
		MCO1PRE: Clock_Output_Prescaler_Factor;
		MCO2PRE: Clock_Output_Prescaler_Factor;
		MCO2: Clock_Output_2;
	end record with Size => 32;

	for Clock_Configuration_Register use record
		SW         at 0 range  0 .. 1;
		SWS        at 0 range  2 .. 3;
		HPRE       at 0 range  4 .. 7;
		Reserved_8 at 0 range  8 .. 9;
		PPRE1      at 0 range 10 .. 12;
		PPRE2      at 0 range 13 .. 15;
		RTCPRE     at 0 range 16 .. 20;
		MCO1       at 0 range 21 .. 22;
		I2SSCR     at 0 range 23 .. 23;
		MCO1PRE    at 0 range 24 .. 26;
		MCO2PRE    at 0 range 27 .. 29;
		MCO2       at 0 range 30 .. 31;
	end record;

	-- CIR
	type Clock_Interrupt_Register is record
		LSIRDYF: Boolean;
		LSERDYF: Boolean;
		HSIRDYF: Boolean;
		HSERDYF: Boolean;
		PLLRDYF: Boolean;
		PLLI2SRDYF: Boolean;
		Reserved_6: Integer range 0 .. 1;
		CSSF: Boolean;
		LSIRDYIE: Boolean;
		LSERDYIE: Boolean;
		HSIRDYIE: Boolean;
		HSERDYIE: Boolean;
		PLLRDYIE: Boolean;
		PLLI2SRDYIE: Boolean;
		Reserved_14: Integer range 0 .. 2**2 - 1;
		LSIRDYC: Boolean;
		LSERDYC: Boolean;
		HSIRDYC: Boolean;
		HSERDYC: Boolean;
		PLLRDYC: Boolean;
		PLLI2SRDYC: Boolean;
		Reserved_22: Integer range 0 .. 1;
		CSSC: Boolean;
		Reserved_24: Integer range 0 .. 2**8 - 1;
	end record with Size => 32;

	for Clock_Interrupt_Register use record
		LSIRDYF     at 0 range  0 .. 0;
		LSERDYF     at 0 range  1 .. 1;
		HSIRDYF     at 0 range  2 .. 2;
		HSERDYF     at 0 range  3 .. 3;
		PLLRDYF     at 0 range  4 .. 4;
		PLLI2SRDYF  at 0 range  5 .. 5;
		Reserved_6  at 0 range  6 .. 6;
		CSSF        at 0 range  7 .. 7;
		LSIRDYIE    at 0 range  8 .. 8;
		LSERDYIE    at 0 range  9 .. 9;
		HSIRDYIE    at 0 range 10 .. 10;
		HSERDYIE    at 0 range 11 .. 11;
		PLLRDYIE    at 0 range 12 .. 12;
		PLLI2SRDYIE at 0 range 13 .. 13;
		Reserved_14 at 0 range 14 .. 15;
		LSIRDYC     at 0 range 16 .. 16;
		LSERDYC     at 0 range 17 .. 17;
		HSIRDYC     at 0 range 18 .. 18;
		HSERDYC     at 0 range 19 .. 19;
		PLLRDYC     at 0 range 20 .. 20;
		PLLI2SRDYC  at 0 range 21 .. 21;
		Reserved_22 at 0 range 22 .. 22;
		CSSC        at 0 range 23 .. 23;
		Reserved_24 at 0 range 24 .. 31;
	end record;

	-- AHB1RSTR, AHB1ENR
	type AHB1_Register is record
		GPIOA: Boolean;
		GPIOB: Boolean;
		GPIOC: Boolean;
		GPIOD: Boolean;
		GPIOE: Boolean;
		GPIOF: Boolean;
		GPIOG: Boolean;
		GPIOH: Boolean;
		GPIOI: Boolean;
		CRC: Boolean;
		FLITF: Boolean;
		SRAM1: Boolean;
		SRAM2: Boolean;
		BKPSRAM: Boolean;
		CCMDATARAM: Boolean;
		DMA1: Boolean;
		DMA2: Boolean;
		ETHMAC: Boolean;
		ETHMACTX: Boolean;
		ETHMACRX: Boolean;
		ETHMACPTP: Boolean;
		OTGHS: Boolean;
		OTGHSULPI: Boolean;
	end record with Size => 32;

	for AHB1_Register use record
		GPIOA      at 0 range  0 .. 0;
		GPIOB      at 0 range  1 .. 1;
		GPIOC      at 0 range  2 .. 2;
		GPIOD      at 0 range  3 .. 3;
		GPIOE      at 0 range  4 .. 4;
		GPIOF      at 0 range  5 .. 5;
		GPIOG      at 0 range  6 .. 6;
		GPIOH      at 0 range  7 .. 7;
		GPIOI      at 0 range  8 .. 8;
		CRC        at 0 range 12 .. 12;
		FLITF      at 0 range 15 .. 15;
		SRAM1      at 0 range 16 .. 16;
		SRAM2      at 0 range 17 .. 17;
		BKPSRAM    at 0 range 18 .. 18;
		CCMDATARAM at 0 range 20 .. 20;
		DMA1       at 0 range 21 .. 21;
		DMA2       at 0 range 22 .. 22;
		ETHMAC     at 0 range 25 .. 25;
		ETHMACTX   at 0 range 26 .. 26;
		ETHMACRX   at 0 range 27 .. 27;
		ETHMACPTP  at 0 range 28 .. 28;
		OTGHS      at 0 range 29 .. 29;
		OTGHSULPI  at 0 range 30 .. 30;
	end record;

	-- AHB2RSTR, AHB2ENR
	type AHB2_Register is record
		DCMI: Boolean;
		CRYP: Boolean;
		HASH: Boolean;
		RNG: Boolean;
		OTGFS: Boolean;
	end record with Size => 32;

	for AHB2_Register use record
		DCMI  at 0 range 0 .. 0;
		CRYP  at 0 range 4 .. 4;
		HASH  at 0 range 5 .. 5;
		RNG   at 0 range 6 .. 6;
		OTGFS at 0 range 7 .. 7;
	end record;

	-- AHB3RSTR, AHB3ENR
	type AHB3_Register is record
		FSMC: Boolean;
	end record with Size => 32;

	for AHB3_Register use record
		FSMC at 0 range 0 .. 0;
	end record;

	-- APB1RSTR, APB1ENR
	type APB1_Register is record
		TIM2: Boolean;
		TIM3: Boolean;
		TIM4: Boolean;
		TIM5: Boolean;
		TIM6: Boolean;
		TIM7: Boolean;
		TIM12: Boolean;
		TIM13: Boolean;
		TIM14: Boolean;
		WWDG: Boolean;
		SPI2: Boolean;
		SPI3: Boolean;
		USART2: Boolean;
		USART3: Boolean;
		UART4: Boolean;
		UART5: Boolean;
		I2C1: Boolean;
		I2C2: Boolean;
		I2C3: Boolean;
		CAN1: Boolean;
		CAN2: Boolean;
		PWR: Boolean;
		DAC: Boolean;
	end record with Size => 32;

	for APB1_Register use record
		TIM2   at 0 range  0 .. 0;
		TIM3   at 0 range  1 .. 1;
		TIM4   at 0 range  2 .. 2;
		TIM5   at 0 range  3 .. 3;
		TIM6   at 0 range  4 .. 4;
		TIM7   at 0 range  5 .. 5;
		TIM12  at 0 range  6 .. 6;
		TIM13  at 0 range  7 .. 7;
		TIM14  at 0 range  8 .. 8;
		WWDG   at 0 range 11 .. 11;
		SPI2   at 0 range 14 .. 14;
		SPI3   at 0 range 15 .. 15;
		USART2 at 0 range 17 .. 17;
		USART3 at 0 range 18 .. 18;
		UART4  at 0 range 19 .. 19;
		UART5  at 0 range 20 .. 20;
		I2C1   at 0 range 21 .. 21;
		I2C2   at 0 range 22 .. 22;
		I2C3   at 0 range 23 .. 23;
		CAN1   at 0 range 25 .. 25;
		CAN2   at 0 range 26 .. 26;
		PWR    at 0 range 28 .. 28;
		DAC    at 0 range 29 .. 29;
	end record;

	-- APB2RSTR, APB2ENR
	type APB2_Register is record
		TIM1: Boolean;
		TIM8: Boolean;
		USART1: Boolean;
		USART6: Boolean;
		ADC1: Boolean; -- RST resets all ADCs
		ADC2: Boolean;
		ADC3: Boolean;
		SDIO: Boolean;
		SPI1: Boolean;
		SYSCFG: Boolean;
		TIM9: Boolean;
		TIM10: Boolean;
		TIM11: Boolean;
	end record with Size => 32;

	for APB2_Register use record
		TIM1   at 0 range 0 .. 0;
		TIM8   at 0 range 1 .. 1;
		USART1 at 0 range 4 .. 4;
		USART6 at 0 range 5 .. 5;
		ADC1   at 0 range 8 .. 8;
		ADC2   at 0 range 9 .. 9;
		ADC3   at 0 range 10 .. 10;
		SDIO   at 0 range 11 .. 11;
		SPI1   at 0 range 12 .. 12;
		SYSCFG at 0 range 14 .. 14;
		TIM9   at 0 range 16 .. 16;
		TIM10  at 0 range 17 .. 17;
		TIM11  at 0 range 18 .. 18;
	end record;

	-- BCDR
	type RTC_Clock_Source is (
		RTC_Not_Clocked,
		RTC_Clock_LSE,
		RTC_Clock_LSI,
		RTC_Clock_HSE
	) with Size => 2;

	for RTC_Clock_Source use (
		RTC_Not_Clocked => 2#00#,
		RTC_Clock_LSE => 2#01#,
		RTC_Clock_LSI => 2#10#,
		RTC_Clock_HSE => 2#11#
	);

	type Backup_Domain_Control_Register is record
		LSEON: Boolean;
		LSERDY: Boolean;
		LSEBYP: Boolean;
		Reserved_3: Integer range 0 .. 2**5 - 1;
		RTCSEL: RTC_Clock_Source;
		Reserved_10: Integer range 0 .. 2**5 - 1;
		RTCEN: Boolean;
		BDRST: Boolean;
		Reserved_17: Integer range 0 .. 2**15 - 1;
	end record with Size => 32;

	for Backup_Domain_Control_Register use record
		LSEON       at 0 range  0 .. 0;
		LSERDY      at 0 range  1 .. 1;
		LSEBYP      at 0 range  2 .. 2;
		Reserved_3  at 0 range  3 .. 7;
		RTCSEL      at 0 range  8 .. 9;
		Reserved_10 at 0 range 10 .. 14;
		RTCEN       at 0 range 15 .. 15;
		BDRST       at 0 range 16 .. 16;
		Reserved_17 at 0 range 17 .. 31;
	end record;

	-- CSR
	type Clock_Control_and_Status_Register is record
		LSION: Boolean;
		LSIRDY: Boolean;
		Reserved_2: Integer range 0 .. 2**22 - 1;
		RMVF: Boolean;
		BORRSTF: Boolean;
		PINRSTF: Boolean;
		PORRSTF: Boolean;
		SFTRSTF: Boolean;
		IWDGRSTF: Boolean;
		WWDGRSTF: Boolean;
		LPWRRSTF: Boolean;
	end record with Size => 32;

	for Clock_Control_and_Status_Register use record
		LSION      at 0 range  0 .. 0;
		LSIRDY     at 0 range  1 .. 1;
		Reserved_2 at 0 range  2 .. 23;
		RMVF       at 0 range 24 .. 24;
		BORRSTF    at 0 range 25 .. 25;
		PINRSTF    at 0 range 26 .. 26;
		PORRSTF    at 0 range 27 .. 27;
		SFTRSTF    at 0 range 28 .. 28;
		IWDGRSTF   at 0 range 29 .. 29;
		WWDGRSTF   at 0 range 30 .. 30;
		LPWRRSTF   at 0 range 31 .. 31;
	end record;

	-- SSCGR
	type Spread_Select is (
		Center_Spread,
		Down_Spread
	) with Size => 1;

	for Spread_Select use (
		Center_Spread => 0,
		Down_Spread => 1
	);

	type Spread_Spectrum_Clock_Generation_Register is record
		MODPER: Integer range 0 .. 2**13 - 1;
		INCSTEP: Integer range 0 .. 2**15 - 1;
		Reserved_28: Integer range 0 .. 3;
		SPREADSEL: Spread_Select;
		SSCGEN: Boolean;
	end record with Size => 32;

	for Spread_Spectrum_Clock_Generation_Register use record
		MODPER at 0 range 0 .. 12;
		INCSTEP at 0 range 13 .. 27;
		Reserved_28 at 0 range 28 .. 29;
		SPREADSEL at 0 range 30 .. 30;
		SSCGEN at 0 range 31 .. 31;
	end record;

	-- PLLI2SCFGR
	type PLLI2S_Configuration_Register is record
		Reserved_0: Integer range 0 .. 2**6 - 1;
		PLLI2SN: Integer range 2 .. 432;
		Reserved_15: Integer range 0 .. 2**13 - 1;
		PLLI2SR: Integer range 2 .. 7;
		Reserved_31: Integer range 0 .. 1;
	end record with Size => 32;

	for PLLI2S_Configuration_Register use record
		Reserved_0 at 0 range 0 .. 5;
		PLLI2SN at 0 range 6 .. 14;
		Reserved_15 at 0 range 15 .. 27;
		PLLI2SR at 0 range 28 .. 30;
		Reserved_31 at 0 range 31 .. 31;
	end record;

	type RCC_Registers is record
		CR:         Clock_Control_Register;
		PLLCFGR:    PLL_Configuration_Register;
		CFGR:       Clock_Configuration_Register;
		CIR:        Clock_Interrupt_Register;
		AHB1RSTR:   AHB1_Register;
		AHB2RSTR:   AHB2_Register;
		AHB3RSTR:   AHB3_Register;
		APB1RSTR:   APB1_Register;
		APB2RSTR:   APB2_Register;
		AHB1ENR:    AHB1_Register;
		AHB2ENR:    AHB2_Register;
		AHB3ENR:    AHB3_Register;
		APB1ENR:    APB1_Register;
		APB2ENR:    APB2_Register;
		AHB1LPENR:  AHB1_Register;
		AHB2LPENR:  AHB2_Register;
		AHB3LPENR:  AHB3_Register;
		APB1LPENR:  APB1_Register;
		APB2LPENR:  APB2_Register;
		BDCR:       Backup_Domain_Control_Register;
		CSR:        Clock_Control_and_Status_Register;
		SSCGR:      Spread_Spectrum_Clock_Generation_Register;
		PLLI2SCFGR: PLLI2S_Configuration_Register;
	end record with Volatile;

	for RCC_Registers use record
		CR         at 16#00# range 0 .. 31;
		PLLCFGR    at 16#04# range 0 .. 31;
		CFGR       at 16#08# range 0 .. 31;
		CIR        at 16#0C# range 0 .. 31;
		AHB1RSTR   at 16#10# range 0 .. 31;
		AHB2RSTR   at 16#14# range 0 .. 31;
		AHB3RSTR   at 16#18# range 0 .. 31;
		APB1RSTR   at 16#20# range 0 .. 31;
		APB2RSTR   at 16#24# range 0 .. 31;
		AHB1ENR    at 16#30# range 0 .. 31;
		AHB2ENR    at 16#34# range 0 .. 31;
		AHB3ENR    at 16#38# range 0 .. 31;
		APB1ENR    at 16#40# range 0 .. 31;
		APB2ENR    at 16#44# range 0 .. 31;
		AHB1LPENR  at 16#50# range 0 .. 31;
		AHB2LPENR  at 16#54# range 0 .. 31;
		AHB3LPENR  at 16#58# range 0 .. 31;
		APB1LPENR  at 16#60# range 0 .. 31;
		APB2LPENR  at 16#64# range 0 .. 31;
		BDCR       at 16#70# range 0 .. 31;
		CSR        at 16#74# range 0 .. 31;
		SSCGR      at 16#80# range 0 .. 31;
		PLLI2SCFGR at 16#84# range 0 .. 31;
	end record;

end STM32.Registers.RCC;
