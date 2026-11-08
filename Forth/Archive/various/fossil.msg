
   I've written some code in ZEN Forth (1.18) to access the modem via
 a FOSSIL driver.  Since ZEN does not include an assembler, the first
 step is to add a few FOSSIL primitives to USER.ASM and regenerate the
 kernel with TASM and TLINK (ug!).  Here are my additions to USER.ASM:
 
 ; ---- generic FOSSIL interrupt calls ----
 
 ; this one returns AX
 NEWNAME FossilAX        ;       (S inAX -- retAX )
         mov     ax, bx
         mov     dx, 00FFh       ;default to always return success
 portA   equ     $-2             ;  until portA is set
         int     14h
         mov     bx, ax
         NEXT
 
 ; this one returns nothing
 NEWNAME Fossil0        ;       (S inAX -- )
         mov     ax, bx
         mov     dx, 00FFh       ;default to always return success
 port0   equ     $-2             ;  until port0 is set
         int     14h
         pop     bx
         NEXT
 
 ; set the fossil port.  Use 0 for com1, 1 for com2, etc.
 ; note that this modifies the code words above (no protected mode here!)
 NEWNAME SetPort ;       (S port -- )
         mov     CS:word ptr portA, bx
         mov     CS:word ptr port0, bx
         pop     bx
         NEXT
 
 ; get the fossil port.  Returns 0 for com1, 1 for com2, 255 for none
 NEWNAME GetPort ;       (S -- port )
         push    bx
         mov     bx, CS:word ptr portA
         NEXT
 
 ; ----- end of user.asm -----
 
 \   The same words can be written using Martin's INT86 word, but that is
 \ much less efficient.  Here is that implementation, for reference:
 
 HEX  VARIABLE port    \ 0 for COM1, 1 for COM2, etc.
 
 : GetPort  ( -- n )   port @ ;
 : SetPort  ( n -- )   port ! ;
 : Fossil0  ( ax -- )       regAX !  port @  regDX !  14 INT86 ;
 : FossilAX ( ax -- ax' )   regAX !  port @  regDX !  14 INT86   regAX @ ;
 
 
 \ -----------------
 \   Regular Forth words can then be used to do the standard FOSSIL
 \ functions.  At first I implemented all of the functions, but after a
 \ while I pared it down to just the ones I actually needed:
 
 HEX \ FOSSIL driver functions
 
 : mrec     ( -- c )        0200 FossilAX ;
 : mstat    ( -- status )   0300 FossilAX ;
 : minit    ( -- 1954|? )   0400 FossilAX ;
 : flush    ( -- )          0800 Fossil0 ;
 : opurge   ( -- )          0900 Fossil0 ;
 : ipurge   ( -- )          0A00 Fossil0 ;
 : mxmit    ( c -- flag )   0B00 OR 0BFF AND FossilAX ;
 : mpeek    ( -- c|ffff )   0C00 FossilAX ;
 
 \ -----------------
 \   With these primitives in place, we can put together the I/O
 \ routines necessary for a typical telecom application:
 
 VALUE hadCarrier
 
 : gotFossil?  ( -- flag )
   minit 1954 = DUP
   IF mstat 0080 AND  ELSE 0  THEN  TO hadCarrier
 ;
 
 \ returns 0080 if carrier is present
 : GotCarrier?  ( -- 0|80 )  mstat 0080 AND ;
 
 \ Exit program if carrier is dropped
 : ?CrashOut  ( -- )
   GotCarrier? 0=
   IF   hadCarrier IF BYE THEN
   THEN ;
 
 \ returns TRUE if there is a char available at the modem port
 : ModKey?  ( -- flag )  mpeek FFFF <> ;
 
 \ returns TRUE if a key was pressed anywhere
 : SomeKey?  ( -- flag )  KEY? ModKey? OR ;
 
 \ gets the next key from somewhere
 : SomeKey  ( -- n )
   BEGIN KEY? 
        IF   KEY TRUE 
        ELSE ModKey? DUP
             IF   mrec SWAP ipurge
             ELSE ?CrashOut
             THEN
        THEN
   UNTIL ;
 
 \ send a char to the modem
 : ModEmit  ( char -- )
   mstat 4000 AND 0=        \ output buffer not empty?
   IF   ?CrashOut flush
   THEN  mxmit DROP ;
 
 \ send a char to both places
 : BothEmit ( char -- )  DUP EMIT ModEmit ;
 
 \ type chars to the modem
 : ModType  ( adr len -- )  0 ?DO COUNT ModEmit LOOP DROP ;
 
 \ type chars to both places
 : BothType ( adr len -- )  0 ?DO COUNT DUP EMIT ModEmit LOOP DROP ;
 
 \ ----- these are the top level words used by the application -----
 \ This method is preferrable to revectoring KEY and EMIT, because
 \ there are often cases where we want i/o to go to the console only.
 \ So we leave KEY and EMIT untouched, and use the 'm' words when we
 \ want telecom level i/o.
 
 : mKey?  ( -- flag )  KEY?  ;   \ patch for modem or dual i/o
 : mKey   ( -- c )     KEY   ;   \  ditto
 : mEmit  ( c -- )     EMIT  ;   \  ditto
 
 \ Initialize in/out to console or dual mode
 : InitIO  ( -- )
   BEGIN KEY? WHILE KEY DROP REPEAT   \ clear type-ahead buffer
   gotFossil? 
   IF   GotCarrier?
        IF   ." Got Carrier!" CR ipurge
             ['] SomeKey   ['] mKey  PATCH
             ['] SomeKey?  ['] mKey? PATCH
             ['] BothEmit  ['] mEmit PATCH
        ELSE ." No Carrier..." CR
        THEN
   THEN ;
  
 \ all other in/out 'm' words defined in terms of mEmit and mKey
 
 DECIMAL
 \ m version of CR
 : mCr  ( -- )  13 mEmit 10 mEmit 09 mEmit ;
 
 \ m version of TYPE
 : mType  ( a u -- )  0 ?DO COUNT mEmit LOOP DROP ;
 
 \ m version of dot-quote
 : m"  ( -- )   POSTPONE " POSTPONE mType ;  IMMEDIATE
 
 \ primitive for m.
 : (m.)  ( n -- )
   DUP 9 > IF 10 /MOD RECURSE THEN  [CHAR] 0 + mEmit ;
 
 \ The m version of dot only handles positive numbers in base
 \ 10 (decimal), but that's all this application requires.
 : m.  ( n -- )  (m.) BL mEmit ;
 
 --- 
   b0b@interface.via.mind.ORG
   Forth is beautiful.  Forth is Pure.


