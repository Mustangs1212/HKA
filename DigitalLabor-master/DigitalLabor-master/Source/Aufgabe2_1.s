/*
 * Aufgabe_2_1.S
 *
 * SoSe 2024
 *
 *  Created on: <$01.11.2025>
 *      Author: <$Muhammed Enes Ercan>
 *
 *	Aufgabe : 64 Bit Addition
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */

//Nibble 0 
.equ BREAD_bm, (1 << 0) 
.equ BUTTER_bm, (1 << 1)
.equ CHEESE_bm, (1 << 2)
.equ BREAKFAST_bm, (BREAD_bm | BUTTER_bm | CHEESE_bm)

// Byte 1
.equ TEQUILA_bm, (1 << 8)
.equ MILK_bm, (1 << 9)
.equ RUM_bm, (1 << 10)
.equ VINE_bm, (1 << 11)
.equ VODKA_bm, (1 << 12)
.equ DRINKS_bm, (TEQUILA_bm | MILK_bm | RUM_bm | VINE_bm | VODKA_bm)

// Nibble 2
.equ ALMOND_bm, (1 << 13)
.equ PEANUT_bm, (1 << 14)
.equ CHESTNUTS_bm, (1 << 15)
.equ NUTS_bm, (ALMOND_bm | PEANUT_bm | CHESTNUTS_bm)

// Nible 3
.equ APPLE_bm, (1 << 16)
.equ MANGO_bm, (1 << 17)
.equ LEMON_bm, (1 << 18)
.equ FRUITS_bm, (APPLE_bm | MANGO_bm | LEMON_bm)

// Frihstück 
.equ BREAKFAST_bm, (BREAD_bm | BUTTER_bm | CHEESE_bm | MILK_bm | PEANUT_bm | LEMON_bm)
main:
        ldr r0, =#BREAKFAST_bm
        ldr r1, =#(BREAKFAST_bm | NUTS_bm)
        ldr r2, =#((BREAKFAST_bm) & ~(MILK_bm) | VINE_bm)
        ldr r3, =#(FRUITS_bm & MILK_bm & MILK_bm) // Warum 0 Bit?
        ldr r4, =#((BREAKFAST_bm & ~BUTTER_bm) | (DRINKS_bm & ~(MILK_bm))) // Bekommt er alle Drinks 



stop:
	nop
	bal stop

.end
