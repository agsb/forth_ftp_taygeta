
\ GOESINTO a recursive decomplier                     02Nov83RSW
 \ from FORTH DIMENSIONS p28 Vol IV, No. 2

: MYSELF LATEST PFA CFA , ; IMMEDIATE \ regular FIG PFA & LFA

0 VARIABLE GIN                  \ # to indent
: GIN+ CR GIN @ 2+ DUP GIN ! SPACES ;
: DIN  CR GIN @ SPACES ;
: CLIT ;                        \ no CLIT in 8086 FORTHs
: GCHK DUP @ 2+ ' COMPILE =
    IF  2+ DUP @ 2+ NFA ID. 2+
    ELSE DUP @ 2+ DUP ' LIT =
         OVER ' BRANCH  = OR
           OVER ' 0BRANCH  = OR
           OVER ' <LOOP>   = OR OVER ' </LOOP> = OR
           SWAP ' <+LOOP>  = OR  -->
\ GOESINTO -- continued                               05Nov83RSW

       IF 2+ DUP @ SPACE . 2+
         ELSE DUP @ 2+ ' CLIT =
        IF 2+ DUP C@ SPACE . 1+         \ no CLIT in 8086 FORTH
        ELSE DUP @ 2+ DUP ' <."> = SWAP ' <ABORT"> = OR
         IF 2+ DUP COUNT TYPE
            DUP C@ 1+ +
         ELSE 2+ THEN THEN THEN THEN
    -2 GIN +! ;

  -->




\ GOESINTO  -- continued                              05Nov83RSW

: <GOESINTO>          ( PFA...) \ handle special cases
      DUP CFA @ ' : CFA @ =
 \    OVER ' ERROR = 0= AND     \ no ERROR in MVPFORTH
 IF                             \ colon def. & not 'ERROR'
   BEGIN DUP @ DUP ' EXIT CFA =
     OVER ' <;CODE> CFA = OR 0=
   WHILE              \ high level & not end of colon definition
     2+ DUP GIN+ NFA ID. KEY DUP 81 =
   IF  ( 'Q' )  SP! QUIT
   ELSE 13 =  ( RETURN )


  -->

\ GOESINTO  -- continued                              02Nov83RSW

    IF  ( go down one level  )  MYSELF
    ELSE DROP THEN
  THEN GCHK
 REPEAT                         \ show last word
 2+ DIN NFA ID.
 THEN DROP ;

: GOESINTO  -FIND IF DROP 0 GIN !
   <GOESINTO> ELSE ." NOT FOUND" THEN ;





\ IDISK          clear disk utility                   10Dec83RSW
        FORTH DEFINITIONS DECIMAL
: IDISK
     CR ." initializing current selected drive - hit a CR"
     CR KEY 13 = NOT IF
       CR ABORT" aborted intialization OK"
     THEN
     0 CLEAR FLUSH      \ make sure drive variables updated
     BPDRV 0 DO
       I CLEAR                  \ blank out blocks
       I . ?TERMINAL 27 = IF    \ exit if operator hits ESC
         LEAVE
       THEN
     LOOP FLUSH CR ;    \ write the last blocks


\ PEMIT ENCHAR SMCHAR NOCHAR FF RESETLP DR1->DR0      17Dec83RSW
        FORTH DEFINITIONS DECIMAL
: PEMIT  ( char --- )  ( sends char to printer   26Oct83 RSW )
   0 0 0 23 INTCALL DROP ; : NOCHAR 18 PEMIT ;
: ENCHAR  27 PEMIT 69 PEMIT ; : SMCHAR 15 PEMIT ;
: FF  12 PEMIT ;
: RESETLP  27 PEMIT 64 PEMIT ;
: DR1->DR0    ( COPY EVERYTHING FROM DRIVE 1 TO DRIVE 0 )
   BPDRV 0 DO
     I BPDRV +   ( n --- )   \ COMPUTE SOURCE SCREEN
     I         ( n n1 --- )  \ COMPUTE DESTINATION SCREEN
     COPY CR I .             \ COPY & DISPLAY SCR #
     UPDATE I 4 MOD 0= IF
       FLUSH
     THEN ?TERMINAL 27 = IF LEAVE THEN  \ ESC causes exit
   LOOP UPDATE FLUSH CR ." Done" CR ;
\ ASCII ESC CLLINE NOLINE TOLINE                       9Nov83RSW
        FORTH DEFINITIONS DECIMAL
: ASCII  \ converts following char to ASCII code
   BL WORD 1+ C@ STATE @
   IF [COMPILE] LITERAL
   THEN ; IMMEDIATE

27 CONSTANT ESC

: CLLINE        \ sets printer to 1/8" line spacing
    ESC PEMIT ASCII 0 PEMIT ;
: NOLINE        \ sets printer to normal 1/6" line spacing
    ESC PEMIT ASCII 2 PEMIT ESC PEMIT ASCII T PEMIT ;
: TOLINE        \ sets printer to 7/72" touching line spacing
    ESC PEMIT ASCII 1 PEMIT ESC PEMIT ASCII S PEMIT 1 PEMIT ;

\ 1TODR1 1FROMDR1 DOCCHAR PON POFF                    17Dec83RSW
        FORTH DEFINITIONS DECIMAL

: 1TODR1 EMPTY-BUFFERS DR0  DUP BPDRV + COPY FLUSH ;

: 1FROMDR1 EMPTY-BUFFERS DR0  DUP BPDRV + SWAP COPY FLUSH ;

: DOCCHAR
    ESC PEMIT  ASCII B PEMIT  2 PEMIT
    ESC PEMIT  ASCII N PEMIT  3 PEMIT
    ESC PEMIT  ASCII M PEMIT  4 PEMIT ;

: PON 1 EPRINT ! ;

: POFF 0 EPRINT ! ;

\ PTRIADS   ( firstscr lastscr --- ) prints screens   11Nov83RSW
        DECIMAL
: PTRIADS
        1+ SWAP DOCCHAR 1 EPRINT !
        DO
                I TRIAD FF
                ?TERMINAL 27 = IF LEAVE THEN
        3 +LOOP
        FF 0 EPRINT !
        ;






\ PRINT-INDEX list disk INDEX on line printer         14Dec83RSW
        FORTH DEFINITIONS DECIMAL
: PRINT-INDEX
        1 EPRINT !      \ turn on printer
        EMPTY-BUFFERS
        BPDRV 1- 56 / 1+ 0 DO   \ calculate block range
          I 56 * DUP 55 +
          DUP BPDRV 1- > IF     \ last computed block > max?
            DROP BPDRV 1-       \  yes - use max block
          THEN
        \ CR SWAP . . ." INDEX" CR      \ debug stuff
          INDEX CR
          12 EMIT    \ print one page of index
        LOOP
 \      CR CR CR CR CR CR
        0 EPRINT ! ;    \ turn off printer
\ MVUP ( first last dest --- )move several screens up 01Nov83RSW

: MVUP   ( first last dest --- )
        OVER 4 PICK ( first last dest last first --- )
        - +     (  dest = dest + { last - first } )
        ROT      ( last dest first --- )
        ROT      ( dest first last --- )
        DO
          DUP I SWAP COPY CR I . ." to " DUP .
          FLUSH
        1- -1 +LOOP CR ."  done " CR
        ;




\ 2PICK 2ROLL UD. 0. 1.                               01Nov83RSW

: 2PICK  ( d --- d1  copy the d-th double number to the top)
(        of the stack)
 2*           ( leave index to high-order 16 bits)
 DUP 1+       ( leave index to low-order 16 bits)
 PICK         ( copy low-order 16 bits to top of stack)
 SWAP         ( put high-order index on top of stack)
 PICK ;       ( copy high-order 16 bits to top of stack)

: 2ROLL  ( d --- d1  roll the d-th double number to TOS )
  2* DUP 1+ ROLL SWAP ROLL ;  ( similar to 2PICK )

: UD.  <# #S #> TYPE SPACE ;
0. 2CONSTANT 0.
1. 2CONSTANT 1.
\ **  single number exponentation                     14Dec83RSW

: **   ( n1 n2 --- n3 )
  DUP 1 >
  IF           ( n2 > 1 )
   OVER SWAP   ( n1 n2 --- n1 n1 n2 )
   1 DO OVER * LOOP  ( multiply current product by n1 )
   SWAP DROP
  ELSE ?DUP 0=
   IF DROP 1      ( n2 = 0 ::= 1 )
   ELSE 0<
     IF DROP 0    ( n2 < 0 ::= 0 )
     THEN
   THEN           ( n2 = 1 ::= n1 )
  THEN ;

\ DT* D*  unsigned double->triple double->double *    06Nov83RSW

 VARIABLE LO1  0 LO1 ! VARIABLE LO2  0 LO2 !
 VARIABLE HI1  0 HI1 ! VARIABLE HI2  0 HI2 !
 VARIABLE R1  0 R1 !   VARIABLE R2  0 R2 !
 VARIABLE R3  0 R3 !   VARIABLE R4  0 R4 !

: DT*  HI2 ! LO2 ! HI1 ! LO1 ! ( d1 d2 --- t3 )
      LO1 @ LO2 @ U* SWAP R1 ! 0
      HI1 @ LO2 @ U* D+
      HI2 @ LO1 @ U* D+ SWAP R2 ! 0
      HI1 @ HI2 @ U* D+ R4 ! R3 !
      R1 @ R2 @ R3 @ R4 @ ;

: D*   DT* DROP ;

\ D** ( d1 n2 --- d3 ) raise d1 to n2 power           01Nov83RSW
        DECIMAL
: D**
  DUP 0>
  IF
    ROT ROT 1. 5 PICK  ( d1 1. n2 --- )
    0 DO
      2SWAP 2DUP 3 2ROLL  ( d1 d1 d3 --- )
      D*             ( d1 d3 --- )
 \      CR I . 2DUP UD.   ( debug stuff )
    LOOP
   2SWAP 2DROP
  ELSE
    DROP 2DROP 1.
  THEN
  ;
\ <PAGEW> clear video utility                         17Dec83RSW
        FORTH DEFINITIONS DECIMAL

( <PAGEW> -- SETS 80 COLUMN B&W MODE FOR COLOR GRAPHICS ADPTR )

: <PAGEW>  2 0 0 0 16 INTCALL DROP ;

   FIND <PAGEW> 'PAGE !         ( update init video vector )
   FREEZE






                EXIT


   FIND <PAGEW> 'PAGE !         ( update init video vector )
   FREEZE








