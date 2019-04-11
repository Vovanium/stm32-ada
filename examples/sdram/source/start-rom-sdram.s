	.syntax unified
	.cpu cortex-m4
	.thumb

	.section .vectors,"a"
__vectors0:
	.word   __stack_end       /* stack top address */
	.word   _start_rom_sdram  /* 1 Reset */
	.word   halt              /* 2 NMI */
	.word   halt              /* 3 HardFault */
	.word   halt              /* 4 MemManage */

	.text

	.thumb_func
	.globl _start_rom_sdram
_start_rom_sdram:
        /* Enable FPU and cache when appropriate */
        bl	_stm32_start_common

	/* Copy .statdata */
	movw	r0,#:lower16:__statdata_start
	movt	r0,#:upper16:__statdata_start
	movw	r1,#:lower16:__statdata_size
	movt	r1,#:upper16:__statdata_size
	movw	r2,#:lower16:__statdata_load
	movt	r2,#:upper16:__statdata_load
	cbz	r1,1f
0:	ldr	r4,[r2],#4
	str	r4,[r0],#4
	subs	r1,r1,#4
	bne	0b
1:
	/* Copy .ccmdata */
	movw	r0,#:lower16:__ccmdata_start
	movt	r0,#:upper16:__ccmdata_start
	movw	r1,#:lower16:__ccmdata_size
	movt	r1,#:upper16:__ccmdata_size
	movw	r2,#:lower16:__ccmdata_load
	movt	r2,#:upper16:__ccmdata_load
	cbz	r1,1f
0:	ldr	r4,[r2],#4
	str	r4,[r0],#4
	subs	r1,r1,#4
	bne	0b
1:
	/* Clear .statbss */
	movw	r0,#:lower16:__statbss_start
	movt	r0,#:upper16:__statbss_start
	movw	r1,#:lower16:__statbss_size
	movt	r1,#:upper16:__statbss_size
	mov	r2,#0
	cbz	r1,1f
0:	str	r2,[r0],#4
	subs	r1,r1,#4
	bne	0b

1:
	bl	_ada_setup_pll
	bl	_ada_early_init_sdram

	/* Copy .data */
	movw	r0,#:lower16:__data_start
	movt	r0,#:upper16:__data_start
	movw	r1,#:lower16:__data_size
	movt	r1,#:upper16:__data_size
	movw	r2,#:lower16:__data_load
	movt	r2,#:upper16:__data_load
	cbz	r1,1f
0:	ldr	r4,[r2],#4
	str	r4,[r0],#4
	subs	r1,r1,#4
	bne	0b
1:

	/* Clear .bss */
	movw	r0,#:lower16:__bss_start
	movt	r0,#:upper16:__bss_start
	movw	r1,#:lower16:__bss_size
	movt	r1,#:upper16:__bss_size
	mov	r2,#0
	cbz	r1,1f
0:	str	r2,[r0],#4
	subs	r1,r1,#4
	bne	0b

1:

	bl	main

	bl	_exit

halt:   b	.
