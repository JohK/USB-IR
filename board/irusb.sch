EESchema Schematic File Version 2  date Sun 24 Feb 2013 10:10:23 PM CET
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:irusb-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title "IRUSB"
Date "24 feb 2013"
Rev ".1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	4050 3700 4050 3550
Wire Wire Line
	6900 4850 7550 4850
Wire Wire Line
	7550 4850 7550 4800
Wire Wire Line
	4200 4350 4050 4350
Wire Wire Line
	2000 5050 2000 5200
Wire Wire Line
	1800 4650 1800 4750
Wire Wire Line
	1800 4750 1050 4750
Wire Wire Line
	1050 4750 1050 4650
Connection ~ 1000 4400
Connection ~ 3700 3250
Wire Wire Line
	3850 3250 3350 3250
Wire Wire Line
	3350 3250 3350 3150
Connection ~ 3700 2000
Wire Wire Line
	3700 2000 3350 2000
Wire Wire Line
	3350 2000 3350 2100
Wire Wire Line
	3700 2600 3700 2750
Connection ~ 3650 4450
Wire Wire Line
	3650 4300 3650 4450
Wire Wire Line
	5150 5100 5150 5200
Wire Wire Line
	5150 5200 5050 5200
Wire Wire Line
	2650 4400 3400 4400
Wire Wire Line
	3000 4550 3150 4550
Wire Wire Line
	3150 4550 3150 4450
Wire Wire Line
	3150 4450 4200 4450
Wire Wire Line
	4200 4650 3150 4650
Connection ~ 3550 5800
Wire Wire Line
	3550 5900 3550 5800
Connection ~ 3950 5200
Wire Wire Line
	3850 5200 3950 5200
Connection ~ 3150 5200
Wire Wire Line
	3250 5200 3150 5200
Connection ~ 7100 4350
Wire Wire Line
	7100 4400 7100 4200
Wire Wire Line
	800  5200 800  4550
Wire Wire Line
	800  4550 1050 4550
Wire Wire Line
	2000 4650 2000 4400
Connection ~ 2350 4550
Wire Wire Line
	1800 4550 2500 4550
Connection ~ 2000 5150
Wire Wire Line
	2000 5150 2350 5150
Wire Wire Line
	1800 4400 2150 4400
Connection ~ 2000 4400
Wire Wire Line
	2350 4650 2350 4550
Wire Wire Line
	2350 5150 2350 5050
Wire Wire Line
	1050 4400 800  4400
Wire Wire Line
	800  4400 800  4300
Wire Wire Line
	7100 4800 7100 5050
Connection ~ 7100 4850
Wire Wire Line
	3150 4650 3150 5300
Wire Wire Line
	3950 5300 3950 4750
Wire Wire Line
	3150 5700 3150 5800
Wire Wire Line
	3150 5800 3950 5800
Wire Wire Line
	3950 5800 3950 5700
Wire Wire Line
	3950 4750 4200 4750
Wire Wire Line
	4200 4850 4100 4850
Wire Wire Line
	4100 4850 4100 5200
Wire Wire Line
	4100 5200 4550 5200
Wire Wire Line
	3400 4400 3400 4550
Wire Wire Line
	4250 3250 4600 3250
Wire Wire Line
	4600 3250 4600 3500
Wire Wire Line
	3650 3800 3650 3700
Wire Wire Line
	3700 2100 3700 1900
Wire Wire Line
	3700 3150 3700 3250
Wire Wire Line
	3350 2600 3350 2750
Connection ~ 800  5000
Wire Wire Line
	1050 4650 800  4650
Connection ~ 800  4650
Wire Wire Line
	3400 4550 4200 4550
Wire Wire Line
	7550 4400 7550 4350
Wire Wire Line
	7550 4350 6900 4350
Wire Wire Line
	4050 4350 4050 4200
$Comp
L R R7
U 1 1 512A8186
P 4050 3950
F 0 "R7" V 4130 3950 50  0000 C CNN
F 1 "4k7" V 4050 3950 50  0000 C CNN
	1    4050 3950
	1    0    0    -1  
$EndComp
$Comp
L C C4
U 1 1 511EB0FB
P 7550 4600
F 0 "C4" H 7600 4700 50  0000 L CNN
F 1 "47u" H 7600 4500 50  0000 L CNN
	1    7550 4600
	1    0    0    -1  
$EndComp
Text Label 3800 4450 0    60   ~ 0
USB D-
Text Label 3800 4550 0    60   ~ 0
USB D+
Text Label 4200 5200 0    60   ~ 0
~RESET
$Comp
L +5V #PWR6
U 1 1 5115758B
P 3700 1900
F 0 "#PWR6" H 3700 1990 20  0001 C CNN
F 1 "+5V" H 3700 1990 30  0000 C CNN
	1    3700 1900
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR5
U 1 1 5115757E
P 3650 3700
F 0 "#PWR5" H 3650 3790 20  0001 C CNN
F 1 "+5V" H 3650 3790 30  0000 C CNN
	1    3650 3700
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR1
U 1 1 5115757A
P 800 4300
F 0 "#PWR1" H 800 4390 20  0001 C CNN
F 1 "+5V" H 800 4390 30  0000 C CNN
	1    800  4300
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR8
U 1 1 51157573
P 5150 5100
F 0 "#PWR8" H 5150 5190 20  0001 C CNN
F 1 "+5V" H 5150 5190 30  0000 C CNN
	1    5150 5100
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR9
U 1 1 5115756A
P 7100 4200
F 0 "#PWR9" H 7100 4290 20  0001 C CNN
F 1 "+5V" H 7100 4290 30  0000 C CNN
	1    7100 4200
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 511565AF
P 3350 2350
F 0 "R3" V 3430 2350 50  0000 C CNN
F 1 "2k2" V 3350 2350 50  0000 C CNN
	1    3350 2350
	1    0    0    -1  
$EndComp
$Comp
L LED D3
U 1 1 511565A2
P 3350 2950
F 0 "D3" H 3350 3050 50  0000 C CNN
F 1 "LED" H 3350 2850 50  0000 C CNN
	1    3350 2950
	0    1    1    0   
$EndComp
$Comp
L R R5
U 1 1 51156567
P 3700 2350
F 0 "R5" V 3780 2350 50  0000 C CNN
F 1 "33R" V 3700 2350 50  0000 C CNN
	1    3700 2350
	1    0    0    -1  
$EndComp
$Comp
L R R4
U 1 1 511564CD
P 3650 4050
F 0 "R4" V 3730 4050 50  0000 C CNN
F 1 "1k5" V 3650 4050 50  0000 C CNN
	1    3650 4050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR7
U 1 1 511563E2
P 4600 3500
F 0 "#PWR7" H 4600 3500 30  0001 C CNN
F 1 "GND" H 4600 3430 30  0001 C CNN
	1    4600 3500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR4
U 1 1 511562B3
P 3550 5900
F 0 "#PWR4" H 3550 5900 30  0001 C CNN
F 1 "GND" H 3550 5830 30  0001 C CNN
	1    3550 5900
	1    0    0    -1  
$EndComp
$Comp
L LED D4
U 1 1 511561F6
P 3700 2950
F 0 "D4" H 3700 3050 50  0000 C CNN
F 1 "IRLED" H 3700 2850 50  0000 C CNN
	1    3700 2950
	0    1    1    0   
$EndComp
$Comp
L NPN Q1
U 1 1 511561E6
P 4050 3350
F 0 "Q1" H 4050 3200 50  0000 R CNN
F 1 "NPN" H 4050 3500 50  0000 R CNN
	1    4050 3350
	0    -1   -1   0   
$EndComp
$Comp
L C C3
U 1 1 511560BC
P 7100 4600
F 0 "C3" H 7150 4700 50  0000 L CNN
F 1 "100n" H 7150 4500 50  0000 L CNN
	1    7100 4600
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 5115608D
P 3950 5500
F 0 "C2" H 4000 5600 50  0000 L CNN
F 1 "22P" H 4000 5400 50  0000 L CNN
	1    3950 5500
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 5115607F
P 3150 5500
F 0 "C1" H 3200 5600 50  0000 L CNN
F 1 "22P" H 3200 5400 50  0000 L CNN
	1    3150 5500
	1    0    0    -1  
$EndComp
$Comp
L R R6
U 1 1 5115602E
P 4800 5200
F 0 "R6" V 4880 5200 50  0000 C CNN
F 1 "4k7" V 4800 5200 50  0000 C CNN
	1    4800 5200
	0    -1   -1   0   
$EndComp
$Comp
L QUARTZCMS4 X1
U 1 1 51155FF7
P 3550 5200
F 0 "X1" H 3550 5350 60  0000 C CNN
F 1 "QUARTZCMS4" H 3550 5050 60  0000 C CNN
	1    3550 5200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR10
U 1 1 51155F07
P 7100 5050
F 0 "#PWR10" H 7100 5050 30  0001 C CNN
F 1 "GND" H 7100 4980 30  0001 C CNN
	1    7100 5050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR2
U 1 1 51155ED2
P 800 5200
F 0 "#PWR2" H 800 5200 30  0001 C CNN
F 1 "GND" H 800 5130 30  0001 C CNN
	1    800  5200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR3
U 1 1 51155E5F
P 2000 5200
F 0 "#PWR3" H 2000 5200 30  0001 C CNN
F 1 "GND" H 2000 5130 30  0001 C CNN
	1    2000 5200
	1    0    0    -1  
$EndComp
$Comp
L ZENER D1
U 1 1 51155E20
P 2000 4850
F 0 "D1" H 2000 4950 50  0000 C CNN
F 1 "ZENER 3.6V" H 2000 4750 40  0000 C CNN
	1    2000 4850
	0    -1   -1   0   
$EndComp
$Comp
L ZENER D2
U 1 1 51155DF7
P 2350 4850
F 0 "D2" H 2350 4950 50  0000 C CNN
F 1 "ZENER 3.6V" H 2350 4750 40  0000 C CNN
	1    2350 4850
	0    -1   -1   0   
$EndComp
$Comp
L R R2
U 1 1 51155D57
P 2750 4550
F 0 "R2" V 2830 4550 50  0000 C CNN
F 1 "68R" V 2750 4550 50  0000 C CNN
	1    2750 4550
	0    -1   -1   0   
$EndComp
$Comp
L R R1
U 1 1 51155D44
P 2400 4400
F 0 "R1" V 2480 4400 50  0000 C CNN
F 1 "68R" V 2400 4400 50  0000 C CNN
	1    2400 4400
	0    -1   -1   0   
$EndComp
$Comp
L USB_1 J1
U 1 1 51155CDC
P 1450 4200
F 0 "J1" H 1300 4600 60  0000 C CNN
F 1 "USB_1" H 1425 3600 60  0001 C CNN
	1    1450 4200
	1    0    0    -1  
$EndComp
$Comp
L ATTINY45-P IC1
U 1 1 51155CC1
P 4400 4250
F 0 "IC1" H 4500 4300 60  0000 C CNN
F 1 "ATTINY45-P" H 6400 3500 60  0000 C CNN
F 2 "DIP8" H 4500 3500 60  0001 C CNN
	1    4400 4250
	1    0    0    -1  
$EndComp
$EndSCHEMATC
