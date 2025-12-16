/*
 * Aufgabe_2_3.S
 *
 * SoSe 2024
 *
 *  Created on: <$08.12.2025>
 *      Author: <$Muhammed Enes Ercan>
 *
 *	Aufgabe : Maximalwert eines Datenblocks ermitteln
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */

divide:
    push {r4- r6, lr} // Temp Register sichern
    mov r4, r0

    mov r5, r1 // Divisor

    mov r6, #0 // Quotient

    cmp r1, #0
    moveq r3, #-1                  
    beq error
    mov r3, #0

loop_division:
    cmp r4, #0
    blt end_loop // wenn Divident < 0

    sub r4, r4, r5 // Dividend - Divisor

    add r6, r6, #1 // Quotient erhöhen

    b loop_division

end_loop:
    // Wir haben 1x zu viel subtrahiert --> rückgängig machen 
    // if (Dividend < 0) --> Korrektur
    cmp r4, #0
    bge no_correction

    sub r6, r6, #1 // Quotient korigieren
    add r4, r4, r5 // rest wiederherstellen: Rest = Dividend + Divisor

no_correction:

    mov r0, r6   // Quotient
    mov r1, r4   // Rest

error:
    pop {r4- r6, lr}
    bx lr


main:
    mov r0, #27      // Dividend
    mov r1, #5       // Divisor

    bl divide

    // Ergebnis in r0 und r1 (Rest)

stop:
    nop
    bal stop

.end