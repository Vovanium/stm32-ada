flash:objects/uart_429disco.bin
	st-flash --reset write $< 0x8000000

objects/%:%
	gprbuild $<.gpr

%.bin:%
	arm-eabi-objcopy -O binary $< $@

.PHONY:flash

