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

loop_start:
        bl delay
        b loop_start

delay:

stop:
	nop
	bal stop

.end
