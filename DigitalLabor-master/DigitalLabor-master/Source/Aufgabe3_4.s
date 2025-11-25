/*
 * Aufgabe_3_4.S
 *
 * SoSe 2024
 *
 *  Created on: <$Date>
 *      Author: <$Name>
 *
 *	Aufgabe : nterprogrammaufruf mit Übergebe von mehreren Parametern - Division
 */
    .text
    .code 32
    .global main
    .global lfsr

/* lfsr:
 * Input:  r0 = current state (32-bit, only lower 22 bits relevant)
 * Output: r0 = next state
 * Clobbers: r1,r2,r3
 */
lfsr:
    push {r1, r2, r3, lr}

    mov   r1, r0         /* r1 = state */
    and   r2, r1, #1     /* r2 = lsb */
    mov   r1, r1, LSR #1 /* r1 = state >> 1 */

    /* POLY >> 1 for x^22+x^18+x^10+1 is 0x00220200 */
    ldr   r3, =0x00220200

    cmp   r2, #0
    beq   lfsr_no_xor
    eor   r1, r1, r3     /* if lsb==1: state ^= (POLY>>1) */

lfsr_no_xor:
    mov   r0, r1
    pop   {r1, r2, r3, pc}

/* main:
 * - set seed = 225567
 * - call lfsr 11 times
 * - push each returned state onto stack (FILO)
 */
main:
    push {r4, lr}            /* save callee regs we'll use */

    ldr  r0, =225567         /* initial seed */
    mov  r4, #11             /* counter: produce 11 values */

lfsr_loop:
    bl   lfsr                /* r0 := next state */
    push {r0}                /* push produced value onto stack (FILO) */
    subs r4, r4, #1
    bne  lfsr_loop

    /* leave values on stack; enter infinite stop-loop (as in your template) */
stop:
    nop
    b    stop

    .end

