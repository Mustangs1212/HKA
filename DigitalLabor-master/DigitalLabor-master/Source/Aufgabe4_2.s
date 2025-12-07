/*
 * Aufgabe_4_2.S
 *
 * SoSe 2024
 *
 *  Created on: <$07.12.2025>
 *      Author: <$Muhammed Enes Ercan>
 *
 *	Aufgabe : Addition von zwei 8 stelligen BCD Zahlen
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */


/* ---------------------------------------------------------
   add_bcd8
   Addiert zwei 8-stellige BCD-Zahlen in r0 und r1.
   Ergebnis kommt in r0 zurück.
--------------------------------------------------------- */
add_bcd8:
        push    {r4-r8, lr}

        mov     r2, #8          @ Stellenzähler (8 Nibbles)
        mov     r3, #0xF        @ Maske für 1 BCD-Nibble
        mov     r4, #0          @ Ergebnisregister
        mov     r5, #0          @ Übertrag (carry)
        mov     r8, #0          @ Bitposition im Ergebnis (0,4,8,...)

bcd_loop:
        cmp     r2, #0
        beq     bcd_finished

        @ --- Niedrigste Stellen isolieren ---
        and     r6, r0, r3      @ Stelle aus BCD1
        and     r7, r1, r3      @ Stelle aus BCD2

        @ --- Summe bilden ---
        add     r6, r6, r7
        add     r6, r6, r5

        @ --- Carry prüfen ---
        mov     r5, #0
        cmp     r6, #10
        blt     no_carry_bcd

        sub     r6, r6, #10     @ BCD-Korrektur
        mov     r5, #1          @ neuen Carry setzen

no_carry_bcd:

        @ --- Ergebnis an richtiger Stelle einfügen ---
        orr     r4, r4, r6, lsl r8

        @ --- Eingabe eine Stelle weiter schieben ---
        lsr     r0, r0, #4
        lsr     r1, r1, #4

        @ --- Ergebnisposition +4 Bits ---
        add     r8, r8, #4

        subs    r2, r2, #1
        b       bcd_loop

bcd_finished:
        @ Finaler Carry wird verworfen (8-stellige Ausgabe)
        mov     r0, r4

        pop     {r4-r8, lr}
        bx      lr

/* ---------------------------------------------------------
   Testprogramm
--------------------------------------------------------- */
main:
        // Mehrfachüberläufe
        ldr     r0, =0x00008999
        ldr     r1, =0x00001111
        bl add_bcd8

        // Einfach, ohne Überlauf
        ldr     r0, =0x00001234
        ldr     r1, =0x00005670
        bl add_bcd8

        // Überlauf in der niedrigsten Stelle
        ldr     r0, =0x00000999
        ldr     r1, =0x00000001
        bl add_bcd8

        // Komplett ohne Carry, perfekte 9 --> 9-Addition
        ldr     r0, =0x00004567
        ldr     r1, =0x00005432
        bl add_bcd8

        // Maximalfall
        ldr     r0, =0x99999999
        ldr     r1, =0x00000001
        bl add_bcd8



stop:
        nop
        b stop