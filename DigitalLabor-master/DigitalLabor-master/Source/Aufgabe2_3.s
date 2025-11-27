/*
 * Aufgabe_2_3.S
 *
 * SoSe 2024
 *
 *  Created on: <$03.11.2025>
 *      Author: <$Muhammed Enes Ercan>
 *
 *	Aufgabe : Werte Binarisieren
 */
        .text
        .code 32
        .global main

/* -------------------------------------------------------
   32-Bit Fibonacci-LFSR
   Polynomial: x^22 + x^18 + x^10 + 1
   Taps (bit positions, 0 = LSB):
        22, 18, 10, 0

   Eingabe : R0 = aktueller LFSR-Wert
   Ausgabe : R0 = neuer Wert
------------------------------------------------------- */
        .thumb
        .align 2
        .global lfsr32
lfsr32:
        @ R0 enthält aktuelles LFSR
        mov     r1, r0

        @ Bits extrahieren
        lsrs    r2, r1, #22     @ Bit 22 → r2
        ands    r2, r2, #1

        lsrs    r3, r1, #18     @ Bit 18 → r3
        ands    r3, r3, #1
        eors    r2, r2, r3      @ XOR sammeln

        lsrs    r3, r1, #10     @ Bit 10 → r3
        ands    r3, r3, #1
        eors    r2, r2, r3

        ands    r3, r1, #1      @ Bit 0
        eors    r2, r2, r3      @ r2 = feedback bit

        @ SHIFT RIGHT & feedback in Bit 31
        lsrs    r0, r0, #1
        lsls    r2, r2, #31
        orrs    r0, r0, r2

        bx      lr




        .thumb
        .align 2
        .code 32
main:
        mov     r4, #0          @ high-word Seed-Split
        ldr     r0, =225567     @ low-word in R0 (Startwert)

        mov     r5, #11         @ 11 Werte berechnen

loop_gen:
        push    {r0}            @ alten Wert FILO auf Stack legen

        bl      lfsr32          @ neuen LFSR-Wert berechnen

        subs    r5, r5, #1
        bne     loop_gen

stop:
        nop
        b       stop
