chip.bin: top.v vga_controller.v sound_controller.v graphics.v dinamic.v numbers.v image.v fontROM.v blackice2.pcf 
	yosys -q -p "synth_ice40 -blif chip.blif" top.v vga_controller.v sound_controller.v graphics.v dinamic.v numbers.v image.v fontROM.v
	arachne-pnr -d 8k -P tq144:4k -p blackice2.pcf chip.blif -o chip.txt
	icepack chip.txt chip.bin

.PHONY: upload
upload:
	cat chip.bin >/dev/ttyUSB0

.PHONY: clean
clean:
	$(RM) -f chip.blif chip.txt chip.ex chip.bin
