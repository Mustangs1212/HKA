/*
 * Aufgabe_4_1.S
 *
 * SoSe 2024
 *
 *  Created on: <$07.12.2025>
 *      Author: <$Muhammed Enes Ercan>
 *
 *	Aufgabe : Verwendung von Stack
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */


.global absSub
absSub:
        subs r0, r1, r2     // r0 = y - z
        rsblt r0, r0, #0   // wenn r0 < 0 --> r0 = 0 - r0
        bx lr


.global berechne
berechne:
        stmfd sp!, {r4-r6, lr}    // Register sichern
        sub sp, sp, #8            // Platz für a,b,c

        mov r0, #150 // unsigned 8 bit
        strb r0, [sp]

        ldr r0, =-193 // signed 16 bit
        strh r0, [sp,#2]

        ldr r0, =-200 // signed 32 bit
        str r0, [sp,#4]

        // 1. addSub
        ldrh r1, [sp,#2] // r1 = b
        ldr  r2, [sp,#4] // r2 = c
        bl absSub        // r0 = abs(b - c)
        str  r0, [sp,#4] // c = r0

        // 2. addSub
        ldrb r1, [sp]     // r1 = a
        ldrh r2, [sp,#2]  // r2 = b
        rsb  r2, r2, #0   // r2 = -b (negieren)
        bl absSub         // r0 = abs(a - (-b))

        ldr r1, [sp,#4]   // r1 = c
        add r0, r0, r1    // zwischenergebnisse addieren
        str r0, [sp,#4]   // Neues c speichern

        // Rückgabewert in r0 laden
        ldr r0, [sp,#4]

        add sp, sp, #8
        ldmfd sp!, {r4-r6, lr}
        bx lr


.global main /* Specify global symbol */
main:
        sub sp, sp, #4 //verschiebe den Stackpointer um 4 byte nach unten

        mov r0, #0x44
        mov r1, #0x55
        
        mov r2, #0xffffffff
        str r2,[sp] // Lege den Wert des Register R2 auf dem Stack ab

        mov r5, #3
      
while:
        bl berechne

        ldr r1,[sp] // Lade den Wert aus dem Stack in dem Register R1
        cmp r0,r1
        strge r0,[sp] // Wenn R0 größer als R1 , dann lege den Inhalt von R0 auf dem Stack

        subs r5, r5, #1  
        bne while // wenn R5 nicht 0 dann Springe zu der Marke while

stop:
	nop
	bal stop

.end