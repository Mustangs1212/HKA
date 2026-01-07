/*
 * Aufgabe_6.S
 *
 * SoSe 2024
 *
 *  Created on: <$Date>
 *      Author: <$Name>
 *
 *	Aufgabe : Softwareinterrupt
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
.global swi_handler /* Specify global symbol */

.equ DELAYCONST, 3  

/* -------------------------------------------------
   GPIO Register
------------------------------------------------- */
.equ IOPIN0, 0xE0028000
.equ IOPIN1, 0xE0028010
.equ IOSET,  0x04
.equ IODIR,  0x08
.equ IOCLR,  0x0C

/* -------------------------------------------------
   SWI Nummern
------------------------------------------------- */
.equ SWI_LED_INIT,    0
.equ SWI_LED_ON,      1
.equ SWI_LED_OFF,     2
.equ SWI_LED_TOGGLE,  3
.equ SWI_KEY_INIT,    4
.equ SWI_IS_PRESSED,  5
.equ SWI_DELAY,       6

/* -------------------------------------------------
   main – Testanwendung
------------------------------------------------- */
main:
        LDR     SP, =0x40001000     // Stack Pointer setzen

        /* LED 0 initialisieren */
        MOV     R0, #16             // Pin für LED
        SWI     #SWI_LED_INIT       // LED initialisieren

loop:
        /* LED ein */
        MOV     R0, #16
        SWI     #SWI_LED_OFF         // LED ein

        MOV     R0, #1000           // Verzögerungswert
        SWI     #SWI_DELAY           // Verzögerung aufrufen

        /* LED aus */
        MOV     R0, #16
        SWI     #SWI_LED_OFF        // LED aus

        MOV     R0, #1000           // Verzögerungswert
        SWI     #SWI_DELAY           // Verzögerung aufrufen

        B       loop                 // Unendliche Schleife

/* -------------------------------------------------
   SWI Handler
------------------------------------------------- */
swi_handler:
        stmfd   sp!, {r0-r3, lr}     // Sichern der Register

        /* SWI Nummer aus Instruktion holen */
        ldr     r1, [lr, #-4]        // Holen der SWI-Nummer
        bic     r1, r1, #0xFF000000  // Nur die SWI-Nummer extrahieren

        cmp     r1, #SWI_LED_INIT
        beq     swi_led_init

        cmp     r1, #SWI_LED_ON
        beq     swi_led_on

        cmp     r1, #SWI_LED_OFF
        beq     swi_led_off

        cmp     r1, #SWI_LED_TOGGLE
        beq     swi_led_toggle

        cmp     r1, #SWI_DELAY
        beq     swi_delay

        b       swi_end

/* -------------------------------------------------
   LED Initialisieren
------------------------------------------------- */
swi_led_init:
        ldr     r2, =IOPIN1
        add     r2, r2, #IODIR
        ldr     r3, [r2]
        orr     r3, r3, #(1 << 16)  // Setze Pin 16 als Ausgang
        str     r3, [r2]
        b       swi_end

/* -------------------------------------------------
   LED an
------------------------------------------------- */
swi_led_on:
        ldr     r2, =IOPIN1
        add     r2, r2, #IOSET
        mov     r3, #(1 << 16)      // Setze Pin 16
        str     r3, [r2]
        b       swi_end

/* -------------------------------------------------
   LED aus
------------------------------------------------- */
swi_led_off:
        ldr     r2, =IOPIN1
        add     r2, r2, #IOCLR
        mov     r3, #(1 << 16)      // Lösche Pin 16
        str     r3, [r2]
        b       swi_end

/* -------------------------------------------------
   LED umschalten
------------------------------------------------- */
swi_led_toggle:
        ldr     r2, =IOPIN1
        ldr     r3, [r2]
        tst     r3, #(1 << 16)      // Teste, ob Pin 16 gesetzt ist
        beq     swi_led_on
        b       swi_led_off

/* -------------------------------------------------
   Verzögerung
------------------------------------------------- */
swi_delay:
        bl      delay                // Aufruf der delay Funktion
        b       swi_end              // Rückkehr zum Handler

/* -------------------------------------------------
   Ende SWI
------------------------------------------------- */
swi_end:
        ldmfd   sp!, {r0-r3, lr}     // Wiederherstellen der Register
        bx      lr                    // Rückkehr vom Handler

/* -------------------------------------------------
   delay Funktion
------------------------------------------------- */
delay:
        stmfd     sp!, {r4}         // r4 sichern

        ldr     r4, =DELAYCONST  

delay_loop:
        subs    r4, r4, #1
        bne     delay_loop

        ldmfd     sp, {r4}         // r4 zurückladen
        bx      lr               // zurück