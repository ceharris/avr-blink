AVR Blink
=========

The "Hello, world" of microcontroller programming is a simple
program that blinks an LED in a loop. This repository provides
such a program for an AVR microcontroller (MCU). Using the 
resources here, along with a breadboard, an AVR microcontroller, 
a suitable programmer, plus some other passive components, the
aim is to get you from zero to being able to compile an AVR
program and transfer it to the MCU to run.

In this tutorial, we'll use the AVR C/C++ compiler (`avr-gcc`)
along, a utility known as `avrdude` used to drive the programmer
which in turn programs the AVR hardware, plus a couple of other
utilities. We'll use a plain text editor and command-line tools
so that you can understand the basic flow without getting tangled
up in an IDE that hides a lot of the detail from you.

This tutorial assumes you're using a Linux distribution that uses
the APT package manager. If you're using some other package manager,
I'll assume you know how to translate `apt` commands and package
names to your package manager of choice.


AVR Programmer
--------------

In order to program an AVR microcontroller (outside of an
ecosystem such as Arduino) you'll need a programmer. AVR MCUs
typically use an in-circuit serial programmer (ISP). This type
of programmer usually has USB interface for the connection to
your workstation, and connects to the AVR's SPI interface pins
to transfer programming data into the MCU's on board flash
memory and/or fuses.

There are a few different options for programming an AVR 
microcontroller, but an affordable option that is easy to
use is an AVR ISP MkII clone. Microchip has moved on to 
later programmer technology, but the AVR ISP MkII was widely 
cloned and a decent unit can be purchased online for about 
$50 USD. The programmer I used for this tutorial is the
[Waveshare AVR ISP XPII](https://www.amazon.com/dp/B00ID98C5K).
It's been trouble free and reliable over about four years of
use now.


Toolchain
---------

Apart from your editor of choice and `git`, you'll need to install
the following APT packages.

* gcc-avr
* avr-libc
* avrdude
* make

```shell
sudo apt update
sudo apt install gcc-avr avr-libc avrdude make
```

Hardware
--------

For this tutorial, you'll need an AVR microcontroller. As
of this writing, the ATmega328P-PU is available from Mouser,
Digikey, and other suppliers for a unit price of about $3 USD.
This is the same breadboard-friendly PDIP-28 package that is 
used on the Arduino Uno. You could also use any of the 
ATmega48/88/168 MCUs. I completed this tutorial using the
ATmega168, and then subsequently made minor revisions to the 
`Makefile` for the ATmega328P.

Here's the complete list of components. 

* ATmega328P-PU (or ATmega48/88/168)
* SPST tactile button
* 5 mm or 3 mm LED
* 10K ohm, 1/4W resistor
* 330 ohm, 1/4W resistor
* 18.432 MHz crystal (optional)
* 2x 22 pF ceramic capacitor (optional)
* 100 nF ceramic capacitor

AVR microcontrollers have an onboard 8 MHz internal oscillator.
This is more than adequate for some projects. However, for 
projects that move a lot of data via the USART, an 18.432 MHz
may be a better choice. This frequency allows the USART to 
operate in asynchronous mode at 115,200 bps or 230,400 bps with
no difference between the specified bit rate and the rate 
produced by the baud rate generator (as specified via register 
UBRR0). The optional crystal and 22 pF capacitors are used to
create this external clock source for the MCU.

