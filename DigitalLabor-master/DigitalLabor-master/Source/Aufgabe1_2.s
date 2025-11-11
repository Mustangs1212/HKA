/*
 * Aufgabe_1_2.S
 *
 * SoSe 2024
 *
 *  Created on: <16.10.2025>
 *      Author: <Muhammed Enes Ercan>
 *
 *	Aufgabe : Addition von Zahlen
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
main:
        // a
        mov r0, #4294967294
	mov r1, #2
	add r2, r1,r0
        
        //b
        mov r3, #~1
        mov r4, #2
        add r5, r4,r3

        //c 
        mov r6, #1<<31
        add r6, r6,r6

stop:
	nop
	bal stop

.end
