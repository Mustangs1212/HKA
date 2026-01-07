/*
 * Aufgabe_5_2.S
 *
 * SoSe 2024
 *
 *  Created on: <$03.01.2026>
 *      Author: <$Muhammed Enes Ercan>
 *
 *	Aufgabe : Permanentes Lauflicht
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */

.equ IODIR1,   0xe0028018
.equ IOSET1,   0xe0028014
.equ IOCLR1,   0xe002801c

.equ STACK_START, 0x40001000

.equ LED_FIRST, (1 << 16)
.equ LED_LAST,  (1 << 23)

.equ DELAY_3_8, 0x003fffff
.equ DELAY_5_8, 0x006fffff

main:
        ldr sp, =STACK_START

        // Pins P1.16–P1.23 als Ausgang
        ldr r0, =IODIR1
        ldr r1, [r0]
        orr r1, r1, #0x00ff0000
        str r1, [r0]

        // Start mit erster LED
        mov r2, #LED_FIRST

loop:
        // LED einschalten
        ldr r0, =IOSET1
        str r2, [r0]

        // 3/8 EIN
        ldr r0, =DELAY_3_8 // r0 erhält den Zählwert für die Delay-Zeit
        bl delay

        // LED ausschalten
        ldr r0, =IOCLR1
        str r2, [r0]

        // 5/8 AUS
        ldr r0, =DELAY_5_8
        bl delay

        // Nächste LED
        lsl r2, r2, #1
        cmp r2, #(LED_LAST << 1)
        moveq r2, #LED_FIRST

        b loop

delay:
        stmfd   sp!, {r4} // r4 sichern

delay_loop:
        subs    r0, r0, #1
        bne     delay_loop

        ldmfd   sp!, {r4} // r4 wiederherstellen
        bx      lr

stop:
	nop
	bal stop

.end