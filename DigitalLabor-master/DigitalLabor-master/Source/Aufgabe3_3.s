/*
 * Aufgabe_3_3.S
 *
 * SoSe 2024
 *
 *  Created on: <$24.11.2025>
 *      Author: <$Muhammed Enes Ercan>
 *
 *	Aufgabe : Unterprogrammaufruf  mit Parameterübergabe über dem Stack
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */

main:
        ldr     r0, =data        // Zeiger auf Datenfeld
        mov     r1, #0           // Ergebnisregister
        mov     r2, #80          // Grenzwert
        mov     r3, #8           // Anzahl der Werte

loop:
        ldr     r4, [r0], #4     // Wert laden (+4)
        cmp     r4, r2
        movlt   r5, #0
        movge   r5, #8

        lsl     r1, r1, #4       // Nibble freischieben
        orr     r1, r1, r5       // Nibble anhängen

        mov     r6, #3          

        sub     sp, sp, #4       // Platz auf Stack schaffen
        str     r6, [sp]         // Parameter speichern (FILO)

        bl      delay            

        add     sp, sp, #4       // Stack bereinigen

        subs    r3, r3, #1
        bne     loop

stop:
        nop
        bal     stop

delay:
        sub     sp, sp, #4       // Speicherplatz schaffen
        stm     sp, {r4}         // r4 sichern

        ldr     r0, [sp, #4]     // Parameter holen (SP bleibt unverändert!)

delay_loop:
        subs    r0, r0, #1
        bne     delay_loop

        ldm     sp, {r4}         // r4 wiederherstellen
        add     sp, sp, #4       // Stack bereinigen
        bx      lr               // zurück


.data
data:
        .word 10, 200, 44, 96, 123, 79, 81, 5
.end
