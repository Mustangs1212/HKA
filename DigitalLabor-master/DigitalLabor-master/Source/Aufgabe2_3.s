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
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
main:
        ldr     r0, =data        // Zeiger auf Datenfeld
        mov     r1, #0           // Ergebnisregister
        mov     r2, #80          // Grenzwert
        mov     r3, #8           // Anzahl der Werte

loop:
        ldr     r4, [r0], #4     // Lade Wert, nach dem laden Zeiger 4 erhöhen
        cmp     r4, r2
        movlt   r5, #0           // Wenn < 80 -> 0
        movge   r5, #8           // Wenn >= 80 -> 8

        lsl     r1, r1, #4       // Ergebnis nach links schieben (neues Nibble frei
        orr     r1, r1, r5       // Oder gatter für neues Nibble anhängen

        subs    r3, r3, #1       // Zähler --
        bne     loop

stop:
        nop
        bal     stop

.data
data:
        .word  10, 200, 44, 96, 123, 79, 81, 5 // 4 Byte lang
.end
