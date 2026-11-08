\ Partial ANS compatibility suite for LMI WinForth
\ Version 2.0  8/18/95
\ Copyright 1995 Leonard Francis Zettel, Jr.
\ zettel@acm.org

\ All rights reserved except as specified in the accompanying license.
\ Author grants user a non-exclusive license to use, copy, or
\ sell this software provided user accepts liabilty for any and
\ all damages resulting from its use.

\ WARNING: This software is under development and has not been
\ thoroughly tested.

\ These definitions pass the version of John Hayes's test suite
\ current about 8/14/95 EXCEPT AS NOTED

\ The Core word set

\ WinForth aborts when attempting to compile
\ : GI5 BEGIN DUP 2 > WHILE DUP 5 < 
\                     WHILE DUP 1+ 
\       REPEAT 123    ELSE 345 THEN ;
\
\ While the author is sympathetic to the view that anybody 
\ seriously trying to use such control sturctures deserves whatever
\ happens, it *is* valid ANS Forth.

\ VARIABLE SCANS
\ : RESCAN?  -1 SCANS +! SCANS +! @ IF 0 >IN ! THEN ;
\ { 2 SCANS ! 345 RESCAN? -> 345 345 }
\ causes a system fault.

: >NUMBER ( ud1 c-addr1 u1 -- ud2 c-addr2 u2) \ convert up to u1
  \ characters in the string at c-addr1 digit by digit, merging
  \ them into ud1 by multiplying the result so far by the value
  \ in BASE before adding the next digit.  Stop if a non-digit
  \ character is encountered. ud2 is the resulting number. c-addr2
  \ is the address of the first unconverted character.  u2 is
  \ the number of unconverted characters in the original string.
 
  OVER + >R                  \ c-addr2 if everything is converted
  1- CONVERT                 \ convert string
  R> OVER - ;                \ characters left


: ACCEPT ( c-addr +n1 -- +n2) \ Receive a string of at most n1
  \ characters.  Store them starting at c-addr with no padding.
  \ n2 is the number of characters stored.

  >R R@ 1+ +STRBUF      \ reserve n1+1 characters in string buffer
  STRBUF DUP R> EXPECT  \ Fill string buffer with EXPECT
  SWAP SPAN @ CMOVE     \ move buffer chars to c-addr
  SPAN @ ;              \ n2

 : ALIGN ( --) ; REDEFINE ALIGN EVEN
\ Bump HERE to the next even address.

: ALIGNED ( addr -- a-addr) \ Bump addr to the next even adddress.
  DUP 2 MOD + ; 

: CELL+ ( a-addr1 -- a-addr2) \ Add the size of a cell to a-addr1
  WSIZE + ;

: CELLS ( n1 -- n2) \ n2 is the number of address units (bytes) in n1 cells.
  WSIZE * ;

: CHAR ( c -- n) \ n is the ASCII code for c
  [COMPILE] ASCII ;

: CHAR+ ( c-addr1 -- c-addr2) \ c-addr2 is one character bigger
                              \ than c-addr1
  1+ ;

: CHARS ( n1 -- n2) ; \ n2 is the number of address units of n1
                      \ characters

: there? ( c-addr1 u1 c-addr2 -- c-addr1 u1 flag)
  COUNT 2OVER STRCMP 0= ;

\ The responses coded in ENVIRONMENT? are incomplete.
HEX
: ENVIRONMENT? ( c-addr u -- false) 
  " /COUNTED-STRING" there?    IF 2DROP FF          TRUE EXIT THEN
  " /HOLD" there?              IF 2DROP            FALSE EXIT THEN
  " /PAD" there?               IF 2DROP 54          TRUE EXIT THEN
  " ADDRESS-UNIT-BITS" there?  IF 2DROP 8           TRUE EXIT THEN
  " CORE" there?               IF 2DROP FALSE       TRUE EXIT THEN
  " CORE-EXT" there?           IF 2DROP FALSE       TRUE EXIT THEN
  " FLOORED" there?            IF 2DROP TRUE        TRUE EXIT THEN
  " MAX-CHAR" there?           IF 2DROP FF          TRUE EXIT THEN
  " MAX-D" there?              IF 2DROP FFFF 7FFF   TRUE EXIT THEN
  " MAX-N" there?              IF 2DROP 7FFF        TRUE EXIT THEN
  " MAX-U" there?              IF 2DROP FFFF        TRUE EXIT THEN
  " MAX-UD" there?             IF 2DROP FFFF FFFF   TRUE EXIT THEN
  " RETURN-STACK-CELLS" there? IF 2DROP R0 @ S0 @ - TRUE EXIT THEN
  " STACK-CELLS" there?        IF 2DROP            FALSE EXIT THEN
  2DROP FALSE ;       \ Default case
  
DECIMAL 

\ EVALUATE does not work in immediate words when compiling,
\ thus flunking the following Hayes tests:
\ : GE1 S" 123" ; IMMEDIATE
\ : GE2 S" 123 1+" ; IMMEDIATE
\ : GE5 EVALUATE ; IMMEDIATE
\ { : GE6 GE1 GE5 ; -> }
\ { GE6 -> 123 }
\ { : GE7 GE2 GE5 ; -> }

\ : GS1 S" SOURCE" 2DUP EVALUATE
\   >R SWAP >R = R> R> = ;
\ { GS1 -> <TRUE> <TRUE> } is flunked.

: EVALUATE ( c-addr u --) \ Make the string at c-addr the input source
  STRPCK EVAL ;

: FM/MOD ( d1 n1 -- n2 n3) M/MOD ; \ REDEFINE FM/MOD  M/MOD
  \ divide d1 by n1 giving floored quotient n3 and remainder n2

: INVERT ( x1 -- x2) NOT ; \ invert all bits of x1, giving x2.

: LSHIFT ( x1 u -- x2) SHIFT ; \ shift x1 left u bits, giving x2.

: M+ ( d1 n -- d2) \ d2 is the sum of d1 and n
  S>D D+ ;

: MOVE ( addr1 addr2 n -- )  \ move n consecutive characters starting at 
                             \ addr1 to addr2 with no overlap effects.
  >R  2DUP <  -ROT           \ addr1 < addr2?
  2DUP SWAP R@ + <           \ addr2 < addr1 + n?
  3 ROLL AND                 \ overlap?
  R> SWAP
  IF CMOVE> ELSE CMOVE THEN ;

\ Code for postpone contributed by Jonah E Thomas
\ Mistakes in transcription are the responsibility
\ of Len Zettel

: POSTPONE ( "<spaces>name" --)      \ compile name
  >IN @                     \ note where we are in the input stream.
  BL WORD                   \ parse the next word in the input stream.
  FIND ?DUP                 \ is it in the dictionary?
  IF   NIP SWAP >IN !       \ restore input stream
       1-                   \ test immediacy
       IF   COMPILE COMPILE		\ not immediate
       ELSE [COMPILE] [COMPILE]		\ immediate
       THEN
  ELSE COUNT TYPE 1 ABORT" not found"
  THEN ; IMMEDIATE

: RSHIFT ( x1 u1 -- x2) NEGATE SHIFT ;  \ Shift x1 right u1 places
                                        \ giving x2.

: S" ( "ccc<quote>" --) ( -- c-addr u) \ At compile time parse
  \ ccc delimited by " and compile it.  At run time put the
  \ address and length of the compiled string on the stack.
  [COMPILE] " STATE @ 
  IF   COMPILE COUNT 
  ELSE COUNT 
  THEN ;  IMMEDIATE

\ Note that SM/REM does not work for a divisor of -32768.
\ That means, if you want to get picky, that this implementation
\ only works for the signed nummber range of (+32767,-32767), 
\ which is all that is required by the standard (3.1.3.2)
\ As far as I know, all other arithmetic operations work for
\ (-32768, +32767).
 : SM/REM ( d1 n1 -- n2 n3) \ symmetric division of d1 by n1 giving
                            \ quotient n3 and remainder n2
   DUP -32768 =
   ABORT" Divisor of -32768 out of range for SM/REM"
   >R                       \ park divisor
   2DUP D0<                 \ negative dividend?
   R@ 0<                    \ negative divisor?
   XOR -ROT                 \ negative quotient?
   2DUP DABS  R@ ABS  D/    \ divide absolute values
   4 ROLL IF DNEGATE THEN   \ Give sign to quotient
   2SWAP 2OVER R> D* D-     \ Calculate remainder
   DROP  -ROT DROP ;        \ Single precision answers

: UNLOOP ( --) ( R: loop-sys --) \ Discard the looping
  \ parameters for the current nesting level (in preparation
  \ for an EXIT)
   R>  R> R> R> 3DROP  >R ;

: [CHAR] \ Compilation: ( "name" --)  Execution: ( -- char)
  [COMPILE] ASCII ; IMMEDIATE


\ The Core word set extensions

: C" ( "ccc<quote>" --) ; IMMEDIATE REDEFINE C" "

: TO ( x"<spaces>name" -- ) ; REDEFINE TO EQU

: VALUE ( x"<spaces>name" --) ; REDEFINE VALUE EQU

: WITHIN ( test low high -- flag)  OVER - >R - R> U< ;
\ code above taken from ANSI X3:215-1994 p 156

\ The Programming Tools word set

: ? ( addr --) \ display the value at addr
  @ . ;

\ The Programming Tools word set extensions

\ Code for [ELSE] [IF] and [THEN] adapted from code by
\ Ray Duncan and Klaus Flesch

: [ELSE] ( ---)  \ compile words following if the matching [IF]
		 \ tested FALSE
  BEGIN BL WORD COUNT 
	2DUP  " [THEN]" COUNT STRCMP 0= -ROT
        " [IF]"   COUNT STRCMP 0=
        IF RECURSE THEN
  UNTIL ;  IMMEDIATE

 : [IF] ( flag ---)  \ if flag is TRUE, compile the words following [IF]
                     \ Otherwise, continue compilation following
                     \ the matching [ELSE] or [THEN]
   1 ?DEPTH          \ Is there a flag on the stack?
   0=
   IF   
        BEGIN BL WORD COUNT
           2DUP  " [ELSE]" COUNT STRCMP    \ Have we parsed an [ELSE] ?
           0= >R 2DUP
           " [THEN]" COUNT STRCMP          \ [THEN] parsed?
           0= R> OR -ROT
           " [IF]"   COUNT STRCMP    \ [IF] parsed?
           0=
           IF [COMPILE] [ELSE] THEN
        UNTIL
   THEN ;  IMMEDIATE

: [THEN] ( ---) ;  IMMEDIATE
