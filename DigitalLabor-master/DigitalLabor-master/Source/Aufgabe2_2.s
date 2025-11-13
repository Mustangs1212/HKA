/*
 * Aufgabe_2_2.S
 *
 * SoSe 2024
 *
 *  Created on: <$02.11.2025>
 *      Author: <$Muhammed Enes Ercan>
 *
 *	Aufgabe : Multiplikation
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
main:

        mov r0, #3          
        mov r1, #3          

        mov r2, #0          // Ergebnis (low)
        mov r3, #0          // Überlaufzähler (high)
        
        cmp r1, #0          // Wenn 0
        beq stop

add_loop:
        

        adds r2, r2, r0      // Addiere Multiplikand zu Ergebnis (low)
        adc r3, r3, #0       // Addiere Übertrag zu High-Teil
        subs r1, r1, #1       // Multiplikator verringern(Fürs wiederhilen
        bne   add_loop       

        // mit bne while_loop + cmp beq außer while loop tragen, darf mann eine do-while haben
        

// Teil 2
        

fact_loop:
        tst r1, #1 // Prüfe niedrigstes Bit des Multiplikators
        beq skip_add // Wenn Bit = 0
        adds r2, r2, r0
        adc r3, r3, #0

skip_add:
        movs r1, r1, lsr #1
        beq stop

        movs r0, r0, lsl #1 // Multiplikant multiplizieren 
        b fact_loop

stop:
	nop
	bal stop

.end
