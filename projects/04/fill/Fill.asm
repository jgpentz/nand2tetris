// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

(INIT)
    @KEY
    0;JMP

(LOOP_INIT)
    @i
    M = 0
(LOOP)
    // 32 words per row, 256 rows
    @i
    D = M
    @8192
    D = A - D
    @KEY
    D;JLE

    // Point to the screen addr + offset and then write 0
    @SCREEN
    D = A
    @i
    D = D + M
    @R0
    M = D
    @color
    D = M
    @R0
    A = M
    M = D

    // Increment by word size (16 bits)
    @i
    M = M + 1

    @LOOP
    0;JMP

(KEY)
    // Set screen to black if key is pressed
    @color
    M = -1
    @KBD
    D = M
    @LOOP_INIT
    D;JNE

    // Otherwise Blank screen
    @color
    M = 0
    @LOOP_INIT
    0;JEQ
