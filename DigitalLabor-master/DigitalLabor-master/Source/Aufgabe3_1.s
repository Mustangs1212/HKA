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
    bl delay // delay einmal ausführen

stop:
    nop
    bal stop

// delay() ohne Parameter
delay:
    sub     sp, sp, #4 // Stackplatz reservieren
    stm     sp, {r4} // r4 sichern

    ldr     r4, =DELAYCONST

delay_loop:
    subs    r4, r4, #1
    bne     delay_loop

    ldm     sp, {r4} // r4 zurückladeen
    add     sp, sp, #4 // stackpointer bereinigen

    bx      lr
