/*
 * Aufgabe_3_3.S
 *
 * SoSe 2024
 *
 *  Created on: <$Date>
 *      Author: <$Name>
 *
 *	Aufgabe : Unterprogrammaufruf  mit Parameterübergabe über dem Stack
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
main:

    ldr r6, =3              

    sub sp, sp, #4          // Platz schaffen (post-decrement konform)
    str r6, [sp]            // Parameter auf den Stack speichern

    bl delay                // Funktion aufrufen

    add sp, sp, #4          // Stack bereinigen (Parameter entfernen)


stop:
    nop
    bal stop


delay:
    // Arbeitsregister sichern (r4)
    sub sp, sp, #4
    stm sp, {r4}

    // Parameter vom Stack holen:
    ldr r0, [sp, #4]        // Parameter in r0 laden (SP bleibt unverändert!)

delay_loop:
    subs r0, r0, #1
    bne delay_loop

    // Arbeitsregister zurückholen
    ldm sp, {r4}
    add sp, sp, #4

    bx lr
