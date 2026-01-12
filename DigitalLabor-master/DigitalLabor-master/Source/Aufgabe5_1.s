/*
 * Aufgabe_5_1.S
 *
 * SoSe 2024
 *
 *  Created on: <$01.01.2026>
 *      Author: <$Muhammed Enes Ercan>
 *
 *	Aufgabe : Fortschrittsanzeige
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */

.equ IODIR1, 0xe0028018      
.equ IOSET1, 0xe0028014       
       
.equ STACK_START, 0x40001000 
.equ LED_0_bm, (1 << 23) 

.equ DELAY, 0x00ffffff  

main:

.global start             
start:

    ldr sp, =STACK_START // Stackpointer setzen

    // Konfiguration der I/O-Pins als Ausgang
    ldr r0, =IODIR1           
    ldr r1, [r0] // Wert von r0(Ausgang) in r1 laden
    orr r1, r1, #0x00ff0000 // die Bits 16 bis 23 in r1 als Ausgang setzen
    str r1, [r0]   // Wert aus r1 an Adresse IODIR1 schreiben


    // Initialisieren der LED-Bewegung
    mov r2, #LED_0_bm // Anfangsbitmuster (0x00010000) / Erste LED
    mov r3, #8  // Anzahl der LEDs 

loop:
    // Setzen der LEDs mit Bitmaske
    ldr r0, =IOSET1           
    str r2, [r0]              
    
    bl delay

    // Verschieben des Bitmusters nach links
    lsr r2, r2, #1 

    subs r3, r3, #1
    bne loop              

stop:
	nop
	bal stop                   



delay:
        stmfd     sp!, {r4}         // r4 sichern

        ldr     r4, =DELAY  

delay_loop:
        subs    r4, r4, #1
        bne     delay_loop

        ldmfd     sp, {r4}         // r4 zurückladen
        bx      lr               // zurück

.end