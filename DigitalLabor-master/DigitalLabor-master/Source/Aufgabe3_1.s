/*
 * Aufgabe_3_1.S
 *
 * SoSe 2024
 *
 *  Created on: <$21.11.2025>
 *      Author: <$Muhammed Enes Ercan>
 *
 *	Aufgabe : Unterprogrammaufruf
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */

.equ DELAYCONST, 3

main:
        ldr     r0, =data        // Zeiger auf Datenfeld
        mov     r1, #0           // Ergebnisregister
        mov     r2, #80          // Grenzwert
        mov     r3, #8           // Anzahl der Werte

loop:
        ldr     r4, [r0], #4     // Lade Wert, Zeiger +4
        cmp     r4, r2
        movlt   r5, #0           // < 80 → 0
        movge   r5, #8           // >= 80 → 8

        lsl     r1, r1, #4       // Ergebnis nach links schieben
        orr     r1, r1, r5       // Neues Nibble anhängen

        bl      delay            // delay einmal aufrufen

        subs    r3, r3, #1       // Zähler --
        bne     loop

stop:
        nop
        bal     stop


delay:
        stmfd     sp!, {r4}         // r4 sichern

        ldr     r4, =DELAYCONST  

delay_loop:
        subs    r4, r4, #1
        bne     delay_loop

        ldmfd     sp, {r4}         // r4 zurückladen
        bx      lr               // zurück
        

.data
data:
        .word 10, 200, 44, 96, 123, 79, 81, 5
.end