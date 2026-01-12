/*
 * Aufgabe_5_3.S
 *
 * SoSe 2024
 *
 *  Created on: <$04.01.2026>
 *      Author: <$Muhammed Enes Ercan>
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

.equ LED_0_bm, (1 << 23) 
.equ LED_1_bm, (1 << 22) 
.equ LED_2_bm, (1 << 21)  
.equ LED_3_bm, (1 << 20) 
.equ LED_4_bm, (1 << 19) 
.equ LED_5_bm, (1 << 18) 
.equ LED_6_bm, (1 << 17) 
.equ LED_7_bm, (1 << 16) 

.equ BUTTON_0_bm, (1 << 13) 
.equ BUTTON_1_bm, (1 << 12) 
.equ BUTTON_2_bm, (1 << 11) 
.equ BUTTON_3_bm, (1 << 10) 

main: 
    // Konfiguration der I/O-Pins als Ausgang für LEDs
        ldr sp, =STACK_START

        /* LEDs als Ausgang konfigurieren */
        ldr   r0, =IOPIN1
        add   r1, r0, #IODIR
        ldr   r2, [r1]
        orr   r2, r2, #(LED_0_bm | LED_1_bm | LED_2_bm | LED_3_bm | \
                        LED_4_bm | LED_5_bm | LED_6_bm | LED_7_bm)
        str   r2, [r1]

loop:
        mov   r0, #BUTTON_0_bm
        mov   r1, #LED_0_bm
        mov   r2, #LED_2_bm
        bl    button_led_momentary

        mov   r0, #BUTTON_1_bm
        mov   r1, #LED_1_bm
        mov   r2, #LED_3_bm
        bl    button_led_momentary

        mov   r0, #BUTTON_2_bm
        mov   r1, #LED_4_bm
        mov   r2, #LED_6_bm
        bl    button_led_momentary

        mov   r0, #BUTTON_3_bm
        mov   r1, #LED_5_bm
        mov   r2, #LED_7_bm
        bl    button_led_momentary

        b     loop


//ldrb r6,[R5, #IOCONFIG_1_R]
// and r6, #~ IO_DATA_SIZE_MASK 
// orr r6,# IO_DATA_SIZE_HWORD 
// strb r6,[R5, #IOCONFIG_1_R] 

button_led_momentary:
        push  {lr}

        ldr r3, =IOPIN0
        ldr r4, [r3]
        ands  r4, r4, r0
        beq   pressed            // Active Low

        /* Button NICHT gedrückt */
        ldr   r3, =IOPIN1
        //and r3, r3, #~ IOSET 
        //orr r3, #IOSET
        str   r2, [r3,#IOSET]            // gerade LED EIN

        ldr   r3, =IOPIN1
        //and r3, r3, #~ IOCLR 
        //orr r3, #IOCLR
        str r1, [r3, #IOCLR]            // ungerade LED AUS
        b     done

        /* Button GEDRÜCKT */
pressed:
        ldr   r3, =IOPIN1
        //and r3, r3, #~ IOSET 
        //orr r3, #IOSET
        str r1, [r3, #IOSET]            // ungerade LED EIN

        ldr   r3, =IOPIN1
        //and r3, r3, #~ IOCLR
        //orr r3, #IOCLR
        str r2, [r3, #IOCLR]            // gerade LED AUS

done:
        pop   {lr}
        bx    lr
stop:
    nop                
    bal stop
.end

//mov r6, #1«16 
//mov r5, #1«10
// ldr r0, [r4] 
// ands r0, r5, r0 
// bne noled1 

//str r6, [r2] // switch pins defined in r9 on (IOSET1) (first LED on)
//mov r6, r6, lsl #1 // shift mask to second LED
//str r6, [r3] // switch pins defined in r9 off (IOCLR1) (second LED off)
//b led_done // brunch to end

//noled1:
//str r6, [r3] // switch pins defined in r9 off (IOCLR1) (first LED off)
//mov r6, r6, lsl #1 // shift mask to second LED
//str r6, [r2] // switch pins defined in r9 on (IOSET1) (second LED on)

//led_done: // End subrutine