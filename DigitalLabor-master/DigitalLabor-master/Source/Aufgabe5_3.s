/*
 * Aufgabe_5_3.S
 *
 * SoSe 2024
 *
 *  Created on: <$04.01.2026>
 *      Author: <$Name>
 *
 *	Aufgabe : Ein- und Ausgabe über Taster und LEDs
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
main:

.equ STACK_START, 0x40001000

.equ IOPIN0, 0xe0028000  
.equ IOPIN1, 0xe0028010  
.equ IOSET, 0x04         
.equ IODIR, 0x08         
.equ IOCLR, 0x0c         

.equ LED_0_bm, (1 << 16) 
.equ LED_1_bm, (1 << 17) 
.equ LED_2_bm, (1 << 18)  
.equ LED_3_bm, (1 << 19) 
.equ LED_4_bm, (1 << 20) 
.equ LED_5_bm, (1 << 21) 
.equ LED_6_bm, (1 << 22) 
.equ LED_7_bm, (1 << 23) 

.equ BUTTON_0_bm, (1 << 10) 
.equ BUTTON_1_bm, (1 << 11) 
.equ BUTTON_2_bm, (1 << 12) 
.equ BUTTON_3_bm, (1 << 13) 

main: 
    // Konfiguration der I/O-Pins als Ausgang für LEDs
        ldr sp, =STACK_START

        /* LEDs als Ausgang konfigurieren */
        ldr   r0, =IOPIN1
        add   r1, r0, #IODIR // Richtungsregister
        ldr   r2, [r1]
        orr   r2, r2, #(LED_0_bm | LED_1_bm | LED_2_bm | LED_3_bm | \
                        LED_4_bm | LED_5_bm | LED_6_bm | LED_7_bm)
        str   r2, [r1]

loop:
        mov   r0, #BUTTON_0_bm
        mov   r1, #LED_1_bm
        mov   r2, #LED_0_bm
        bl    button_led_momentary

        mov   r0, #BUTTON_1_bm
        mov   r1, #LED_3_bm
        mov   r2, #LED_2_bm
        bl    button_led_momentary

        mov   r0, #BUTTON_2_bm
        mov   r1, #LED_5_bm
        mov   r2, #LED_4_bm
        bl    button_led_momentary

        mov   r0, #BUTTON_3_bm
        mov   r1, #LED_7_bm
        mov   r2, #LED_6_bm
        bl    button_led_momentary

        b     loop


button_led_momentary:
        push  {lr}

        ldr   r3, =IOPIN0
        ldr   r4, [R3]
        ands  r4, r4, r0
        beq   pressed            // Active Low

        /* Button NICHT gedrückt */
        ldr   r3, =IOPIN1
        add   r3, r3, #IOSET
        str   r2, [r3]            // gerade LED EIN

        ldr   r3, =IOPIN1
        add   r3, r3, #IOCLR
        str   r1, [r3]            // ungerade LED AUS
        b     done

        /* Button GEDRÜCKT */
pressed:
        ldr   r3, =IOPIN1
        add   r3, r3, #IOSET
        str   r1, [r3]            // ungerade LED EIN

        ldr   r3, =IOPIN1
        add   r3, r3, #IOCLR
        str   r2, [r3]            // gerade LED AUS

done:
        pop   {lr}
        bx    lr
stop:
    nop                
    bal stop
.end