
( Henry Laxen's Screen EDITOR - ACKNOWLEDGEMENTS      03Jan84RSW
)  10 LIST  11 LOAD  EXIT

    This screen editor is based on an article in
Dr. Dobb's Journal, Number 59, September 1981, page 27
by Henry Laxen.  It has been adapted for the IBM-PC
(or equivalent) running MVP-FORTH version 1.0305.03 by
R.S. White, Marion, IA.
     It is R.S. White's understanding that this editor is in
the public domain for non-commercial use only!  Any commercial
use or sales of this editor should be arranged by
contacting:
      Henry Laxen
      1259 Cornell Ave.
      Berkeley, CA. 94706
      (415) 525-8582
( LOAD SCREEN FOR SYSTEM GENERATION                  29Oct83 RSW
)


    24 LOAD     ( LOAD GENERAL PURPOSE STUFF )
    38 LOAD     ( LOAD THE EDITOR )










FORTH Development System Documentation                01Nov83RSW


   The FORTH editor is easy to learn and to use. It consists of
control key ( or special function key ) commands that allow
cursor movement and text entry and deletion so that editing can
be done quickly and smoothly.

CURSOR MOVEMENT

   You can place the cursor anywhere on the screen by using a
few editing commands.

   The following table describes the commands that are relevant
to cursor movement.

CURSOR MOVEMENT COMMANDS                              01Nov83RSW















































































































































































( \    COMMENT TO END OF LINE                       29Oct83 RSW
)

  CR CR ." Most of the general purpose stuff is already "
  CR    ." availible from MVP-FORTH binary image. " CR








  -->


\  (S  (P  DOCUMEMTATION WORDS                       206Nov83RSW

: (S           ( --- )
   41 WORD DROP ;
   IMMEDIATE

: (P           ( --- )
   41 WORD DROP ;
   IMMEDIATE


 -->




\ SC@  fetch scan code byte of last key hit, IBM-PC   31Oct83RSW
      HEX
: SC@   ( --- scan-code ) \ fetch scan code of last key hit
        40 DUP 1C @L    ( next-buf-addr --- )
        20 MOD 1F +     ( prev-scan-code-buff-addr --- )
        C@L ;           ( last-scan-code-byte --- )







                        DECIMAL -->


\ L     INTELLIGENT SCREEN LISTER                    229Oct83RSW


: L     ( (S [N] --- )
   DEPTH IF
    DUP SCR !
   ELSE
    SCR @
   THEN
   LIST ;


  -->



\       BEEP









: BEEP
    7 EMIT ;


  -->

\  BOUNDS      DO LOOP SETUP                    28Oct83 RSW

: BOUNDS    (  (S ADDR LEN --- ADDR+LEN ADDR )
     OVER + SWAP ;

 -->










\
   -->














\
   -->














\
   -->














\
  -->














\
  -->














\  >=   <>  U> CONDITIONALS                     28Oct83 RSW

: >=  ( (S N1 N2 --- BOOL )
 < 0= ;

: <>
  = 0= ;

: <=
   > 0= ;

: U>
   SWAP U< ;

   -->

\ RE-FORTH   RE-ENTER FORTH FOR 1 LINE           28Oct83 RSW

: RE-FORTH    ( (S --- ??? )
   >IN @ >R
   BLK @ >R
   0 >IN ! 0 BLK !
   QUERY INTERPRET
   R> BLK !
   R> >IN ! ;






     -->
\















\ CASE:

: CASE:    ( (S N --- )
   CREATE  ] SMUDGE
   DOES>
    SWAP 2* + @
    EXECUTE ;






     -->


\  -TIDY                                       28Oct83 RSW

: -TIDY  ( (S ADDR LEN --- )
   BOUNDS DO
    I C@ BL < IF
     BL I C!
    THEN
   LOOP ;

    BASE @ DECIMAL
1024 CONSTANT B/BUF    \ MVPFORTH BYTES-PER-BUFFER
1 CONSTANT B/SCR       \ MVPFORTH BLOCKS-PER-SCREEN
     BASE !    \ RESTORE PRESENT BASE

   -->

\ VARIABLE AND CONSTANT DEFINITIONS               28OCT83 RSW
 VOCABULARY EDIT IMMEDIATE EDIT DEFINITIONS
VARIABLE &MODE  0 &MODE !
VARIABLE &CURSOR  0 &CURSOR !
VARIABLE &OLD-MODE  0 &OLD-MODE !
VARIABLE &UPDATE  0 &UPDATE !
VARIABLE &BUF-ADR  0 &BUF-ADR !
VARIABLE &E-ID
 12 ALLOT
 &E-ID 14 BLANK

5 CONSTANT %X-OFF
2 CONSTANT %Y-OFF
 B/SCR B/BUF * CONSTANT C/SCR    \ CHARS PER SCREEN
 C/SCR C/L /   CONSTANT L/SCR    \ LINES PER SCREEN
  -->
\ CURSOR POSITIONING VECTORS                        29Oct83 RSW

VARIABLE 'CRTXY
VARIABLE 'CRTCLR-SCR
VARIABLE 'CLEAR-TO-EOL

: CRTXY   ( (S X Y --- )
   'CRTXY @ EXECUTE ;

: CRTCLR-SCR
   'CRTCLR-SCR @ EXECUTE ;

: CLEAR-TO-EOL   ( (S col --- )
   'CLEAR-TO-EOL @ EXECUTE ;
   -->

\ DESCRIPTION OF CURSOR COMMANDS
  -->














\ DESC CONTINUED
    -->














\ DESC CONTINUED
   -->














\ CURPOS +CURPOS   MOVE-CURSOR                      29Oct83 RSW
: CURPOS
   &CURSOR @ ;

: +CURPOS
   &CURSOR +!
   CURPOS 0 MAX
   [ C/SCR 1- ] LITERAL
   MIN &CURSOR ! ;

: MOVE-CURSOR
   +CURPOS
   CURPOS C/L /MOD
   %Y-OFF + SWAP
   %X-OFF + SWAP
   CRTXY ;    -->
\ BUF-ADR

: BUF-ADR
   &BUF-ADR @ + ;

: BUFPOS
  CURPOS BUF-ADR ;

  -->







\ E-UPDATE
: E-UPDATE
   1 &UPDATE ! ;

  -->











\ BUF-MOVE

: BUF-MOVE
   ROT BUF-ADR
   ROT BUF-ADR
   ROT BMOVE        \ MVPFORTH SPEC
   E-UPDATE ;

     -->







\ ?PRINTABLE
: ?PRINTABLE
   DUP 32 <
   SWAP 126 >
   OR 0= ;

     -->









\ >LINE# LINE#
: >LINE#
   C/L / ;

: LINE#>
   C/L * ;

     -->








\ CHAR-TO-EOL
: CHARS-TO-EOL
   C/L MOD
   C/L SWAP - ;

     -->










\ DISPLAY-TO-EOL                                      29Oct83RSW

: DISPLAY-TO-EOL   ( (S POS --- )
   DUP BUF-ADR          \ GET ADDRESS IN BUFFER
   OVER CHARS-TO-EOL    \ REST OF LINE
   -TRAILING            \ IGNORE BLANKS
   ROT OVER + >R        \ SAVE RESULTANT CURSOR POSITION
  TYPE                  \ DISPLAY WHATS THERE
  R> CLEAR-TO-EOL       \ AND REMOVE THE REST
  ;

( (P DISPLAY-TO-EOL DISPLAYS THE REST OF THE LINE STARTING FROM
THE CURRENT CURSOR POSITION.  IT ASSUMES THAT THE TERMINAL
CURSOR IS PROPERLY POSITIONED BEFORE IT EXECUTES. )

      -->
\ ?EMPTY-LINE
: ?EMPTY-LINE
   LINE#> BUF-ADR C/L
   -TRAILING
  SWAP DROP 0=
  ;

       -->








\ DISPLAY-TO-EOS
: DISPLAY-TO-EOS
   CURPOS SWAP
   L/SCR SWAP DO
    I LINE#>
    DUP &CURSOR !
    0 MOVE-CURSOR
    DISPLAY-TO-EOL
   LOOP
   &CURSOR !
   0 MOVE-CURSOR ;

       -->



\ EXPAND

: EXPAND
   DUP DUP
   C/L +
   C/SCR OVER -
   BUF-MOVE
   BUF-ADR C/L BLANK
   E-UPDATE ;

       -->





\ SHRINK

: SHRINK
   DUP
   C/L + SWAP
   OVER C/SCR SWAP -
   BUF-MOVE
   [ L/SCR 1- ] LITERAL
   LINE#> BUF-ADR C/L BLANK
   E-UPDATE ;

      -->




\ INSERT-LINE

: INSERT-LINE
   [ L/SCR 1- ] LITERAL
   ?EMPTY-LINE IF
    DUP EXPAND
    >LINE# DISPLAY-TO-EOS
   ELSE
    BEEP
   THEN ;

     -->




\ DELETE-LINE

: DELETE-LINE
   >LINE# DUP LINE#> SHRINK
   DISPLAY-TO-EOS ;

  -->









\ INS-CHAR

: INS-CHAR
   DUP DUP 1+
   OVER CHARS-TO-EOL 1-
   BUF-MOVE
   BUF-ADR C! ;

       -->







\ DEL-CHAR

: DEL-CHAR
   DUP DUP 1+ SWAP
   OVER CHARS-TO-EOL
   BUF-MOVE
   DUP CHARS-TO-EOL + 1-
   BUF-ADR BL SWAP C! ;

     -->






\ ARROW COMMANDS

: R-ARROW
   1 +CURPOS ;

: L-ARROW
   -1 +CURPOS ;

: U-ARROW
   C/L NEGATE +CURPOS ;

: D-ARROW
   C/L +CURPOS ;

     -->

\ I-LINE D-LINE D-CHAR INSERT-MODE                    29Oct83RSW

: I-LINE
   CURPOS INSERT-LINE ;

: D-LINE
   CURPOS DELETE-LINE ;

: D-CHAR
   CURPOS DEL-CHAR
   CURPOS DISPLAY-TO-EOL ;

: INSERT-MODE
   &MODE 1 TOGGLE ;

      -->
\ RETURN EXIT-EDIT                                    24Dec83RSW

: RETURN
   CURPOS >LINE#
   1+
   [ L/SCR 1- ] LITERAL MIN
   LINE#> &CURSOR ! ;

: EXIT-EDIT
   CR ABORT" OK " ;                               \ MVP version
    ( R> DROP R> DROP R> DROP R> DROP R> DROP ; ) \ fig version

      -->



\ ADD-ID MOV-BOT                                      24Dec83RSW

: ADD-ID
     &E-ID
     [ C/L 10 - ] LITERAL
     BUF-ADR 10 CMOVE ;

: MOV-BOT   ( --- scr-addr )
     C/SCR MOVE-CURSOR
     CR CR
     SCR ;




                                -->
\ NEW-SCR                                             24Dec83RSW

: NEW-SCR
   SCR @ BLOCK &BUF-ADR !
   CRTCLR-SCR
   0 &MODE ! 0 &CURSOR !
   0 &UPDATE !
   0 %Y-OFF CRTXY
   L/SCR 0 DO
     I 3 .R CR
   LOOP
   10 0 CRTXY
   ." Scr: " SCR @ 4 .R 6 SPACES ." X=     Y="
   0 DISPLAY-TO-EOS ;
 -->

\ PAGE-UP -- edit next lower # screen                 03Jan84RSW

: PAGE-UP
    &UPDATE @ IF        \ screen modified?
      ADD-ID UPDATE     \  yes - finish up screen
    THEN
    SCR @ 1-
    DUP DUP 0 < SWAP BPDRV >= OR IF              \ out of range?
      CR BEEP ." screen " . ." is out of range"  \  yes - error
      CR ." hit any key to continue " CR BEEP KEY
    ELSE
      SCR !                      \ no - point to previous screen
    THEN
    NEW-SCR ;   -->


\ PAGE-DOWN -- edit next higher # screen              03Jan84RSW

: PAGE-DOWN
    &UPDATE @ IF        \ screen modified?
      ADD-ID UPDATE     \  yes - finish up screen
    THEN
    SCR @ 1+
    DUP BPDRV >= IF                             \ out of range?
      CR BEEP ." screen " . ." is out of range" \  yes - error
      CR ." hit any key to continue" BEEP KEY
    ELSE
      SCR !                         \  no - point to next screen
    THEN
    NEW-SCR ;   -->


\                                                     24Dec83RSW

        -->













\                                                     24Dec83RSW

        -->













\ EXIT-UPDATE                                         24Dec83RSW

: EXIT-UPDATE
   MOV-BOT
   @ .
   &UPDATE @ IF
     ADD-ID
     ." Modified" UPDATE FLUSH
   ELSE ." Unmodified" THEN
   EXIT-EDIT ;

     -->




\ EXIT-SCRATCH                                        24Dec83RSW

: EXIT-SCRATCH
   MOV-BOT
   ?
   ." Abandoned"
   EXIT-EDIT ;

       -->







\ E-TAB

: E-TAB
   8 CURPOS 8 MOD -
   +CURPOS ;

      -->









\ SCAN+=
: SCAN+=
   2DUP = IF
     DROP 2DROP 0
   ELSE
     0 ROT ROT DO
       OVER I C@ = IF
         LEAVE
       ELSE 1+ THEN
     LOOP
     SWAP DROP
   THEN ;

        -->


\ SCAN+<>
: SCAN+<>
   2DUP = IF
     DROP 2DROP 0
   ELSE
     0 ROT ROT DO
       OVER I C@ <> IF
         LEAVE
       ELSE 1+ THEN
     LOOP
     SWAP DROP
   THEN ;

      -->


\ SCAN-=
: SCAN-=
   2DUP = IF
     DROP 2DROP 0
   ELSE
     0 ROT ROT DO
       OVER I C@ = IF
         LEAVE
       ELSE 1- THEN
     -1 +LOOP
     SWAP DROP
   THEN ;

      -->


\ SCAN-<>
: SCAN-<>
   2DUP = IF
     DROP 2DROP 0
   ELSE
     0 ROT ROT DO
       OVER I C@ <> IF
         LEAVE
       ELSE 1- THEN
     -1 +LOOP
     SWAP DROP
   THEN ;

      -->


\ MOVE-LEFT-WORD
: MOVE-LEFT-WORD
    BL 0 BUF-ADR BUFPOS
    SCAN-= >R
    BL 0 BUF-ADR BUFPOS R@ +
    SCAN-<> R> + >R
    BL 0 BUF-ADR BUFPOS R@ +
    SCAN-= R> +
    DUP BUFPOS + C@ BL = IF
     1+
    THEN ;

         -->



\ MOVE-RIGHT-WORD

: MOVE-RIGHT-WORD
   BL [ C/SCR 1- ] LITERAL BUF-ADR
   BUFPOS SCAN+= >R
   BL [ C/SCR 1- ] LITERAL BUF-ADR
   BUFPOS R@ +
   SCAN+<> R> + ;

       -->






\ R-WORD L-WORD

: R-WORD
   MOVE-RIGHT-WORD
   +CURPOS ;

: L-WORD
   MOVE-LEFT-WORD
   +CURPOS ;

        -->





\ DEL-CHARS                                           29Oct83RSW

: DEL-CHARS     ( (S N POS --- )
   2DUP + OVER
   DUP CHARS-TO-EOL
   BUF-MOVE
   DUP CHARS-TO-EOL +
   OVER - BUF-ADR
   SWAP BLANK ;

       -->





\ D-WORD

: D-WORD
   MOVE-RIGHT-WORD
   CURPOS BUF-ADR
   CURPOS CHARS-TO-EOL
   -TRAILING SWAP DROP
   MIN CURPOS DEL-CHARS
   CURPOS DISPLAY-TO-EOL ;

         -->





\ U-TAB D-TAB CRL-SCREEN
: U-TAB
   4 C/L *
   NEGATE +CURPOS ;

: D-TAB
   4 C/L *
   +CURPOS ;

: CLR-SCREEN
   0 &CURSOR !
   CURPOS BUF-ADR
   C/SCR BLANK
   0 DISPLAY-TO-EOS
   E-UPDATE ;
             -->
\ DISPLAY-STATUS

: DISPLAY-STATUS
   &MODE @ &OLD-MODE @ <> IF
     40 0 CRTXY
     &MODE @ IF
       ." Insert ON"
     ELSE
       9 SPACES
     THEN
     &MODE @ &OLD-MODE !
   THEN
   CURPOS C/L /MOD
   35 0 CRTXY 2 .R
   28 0 CRTXY 2 .R ;
         -->
\ CLR-LINE

: CLR-LINE
   CURPOS DUP
   >LINE# LINE#> &CURSOR !
   CURPOS BUF-ADR
   C/L BLANK
   E-UPDATE
   0 MOVE-CURSOR
   CURPOS CLEAR-TO-EOL
   &CURSOR ! ;

       -->



\ GET-USER-ID

: GET-USER-ID
   &E-ID 10 -TRAILING 0= IF
     CR ." Enter Your ID: "
     10 0 DO 46 ( . ) EMIT LOOP
     10 0 DO 8 ( BS ) EMIT LOOP
     10 EXPECT
     &E-ID 10 -TIDY
   ELSE
    DROP
   THEN ;

         -->


\ CONTROL CHARACTER DEFINITIONS

CASE: (CONTROL-CHAR)

   BEEP        \ 0: c@ --- ERROR
   L-WORD
   CLR-LINE
   D-TAB
   R-ARROW
   U-ARROW
   R-WORD
   D-CHAR
   L-ARROW
   E-TAB
 -->

\ CONTROL CHAR DEF CONTINUED

     BEEP
     CLR-SCREEN
     BEEP
     RETURN
     I-LINE
     BEEP
     BEEP
     BEEP
     U-TAB
     L-ARROW
 -->



\ CONTROL CHAR DEF CONTINUED

   D-WORD
   BEEP
   INSERT-MODE
   BEEP
   D-ARROW
   D-LINE
   EXIT-SCRATCH
   EXIT-UPDATE      \ 27: ESC --- EXIT EDITOR NORMALLY
   ;

     -->



\                                                     24Dec83RSW

        -->













\ special IBM PC key definitions                      06Nov83RSW

CASE: <IBM-KEY>

   I-LINE       \ 0;59 F1 --- INSERT LINE
   EXIT-UPDATE  \ 1;60 F2 --- EXIT EDITOR NORMALLY
   EXIT-SCRATCH \ 2;61 F3 --- ABANDON SCREEN
   CLR-SCREEN   \ 3;62 F4 --- CLEAR SCREEN
   BEEP         \ 4;63 F5 --- ERROR
   CLR-LINE     \ 5;64 F6 --- BLANK OUT CURRENT LINE
   D-WORD       \ 6;65 F7 --- DELETE CURRENT WORD
   D-LINE       \ 7;66 F8 --- DELETE CURRENT LINE
   L-WORD       \ 8;67 F9 --- MOVE TO NEXT WORD ON LEFT
   R-WORD       \ 9;68 F10 -- MOVE TO NEXT WORD ON RIGHT
   BEEP         \ 10;69   --- ERROR
 -->
\ special IBM PC keys continued                       24Dec83RSW
   BEEP         \ 11;70      --- ERROR
   U-TAB        \ 12;71 Home --- MOVE UP 4 LINES
   U-ARROW      \ 13;72  ^   --- MOVE UP ONE LINE up-arrow
   PAGE-UP      \ 14;73 PgUp --- EDIT NEXT LOWER # SCREEN
   BEEP         \ 15;74      --- ERROR
   L-ARROW      \ 16;75 <--  --- MOVE LEFT ONE CHAR
   BEEP         \ 17;76      --- ERROR
   R-ARROW      \ 18;77 -->  --- MOVE RIGHT ONE CHAR
   BEEP         \ 19;78      --- ERROR
   D-TAB        \ 20;79 End  --- MOVE DOWN 4 LINES
   D-ARROW      \ 21;80  v   --- MOVE DOWN ONE LINE down-arrow
   PAGE-DOWN    \ 22;81 PgDn --- EDIT NEXT HIGHER # SCREEN
   INSERT-MODE  \ 23;82 Ins  --- TOGGLE INSERT MODE
   D-CHAR       \ 24;83 Del  --- DELETE CURRENT CHAR
   ;    -->
\ IBM-KEY  process special IBM PC edit keys           31Oct83RSW

: IBM-KEY  ( CHAR --- )
   DROP SC@             \ forget key code & fetch scan code
   DUP 58 > IF          \ in valid range?
     DUP 84 < IF        \   maybe - in valid range?
       59 - <IBM-KEY>   \            yes - process key
     ELSE
       DROP BEEP        \            no - complain
     THEN
   ELSE
     DROP BEEP          \   no - complain
   THEN ;       -->



\ CONTROL-CHAR                                        31Oct83RSW

: CONTROL-CHAR
   DUP 0= IF            \ special IBM key?
     IBM-KEY            \  yes - do it
   ELSE
     DUP 28 < IF        \  no - control key?
       (CONTROL-CHAR)   \         yes - do it
     ELSE
       DROP BEEP        \         no - complain
     THEN
   THEN ;       -->




\ E-OVERSTRIKE

: E-OVERSTRIKE
   KEY DUP
   ?PRINTABLE IF
     DUP EMIT
     BUFPOS C!
     E-UPDATE
     1 +CURPOS
   ELSE
    CONTROL-CHAR
   THEN ;

       -->


\ E-INSERT

: E-INSERT
   KEY DUP
   ?PRINTABLE IF
     CURPOS INS-CHAR
     CURPOS DISPLAY-TO-EOL
     1 +CURPOS
   ELSE
     CONTROL-CHAR
   THEN ;

         -->



\ E-INIT                                              24Dec83RSW

: E-INIT
   DEPTH IF SCR ! THEN
   GET-USER-ID
   NEW-SCR ;








 -->

\ E
       FORTH DEFINITIONS
: E
   EDIT
   E-INIT
   BEGIN
     DISPLAY-STATUS
     0 MOVE-CURSOR
     &MODE @ IF
       E-INSERT
     ELSE
       E-OVERSTRIKE
     THEN
   AGAIN ;

        -->
\ CLRID clear screen editor date/user ID              13Dec83RSW
        FORTH DEFINITIONS DECIMAL

: CLRID         \ clears screen editor date/name ID
        EDIT
        &E-ID 12 BLANK
        FORTH
        ;
                 -->







\  CONFIGURE USER'S TERMINAL                          13Dec83RSW

        DECIMAL EDIT DEFINITIONS

 100 LOAD               \ only configure IBM-PC video for now

 FORTH DEFINITIONS DECIMAL
 CR ." Ready to Edit" CR CR








\ CURSOR COMMANDS FOR MVPFORTH/IBM-PC VERSION         29Oct83RSW
  HEX
CODE PC-CRTXY  ( (S  X Y --- )  \ POSITION IBM PC CURSOR
        AX              POP     \ FETCH Y INTO AL
        DX              POP     \ FETCH X INTO DL
        DH, AL          MOV     \ PUT Y INTO DH
        AH, # 2         MOV     \ AH=2 FOR CURSOR POS CMD
        BH, # 0         MOV     \ BH=0 FOR PAGE 0
        SI              PUSH    \ SAVE NECESSARY REGS
        BP              PUSH
        10              INT     \ DO IBM VIDEO ROM ROUTINE
        BP              POP     \ RECOVER REGS
        SI              POP
        NEXT            JMP  END-CODE  DECIMAL -->


\ CURSOR COMMANDS CONT.                               29Oct83RSW
  HEX
CODE <CLRSCR>  ( (S --- )       \ CLEAR ENTIRE IBM PC SCREEN
        AX, # 600       MOV     \ AH=6, AL=0 FOR BLANK SCROLL UP
        BH, # 7         MOV     \ BH=7 FOR NORMAL VIDEO
        DX, # 184F      MOV     \ DH=24D, DL=79D FOR BOT CORNER
        CX, # 0         MOV     \ CH=0, CL=0 FOR TOP CORNER
        SI              PUSH    \ SAVE NECCESARY REGS
        BP              PUSH
        10              INT     \ DO IBM VIDEO ROM ROUTINE
        BP              POP     \ RECOVER REGS
        SI              POP
        NEXT            JMP   END-CODE  DECIMAL -->



( CURSOR COMMANDS CONT. ) HEX   \                     29Oct83RSW
CODE PC-CRTCLR-EOL  ( (S POS --- ) \ IBM PC CLEAR TO END OF LINE
        AX              POP     \ THROW AWAY COMPUTED POSITION
        AH, # 3         MOV     \ READ CURSOR ADDRESS CMD
        BH, # 0         MOV     \ PAGE 0 OF VIDEO
        SI PUSH  BP PUSH        \ SAVE NECESSARY REGS
        10              INT     \ DO IBM ROM BIOS ROUTINE
        DH, # 0         MOV     \ IGNORE ROW INFO
        CX, # 46        MOV     \ MAX = C/L + %XOFF
        CX, DX          SUB     \ CX = # OF CHARS LEFT ON LINE
      ( IF ELSE                 \ EXACTLY = ?           )
        AX, # 0A20      MOV     \ AH=10D, AL=' ' FOR VIDEO WRT
        BH, # 0         MOV     \ PAGE 0 OF VIDEO
        10              INT     \ DO IBM ROM BIOS ROUTINE
      ( ENDIF                   \  SKIPPED CODE IF EQUAL )
        BP POP  SI POP  NEXT JMP  END-CODE   DECIMAL -->
\ cursor & video for IBM-PC continued
      HEX
: PC-CLRSCR    <CLRSCR> 0 0 PC-CRTXY ;

' PC-CRTXY         CFA 'CRTXY !
' PC-CLRSCR        CFA 'CRTCLR-SCR !
' PC-CRTCLR-EOL    CFA 'CLEAR-TO-EOL !

 DECIMAL 103 . ." done loading SCREEN EDITOR " CR BEEP

\ ******** end of Henry Laxen's EDITOR *************





\ _________________    F1-F10 special function keys   24Dec83RSW
  |insert |normal |
  | line 1|exit  2|   Home -- move up 4 lines
  -----------------
  |abandon| clear |    End -- move down 4 lines
  | scrn 3| scrn 4|
  -----------------    Ins -- toggle insert mode
  |       | blank |
  |      5| line 6|    Del -- delete character
  -----------------
  |delete |delete |   PgUp -- edit next lower # screen
  | word 7| line 8|
  -----------------   PgDn -- edit next higher # screen
  | left  |right  |
  | word 9|word 10|
  -----------------



