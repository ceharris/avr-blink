.phony: all clean blink flash lfuse

# MCU type as defined for avr-gcc and avrdude
# You can list all supported MCUs using `avrdude -p ?`
MCU=atmega328p

# Lower fuse bits used by the `lfuse` target. 
# Internal clock (1 MHz) (8 MHz divided by 8)
LFUSE_BITS=0x62
# Internal clock (8 MHz) 
# LFUSE_BITS=0xe2
# External crystal
# LFUSE_BITS=0xef

# Clock frequency -- set to match your clock source
CLOCK=1000000
# CLOCK=8000000
# CLOCK=18432000

# AVR programmer type (use `avrdude -c ?` to get all supported options)
PROGRAMMER=avrispmkii

CC=avr-gcc
CFLAGS=-Os -mmcu=$(MCU) -DF_CPU=$(CLOCK)
LD=avr-gcc
LDFLAGS=

OBJCOPY=avr-objcopy
OBJCOPY_FLAGS=-O ihex -R .eeprom

AVRDUDE=avrdude -p $(MCU) -c $(PROGRAMMER)

all: blink.hex

clean:
	-rm -f *.o *.elf *.hex

blink.elf: blink.o
	$(LD) $(LDFLAGS) $^ -o $@
	
blink.hex: blink.elf
	$(OBJCOPY) $(OBJCOPY_FLAGS) $< $@

flash: blink.hex
	$(AVRDUDE) -U flash:w:$<:i

lfuse:
	$(AVRDUDE) -U lfuse:w:$(LFUSE_BITS):m

%.o: %.c
	$(CC) $(CFLAGS) -c $< 
