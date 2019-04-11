__DYNAMIC  =  0;

_DEFAULT_STACK_SIZE = 4*1024;

ENTRY(_start_rom_sdram);

MEMORY {
	ROM     (rx) : org = 0x08000000, len = 2048K
	SRAM    (rwx): org = 0x20000000, len = 192K
	CCM     (rw) : org = 0x10000000, len = 64K
	SDRAM   (rwx): org = 0xD0000000, len = 8M
}

SECTIONS {
	/* ROM (Flash)*/
	.text : {
		KEEP (*(.vectors))
		*(.text .text.* .gnu.linkonce.t*)
		*(.plt)
		*(.gnu.warning)
		*(.glue_7t)
		*(.glue_t)
		*(.vp11_veneer)
	} >ROM

	.ARM.extab : {
		*(.ARM.extab* .gnu.linkonce.armextab.*)
	} >ROM

	.ARM.exidx : {
		PROVIDE_HIDDEN (__exidx_start = .);
		*(.ARM.exidx* .gnu.linkonce.armexidx.*)
		PROVIDE_HIDDEN (__exidx_end = .);
	} >ROM

	.rodata : {
		*(.lit)
		*(SORT_BY_ALIGNMENT(.rodata) SORT_BY_ALIGNMENT(.rodata.*) SORT_BY_ALIGNMENT(.gnu.linkonce.r*))
		. = ALIGN(4);
		__rom_end = .;
	} >ROM

	/* Internal SRAM: early available data */

	.statdata : {
		. = ALIGN(4);
		__statdata_load = LOADADDR(.statdata);
		__statdata_start = .;
		//early_init*(SORT_BY_ALIGNMENT(.data) SORT_BY_ALIGNMENT(.data.*))
		//setup_pll*.o(SORT_BY_ALIGNMENT(.data) SORT_BY_ALIGNMENT(.data.*)) /* one defined in GNAT and must be executed prior to SDRAM init */
		*(SORT_BY_ALIGNMENT(.statdata) SORT_BY_ALIGNMENT(.statdata.*))

		. = ALIGN(4);
		__statdata_end = .;

		__interrupt_stack_start = .;
		*(.interrupt_stacks)
		. = ALIGN(8);
		__interrupt_stack_end = .;
		__stack_start = .;
		. += DEFINED (__stack_size) ? __stack_size : _DEFAULT_STACK_SIZE;
		. = ALIGN(8);
		PROVIDE_HIDDEN(__stack_end = .);
	} >SRAM AT>ROM
	__statdata_size = __statdata_end - __statdata_start;

	.statbss (NOLOAD) : {
		. = ALIGN(8);
		__statbss_start = .;
		early_init*(SORT_BY_ALIGNMENT(.bss) SORT_BY_ALIGNMENT(.bss.*))
		setup_pll*.o(SORT_BY_ALIGNMENT(.bss) SORT_BY_ALIGNMENT(.bss.*))
		*(SORT_BY_ALIGNMENT(.statbss) SORT_BY_ALIGNMENT(.statbss.*))
		*(COMMON)
		. = ALIGN(8);
		__statbss_end = .;
	} >SRAM
	__statbss_size = __statbss_end - __statbss_start;


	/* Core coupled RAM */
	.ccmdata : {
		__ccmdata_load = LOADADDR(.ccmdata);
		__ccmdata_start = .;
		*(SORT_BY_ALIGNMENT(.ccmdata) SORT_BY_ALIGNMENT(.ccmdata.*))

		. = ALIGN(4);
		__ccmdata_end = .;
	} >CCM AT>ROM
	__ccmdata_size = __ccmdata_end - __ccmdata_start;


	/* SDRAM: common data, bss */
	.data : {
		__data_load = LOADADDR(.data);
		__data_start = .;
		*(SORT_BY_ALIGNMENT(.data) SORT_BY_ALIGNMENT(.data.*) SORT_BY_ALIGNMENT(.gnu.linkonce.d*))

		. = ALIGN(4);
		__data_end = .;
	} >SDRAM AT>ROM
	__data_size = __data_end - __data_start;

	PROVIDE(sdata = __data_start);
	PROVIDE(edata = __data_end);
	PROVIDE(_sdata = __data_start);
	PROVIDE(_edata = __data_end);
	PROVIDE(__sdata = __data_start);
	PROVIDE(__edata = __data_end);

	.bss (NOLOAD) : {
		. = ALIGN(8);
		__bss_start = .;
		*(SORT_BY_ALIGNMENT(.bss) SORT_BY_ALIGNMENT(.bss.*))
		*(COMMON)
		. = ALIGN(8);
		__bss_end = .;

		_end = .;
		__heap_start = .;
		__heap_end = ORIGIN(SDRAM) + LENGTH(SDRAM);
	} >SDRAM
	__bss_size = __bss_end - __bss_start;

	.debug          0 : { *(.debug) }
	.line           0 : { *(.line) }
	.debug_srcinfo  0 : { *(.debug_srcinfo) }
	.debug_sfnames  0 : { *(.debug_sfnames) }
	.debug_aranges  0 : { *(.debug_aranges) }
	.debug_pubnames 0 : { *(.debug_pubnames) }
	.debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
	.debug_abbrev   0 : { *(.debug_abbrev) }
	.debug_line     0 : { *(.debug_line) }
	.debug_frame    0 : { *(.debug_frame) }
	.debug_str      0 : { *(.debug_str) }
	.debug_loc      0 : { *(.debug_loc) }
	.debug_macinfo  0 : { *(.debug_macinfo) }
	.debug_pubtypes 0 : { *(.debug_pubtypes) }
	.debug_ranges   0 : { *(.debug_ranges) }
	.gnu.attributes 0 : { KEEP (*(.gnu.attributes)) }
	/DISCARD/ : { *(.note.GNU-stack) *(.gnu_debuglink) *(.gnu.lto_*) }
}
