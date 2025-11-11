/*
 * Aufgabe_1_4.S
 *
 * SoSe 2024
 *
 *  Created on: <$16.10.2025>
 *      Author: <$Muhammed Enes Ercan>
 *
 *	Aufgabe : Maskenoperationen
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
main:

        mov r0, #0xFFFFFFFF
        mov r1, #0x00000001
        mov r2, #0x00000001
        mov r3, #0x00000002

        // Niederwertigen Wert
        adds r4, r0, r2       // r4 = r0 + r2, sets carry flag
        adcs r5, r1, r3       
        movcc  r6, #0           // R6 wird für finalen Overflow verwendet
        movcs  r6, #1           // Überlauf aus der High-Addition
        

stop:
	nop
	bal stop

.end
