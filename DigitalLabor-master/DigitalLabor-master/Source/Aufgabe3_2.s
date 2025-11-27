/*
 * Aufgabe_3_2.S
 *
 * SoSe 2024
 *
 *  Created on: <$24.11.2025>
 *      Author: <$Muhammed Enes Ercan>
 *
 *	Aufgabe : Unterprogrammaufruf  mit Parametern
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
        ldr     r4, [r0], #4     // Wert laden, Zeiger +4
        cmp     r4, r2

        movlt   r5, #0           // < 80 → 0
        movge   r5, #8           // >= 80 → 8

        lsl     r1, r1, #4       // Ergebnis-Nibble frei machen
        orr     r1, r1, r5       // Nibble anhängen

        mov     r0, #3           // Wartezeitparameter setzen 
        bl      delay            
     
        subs    r3, r3, #1       // Schleifenzähler--
        bne     loop

stop:
        nop
        bal stop


delay:

delay_loop:
        subs    r0, r0, #1       
        bne     delay_loop       
        bx      lr               
        

.data
data:
        .word 10, 200, 44, 96, 123, 79, 81, 5
.end