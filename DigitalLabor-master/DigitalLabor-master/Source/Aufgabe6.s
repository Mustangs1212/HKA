/*
 * Aufgabe_6.S
 *
 * SoSe 2024
 *
 *  Created on: <$Date>
 *      Author: <$Name>
 *
 *	Aufgabe : Softwareinterrupt
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
.global swi_handler /* Specify global symbol */

/************* Stack *************/
.equ STACK_START, 0x40001000

/************* GPIO (wie Abgabe 5) *************/
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
.equ LED_BASE, 16          // LEDs are 16..23

/************* Jump Table *************/
EntryTable:
    .word _ledInit
    .word _ledOn
    .word _ledOff
    .word _ledToggle
    .word _keyInit
    .word _isPressed
    .word _delay

/* pin , delta */
ButtonTable:
    .word BTN0_PIN,  2
    .word BTN1_PIN,  1
    .word BTN2_PIN, -1
    .word BTN3_PIN, -2



/*************************************************
 * USER PROGRAM (Testanwendung)
 * Button0: +1, Button1: +2, Button2: -1, Button3: -2
 * count clamped 0..8, LEDs show "filled" state
 *************************************************/
main:
    ldr sp, =STACK_START

    /* init buttons as input */
    mov r0, #BTN0_PIN
    swi KEY_INIT
    mov r0, #BTN1_PIN
    swi KEY_INIT
    mov r0, #BTN2_PIN
    swi KEY_INIT
    mov r0, #BTN3_PIN
    swi KEY_INIT

    /* init leds as output */
    mov r5, #LED_BASE      // current pin
init_leds:
    mov r0, r5
    swi LED_INIT
    add r5, r5, #1
    cmp r5, #24            // stop after 23
    blt init_leds

    mov r6, #0             // count = 0..8

loop:
    ldr r8, =ButtonTable   // Tabellenzeiger
    mov r9, #4             // Anzahl Buttons

check_buttons:
    ldr r0, [r8]           // pin
    swi IS_PRESSED
    cmp r0, #0
    beq next_button

    /* gedrückt → delta anwenden */
    ldr r1, [r8, #4]       // delta
    add r6, r6, r1

/* wait for release (gemeinsam!) */
wait_release:
    ldr r0, [r8]           // gleicher pin
    swi IS_PRESSED
    cmp r0, #0
    bne wait_release

    b after_buttons        // nur ein Button pro Loop

next_button:
    add r8, r8, #8         // nächster Eintrag
    subs r9, r9, #1
    bne check_buttons


after_buttons:
    /* clamp 0..8 */
    cmp r6, #0
    movlt r6, #0
    cmp r6, #8
    movgt r6, #8

update_leds:
    /* for i=0..7: if i<count -> on else off */
    mov r7, #0
    mov r5, #LED_BASE

led_loop:
    cmp r7, r6
    mov r0, r5
    swilt LED_ON
    swige LED_OFF


next_led:
    add r7, r7, #1
    add r5, r5, #1
    cmp r7, #8
    blt led_loop

    /* small delay (optional, kann bleiben) */
    ldr r0, =60000
    swi DELAY

    b loop



/*************************************************
 * SWI HANDLER (robust, ohne "0xFFFF" immediate)
 * Strategy:
 *  - Read SWI instruction word at (lr-4)
 *  - Keep 24-bit comment field
 *  - r1 = function index = bits 23..16
 *  - param = low 16 bits (extracted via shifts)
 *  - if param != 0 -> r0 = param else keep r0
 *************************************************/
swi_handler:
    stmfd sp!, {r1-r3, lr}

    ldr  r3, [lr, #-4]         // instruction word
    lsl  r3, r3, #8            // drop top 8 bits (opcode/cond)
    lsr  r3, r3, #8            // r3 now = 24-bit comment field

    mov  r1, r3, lsr #16       // function index (0..255)

    /* extract low 16 bits param WITHOUT 0xFFFF mask */
    mov  r2, r3
    lsl  r2, r2, #16
    lsr  r2, r2, #16           // r2 = param (0..65535)

    cmp  r2, #0
    movne r0, r2               // if param present -> r0=param

    ldr  r3, =EntryTable
    ldr  r3, [r3, r1, lsl #2]
    bx   r3

swi_end:
    ldmfd sp!, {r1-r3, pc}^


/*************************************************
 * helper: compute base + mask
 * IN:  r0=pin
 * OUT: r1=base(IOPIN0/1), r4=mask(1<<pin)
 *************************************************/
_calc_base_and_mask:
    mov r4, #1
    lsl r4, r4, r0

    cmp r0, #16
    ldrlt r1, =IOPIN0
    ldrge r1, =IOPIN1
    bx lr


/************* Kernel functions *************/
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

    ldr r2, [r1]           // read IOPINx
    tst r2, r4
    beq _tgl_on

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
    bic r2, r2, r4         // input = 0
    str r2, [r5]

    pop {r4, r5, lr}
    b swi_end


_isPressed:
    /* Active-Low: pressed if (IOPIN & mask)==0 */
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
