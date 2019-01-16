TARGET=led_flasher
gprbuild $TARGET.gpr
arm-eabi-objcopy -O binary objects/$TARGET objects/$TARGET.bin
st-flash --reset write objects/$TARGET.bin 0x8000000
