/* Name: main.c
 * Project: hid-data, example how to use HID for data transfer
 * Author: Christian Starkjohann
 * Creation Date: 2008-04-11
 * Tabsize: 4
 * Copyright: (c) 2008 by OBJECTIVE DEVELOPMENT Software GmbH
 * License: GNU GPL v2 (see License.txt), GNU GPL v3 or proprietary (CommercialLicense.txt)
 * This Revision: $Id$
 */

/* PIN Configuration on Atmega 8
 *
 * Status LED:  PB0 (PIN14)
 * USB D-:		PD2 (PIN2)   // D-/D+ reversed for the usbSofCount feature
 * USB D+:		PD0 (PIN4)
 *
 */

/* PIN Configuration on ATtiny45
 # IR LED:	PB0 (PIN 5)
 # USB D-:  PB1 (PIN 6)
 # USB D+:  PB2 (PIN 7) 
*/

/*
This example should run on most AVRs with only little changes. No special
hardware resources except INT0 are used. You may have to change usbconfig.h for
different I/O pins for USB. Please note that USB D+ must be the INT0 pin, or
at least be connected to INT0 as well.
*/

#include <avr/io.h>
#include <avr/wdt.h>
#include <avr/interrupt.h>  /* for sei() */
#include <util/delay.h>     /* for _delay_ms() */
#include <avr/eeprom.h>

#include <avr/pgmspace.h>   /* required by usbdrv.h */
#include "usbdrv.h"
#include "oddebug.h"        /* This is also an example for using debug macros */

#include "irsnd.h"			/* IR Library */

/* ------------------------------------------------------------------------- */
/* ----------------------------- USB interface ----------------------------- */
/* ------------------------------------------------------------------------- */

PROGMEM const char usbHidReportDescriptor[22] = {    /* USB report descriptor */
    0x06, 0x00, 0xff,              // USAGE_PAGE (Generic Desktop)
    0x09, 0x01,                    // USAGE (Vendor Usage 1)
    0xa1, 0x01,                    // COLLECTION (Application)
    0x15, 0x00,                    //   LOGICAL_MINIMUM (0)
    0x26, 0xff, 0x00,              //   LOGICAL_MAXIMUM (255)
    0x75, 0x08,                    //   REPORT_SIZE (8)
    0x95, 0x06,                    //   REPORT_COUNT (6)
    0x09, 0x00,                    //   USAGE (Undefined)
    0xb2, 0x02, 0x01,              //   FEATURE (Data,Var,Abs,Buf)
    0xc0                           // END_COLLECTION
};


/* Since we define only one feature report, we don't use report-IDs (which
 * would be the first byte of the report). The entire report consists of 128
 * opaque data bytes.
 */

/* The following variables store the status of the current data transfer */
static uchar    currentAddress;
static uchar    bytesRemaining;

static uchar	buf[6];

static uchar	flag_send;



/* ------------------------------------------------------------------------- */

/* usbFunctionRead() is called when the host requests a chunk of data from
 * the device. For more information see the documentation in usbdrv/usbdrv.h.
 */
uchar   usbFunctionRead(uchar *data, uchar len)
{
    if(len > bytesRemaining)
        len = bytesRemaining;
    //eeprom_read_block(data, (uchar *)0 + currentAddress, len);

	//memcpy(data, &buf[currentAddress], len);
	*data = &buf;
    currentAddress += len;
    bytesRemaining -= len;
	flag_send = 1;
    return len;
}

/* usbFunctionWrite() is called when the host sends a chunk of data to the
 * device. For more information see the documentation in usbdrv/usbdrv.h.
 */
uchar   usbFunctionWrite(uchar *data, uchar len)
{
    if(bytesRemaining == 0)
        return 1;               /* end of transfer */
    if(len > bytesRemaining)
        len = bytesRemaining;
    //eeprom_write_block(data, (uchar *)0 + currentAddress, len);
	memcpy(&buf[currentAddress], data, len);
    currentAddress += len;
    bytesRemaining -= len;
	flag_send = 1;
    return bytesRemaining == 0; /* return 1 if this was the last chunk */
}

/* ------------------------------------------------------------------------- */

usbMsgLen_t usbFunctionSetup(uchar data[8])
{
usbRequest_t    *rq = (void *)data;

    if((rq->bmRequestType & USBRQ_TYPE_MASK) == USBRQ_TYPE_CLASS){    /* HID class request */
        if(rq->bRequest == USBRQ_HID_GET_REPORT){  /* wValue: ReportType (highbyte), ReportID (lowbyte) */
            /* since we have only one report type, we can ignore the report-ID */
            bytesRemaining = 6;
            currentAddress = 0;
            return USB_NO_MSG;  /* use usbFunctionRead() to obtain data */
        }else if(rq->bRequest == USBRQ_HID_SET_REPORT){
            /* since we have only one report type, we can ignore the report-ID */
            bytesRemaining = 6;
            currentAddress = 0;
            return USB_NO_MSG;  /* use usbFunctionWrite() to receive data from host */
        }
    }else{
        /* ignore vendor type requests, we don't use any */
    }
    return 0;
}

/* ------------------------------------------------------------------------- */

/*// start status LED, t blinking period in 
void statusLed_Start (uchar t)
{
	if (!Led_T) {
		Led_C = t;
		PORTB |= 0x01;	// LED off
	}
  Led_T = Led_F = t;
}

// LED-state  tested every 1 ms (SOF)
static void statusLed_On1ms(void) {
	uchar led_t = Led_T, led_c;
	if (!led_t) return;
		led_c = Led_C;			// load to register
	if (!--led_c) {
		PORTB ^= 0x01;			// toggle LED
		led_c = Led_F;			// reload counter
	}
 	if (!--led_t) PORTC &= ~0x01;	// switch LED on 
	Led_T = led_t;				// write back register
	Led_C = led_c;
}
*/


void timer1_init (void)
{
//#if defined (__AVR_ATtiny45__) || defined (__AVR_ATtiny85__)                // ATtiny45 / ATtiny85:
	
	// this is 266 ... for a 8bit timer this is too high
    //OCR1C   =  (F_CPU / F_INTERRUPTS / 4) - 1;                              // compare value: 1/15000 of CPU frequency, presc = 4
	OCR1C = 255;
    TCCR1   = (1 << CTC1) | (1 << CS11) | (1 << CS10);                      // switch CTC Mode on, set prescaler to 4
//#else                                                                       // ATmegaXX:
//    OCR1A   =  (F_CPU / F_INTERRUPTS) - 1;                                  // compare value: 1/15000 of CPU frequency
//    TCCR1B  = (1 << WGM12) | (1 << CS10);                                   // switch CTC Mode on, set prescaler to 1
//#endif

#ifdef TIMSK1
    TIMSK1  = 1 << OCIE1A;                                                  // OCIE1A: Interrupt by timer compare
#else
    TIMSK   = 1 << OCIE1A;                                                  // OCIE1A: Interrupt by timer compare
#endif
}



/*---------------------------------------------------------------------------------------------------------------------------------------------------
 *  * timer 1 compare handler, called every 1/10000 sec
 *   *---------------------------------------------------------------------------------------------------------------------------------------------------
 *    */
#if defined (__AVR_ATtiny45__) || defined (__AVR_ATtiny85__)                // ATtiny45 / ATtiny85:
	ISR(TIM1_COMPA_vect, ISR_NOBLOCK)
#else
	ISR(TIMER1_COMPA_vect, ISR_NOBLOCK)
#endif
{
	    (void) irsnd_ISR();                                                     // call irsnd ISR

		// call other timer interrupt routines here...
}



/* ------------------------------------------------------------------------- */

int main(void)
{
	//DDRB &= ~((1 << DDB1) | (1 << DDB2));
	//DDRB  = 0x01;
	//PORTB |= (1<<PB0); // LED IRLED debug
	uchar   i;
	//uchar SofCmp = 0;

	IRMP_DATA *irmp_data;

    wdt_enable(WDTO_1S);
    /* Even if you don't use the watchdog, turn it off here. On newer devices,
     * the status of the watchdog (on/off, period) is PRESERVED OVER RESET!
     */
    /* RESET status: all port bits are inputs without pull-up.
     * That's the way we need D+ and D-. Therefore we don't need any
     * additional hardware initialization.
     */
    //odDebugInit();
    //DBG1(0x00, 0, 0);       /* debug output: main starts */
    usbDeviceDisconnect();  /* enforce re-enumeration, do this while interrupts are disabled! */
    i = 0;
    while(--i){             /* fake USB disconnect for > 250 ms */
        wdt_reset();
        _delay_ms(1);
    }

	irsnd_init();			/* stuff */
	timer1_init();

    usbDeviceConnect();
    usbInit();
    sei();

    //DBG1(0x01, 0, 0);       /* debug output: main loop starts */

//DDRB |= (1 << DDB0); // debug

    for(;;){                /* main event loop */
        //DBG1(0x02, 0, 0);   /* debug output: main loop iterates */
        wdt_reset();
        usbPoll();

		// LED IRLED debug
		// PORTB=(1<<PB0);
		// _delay_ms(250);
//		 PORTB &= ~(1<<PB0);
		// _delay_ms(250);
		
		if (flag_send == 1) {
			flag_send = 0;
		//	irmp_data = (struct IRMP_DATA*) buf;
			IRMP_DATA    *irmp_data = (void *)buf;
        	irsnd_send_data (irmp_data, TRUE);

        //	irmp_data.protocol = IRMP_NEC_PROTOCOL;
        //	irmp_data.address  = 0x00FF;
        //	irmp_data.command  = 0x0001;
        //	irmp_data.flags    = 0;
		}



    }
    return 0;
}

/* ------------------------------------------------------------------------- */
