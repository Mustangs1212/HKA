/*
 * Aufgabe_3_4.S
 *
 * SoSe 2024
 *
 *  Created on: <$25.11.2025>
 *      Author: <$Muhammed Enes Ercan>
 *
 *	Aufgabe : nterprogrammaufruf mit Übergebe von mehreren Parametern - Division
 */
         .text
        .global main
        .code 32
        .align 4


main:
        LDR   r0, =seed
        LDR   r1, [r0]        @ r1 = seed value
        MOV   r4, #11         @ loop counter

loop_start:
        PUSH  {r1}            @ FILO

        MOV   r0, r1
        BL    lfsr_step
        MOV   r1, r0          @ update state

        SUBS  r4, r4, #1
        BNE   loop_start

stop:
        B     stop


@ ---------------- LFSR FUNCTION --------------------------
@ polynomial: x^22 + x^18 + x^10 + 1
@ taps: bit21, bit17, bit9, bit0
@ ----------------------------------------------------------
        .thumb
        .thumb_func
lfsr_step:

        PUSH   {r1,r2,r3,r4}

        MOV    r4, #1         @ constant 1
        MOV    r1, r0         @ r1 = state

        @ ----- bit21 -----
        MOV    r2, r1
        LSR    r2, r2, #21
        AND    r2, r2, r4     @ r2 = bit21

        @ ----- bit17 -----
        MOV    r3, r1
        LSR    r3, r3, #17
        AND    r3, r3, r4
        EOR    r2, r2, r3

        @ ----- bit9 -----
        MOV    r3, r1
        LSR    r3, r3, #9
        AND    r3, r3, r4
        EOR    r2, r2, r3

        @ ----- bit0 -----
        MOV    r3, r1
        AND    r3, r3, r4
        EOR    r2, r2, r3      @ r2 = feedback bit

        @ ----- shift state -----
        LSR    r0, r1, #1      @ r0 = state >> 1

        @ ----- insert MSB -----
        @ r2 contains either 0 or 1
        MOV    r3, r2          @ copy feedback
        LSL    r3, r3, #31
        ORR    r0, r0, r3

        POP    {r1,r2,r3,r4}
        BX     lr


        .code 32
seed:
        .word 225567
