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
    ldr r0, = 3 // Parameter (Wartezeit) in r0 laden
    bl delay // delay(3) aufrufen

stop:
    nop
    bal stop


// kein Stack, kein Register sichern

delay:
    subs    r0, r0, #1
    bne     delay

    bx      lr
