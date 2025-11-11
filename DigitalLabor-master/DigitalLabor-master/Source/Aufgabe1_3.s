/*
 * Aufgabe_1_3.S
 *
 * SoSe 2024
 *
 *  Created on: <$16.10.2025>
 *      Author: <$Muhammed Enes Ercan>
 *
 *	Aufgabe : Flags und bedingte Ausführung
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
main:
          
         mov r0, #0x0011
	 mov r1, #0x1100
	
	cmp r0,r1 // 
        bhi label // Wenn der Wert größer ist

        mov r1,#0
        b ohneSprung

label:
        mov r1,#255

.equ TRESCHOLD, 120 

ohneSprung: 
        mov r0, #TRESCHOLD - 1
        mov r1, #TRESCHOLD
        cmp r0, r1
        movgt r1, #255 // r0 > r1, setze r1 auf 0 (movgt: Move if Greater Than)
        movle r1, #0 // r0 <= r1, setze r1 auf 1 (movle: Move if Less Than or Equal)

        mov r0, #TRESCHOLD
	mov r1, #TRESCHOLD
        cmp r0, r1
        movgt r1, #255 // r0 > r1, setze r1 auf 0 (movgt: Move if Greater Than)
        movle r1, #0 // r0 <= r1, setze r1 auf 1 (movle: Move if Less Than or Equal)

        mov r0, #TRESCHOLD + 1
	mov r1, #TRESCHOLD
        cmp r0, r1
        movgt r1, #255 // r0 > r1, setze r1 auf 0 (movgt: Move if Greater Than)
        movle r1, #0 // r0 <= r1, setze r1 auf 1 (movle: Move if Less Than or Equal)

        mov r0, #0
	mov r1, #TRESCHOLD
        cmp r0, r1
        movgt r1, #255 // r0 > r1, setze r1 auf 0 (movgt: Move if Greater Than)
        movle r1, #0 // r0 <= r1, setze r1 auf 1 (movle: Move if Less Than or Equal)
stop:
	nop
	bal stop


.end