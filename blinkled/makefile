PROJECT ?= blink
FAMILY  ?= GW1N-9C
DEVICE  ?= GW1NR-LV9QN88PC6/I5
CST     ?= pin.cst
BOARD   ?= tangnano9k

# Default target
all: run

# Declare non-file targets
.PHONY: all synth pnr pack flash run clean

# Synthesis
synth: $(PROJECT).json

$(PROJECT).json: $(PROJECT).v
	yosys -p "read_verilog $<; synth_gowin -top $(PROJECT) -json $@"

# Place and Route
pnr: $(PROJECT)_pnr.json

$(PROJECT)_pnr.json: $(PROJECT).json $(CST)
	nextpnr-himbaechel --json $< --write $@ --device $(DEVICE) --vopt family=$(FAMILY) --vopt cst=$(CST)

# Bitstream Packaging
pack: $(PROJECT).fs

$(PROJECT).fs: $(PROJECT)_pnr.json
	gowin_pack -d $(FAMILY) -o $@ $<

# Flash permanently to SPI flash
flash: $(PROJECT).fs
	sudo modprobe -r ftdi_sio || true
	sudo /opt/oss-cad-suite/bin/openFPGALoader -b $(BOARD) $<

# Run temporarily from SRAM (-m)
run: $(PROJECT).fs
	sudo modprobe -r ftdi_sio || true
	sudo /opt/oss-cad-suite/bin/openFPGALoader -b $(BOARD) -m $<

# Clean build artifacts
clean:
	rm -f $(PROJECT).json $(PROJECT)_pnr.json $(PROJECT).fs