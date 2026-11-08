
                            LEXICON

F83 ver 2.1.0

This is a composit listing of colon definitions in META80.BLK, KERNEL80.BLK,
EXTEND80.BLK and UTILITY.BLK as found in the library file F83V2-80.LBR.
Compiled by A. J. "Mac" McLean
April 2, 1986

:  IS    'T >BODY @ >BODY !-T    ;                       18 b:meta80.blk
: !-T     (S n taddr -- )      THERE !  ;                 4 b:meta80.blk
: !CSP   (S -- )   SP@ CSP !   ;                         77 b:kernel80.blk
: !FCB   (S FCB-addr )                                    8 b:extend80.blk
: !FILES   (S fcb -- )   DUP FILE !  IN-FILE !  ;        51 b:kernel80.blk
: "    (S -- )   COMPILE (")    ,"   ;   IMMEDIATE       71 b:kernel80.blk
: "CREATE   (S str -- )   COUNT HERE EVEN 4 + PLACE      76 b:kernel80.blk
: #      (S -- )                                         60 b:kernel80.blk
: #>     (S d# -- addr len )    2DROP  HLD  @  PAD  OVE  60 b:kernel80.blk
: #AFTER       (S -- n )    C/L COL# -  ;                14 b:utility.blk
: #END         (S -- n )    #REMAINING COL# +  ;         14 b:utility.blk
: #REMAINING   (S -- n )    B/BUF CURSOR - ;             14 b:utility.blk
: #S     (S -- )     BEGIN  #  2DUP  OR  0=  UNTIL  ;    60 b:kernel80.blk
: '   (S -- cfa )   DEFINED 0= ?MISSING   ;              71 b:kernel80.blk
: 'C#A   (S -- 'cursor #after )   'CURSOR #AFTER  MODIF  16 b:utility.blk
: 'CURSOR      (S -- adr )  'START  CURSOR  + ;          14 b:utility.blk
: 'F   (S -- cfa )                                       12 b:meta80.blk
: 'F+   (S n1 -- n2 )  'FIND C@ +  ;                     16 b:utility.blk
: 'FIND     (S -- find-buffer )     'INSERT C/PAD + ;    15 b:utility.blk
: 'INSERT   (S -- insert-buffer )   PAD     C/PAD + ;    15 b:utility.blk
: 'LINE        (S -- adr )  'CURSOR  COL# -  ;           14 b:utility.blk
: 'START       (S -- adr )  SCR @ BLOCK ;                14 b:utility.blk
: 'T   (S -- cfa )                                       12 b:meta80.blk
: 'UNNEST   (S Pfa -- Pfa' )                             50 b:utility.blk
: 'VIDEO    (S -- video-buffer )    'FIND   C/PAD + ;    15 b:utility.blk
: 'WORD   (S -- adr )                                    64 b:kernel80.blk
: (    (S -- )   ASCII ) PARSE 2DROP  ; IMMEDIATE        64 b:kernel80.blk
: (!FCB)          (S Addr len FCB-addr --- )              8 b:extend80.blk
: (")    (S -- addr len )   R> COUNT 2DUP + EVEN >R  ;   71 b:kernel80.blk
: ((SEE))   (S Cfa -- )                                  42 b:utility.blk
: (.")   (S -- )            R> COUNT 2DUP + EVEN >R   T  71 b:kernel80.blk
: (.)   (S n -- a l )   DUP ABS 0   <# #S   ROT SIGN     61 b:kernel80.blk
: (;CODE)     (S -- )   R>    LAST @ NAME>  !  ;         77 b:kernel80.blk
: (;USES)     (S -- )   R> @  LAST @ NAME>  !  ;         77 b:kernel80.blk
: (>SHADOW)   (S scr# fcb -- scr#' )                     22 b:utility.blk
: (?DO)   (S n1 n2 -- )                                  12 b:kernel80.blk
: (?ERROR)   (S adr len f -- )                           73 b:kernel80.blk
: (ABORT")   (S f -- )                                   73 b:kernel80.blk
: (AT)     (S col row -- )   2DROP  CR  ;                24 b:utility.blk
: (BLOCK)    (S n fcb -- a )                             55 b:kernel80.blk
: (BLOT)   (S col -- )   C/L SWAP - SPACES   ;           24 b:utility.blk
: (BUFFER)   (S n fcb -- a )   PAUSE  ABSENT?            55 b:kernel80.blk
: (CHAR)   (S a n char -- a n+1 )                        48 b:kernel80.blk
: (CONSOLE)   (S char -- )                               45 b:kernel80.blk
: (CONVEY)   (S blk n -- blk+-n )                         8 b:utility.blk
: (COPY)   ( from to -- )                                 7 b:utility.blk
: (D.)  (S d -- a l )   TUCK DABS   <# #S   ROT SIGN  #  61 b:kernel80.blk
: (DARK)   (S -- )   24 0 DO   CR   LOOP ;               24 b:utility.blk
: (DEBUG)       (S low-adr hi-adr -- )                   50 b:utility.blk
: (DEL-IN)   (S n c -- 0 | n-1 )                         47 b:kernel80.blk
: (DO)   (S n1 n2 -- )                                   12 b:kernel80.blk
: (EMIT)   (S char -- )                                  46 b:kernel80.blk
: (FORGET)   (S addr -- )                                72 b:kernel80.blk
: (I)  (S -- len 'insert len 'cursor #after )            16 b:utility.blk
: (KEY)    (S -- char )                                  45 b:kernel80.blk
: (KEY?)   (S -- f )                                     45 b:kernel80.blk
: (LOAD)     (S n -- )   FILE @ >R   BLK @ >R   >IN @ >  57 b:kernel80.blk
: (NUMBER)   (S adr -- d# )                              59 b:kernel80.blk
: (NUMBER?)   (S adr -- d flag )                         59 b:kernel80.blk
: (PAGE)   (S -- )  L/PAGE #LINE @ OVER MIN ?DO  CR  LO  44 b:utility.blk
: (PRINT)   (S char -- )                                 46 b:kernel80.blk
: (S  ( -- )     [COMPILE] (   ;   IMMEDIATE              3 b:extend80.blk
: (SEMIT)   (S c -- )                                    44 b:utility.blk
: (SOURCE)    (S -- addr len )                           63 b:kernel80.blk
: (TILL)  (S -- n )   'FIND ?TEXT 'C#A SEARCH ?MISSING   16 b:utility.blk
: (U.)  (S u -- a l )   0    <# #S #>   ;                61 b:kernel80.blk
: (UD.) (S ud -- a l )  <# #S #>   ;                     61 b:kernel80.blk
: (WHERE)   (S pos scr -- )   DISK-ERROR @ 0=            21 b:utility.blk
: *   (S n1 n2 -- n3 )   UM* DROP   ;                    37 b:kernel80.blk
: */    (S n1 n2 n3 -- n1*n2/n3 )     */MOD  NIP  ;      37 b:kernel80.blk
: */MOD (S n1 n2 n3 -- rem quot )                        37 b:kernel80.blk
: *D   (S n1 n2 -- d# )                                  36 b:kernel80.blk
: +LOOP                                                  75 b:kernel80.blk
: +T           (S n -- )    LINE# + T   ;                14 b:utility.blk
: +THRU   (S n1 n2 -- )                                   3 b:extend80.blk
: ,      (S n -- )   HERE !   2 ALLOT   ;                70 b:kernel80.blk
: ,"   (S -- )                                           71 b:kernel80.blk
: ,-T     (S n -- )      HERE-T  !-T   2 ALLOT-T   ;      4 b:meta80.blk
: ,VIEW  (S -- )   BLK @ DUP IF  VIEW# @ 4096 * +  THEN  76 b:kernel80.blk
: -->      (S -- )                                        3 b:extend80.blk
: -TRAILING   (S addr len -- addr len' )                 42 b:kernel80.blk
: .     (S n -- )       (.)   TYPE SPACE   ;             61 b:kernel80.blk
: ."   (S -- )   COMPILE (.")   ,"   ;   IMMEDIATE       71 b:kernel80.blk
: .(   (S -- )   ASCII ) PARSE >TYPE  ; IMMEDIATE        64 b:kernel80.blk
: .(;CODE)    (S IP -- IP' )                             35 b:utility.blk
: .2   (S n -- )   0 <#   # #   #>   TYPE   SPACE   ;    29 b:utility.blk
: .:           (S CFA -- )                               39 b:utility.blk
: .ALL   (S -- )   DISK-ERROR @ 0=                       19 b:utility.blk
: .BRANCH     (S IP -- IP' )                             34 b:utility.blk
: .BUFS     (S -- )                                      15 b:utility.blk
: .CONSTANT    (S CFA -- )                               39 b:utility.blk
: .DEFER   (S CFA -- )                                   40 b:utility.blk
: .DOES>       (S CFA -- )                               39 b:utility.blk
: .DUMB    (S -- )   CR   .LINE   CR   ;                 24 b:utility.blk
: .FILE   (S adr -- )                                    51 b:kernel80.blk
: .FINISH     (S IP -- IP' )                             35 b:utility.blk
: .FRAMED   (S adr -- )   ." '" COUNT TYPE ." '" ;       15 b:utility.blk
: .HEAD   (S addr len -- addr' len' )                    30 b:utility.blk
: .IMMEDIATE   (S CFA -- )                               38 b:utility.blk
: .INLINE     (S IP -- IP' )                             34 b:utility.blk
: .LINE   (S -- )                                        19 b:utility.blk
: .LINE0   (S n -- )                                      4 b:utility.blk
: .NAME   (S n -- )                                      10 b:extend80.blk
: .OTHER   (S CFA -- )                                   40 b:utility.blk
: .PFA   (S CFA -- )                                     38 b:utility.blk
: .QUOTE      (S IP -- IP' )                             34 b:utility.blk
: .R    (S n l -- )     >R   (.)   R> OVER - SPACES   T  61 b:kernel80.blk
: .SCR   (S -- )   ." Scr # " SCR ?  8 SPACES FILE?  ;    4 b:utility.blk
: .STRING     (S IP -- IP' )                             34 b:utility.blk
: .SYMBOLS    (S -- )                                    19 b:meta80.blk
: .TO  ( #1 #2 -- #1 #2 )  CR  OVER . ." to "  DUP . ;    8 b:utility.blk
: .UNNEST     (S IP -- IP' )                             35 b:utility.blk
: .UNRESOLVED   (S -- )                                  20 b:meta80.blk
: .USER-DEFER   (S cfa -- )                              40 b:utility.blk
: .USER-VARIABLE   (S CFA -- )                           39 b:utility.blk
: .VARIABLE    (S CFA -- )                               39 b:utility.blk
: .WORD       (S IP -- IP' )                             34 b:utility.blk
: /     (S n1 n2 -- quot )   /MOD  NIP  ;                37 b:kernel80.blk
: /MOD  (S n1 n2 -- rem quot )   >R  S>D  R>  M/MOD  ;   37 b:kernel80.blk
: /STRING   (S addr len n -- addr' len' )                63 b:kernel80.blk
: 0<=   (S n1 n2 -- f )   0> NOT   ;                      2 b:utility.blk
: 0>=   (S n1 n2 -- f )   0< NOT   ;                      2 b:utility.blk
: 2PR   (S Scr1# Scr2# line# -- )                        45 b:utility.blk
: 2ROT  (S a b c d e f --- c d e f a b )  5 ROLL 5 ROLL  32 b:kernel80.blk
: 2SCR   (S Scr1 Scr2 --- )                              45 b:utility.blk
: 3DUP  (S a b c -- a b c a b c )        DUP 2OVER ROT   32 b:kernel80.blk
: 4DUP  (S a b c d -- a b c d a b c d )  2OVER 2OVER     32 b:kernel80.blk
: :   (S -- )                                             8 b:kernel80.blk
: :   (S -- )                                            78 b:kernel80.blk
: ::   (S -- )                                            6 b:utility.blk
: ;   (S -- )                                            78 b:kernel80.blk
: ;CODE       (S -- )   ?CSP   COMPILE  (;CODE)          77 b:kernel80.blk
: ;USES       (S -- )   ?CSP   COMPILE  (;USES)          77 b:kernel80.blk
: <#     (S -- )     PAD  HLD  !  ;                      60 b:kernel80.blk
: <=    (S n1 n2 -- f )   > NOT    ;                      2 b:utility.blk
: <>     (S n1 n2 -- f )   = NOT   ;                     29 b:kernel80.blk
: <MARK      (S -- addr )    HERE    ;                   74 b:kernel80.blk
: <RESOLVE   (S addr -- )    ,   ;                       74 b:kernel80.blk
: >=    (S n1 n2 -- f )   < NOT    ;                      2 b:utility.blk
: >BODY      2+   ;                                      66 b:kernel80.blk
: >BUFFERS   (S -- adr )   FIRST  >SIZE - ;              50 b:kernel80.blk
: >END       (S -- adr )   FIRST  2-  ;                  50 b:kernel80.blk
: >IN-SHADOW   (S scr# -- scr#' )                        22 b:utility.blk
: >LINK      >NAME   N>LINK   ;                          66 b:kernel80.blk
: >MARK      (S -- addr )    HERE 0 ,   ;                74 b:kernel80.blk
: >NAME      1- -1 TRAVERSE   ;                          66 b:kernel80.blk
: >RESOLVE   (S addr -- )    HERE SWAP !   ;             74 b:kernel80.blk
: >SHADOW   (S scr# -- scr#' )                           22 b:utility.blk
: >TYPE   (S adr len -- )                                64 b:kernel80.blk
: >UPDATE    (S -- adr )   1 BUFFER# 6 +  ;              50 b:kernel80.blk
: >VIEW      >LINK   2-   ;                              66 b:kernel80.blk
: ?   (S adr -- )   @ .   ;                               3 b:extend80.blk
: ?.A    (S n1 n2 -- n1 )                                29 b:utility.blk
: ?.N    (S n1 n2 -- n1 )                                29 b:utility.blk
: ?<MARK      (S -- f addr )   TRUE   <MARK   ;          74 b:kernel80.blk
: ?<MARK      (S -- f addr )   TRUE   HERE-T   ;          7 b:meta80.blk
: ?<RESOLVE   (S f addr -- )   ,-T   ?CONDITION   ;       7 b:meta80.blk
: ?<RESOLVE   (S f addr -- )   SWAP ?CONDITION <RESOLVE  74 b:kernel80.blk
: ?>MARK      (S -- f addr )   TRUE   HERE-T   0 ,-T      7 b:meta80.blk
: ?>MARK      (S -- f addr )   TRUE >MARK   ;            74 b:kernel80.blk
: ?>RESOLVE   (S f addr -- )   HERE-T SWAP !-T   ?CONDI   7 b:meta80.blk
: ?>RESOLVE   (S f addr -- )   SWAP ?CONDITION >RESOLVE  74 b:kernel80.blk
: ?CONDITION   (S f -- )                                 74 b:kernel80.blk
: ?CR   (S -- )   0 ?LINE  ;                              3 b:utility.blk
: ?CSP   (S -- )   SP@ CSP @ <> ABORT" Stack Changed"    77 b:kernel80.blk
: ?DEFINE   (S -- fcb )                                  11 b:extend80.blk
: ?DISK-ERROR  (S fcb n -- )                             51 b:kernel80.blk
: ?DNEGATE  (S d1 n -- d2 )     0< IF   DNEGATE   THEN   34 b:kernel80.blk
: ?DO     COMPILE (?DO)  ?>MARK                    ; IM  75 b:kernel80.blk
: ?DUP      (S n -- [n] n )                              20 b:kernel80.blk
: ?ENOUGH   (S n -- )                                     3 b:extend80.blk
: ?LEAVE  COMPILE (?LEAVE)  ; IMMEDIATE                  74 b:kernel80.blk
: ?LINE   (S n -- )                                       3 b:utility.blk
: ?MISSING   (S f -- )                                   71 b:kernel80.blk
: ?MISSING   (S n f -- n | )                             15 b:utility.blk
: ?NEGATE    (S n1 n2 -- n3 )   0< IF    NEGATE   THEN   29 b:kernel80.blk
: ?STACK  (S -- )   ( System dependant )                 69 b:kernel80.blk
: ?STAMP   (S -- )   CHANGED @ IF  STAMP  CHANGED OFF    16 b:utility.blk
: ?TEXT   (S adr -- adr+1 n )   >R   EOS PARSE DUP       15 b:utility.blk
: ?UPPERCASE   (S adr -- adr )                           68 b:kernel80.blk
: @-T     (S taddr -- n )      THERE @  ;                 4 b:meta80.blk
: @VIEW   (S code-field -- scr file# )                    7 b:utility.blk
: A   (S -- )                                            22 b:utility.blk
: A:   (S -- )   [ DOS ]  0 SELECT ;                     10 b:extend80.blk
: ABORT   (S -- )                                        73 b:kernel80.blk
: ABORT"   (S -- )                                       73 b:kernel80.blk
: ABSENT?   (S n fcb -- a f )                            54 b:kernel80.blk
: ACTIVATE   (S task -- )                                53 b:utility.blk
: AGAIN   COMPILE  BRANCH    ?<RESOLVE             ; IM  75 b:kernel80.blk
: ALIGN  ( HERE 1 AND IF  BL C,  THEN )  ; IMMEDIATE     70 b:kernel80.blk
: ALLOT       (S n -- )                                  16 b:meta80.blk
: ALLOT  (S n -- )      DP +!   ;                        70 b:kernel80.blk
: ALLOT-T (S n -- )       DP-T +!   ;                     4 b:meta80.blk
: ALSO   (S -- )                                          4 b:extend80.blk
: ANSI   (S -- )   SMART                                 25 b:utility.blk
: ANSI--LINE   (S -- )           27 EMIT ." [1M"   ;     25 b:utility.blk
: ANSI-AT   (S col row -- )                              25 b:utility.blk
: ANSI-BLOT   (S col -- )   DROP   27 EMIT ." [K"   ;    25 b:utility.blk
: ANSI-DARK    (S -- )           27 EMIT ." [2J"   ;     25 b:utility.blk
: ASCII     (S -- n )   BL WORD   1+ C@                  70 b:kernel80.blk
: ASSEMBLER ASSEMBLER ;                                   5 b:meta80.blk
: ASSOCIATIVE:                                           33 b:utility.blk
: AT   (S col row -- )  ( 0 0 is upper left )            13 b:utility.blk
: B   (S -- )     -1 SCR +!  DISK-ERROR OFF  ;            7 b:utility.blk
: B:   (S -- )   [ DOS ]  1 SELECT ;                     10 b:extend80.blk
: BACK-UP (S n c -- 0 )                                  47 b:kernel80.blk
: BACKGROUND:   (S -- )                                  54 b:utility.blk
: BACKSPACES   (S n -- )     0 ?DO   BS EMIT   LOOP   ;  46 b:kernel80.blk
: BEEP   (S -- )     BELL EMIT   ;                       46 b:kernel80.blk
: BEGIN   ?<MARK                                   ; IM  75 b:kernel80.blk
: BETWEEN   (S n1 min max -- f )                         30 b:kernel80.blk
: BLANK      (S addr len -- )   BL FILL   ;              41 b:kernel80.blk
: BLOCK     (S n -- a )   FILE @ (BLOCK)  ;              55 b:kernel80.blk
: BODY>      2-   ;                                      66 b:kernel80.blk
: BOUNDS   (S adr len -- lim first )                     12 b:kernel80.blk
: BRING   (S scr# l1 l2 -- )                             23 b:utility.blk
: BRING   (S screen first last -- )                      17 b:utility.blk
: BS-IN   (S n c -- 0 | n-1 )                            47 b:kernel80.blk
: BUFFER   (S n -- a )   FILE @ (BUFFER)  ;              55 b:kernel80.blk
: BUFFER#    (S n -- adr )   8* >BUFFERS +   ;           50 b:kernel80.blk
: C            (S n -- )    R# @ + C/SCR MOD R# ! ;      14 b:utility.blk
: C!-T    (S char taddr -- )   THERE C! ;                 4 b:meta80.blk
: C,     (S char -- )   HERE C!   1 ALLOT ;              70 b:kernel80.blk
: C,-T    (S char -- )   HERE-T C!-T   1 ALLOT-T   ;      4 b:meta80.blk
: C;   END-CODE  ;                                       11 b:meta80.blk
: C@-T    (S taddr -- char )   THERE C@ ;                 4 b:meta80.blk
: CAPACITY   (S -- n )                                   54 b:kernel80.blk
: CASE:   (S n --  ) ( define positional case defining   32 b:utility.blk
: CHANGED?   (S line# -- f )                             19 b:utility.blk
: CLOSE    (S fcb -- )                                    7 b:extend80.blk
: CLR-FCB    (S fcb -- )    DUP  B/FCB ERASE 1+ 11 BLAN  52 b:kernel80.blk
: CODE   (S -- )                                         11 b:meta80.blk
: COL#         (S -- n )    CURSOR  C/L  MOD  ;          14 b:utility.blk
: COMPARE   (S addr1 addr2 len -- -1 | 0 | 1 )           44 b:kernel80.blk
: COMPILE   (S -- )   R> DUP 2+ >R   @ ,   ;             70 b:kernel80.blk
: CONSTANT   (S n -- )                                    6 b:kernel80.blk
: CONSTANT   (S n -- )                                   79 b:kernel80.blk
: CONTROL   (S -- n )   BL WORD   1+ C@  31 AND          70 b:kernel80.blk
: CONVERT   (S +d1 adr1 -- +d2 adr2 )                    58 b:kernel80.blk
: CONVEY   (S first last -- )                             8 b:utility.blk
: CONVEY   (S first last -- )   2DUP CONVEY              23 b:utility.blk
: COPY   (S from to -- )  FLUSH  2DUP (COPY)             23 b:utility.blk
: COPY   FLUSH (COPY) FLUSH ;                             7 b:utility.blk
: CR-IN (S m a n c -- m a m )                            48 b:kernel80.blk
: CRASH   (S -- )                                        71 b:kernel80.blk
: CREATE                                                 15 b:meta80.blk
: CREATE   (S -- )                                       76 b:kernel80.blk
: CREATE-FILE   (S #blocks -- )                           9 b:extend80.blk
: CRLF   (S -- )  13 EMIT   10 EMIT   #OUT OFF  1 #LINE  46 b:kernel80.blk
: CURSOR       (S -- n )    R# @ ;                       14 b:utility.blk
: D   (S -- )   F E ;                                    18 b:utility.blk
: D-    (S d1 d2 -- d3 )   DNEGATE D+   ;                34 b:kernel80.blk
: D.    (S d -- )       (D.)   TYPE SPACE   ;            61 b:kernel80.blk
: D.2   (S addr len -- )   BOUNDS ?DO   I C@ .2   LOOP   29 b:utility.blk
: D.R   (S d l -- )     >R   (D.)   R> OVER - SPACES     61 b:kernel80.blk
: D0=   (S d -- f )        OR 0= ;                       35 b:kernel80.blk
: D<    (S d1 d2 -- f )   2 PICK OVER =                  35 b:kernel80.blk
: D=    (S d1 d2 -- f )    D-  D0=  ;                    35 b:kernel80.blk
: D>    (S d1 d2 -- f )    2SWAP D<   ;                  35 b:kernel80.blk
: DARK   (S -- )                                         13 b:utility.blk
: DEBUG   (S -- )                                        51 b:utility.blk
: DECIMAL    (S -- )   10 BASE !  ;                      60 b:kernel80.blk
: DEFAULT    (S -- )   [ DOS ]   FCB1 DUP IN-FILE !  DU  57 b:kernel80.blk
: DEFER       (S -- )                                    16 b:meta80.blk
: DEFER   (S -- )                                        15 b:meta80.blk
: DEFER   (S -- )                                        79 b:kernel80.blk
: DEFINE  (S -- )   [ DOS ]  ?DEFINE  DROP  ;            11 b:extend80.blk
: DEFINED   (S -- here 0 | cfa [ -1 | 1 ] )              68 b:kernel80.blk
: DEFINITIONS   (S -- )                                  79 b:kernel80.blk
: DEFINITIONS   DEFINITIONS   ;                           5 b:extend80.blk
: DELETE   (S buffer size count -- )                     11 b:utility.blk
: DELETE   (S fcb -- n )   19 BDOS ;                      7 b:extend80.blk
: DIGIT?   (S CHAR -- F )                                13 b:meta80.blk
: DIR   (S -- )   [ DOS ]                                10 b:extend80.blk
: DISCARD  (S -- )   1 >UPDATE ! ( 1 BUFFER# ON ) ;      55 b:kernel80.blk
: DISK-ABORT   (S fcb a n -- )                           51 b:kernel80.blk
: DISPLACEMENT   (S fcb -- disp )                        22 b:utility.blk
: DL   (S line# -- )                                     30 b:utility.blk
: DLITERAL    (S d# -- )                                 70 b:kernel80.blk
: DLN   (S addr --- )                                    29 b:utility.blk
: DMAX  (S d1 d2 -- d3 )   4DUP D< IF   2SWAP   THEN     35 b:kernel80.blk
: DMIN  (S d1 d2 -- d3 )   4DUP D> IF   2SWAP   THEN     35 b:kernel80.blk
: DO      COMPILE (DO)   ?>MARK                    ; IM  75 b:kernel80.blk
: DOES>   (S -- )   COMPILE (;CODE)   205 ( CALL ) C,    77 b:kernel80.blk
: DONE   (S -- )   [ EDITOR ]   EDITING? @               21 b:utility.blk
: DONE?   (S n -- f )                                    65 b:kernel80.blk
: DOS-ERR?    (S -- f )   255 =    ;                     57 b:kernel80.blk
: DOUBLE?   (S -- f )      DPL @ 1+   0<> ;              58 b:kernel80.blk
: DRIVE?   (S -- )   0 25 BDOS ASCII A + EMIT ." : "  ;  10 b:extend80.blk
: DU   (S addr -- addr+64 )                              30 b:utility.blk
: DU<   (S ud1 ud2 -- f )   ROT SWAP 2DUP U<             35 b:kernel80.blk
: DUMB      (S -- )                                      24 b:utility.blk
: DUMP   (S addr len -- )                                30 b:utility.blk
: E   (S -- )   'FIND C@  DUP NEGATE C  'C#A ROT DELETE  18 b:utility.blk
: ED   (S -- )   [ EDITOR ]  GET-ID  INSTALL EDITOR      21 b:utility.blk
: EDIT   (S scr -- )   1 ?ENOUGH SCR !  [ EDITOR ] TOP   21 b:utility.blk
: EDIT-AT  ( -- )  CURSOR C/L /MOD SWAP DX + SWAP DY +   20 b:utility.blk
: ELSE    COMPILE  BRANCH ?>MARK  2SWAP ?>RESOLVE  ; IM  75 b:kernel80.blk
: EMIT.   (S char -- )                                   29 b:utility.blk
: EMPTY-BUFFERS   (S -- )                                56 b:kernel80.blk
: END-CODE                                               11 b:meta80.blk
: EPSON   (S -- )   CONTROL O EMIT ( EPSON Condensed )   44 b:utility.blk
: ERASE      (S addr len -- )   0 FILL   ;               41 b:kernel80.blk
: ESTABLISH   (S n -- )   FILE @ SWAP  1 BUFFER# 2! ;     7 b:utility.blk
: EVEN   ( DUP 1 AND + ) ;  IMMEDIATE                    70 b:kernel80.blk
: EXPECT   (S adr len -- )                               49 b:kernel80.blk
: F   (S -- )   FIND? ?MISSING   'F+ C ;                 18 b:utility.blk
: FALCO   TELEVIDEO ;                                    27 b:utility.blk
: FILE-IO   (S -- )                                      53 b:kernel80.blk
: FILE-READ   (S buffer-header -- )                      53 b:kernel80.blk
: FILE-SIZE   (S fcb -- n )   DUP 35 BDOS  DROP  RECORD  57 b:kernel80.blk
: FILE-WRITE   (S buffer-header -- )                     53 b:kernel80.blk
: FILE:   (S -- fcb )                                    11 b:extend80.blk
: FILE?   (S -- )   FILE @ .FILE  ;                      51 b:kernel80.blk
: FIND   (S addr -- cfa flag | addr false )              68 b:kernel80.blk
: FIND-UNRESOLVED   (S -- cfa f )                        20 b:meta80.blk
: FIND?  (S - n f ) 'FIND ?TEXT  'CURSOR #REMAINING  SE  18 b:utility.blk
: FIX   (S -- )   [ DOS ]  >IN @  ' @VIEW   ?DUP         21 b:utility.blk
: FLUSH   (S -- )                                        56 b:kernel80.blk
: FORGET   (S -- )                                       72 b:kernel80.blk
: FORM-FEED   (S -- )   CONTROL M EMIT   CONTROL L EMIT  44 b:utility.blk
: FORTH   FORTH ;                                         5 b:extend80.blk
: FORTH-83   (S -- )   FORTH DEFINITIONS CAPS OFF  ;     65 b:kernel80.blk
: FORWARD FORWARD ;                                       5 b:meta80.blk
: FORWARD-CODE   (S pfa -- )                              9 b:meta80.blk
: FORWARD:    (S -- )                                     9 b:meta80.blk
: FROM    (S -- )   [ DOS ]  ?DEFINE  IN-FILE !  OPEN-F  11 b:extend80.blk
: G   (S  screen line -- )                               17 b:utility.blk
: G   (S scr# line -- )   2DUP G A                       23 b:utility.blk
: GET-ID   (S -- )                                       20 b:utility.blk
: H19--LINE   (S n --- )                                 26 b:utility.blk
: H19-AT   (S x y --- )                                  26 b:utility.blk
: H19-BLOT   (S n --- )                                  26 b:utility.blk
: H19-DARK   (S -- )                                     26 b:utility.blk
: H:   [COMPILE] :   ;                                   21 b:meta80.blk
: HASH   (S str-addr voc-addr -- thread )                10 b:meta80.blk
: HEADER   (S -- )                                       10 b:meta80.blk
: HEATH   (S -- )   SMART                                26 b:utility.blk
: HELLO   (S -- )                                         2 b:extend80.blk
: HERE   (S -- addr )   DP @   ;                         42 b:kernel80.blk
: HERE-T  (S -- taddr )   DP-T @   ;                      4 b:meta80.blk
: HEX        (S -- )   16 BASE !  ;                      60 b:kernel80.blk
: HIDE      (S -- )                                      77 b:kernel80.blk
: HOLD   (S char -- )   -1 HLD +!   HLD @ C!   ;         60 b:kernel80.blk
: HOP   ( n -- ) ( specifies n screens to skip )  HOPPE   8 b:utility.blk
: I   (S -- )   (I)  INSERT  C ;                         17 b:utility.blk
: IF      COMPILE  ?BRANCH  ?>MARK                 ; IM  75 b:kernel80.blk
: IMMEDIATE   (S -- )   WIDTH @ IF ( Headers present? )  17 b:meta80.blk
: IMMEDIATE (S -- )   64 ( Precedence bit ) LAST @  CSE  70 b:kernel80.blk
: IN-BLOCK  (S n -- a )   IN-FILE @ (BLOCK)  ;           55 b:kernel80.blk
: IN-FORWARD   (S -- )                                    8 b:meta80.blk
: IN-META     (S -- )                                     8 b:meta80.blk
: IN-RANGE   (S fcb -- fcb )                             52 b:kernel80.blk
: IN-TARGET   (S -- )                                     8 b:meta80.blk
: IN-TRANSITION   (S -- )                                 8 b:meta80.blk
: IND   (S n -- )                                         4 b:utility.blk
: INDEX   (S n1 n2 -- )                                   4 b:utility.blk
: INSERT   (S string length buffer size -- )             11 b:utility.blk
: INSTALL   (S -- )   EDITING? @ NOT                     13 b:utility.blk
: INTERPRET   (S -- )                                    69 b:kernel80.blk
: J       (S -- )   'C#A (TILL)  DELETE ;                18 b:utility.blk
: JOIN   (S -- )   'LINE C/L + C/L  'C#A  INSERT ;       17 b:utility.blk
: K   (S -- )   'FIND PAD  C/PAD CMOVE                   16 b:utility.blk
: KEEP   (S -- )   'LINE C/L 'INSERT  PLACE  ;           15 b:utility.blk
: KT      (S -- )   'CURSOR (TILL)  'F+  'INSERT PLACE   18 b:utility.blk
: L   (S -- )     SCR @ LIST   ;                          7 b:utility.blk
: L.ID   (S nfa len -- )                                 50 b:utility.blk
: L>NAME     2+   ;                                      66 b:kernel80.blk
: LABEL   (S -- )                                         8 b:meta80.blk
: LARGEST (S addr n -- addr' val )                        5 b:utility.blk
: LATEST?   (S n fcb -- fcb   | a f )                    54 b:kernel80.blk
: LEAVE   COMPILE (LEAVE)   ; IMMEDIATE                  74 b:kernel80.blk
: LINE#        (S -- n )    CURSOR  C/L  /  ;            14 b:utility.blk
: LINK-BACKWARDS   (S PFA -- )                            9 b:meta80.blk
: LINK>      L>NAME   NAME>   ;                          66 b:kernel80.blk
: LIST   (S n -- )                                        4 b:utility.blk
: LISTING   (S -- )                                      48 b:utility.blk
: LITERAL   (S n -- )    COMPILE (LIT)   ,   ;   IMMEDI  70 b:kernel80.blk
: LOOP                                                   75 b:kernel80.blk
: M   (S -- )   TRUE ABORT" Use G !" ;                   17 b:utility.blk
: M/MOD   (S d# n1 -- rem quot )                         36 b:kernel80.blk
: MAKE-CODE   (S PFA -- )                                 8 b:meta80.blk
: MAKE-FILE   (S fcb -- )                                 7 b:extend80.blk
: MANY   (S -- )                                          6 b:utility.blk
: MAP  ( # apf -- a ) ( convert subscript # to address   32 b:utility.blk
: MARK    (S -- )                                         2 b:extend80.blk
: MAX   (S n1 n2 -- n3 )   2DUP < IF   SWAP   THEN   DR  30 b:kernel80.blk
: MAXREC#    (S fcb -- adr )   38 + ;                    52 b:kernel80.blk
: META META ;                                             5 b:meta80.blk
: MIN   (S n1 n2 -- n3 )   2DUP > IF   SWAP   THEN   DR  30 b:kernel80.blk
: MISSING   (S -- )                                      55 b:kernel80.blk
: MOD   (S n1 n2 -- rem )    /MOD  DROP  ;               37 b:kernel80.blk
: MODIFIED   (S -- )   CHANGED ON  UPDATE ;              15 b:utility.blk
: MORE   (S n -- )   [ DOS ]                              9 b:extend80.blk
: MOVE   ( from to len -- )                              41 b:kernel80.blk
: MS   (S n -- )                                          2 b:utility.blk
: MU/MOD  (S d# n1 -- rem d#quot )                       36 b:kernel80.blk
: N   (S -- )      1 SCR +!  DISK-ERROR OFF  ;            7 b:utility.blk
: N>LINK     2-   ;                                      66 b:kernel80.blk
: NAME>      1 TRAVERSE   1+   ;                         66 b:kernel80.blk
: NEW   (S n -- )                                        20 b:utility.blk
: NLOAD   CR .S  (LOAD) ;   ' NLOAD IS LOAD               1 b:meta80.blk
: NUMBER?   (S adr -- d flag )                           59 b:kernel80.blk
: NUMERIC   (S -- )                                       7 b:kernel80.blk
: NUMERIC?   (S ADDR LEN -- F )                          13 b:meta80.blk
: O   (S -- )   (I)  REPLACE C ;                         17 b:utility.blk
: OCTAL      (S -- )    8 BASE !  ;                      60 b:kernel80.blk
: ONLY   (S -- )                                          4 b:extend80.blk
: OPEN    (S -- )   [ DOS ]  ?DEFINE  !FILES     OPEN-F  11 b:extend80.blk
: OPEN-FILE   (S -- )   IN-FILE @ DUP 15 BDOS DOS-ERR?   57 b:kernel80.blk
: ORDER   (S -- )                                         5 b:extend80.blk
: OUT   ( # apf -- ) ( report out of range error )       32 b:utility.blk
: P   (S -- )   'INSERT ?TEXT DROP 'LINE C/L CMOVE MODI  17 b:utility.blk
: P-FOOTING   (S -- )                                    46 b:utility.blk
: P-HEADING   (S -- )                                    46 b:utility.blk
: P-IN  (S c -- )                                        47 b:kernel80.blk
: PAD    (S -- addr )   HERE 80 +   ;                    42 b:kernel80.blk
: PAGE   (S -- )                                         44 b:utility.blk
: PARSE   (S char -- addr len )                          63 b:kernel80.blk
: PARSE-WORD   (S char -- addr len )                     63 b:kernel80.blk
: PLACE     (S str-addr len to -- )                      63 b:kernel80.blk
: PR   (S scr -- )                                       45 b:utility.blk
: PR-FLUSH    (S -- f )                                  47 b:utility.blk
: PR-PAGE   (S -- )                                      47 b:utility.blk
: PR-S-PAGE   (S -- )                                    47 b:utility.blk
: PR-START  (S -- )   PRINTING ON   #LINE OFF            47 b:utility.blk
: PR-STAT (S -- f )   TRUE   ( 0 15 BIOS )   ;           46 b:kernel80.blk
: PR-STOP     (S -- )                                    47 b:utility.blk
: PREVIOUS   (S -- )                                      4 b:extend80.blk
: PUNCT?   (S CHAR -- F )                                13 b:meta80.blk
: QUERY   (S -- )                                        49 b:kernel80.blk
: QUME    TELEVIDEO ;                                    27 b:utility.blk
: R   (S -- )   E I ;                                    18 b:utility.blk
: READ     (S fcb -- )                                    7 b:extend80.blk
: REC-READ   (S fcb -- )                                 52 b:kernel80.blk
: REC-WRITE  (S fcb -- )                                 52 b:kernel80.blk
: RECORD#    (S fcb -- adr )   33 + ;                    52 b:kernel80.blk
: RECREATE   (S -- )                                     11 b:meta80.blk
: RECURSE   (S -- )                                      84 b:kernel80.blk
: RECURSE   (S -- )                                      88 b:kernel80.blk
: RECURSIVE (S -- )   REVEAL ;   IMMEDIATE               79 b:kernel80.blk
: REDISPLAY   (S line# -- )                              19 b:utility.blk
: REPEAT  2SWAP [COMPILE] AGAIN   [COMPILE] THEN   ; IM  75 b:kernel80.blk
: REPLACE   (S string length buffer size -- )  ROT MIN   11 b:utility.blk
: RES-IN   (S c -- )                                     47 b:kernel80.blk
: RESET    (S -- )   0  13 BDOS DROP ;                    7 b:extend80.blk
: RESOLVE   (S taddr cfa -- )                            20 b:meta80.blk
: RESOLVED?   (S pfa -- f )                               9 b:meta80.blk
: RESOLVES   (S taddr -- )                               20 b:meta80.blk
: RESUME   (S -- )                                       51 b:utility.blk
: REVEAL   (S -- )                                       77 b:kernel80.blk
: ROLL   (S n1 n2 .. nk n -- wierd )                     21 b:kernel80.blk
: S   (S n - )   1 ?ENOUGH   FIND?                       18 b:utility.blk
: S,-T    (S addr len -- )                                4 b:meta80.blk
: SAVE   (S Addr len --- )                                9 b:extend80.blk
: SAVE-BUFFERS   (S -- )                                 56 b:kernel80.blk
: SAVE-SYSTEM   (S -- )                                  11 b:extend80.blk
: SCAN-1ST   (S a n c -- a n )                           10 b:utility.blk
: SEAL   (S -- )                                          4 b:extend80.blk
: SEARCH   ( sadr slen badr blen -- n f )                10 b:utility.blk
: SEARCH   (S fcb -- n )   18 BDOS ;                      7 b:extend80.blk
: SEARCH0  (S fcb -- n )   17 BDOS ;                      7 b:extend80.blk
: SEE   (S -- )                                          42 b:utility.blk
: SELECT   (S drive -- )                                  8 b:extend80.blk
: SET-DMA    (S adr -- )   26 BDOS  DROP ;               52 b:kernel80.blk
: SET-IO       (S buf-header -- file buffer rec/blk 0 )  53 b:kernel80.blk
: SET-TASK   (S ip task -- )                             53 b:utility.blk
: SHOW   (S first last -- )                              48 b:utility.blk
: SHOW   (S first last -- )                              48 b:utility.blk
: SIGN   (S n1 -- )  0< IF  ASCII -  HOLD  THEN  ;       60 b:kernel80.blk
: SMART   (S -- )                                        25 b:utility.blk
: SPACE  (S -- )     BL EMIT   ;                         46 b:kernel80.blk
: SPACES (S n -- )   0 MAX   0 ?DO   SPACE   LOOP   ;    46 b:kernel80.blk
: SPLIT  (S -- )                                         17 b:utility.blk
: STAMP  (S -- )  ID 'START C/L + ID-LEN 1- - ID-LEN 1-  16 b:utility.blk
: STRING,-T   (S -- )                                    14 b:meta80.blk
: SWITCH   (S -- )                                        3 b:meta80.blk
: SWITCH   (S -- )   FILE @ IN-FILE @ FILE ! IN-FILE !   51 b:kernel80.blk
: T            (S n -- )    TOP  C/L *  C ;              14 b:utility.blk
: T:   (S -- )                                           13 b:meta80.blk
: T;   (S -- )                                           13 b:meta80.blk
: TARGET TARGET ;                                         5 b:meta80.blk
: TARGET-CREATE   (S -- )                                11 b:meta80.blk
: TASK:   (S size -- )                                   53 b:utility.blk
: TELEVIDEO   (S -- )   SMART                            27 b:utility.blk
: TEXT?   (S Scr# -- f )                                 45 b:utility.blk
: THEN    ?>RESOLVE                                ; IM  75 b:kernel80.blk
: THERE   (S taddr -- addr )   TARGET-ORIGIN +   ;        4 b:meta80.blk
: THRU   (S n1 n2 -- )                                    3 b:extend80.blk
: TIB     (S -- adr )   'TIB @  ;                        49 b:kernel80.blk
: TILL    (S -- )   'C#A (TILL)  'F+  DELETE ;           18 b:utility.blk
: TIMES   (S n -- )                                       6 b:utility.blk
: TO   ( #1st-source #last-source -- #1st-source #last-   8 b:utility.blk
: TOP          (S -- )      R# OFF ;                     14 b:utility.blk
: TRACE   (S Ip - )                                      51 b:utility.blk
: TRANSITION TRANSITION ;                                 5 b:meta80.blk
: TRIAD   (S n -- )                                       4 b:utility.blk
: TRIM   (S faddr voc-addr -- )                          72 b:kernel80.blk
: TVI--LINE   (S -- )   27 EMIT   ASCII R EMIT  ;        27 b:utility.blk
: TVI-AT   (S x y -- )                                   27 b:utility.blk
: TVI-BLOT   (S n -- )                                   27 b:utility.blk
: TVI-DARK   (S -- )   26 EMIT   ( CTRL Z )   ;          27 b:utility.blk
: TYPE  (S addr len -- )   0 ?DO  COUNT EMIT  LOOP   DR  46 b:kernel80.blk
: U   (S -- )   C/L C 'LINE C/L OVER #END INSERT  P ;    17 b:utility.blk
: U*D   (S n1 n2 -- d )   UM*  ;                         26 b:kernel80.blk
: U.    (S u -- )       (U.)   TYPE SPACE   ;            61 b:kernel80.blk
: U.R   (S u l -- )     >R   (U.)   R> OVER - SPACES     61 b:kernel80.blk
: U<=   (S u1 u2 -- f )   U> NOT   ;                      2 b:utility.blk
: U>=   (S u1 u2 -- f )   U< NOT   ;                      2 b:utility.blk
: UD.   (S ud -- )      (UD.)   TYPE SPACE   ;           61 b:kernel80.blk
: UD.R  (S ud l -- )    >R   (UD.)   R> OVER - SPACES    61 b:kernel80.blk
: UNDEFINED   (S -- )                                     7 b:kernel80.blk
: UNTIL   COMPILE ?BRANCH    ?<RESOLVE             ; IM  75 b:kernel80.blk
: UPDATE   (S -- )   >UPDATE ON   ;                      55 b:kernel80.blk
: USER USER   ;                                           5 b:meta80.blk
: VARIABLE    (S -- )                                    16 b:meta80.blk
: VARIABLE  (S -- )                                      15 b:meta80.blk
: VARIABLE  (S -- )                                      79 b:kernel80.blk
: VIEW   (S -- )   [ DOS ]  ' @VIEW  ?DUP                 7 b:utility.blk
: VIEW#    (S -- addr )    FILE @ 40 +   ;               56 b:kernel80.blk
: VIEW>      2+   LINK>   ;                              66 b:kernel80.blk
: VIEWS   (S n -- )   [ DOS ]                            12 b:extend80.blk
: VOCABULARY   (S -- )                                   17 b:meta80.blk
: VOCABULARY   (S -- )                                   79 b:kernel80.blk
: VOCS   (S -- )                                          5 b:extend80.blk
: W   (S -- )   SAVE-BUFFERS  ;                          16 b:utility.blk
: WHILE   [COMPILE] IF                             ; IM  75 b:kernel80.blk
: WIPE   (S -- )   'START B/BUF BLANK  MODIFIED ;        17 b:utility.blk
: WITHIN   (S n1 min max -- f )   1- BETWEEN  ;          30 b:kernel80.blk
: WORD    (S char -- addr )                              64 b:kernel80.blk
: WORDS    WORDS ;                                        5 b:utility.blk
: WORDS   (S -- )                                         5 b:utility.blk
: WRITE    (S fcb -- )                                    7 b:extend80.blk
: X   (S -- )   KEEP  'LINE #END C/L  DELETE MODIFIED ;  17 b:utility.blk
: [   (S -- )   STATE OFF   ;   IMMEDIATE                78 b:kernel80.blk
: ['] (S -- )       ' [COMPILE] LITERAL   ; IMMEDIATE    71 b:kernel80.blk
: [ASSEMBLER]    ASSEMBLER    ; IMMEDIATE                 3 b:meta80.blk
: [COMPILE]   (S -- )   ' ,   ; IMMEDIATE                71 b:kernel80.blk
: [FORTH]        FORTH   ; IMMEDIATE                      3 b:meta80.blk
: [FORWARD]   (S -- )                                    12 b:meta80.blk
: [META]         META    ; IMMEDIATE                      3 b:meta80.blk
: [TARGET]   (S -- )                                     12 b:meta80.blk
: [[   [COMPILE] [   ; FORTH IMMEDIATE META               2 b:kernel80.blk
: \   ( -- )     >IN @ NEGATE  C/L MOD  >IN +!  ; IMMED   3 b:extend80.blk
: \S   (S -- )   END? ON ;  IMMEDIATE                    64 b:kernel80.blk
: ]   (S -- )                                             8 b:kernel80.blk
: ]   (S -- )                                            78 b:kernel80.blk
: ]]   ]   ;                                              2 b:kernel80.blk


