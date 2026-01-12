/*
 * Aufgabe_6.S
 *
 * SoSe 2024
 *
 *  Created on: <$12.01.2026>
 *      Author: <$Taha Kilic>
 *
 *	Aufgabe : Softwareinterrupt
 */
.text
.code 32
.global main
.global swi_handler

/************* Stack *************/
.equ STACK_START, 0x40001000

/************* GPIO *************/
.equ IOPIN0, 0xE0028000
.equ IOPIN1, 0xE0028010
.equ IOSET,  0x04
.equ IODIR,  0x08
.equ IOCLR,  0x0C

/************* SWI Function IDs (Bits 23..16) *************/
.equ LED_INIT,     (0 << 16)
.equ LED_ON,       (1 << 16)
.equ LED_OFF,      (2 << 16)
.equ LED_TOGGLE,   (3 << 16)
.equ KEY_INIT,     (4 << 16)
.equ IS_PRESSED,   (5 << 16)
.equ DELAY,        (6 << 16)

/************* Pins *************/
.equ BTN0_PIN, 10
.equ BTN1_PIN, 11
.equ BTN2_PIN, 12
.equ BTN3_PIN, 13
.equ LED_BASE, 16          // LEDs on P1.16 .. P1.23

/************* Jump Table *************/
EntryTable:
    .word _ledInit
    .word _ledOn
    .word _ledOff
    .word _ledToggle
    .word _keyInit
    .word _isPressed
    .word _delay

/* Button pin + delta */
ButtonTable:
    .word BTN0_PIN,  2
    .word BTN1_PIN,  1
    .word BTN2_PIN, -1
    .word BTN3_PIN, -2


main:
    ldr sp, =STACK_START

    /* Init buttons */
    mov r0, #BTN0_PIN
    swi KEY_INIT
    mov r0, #BTN1_PIN
    swi KEY_INIT
    mov r0, #BTN2_PIN
    swi KEY_INIT
    mov r0, #BTN3_PIN
    swi KEY_INIT

    /* Init LEDs */
    mov r5, #LED_BASE       // current pin
init_leds:
    mov r0, r5
    swi LED_INIT
    add r5, r5, #1
    cmp r5, #24
    blt init_leds

    mov r6, #0              // LED counter 0..8

loop:
    ldr r8, =ButtonTable
    mov r9, #4              // number of buttons

check_buttons:
    ldr r0, [r8]            // pin
    swi IS_PRESSED
    cmp r0, #0
    beq next_button

    /* apply delta */
    ldr r1, [r8, #4]
    add r6, r6, r1

/* wait for button release */
wait_release:
    ldr r0, [r8]
    swi IS_PRESSED
    cmp r0, #0
    bne wait_release

    b after_buttons         // only one button per loop

next_button:
    add r8, r8, #8
    subs r9, r9, #1
    bne check_buttons


after_buttons:
    /* clamp counter 0..8 */
    cmp r6, #0
    movlt r6, #0
    cmp r6, #8
    movgt r6, #8

update_leds:
    mov r7, #0
    mov r5, #LED_BASE

led_loop:
    cmp r7, r6
    blt led_on
    bge led_off

led_on:
    mov r0, r5
    swi LED_ON
    b next_led

led_off:
    mov r0, r5
    swi LED_OFF

next_led:
    add r7, r7, #1
    add r5, r5, #1
    cmp r7, #8
    blt led_loop

    /* small delay */
    ldr r0, =60000
    swi DELAY

    b loop


/*************************************************
 * SWI HANDLER
 *************************************************/
swi_handler:
    stmfd sp!, {r1-r3, lr}

    ldr  r3, [lr, #-4]      // SWI instruction
    lsl  r3, r3, #8
    lsr  r3, r3, #8         // 24-bit comment

    mov  r1, r3, lsr #16    // function index

    /* extract parameter */
    mov  r2, r3
    lsl  r2, r2, #16
    lsr  r2, r2, #16

    // Entscheidung: Register oder Kommentarfel
    cmp  r2, #0
    movne r0, r2

    // Sprung über Jump Table
    ldr  r3, =EntryTable
    ldr  r3, [r3, r1, lsl #2]
    bx   r3

//Rückkehr ins User-Programm
swi_end:
    ldmfd sp!, {r1-r3, pc}^

/*
* Hilfsmethode: Diese Funktion verhindert doppelten Code in allen Kernel-Funktionen.
*
* 1. Erzeugt die Bitmaske für einen Pin
*
* 2. Wählt das richtige GPIO-Basisregister (Port 0 oder Port 1
*/
_calc_base_and_mask:
    mov r4, #1
    lsl r4, r4, r0

    cmp r0, #16
    ldrlt r1, =IOPIN0
    ldrge r1, =IOPIN1
    bx lr


/************* Kernel Functions *************/
_ledInit:
    push {r4, r5, lr}
    bl _calc_base_and_mask

    add r5, r1, #IODIR
    ldr r2, [r5]
    orr r2, r2, r4
    str r2, [r5]

    pop {r4, r5, lr}
    b swi_end


_ledOn:
    push {r4, r5, lr}
    bl _calc_base_and_mask

    add r5, r1, #IOSET
    str r4, [r5]

    pop {r4, r5, lr}
    b swi_end


_ledOff:
    push {r4, r5, lr}
    bl _calc_base_and_mask

    add r5, r1, #IOCLR
    str r4, [r5]

    pop {r4, r5, lr}
    b swi_end


_ledToggle:
    push {r4, r5, lr}
    bl _calc_base_and_mask

    ldr r2, [r1]
    tst r2, r4
    beq _tgl_on

/*
* Schalten eine LED abhängig vom aktuell gelesenen Zustand über IOSET bzw. IOCLR ein oder aus
*/
_tgl_off:
    add r5, r1, #IOCLR
    str r4, [r5]
    b _tgl_done

_tgl_on:
    add r5, r1, #IOSET
    str r4, [r5]

_tgl_done:
    pop {r4, r5, lr}
    b swi_end


_keyInit:
    push {r4, r5, lr}
    bl _calc_base_and_mask

    add r5, r1, #IODIR
    ldr r2, [r5]
    bic r2, r2, r4
    str r2, [r5]

    pop {r4, r5, lr}
    b swi_end


_isPressed:
    /* Active-Low */
    push {r4, lr}
    bl _calc_base_and_mask

    ldr r2, [r1]
    tst r2, r4
    moveq r0, #1
    movne r0, #0

    pop {r4, lr}
    b swi_end


_delay:
delay_loop:
    subs r0, r0, #1
    bne delay_loop
    b swi_end

.end