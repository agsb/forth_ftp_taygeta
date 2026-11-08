
Part 1 of 1 of STRING.4TH
CR .( Loading STRING.4TH )
CR .( Requires -ROT, NIP, TUCK)

\ STRING.4TH                                   rdb 10/24/87
\ Last revised:                                rdb 11/07/87
\ This file contains various string stack operators and assumes
\ the existence of four words not in the Forth-83 Standard:
\ -ROT, NIP, TUCK, and LIMIT. The first three are in common
\ usage and do not need to be explained. The word LIMIT returns
\ the address of the upper limit of free user memory.


\ MAX$          -- addr
\ Contains the maximum number of strings on the string stack.

VARIABLE        MAX$


\ $0            -- addr
\ Contains a pointer to the base of the string stack.

VARIABLE        $0


\ $P            -- addr
\ Contains a pointer to the top of the string stack.

VARIABLE        $P


\ $EXACT        -- addr
\ Contains a string comparison control value. If 0, the string
\ comparison operators will match the strings over their full
\ lengths. If non-0, the string comparison operators will match
\ the strings up to the MIN of their length and the value held
\ at $EXACT.

VARIABLE        $EXACT


\ $P!           addr --
\ Sets the address of the string stack pointer.

: $P!           ( addr -- )
        $P !  ;


\ $INIT         addr n -- addr'
\ Initializes the string stack for n strings with addr as the
\ highest address to use, reserving space for one string at the
\ top of the stack and one string at the stack base, returning
\ the address addr' of the low address used.

: $INIT         ( addr n -- addr' )
        TUCK MAX$ !   256 -  DUP $0 !  DUP $P!  \ Stack base
        SWAP 1+ 256 * - DUP  MAX$ @  2+  256 *  BLANK  ;


\ 0$            $ -- $ str^
\ Returns the address of the string on top of the string stack.

: 0$           ( $ -- $ str^ )
        $P @  ;


\ 1$            1$ 0$ -- 1$ 0$ str^
\ Returns the address of the string second on the string stack.

: 1$            ( 1$ 0$ -- 1$ 0$ str^ )
        $P @  COUNT +  ;


\ 2$            2$ 1$ 0$ -- 2$ 1$ 0$ str^
\ Returns the address of the string third on the string stack.

: 2$            ( 2$ 1$ 0$ -- 2$ 1$ 0$ str^ )
        $P @  COUNT +  COUNT +  ;


\ N$            $.. n -- $.. str^
\ Returns the address of the string nth on the string stack.

: N$            ( $.. n -- $.. str^ )
        $P @  SWAP  0                           \ Start at top
 ?DO    COUNT +  DUP  $0 @  U>                  \ Get next str^
  IF    MAX$ @  $INIT  CR ." $stack underflow"  THEN
 LOOP   ;


\ $CNT          $.. n -- $.. cnt
\ Returns the count cnt for string n on the string stack.

: $CNT          ( $.. n -- $ cnt )
        N$ C@  ;


\ $DEPTH        $.. -- $.. n
\ Returns the number n of strings on the string stack.

: $DEPTH        ( $.. -- $.. n )
        $0 @  0$  U<                            \ Underflow?
 IF     MAX$ @  $INIT  0                        \ Re-init stk
 ELSE   0                                       \ At least 1
  BEGIN DUP  N$  $0 @  U<                       \ Another?
  WHILE 1+                                      \ Inc cnt
  REPEAT                                        \ n on stack
 THEN   ;


\ .$S           $.. -- $..
\ Non-destructively displays the contents of the string stack.

: .$S           ( $.. -- $.. )
        $DEPTH  0                               \ Set up loop
 ?DO    CR  I  2 .R  ASCII :  EMIT  SPACE       \ CR, then I:
        I N$ COUNT  TYPE                        \ Print string
 LOOP   CR  ;


\ .$            $ --
\ Displays and discards the top string on the string stack.

: .$            ( $ -- )
        0$ COUNT  2DUP  TYPE  +  $P!  ;


\ >$            addr cnt -- $
\ Copies cnt characters of the string at addr to the string
\ stack, converting it to a counted string.

: >$            ( addr cnt -- $ )
        TUCK 0$ OVER - DUP 1- $P! SWAP CMOVE 0$ C!  ;


\ $@            str^ -- $
\ Fetches the string pointed to by str^ to the top of the
\ string stack.

: $@            ( str^ -- $ )
        DUP C@ 1+ 0$ OVER - DUP $P!  SWAP CMOVE  ;


\ $!            $ addr --
\ Stores the string on top of the string stack as a counted
\ string at addr.

: $!            ( $ addr -- )
        0$ DUP C@ 1+  ROT  SWAP  CMOVE  $0 COUNT +  $P!  ;


\ $Z@           addr -- $
\ Returns the string $ on the string stack of the ASCIIZ
\ string at addr which is terminated by a null.

: $Z@           ( addr -- ^str )
        0  HERE 1+  ROT                         \ Move to HERE
 BEGIN  2DUP  C@ DUP  0<>                       \ Until null
 WHILE  SWAP C!  ROT 1+ ROT 1+ ROT 1+           \ Inc cnt&ptr
 REPEAT 4DROP HERE SWAP OVER C!  $@  ;          \ Return $


\ $Z!           $ addr --
\ Store the string $ on the string stack as an ASCIIZ string
\ at addr, terminated by a null.

: $Z!           ( $ addr -- )
        DUP  0$ COUNT  2DUP +  $P!              \ $DROP
        TUCK  3 PICK  CMOVE +  0 SWAP C!  ;     \ Copy, $+0


\ $VARIABLE     --              -- addr
\ Allocates memory for storage of a string. Used in the form:
\       $VARIABLE <name>
\ At compile time, $VARIABLE adds <name> to the dictionary and
\ ALLOTs memory for storage of a string in <name>'s parameter
\ field. When <name> is executed, it leaves its parameter field
\ address on the stack. The storage ALLOTed by $VARIABLE is not
\ initialized.

: $VARIABLE     ( -- )          ( -- addr )
 CREATE 256 ALLOT  ;


\ $CONSTANT     str^ --         -- $
\ Creates a string constant. Typically used in the form:
\       " <string>" $CONSTANT <name>
\ At compilet time, $CONSTANT adds <name> to the dictionary and
\ compiles the counted string <string> in <name>'s parameter
\ field. When <name> is executed, <string> is left on the 
\ string stack.

: $CONSTANT
 CREATE         ( str^ -- )
        DUP C@ 1+ TUCK HERE SWAP CMOVE ALLOT    \ Save, allot

 DOES>          ( -- $ )
        $@  ;                                   \ Get string


\ $NULL         -- $
\ Returns the null string (a zero length string) on the string
\ stack.

: $NULL         ( -- $ )
        0$ 1- $P!  0 $P @ C!  ;


\ $NULL?        $ -- $ flag
\ Returns TRUE if the string on top of the string stack is the
\ null string.

: $NULL?        ( $ -- $ f )
        0$ C@  0=  ;


\ $DROP         $ --
\ Discards the string on the top of the string stack.

: $DROP         ( $ -- )
        0$ COUNT + $P!  ;


\ $2DROP        $ $ --
\ Dicards the top two strings on the string stack.

: $2DROP        ( $ $ -- )
        0$ COUNT + COUNT + $P!  ;


\ $DUP          $ -- $$
\ Copies the string on top of the string stack to the top.

: $DUP          ( $ -- $ $ )
        0$  $@  ;


\ $2DUP         1$ 0$ -- 1$ 0$ 1$ 0$
\ Copies the top two strings on the string stack to the top.

: $2DUP         ( 1$ 0$ -- 1$ 0$ 1$ 0$ )
        0$ DUP C@ 1+ 2DUP + C@ 1+ + 2DUP - DUP $P! SWAP CMOVE ;


\ $OVER         1$ 0$ -- 1$ 0$ 1$
\ Copies the string second on the string stack to the top.

: $OVER         ( 1$ 0$ -- 1$ 0$ 1$ )
        1$  $@  ;


\ $SWAP         1$ 0$ -- 0$ 1$
\ Exchange the top two strings on the string stack.

: $SWAP         ( 1$ 0$ -- 0$ 1$ )
        1$ $@ 0$ 1$ 2DUP C@ SWAP C@ + 2+ CMOVE> $DROP ;


\ $PICK         $.. n -- $.. $n
\ Copies the nth string on the string stack to the top.

: $PICK         ( $.. n -- $.. $n )
        N$  $@  ;


\ $ROT          2$ 1$ 0$ -- 1$ 0$ 2$
\ Rotates the third string on the string stack to the top.

: $ROT          ( 2$ 1$ 0$ -- 1$ 0$ 2$ )
        2 $PICK 0$ DUP C@ 1+ OVER +             \ src dest
        0$ C@ 1+  1$ C@ 1+ +  2$ C@ 1+ +  CMOVE> $DROP  ;


\ -$ROT         2$ 1$ 0$ -- 0$ 2$ 1$
\ Rotates the top string on the string stack to the third
\ position.

: -$ROT         ( 2$ 1$ 0$ -- 0$ 2$ 1$ )
        $DUP  1$  0$                            \ src dest
        3 $CNT 1+ 2$ C@ 1+ + 1$ C@ 1+ + CMOVE   \ slide
        0$  3 N$  OVER C@ 1+  CMOVE>  $DROP ;   \ Copy/drop


\ $NIP          1$ 0$ -- 0$
\ Discards the string second on the string stack.

: $NIP          ( 1$ 0$ -- 0$ )
        1$ C@ 1+  0$  2DUP +  2 PICK  CMOVE>  0$ +  $P!  ;


\ $TUCK         1$ 0$ -- 0$ 1$ 0$
\ Copies the string on the top of the string stack to the third
\ position.

: $TUCK         ( 1$ 0$ -- 0$ 1$ 0$ )
        1$ $@ 0$ 1$ 2DUP C@ SWAP C@ + 2+ CMOVE> $DROP 1$ $@  ;


\ $CMP          1$ 0$ -- -1 | 0 | 1
\ Compares the top two strings on the stack, returning a flag.
\ If the second string 1$ is less than the first string, 0$, a
\ -1 is returned. If the second, string, 1$ is greater than the
\ first string, 0$, a 1 is returned. If the two strings are
\ equal, a 0 is returned. The comparison is exact if the $EXACT
\ is 0. If $EXACT is greater than zero, it compares the MIN of
\ the string lengths and $EXACT.

: $CMP          ( 1$ 0$ -- -1 | 0 | 1 )
        1$ COUNT  0$ COUNT  ROT SWAP            \ a2 a1 c2 c1
        2DUP >R >R  $EXACT @ ?DUP 0<>           \ Not exact?
 IF     ROT  OVER MIN  -ROT  MIN                \ Min $EXACT
 THEN   MIN  OVER + SWAP  0 -ROT                \ a2 0 a1c a1
 ?DO    DROP  DUP C@  I C@  <>                  \ Not equal?
  IF    DUP C@  I C@  <                         \ Less than?
   IF   -1  LEAVE                               \ $<
   ELSE 1  LEAVE                                \ $>
   THEN                                         \
  THEN  1+  0                                   \ Inc ptr
 LOOP   NIP  ?DUP                               \ Not equal
 IF     R> R>  2DROP                            \ Drop cnts
 ELSE   R> R>  2DUP  <>                         \ Not equal?
  IF    <                                       \ Less then?
   IF   -1                                      \ $<
   ELSE 1                                       \ $>
   THEN                                         \
  ELSE  2DROP  0                                \ $=
  THEN                                          \
 THEN   $2DROP  ;                               \


\ $=            1$ 0$ -- flag
\ Returns TRUE if the top two strings on the string stack
\ are equal.

: $=            ( 1$ 0$ -- flag )
        $CMP  0=  ;


\ $<            1$ 0$ -- flag
\ Returns TRUE if the string second on the string stack has a
\ lower ASCII value than the first.

: $<            ( 1$ 0$ -- flag )
        $CMP  -1 =  ;


\ $>            1$ 0$ -- flag
\ Returns TRUE if the string second on the string stack has a
\ greater ASCII value than the first.

: $>            ( 1$ 0$ -- flag )
        $CMP   1 =  ;


\ $WITHIN       2$ 1$ 0$ -- flag
\ Returns TRUE if the string 2$ on the string stack is greater
\ or equal to string 1$ and less or equal to string 0$.

: $WITHIN       ( 2$ 1$ 0$ -- flag )
        2 $PICK  $< NOT  $< NOT  AND  ;


\ $UPPER        $ -- $
\ Converts a string indicated by addr cnt to all upper case,
\ not affecting any other ASCII symbols.

: $UPPER        ( $ -- $ )
        0$ COUNT  OVER +  SWAP                  \ limit start
 ?DO    I C@  ASCII `  OVER  <                  \ char >= a
        OVER  ASCII {  <  AND                   \ char <= z
  IF    DUP  32 -  I C!                         \ Convert
  THEN  DROP                                    \ Drop char
 LOOP   ;


\ $LOWER        $ -- $
\ Converts a string indicated by addr cnt to all lower case,
\ not affecting any other ASCII symbols.

: $LOWER        ( $ -- )
        0$ COUNT  OVER +  SWAP                  \ limit start
 ?DO    I C@  ASCII @  OVER  <                  \ char >= A
        OVER  ASCII [  <  AND                   \ char <= Z
  IF    DUP  32 +  I C!                         \ Convert
  THEN  DROP                                    \ Drop char
 LOOP   ;


\ $CAT          1$ 0$ -- 2$
\ Concatenates the string second on the stack to the string on
\ the top of the stack.

: $CAT          ( 1$ 0$ -- 2$ )
        0$ C@  1$ C@  +                         \ New cnt
        0$ COUNT  OVER 1+  SWAP  CMOVE>         \ Slide string
        0$ 1+ $P!  0$ C!  ;                     \ Adj ptr, cnt


\ $LEFT         0$ l -- 1$
\ Extracts a string 1$ of length l from the string 0$ on the
\ string stack, starting with the first character. The length
\ of 1$ is the MIN of the length l with the length of 0$.

: $LEFT         ( 0$ l -- 1$ )
        0$ C@  OVER -  DUP  0>                  \ #Drop > 0?
 IF     0$  2DUP +  3 PICK  1+  CMOVE>          \ Slide l chrs
        0$ +  DUP  $P!  C!                      \ Adj ptr, cnt
 ELSE   2DROP  THEN  ;                          \ Do nothing


\ $RIGHT        0$ l -- 1$
\ Extracts a string 1$ of length l from the string 0$ on the
\ string stack, starting from the last character. The length of
\ 1$ is the MIN of the length l with the length of 0$.

: $RIGHT        ( 0$ l -- 1$ )
        0$ C@  TUCK  MIN  TUCK -  0$ +  $P!  0$ C!  ;


\ $MID          0$ o l -- 1$
\ Extracts a string 1$ of offset o and length l from string 0$
\ on the string stack. If the offset o is greater than the
\ length of the string S1, the null string is returned as 1$.
\ The length of 1$ is the MIN of the length l with the length of
\ 0$ minus the offset o.

: $MID          ( 0$ o l -- 1$ )
        0$ C@  ROT  -  DUP  0>          \ o less than len?
 IF     $RIGHT  0$ C@  MIN  $LEFT       \ Extract string
 ELSE   2DROP  $DROP  $NULL  THEN  ;    \ Return null string


\ $INC          0$ -- 1$
\ Increments the lexicographical value of the string 0$ on the
\ string stack, returning 1$.

: $INC          ( 0$ -- 1$ )
        0$ COUNT  ?DUP                  \ Check for null
 IF     1- +  DUP  C@  DUP  255 <       \ Less than max?
  IF    1+  SWAP  C!                    \ Inc char val
  ELSE  2DROP  0$ 1-  1 OVER C!         \ Make a 1 char str
        1- 1 OVER C!  $P!  $SWAP  $CAT  \ Append it
  THEN                                  \
 ELSE   1- 1 OVER C!  1- 1 OVER C!  $P! \ 1 char string
 THEN   ;


\ $DEC          0$ -- 1$
\ Increments the lexicographical value of the string 0$ on the
\ string stack, returning 1$. If 0$ is the null string, no
\ action is taken.

: $DEC          ( 0$ -- 1$ )
        0$ COUNT  ?DUP                  \ Check for null
 IF     1- +  DUP  C@  DUP  0 >         \ Greater than null?
  IF    1-  SWAP  C!                    \ Dec char val
  ELSE  DROP  0$ C@  DUP  1 >           \ Count > 1?
   IF   1- $LEFT  255 0$ COUNT + 1- C!  \ Set last char to 255
   ELSE 2DROP  $DROP  $NULL  THEN       \ Return null string
  THEN                                  \
 THEN   ;


\ $TRAILING-    0$ -- 1$
\ Discards trailing spaces from the string 0$ on the string
\ stack, returning the string 1$.

: $TRAILING-    ( 0$ -- 1$ )
        0$ COUNT  -TRAILING  NIP  $LEFT  ;


\ $TRAILING+    0$ n -- 1$
\ Appends n trailing spaces to the string 0$ on the string
\ stack, returning the string 1$.

: $TRAILING+    ( 0$ n -- 1$ )
        PAD OVER 1+ BLANK  PAD C!  PAD $@  $SWAP  $CAT  ;


\ $LEADING-     0$ -- 1$
\ Discards leading spaces from the string 0$ on the string
\ stack, returning the string 1$.

: $LEADING-     ( 0$ -- 1$ )
        0$ COUNT  0  TUCK               \ addr 0 cnt 0
 ?DO    DROP  DUP C@  32 <>             \ If not a blank
  IF    I  LEAVE                        \ Leave offset
  THEN  1+  0                           \ Inc addr, flag
 LOOP   NIP  ?DUP                       \ Something there?
 IF     0$ C@  SWAP  -  $RIGHT          \ -LEADING
 THEN   ;                               \ No leading blanks

\ $LEADING+     0$ n -- 1$
\ Appends n leading spaces to the string 0$ on the string
\ stack, returning the string 1$.

: $LEADING+     ( 0$ n -- 1$ )
        PAD OVER 1+ BLANK  PAD C!  PAD $@  $CAT  ;


\ D>$           d -- $
\ Converts the double precision integer d to the string $ on
\ the string stack.

: D>$           ( d -- $ )
        DUP >R  <# #S R> SIGN #>  >$  ;


\ F>$           fp -- $
\ Converts the floating point value fp to the string $ on the
\ string stack.

: F>$           ( fp -- $ )
;


\ $>D           $ -- d n
\ Converts the string $ on the string stack to the double
\ precision integer d, using the current radix, and the
\ conversion count n. If all characters in the string $ are
\ converted, the flag is -1. If the string $ is partially
\ converted, n is the number of characters that converted.
\ If n is 0, the value of d is undefined.
\
\ The position of the decimal point is placed in the variable
\ DPL. If no decimal point was present, DPL will contain the
\ value -1. If either hardware or software floating point
\ extensions have been loaded, the action of $>D and the value
\ in DPL may vary from this description.

: $>D           ( $ -- d n )
        BASE @ >R  -1 DPL !  0$ COUNT  0 TUCK   \ Set up scan
 ?DO    OVER C@ DUP ASCII 0 < SWAP ASCII 9 > OR \ 0 > c > F?
  IF    LEAVE                                   \ Get out
  THEN  1+ SWAP 1+ SWAP                         \ Inc cnt&addr
 LOOP   NIP  0$ C@  OVER =                      \ Pure number?
 IF     DROP  -1                                \ Don't adjust
 ELSE   DUP  $LEFT                              \ Extract num
 THEN   0$  NUMBER?                             \ Convert
 IF     ROT                                     \ Offset
 ELSE   ROT  DROP  0                            \ Didn't go
 THEN   $DROP  R> BASE !  ;                     \ Restore base


\ $CONTAINS     1$ 0$ -- o
\ Returns the 1 based offset into the second string, 1$, on the
\ string stack of the first position matching the pattern of
\ the first string 0$. If 0$ is not a subset of 1$, 0 is
\ returned.

: $CONTAINS     ( 1$ 0$ -- o )
        1$ COUNT  0 TUCK                        \ Set up loop
 ?DO    DROP  0$ C@  1$ C@ I -  >               \ Run out?
  IF    0  LEAVE                                \ Not subset
  THEN  DUP C@  0$ 1+ C@  =                     \ First char=?
  IF    DUP  -1  0$ COUNT OVER + SWAP           \ Flag, indices
   ?DO  DROP  DUP C@  I C@  <>                  \ Not equal?
    IF  0  LEAVE                                \ Get out
    THEN 1+  -1                                 \ Inc ptr, flag
   LOOP NIP                                     \ Drop addr
   IF   1$  - DUP  LEAVE                        \ Offs (1based)
   THEN                                         \
  THEN  1+  0                                   \ Try next char
 LOOP   NIP  $2DROP  ;                          \ Leave offset


\ $VERIFY       1$ 0$ -- o
\ Returns the 1 based offset into the second string on the
\ string stack of the first position differing from the pattern
\ of the first string.  The strings are compared up to the MIN
\ of their counts.

: $VERIFY       ( 1$ 0$ -- o )
        1$ COUNT  0$ COUNT  ROT  MIN  0 TUCK    \ a2 a1 0 c 0
 ?DO    DROP  OVER C@  OVER C@  <>              \ Not equal?
  IF    I 1+  LEAVE                             \ Get out w/o
  THEN  1+ SWAP 1+  0                           \ Inc ptrs
 LOOP   -ROT  2DROP  $2DROP  ;                  \ Return offset


\ $PARSE        1$ 0$ -- 3$ 2$
\ Parses the string 1$ for the string 0$, returning the parsed
\ string 2$, without the string 0$, and the remaining string
\ 3$, without the string 0$. If no instances of the string 0$
\ are found, string 2$ is the null string and string 3$ is 0$.

: $PARSE        ( 1$ 0$ -- 3$ 2$ )
        $2DUP  $CONTAINS  ?DUP                  \ Find pos
 IF     1-  0$ C@  $DROP  $DUP  OVER +          \ Offset to 3$
        0$ C@  SWAP -  $RIGHT  $SWAP  $LEFT     \ Make 3$ & 2$
 ELSE   $DROP  $NULL                            \ Not found
 THEN   ;


\ $SOUNDEX      0$ -- 1$
\ Computes the soundex code string 1$ of the string 0$ on the
\ string stack. The soundex code is in the range 0 => s => 9999.

: C>SNDX        ( c1 -- c2 )
        64 -  DUP  0<  OVER  27 <  OR           \ In range?
 IF     " 01230120022455012623010202"  + C@     \ Get code
        ( ABCDEFGHCJKLMNOPQRSTUVWXYZ)           \ Corresponding
 ELSE   DROP  ASCII 0                           \ Not char
 THEN   ;

: $SOUNDEX      ( 0$ -- 1$ )
        $UPPER  1 HERE C!  0$ COUNT  0>         \ Not null?
 IF     C@                                      \ Get char
 ELSE   DROP  ASCII 0                           \
 THEN   HERE 1+ C!  0$ C@  1 >                  \ Store 1st chr
 IF     0$ 1+ C@ C>SNDX 0$ COUNT OVER + SWAP 1+ \ Rest of $
  ?DO   I C@ C>SNDX TUCK = OVER ASCII 0 = OR 0= \ Not =|0
   IF   DUP HERE COUNT + C! HERE DUP C@ 1+ SWAP C! THEN
  LOOP  DROP                                    \ Run thru 0$
 THEN   $DROP " 000" $@ HERE $@ $CAT 4 $LEFT ;  \ 4char code


\ $MATCH        1$ 0$ -- flag
\ Returns TRUE if the string 1$ on the string stack matches the
\ pattern of 0$. The pattern of 0$ may consist of the pattern
\ codes of C, G, N, P, A, L, U, E, ", or '. If the pattern code
\ is a ", the following character is taken as a literal value.
\ The pattern is the union of the pattern codes in 0$.
\
\ The significance of the pattern codes are:
\       C       33 Control characters, including DEL
\       G       128 Graphic characters above DEL
\       N       10 Numeric characters
\       P       33 Punctuation characters, including SP
\       A       52 Alphabetic characters
\       L       26 Lower-case alphabetic characters
\       U       26 Upper-case alphabetic characters
\       E       Everything non-graphic
\       "       The following character is present
\       '       The following character is not present

\ Implementation note:  This is a very long which would
\ normally be divided into much smaller words. In this case,
\ however, further decomposition would make it more clumsy.

: $MATCH        ( 1$ 0$ -- flag )
        -1  0$ COUNT  OVER +  SWAP              \ Flag, do 0$
 ?DO    I C@                                    \ Get pattern
  CASE  ASCII C                                 \ Control?
  OF    -1  1$ COUNT  OVER +  SWAP              \
   ?DO  I C@  DUP  32 <  SWAP  127 =  OR NOT    \
    IF  DROP   0  LEAVE                 THEN    \
   LOOP AND  DUP 0=                             \
   IF   LEAVE                           THEN    \
  ENDOF ASCII G                                 \ Graphic?
  OF    -1  1$ COUNT  OVER +  SWAP              \
   ?DO  I C@  128 <                             \
    IF  DROP   0  LEAVE                 THEN    \
   LOOP AND  DUP 0=                             \
   IF   LEAVE                           THEN    \
  ENDOF ASCII N                                 \ Numeric?
  OF    -1  1$ COUNT  OVER +  SWAP              \
   ?DO  I C@ DUP  ASCII 0 < SWAP ASCII 9 > OR   \
    IF  DROP   0  LEAVE                 THEN    \
   LOOP AND  DUP 0=                             \
   IF   LEAVE                           THEN    \
  ENDOF ASCII P                                 \ Punctuation?
  OF    -1  1$ COUNT  OVER +  SWAP              \
   ?DO  I C@  DUP     31 > OVER ASCII 0 < AND   \
        SWAP DUP ASCII 9 > OVER ASCII A < AND   \
        SWAP DUP ASCII Z > OVER ASCII a < AND   \
        SWAP DUP ASCII z > SWAP 127 < AND OR OR OR \
    IF  DROP   0  LEAVE                 THEN    \
   LOOP AND  DUP 0=                             \
   IF   LEAVE                           THEN    \
  ENDOF ASCII A                                 \ Alphabetic?
  OF    -1  1$ COUNT  OVER +  SWAP              \
   ?DO  I C@ DUP ASCII @ > OVER ASCII [ < AND   \
        SWAP DUP ASCII ` > SWAP ASCII { < AND OR NOT \
    IF  DROP   0  LEAVE                 THEN    \
   LOOP AND  DUP 0=                             \
   IF   LEAVE                           THEN    \
  ENDOF ASCII L                                 \ Lower case?
  OF    -1  1$ COUNT  OVER +  SWAP              \
   ?DO  I C@ DUP ASCII a < SWAP ASCII z > OR    \
    IF  DROP   0  LEAVE                 THEN    \
   LOOP AND  DUP 0=                             \
   IF   LEAVE                           THEN    \
  ENDOF ASCII U                                 \ Upper case?
  OF    -1  1$ COUNT  OVER +  SWAP              \
   ?DO  I C@ DUP ASCII A < SWAP ASCII Z > OR    \
    IF  DROP   0  LEAVE                 THEN    \
   LOOP AND  DUP 0=                             \
   IF   LEAVE                           THEN    \
  ENDOF ASCII E                                 \ Not graphic?
  OF    -1  1$ COUNT  OVER +  SWAP              \
   ?DO  I C@  127 >                             \
    IF  DROP   0  LEAVE                 THEN    \
   LOOP AND  DUP 0=                             \
   IF   LEAVE                           THEN    \
  ENDOF ASCII "                                 \ Literal?
  OF    0  1$ COUNT  OVER +  SWAP               \
   ?DO  I C@  J 1+ C@  =                        \
    IF  DROP  -1  LEAVE                 THEN    \
   LOOP AND  DUP 0=                             \
   IF   LEAVE                           THEN    \
  ENDOF ASCII '                                 \ Literal NOT?
  OF    -1  1$ COUNT  OVER +  SWAP              \
   ?DO  I C@  J 1+ C@  =                        \
    IF  DROP   0  LEAVE                 THEN    \
   LOOP AND  DUP 0=                             \
   IF   LEAVE                           THEN    \
  ENDOF                                         \
  ENDCASE                                       \
 LOOP   $2DROP  ;                               \ leave flag


\ >$YYYYMMDD    y md -- $
\ Converts the standard date format integers y md to a date
\ string in the format yyyymmdd.

: >$YYYYMMDD    ( y md -- $ )
        SWAP     0 <# # # # # #> HERE 1+  SWAP CMOVE
        256 /MOD 0 <# # # #>     HERE 5 + SWAP CMOVE
                 0 <# # # #>     HERE 7 + SWAP CMOVE
        HERE 8 OVER C!  $@  ;


\ $YYYYMMDD>    $ -- y md
\ Converts the date string in the format yyyymmdd to the
\ standard date format integers y md.

: $YYYYMMDD>    ( $ -- y md )
        $DUP  4 $LEFT  0$ NUMBER? NIP 0=        \ yyyy?
 IF     DROP  0                                 \ 0 year
 THEN   $DROP  $DUP  4 2 $MID 0$ NUMBER? NIP 0= \ mm?
 IF     DROP  0                                 \ 0 month
 THEN   256 *  $DROP 2 $RIGHT 0$ NUMBER? NIP 0= \ dd?
 IF     DROP  0                                 \ 0 day
 THEN   $DROP  +  ;


\ >$MM/DD/YY    y md -- $
\ Converts the standard date format integers y md to a date
\ string in the format mm/dd/yy.

: >$MM/DD/YY     ( y md -- $ )
        256 /MOD 0 <# ASCII / HOLD # # #> HERE 1+  SWAP CMOVE
                 0 <# ASCII / HOLD # # #> HERE 4 + SWAP CMOVE
        1900 -   0 <# # # #>              HERE 7 + SWAP CMOVE
        HERE 8 OVER C!  $@  ;


\ $MM/DD/YY>    $ -- y md
\ Converts the date string in the format mm/dd/yy to the
\ standard date integers y md.

: $MM/DD/YY>    ( $ -- y md )
        $DUP  2 $RIGHT  0$ NUMBER? NIP 0=       \ yy?
 IF     -1900                                   \ 0 year
 THEN   1900 +                                  \ This century
        $DROP $DUP 2 $LEFT  0$ NUMBER? NIP 0=   \ mm?
 IF     0                                       \ 0 month
 THEN   256 *                                   \ Shift left 8b
        $DROP 3 2 $MID  0$ NUMBER? NIP 0=       \ dd?
 IF     0                                       \ 0 day
 THEN   $DROP  +  ;                             \


\ >$JULIAN      y md -- $
\ Converts the standard date format integers y md to the julian
\ date of the string $. The julian date is a day offset from
\ the first day of the year 1460.

: >$JULIAN      ( y md -- $ )
        SWAP  1752 -  DUP  4 /                  \ #leap years
        SWAP  365 M*  ROT S>D  D+               \ y > j
        ROT   256 /MOD  >R  S>D  D+  R>         \ d+y month
 CASE    1 OF   0  ENDOF                        \ January   31
         2 OF  31  ENDOF                        \ February  28
         3 OF  59  ENDOF                        \ March     31
         4 OF  90  ENDOF                        \ April     30
         5 OF 120  ENDOF                        \ May       31
         6 OF 151  ENDOF                        \ June      30
         7 OF 181  ENDOF                        \ July      31
         8 OF 212  ENDOF                        \ August    31
         9 OF 243  ENDOF                        \ September 30
        10 OF 273  ENDOF                        \ October   31
        11 OF 304  ENDOF                        \ November  30
        12 OF 334  ENDOF                        \ December  31
 ENDCASE S>D  D+  D>$  ;                        \ y md>julian


\ $JULIAN>      $ -- y md
\ Converts the julian date of the string $ to the standard date
\ format integers y md. The julian date is a day offset from
\ the first day of the year 1460.

: $JULIAN>      ( $ -- y md )
        $>D DROP 2DUP 365 M/MOD NIP 4 /MOD SWAP \ j #leap leap?
 IF     0   ELSE  1                             \ 1=leap this y
 THEN   >R S>D D- 365 M/MOD 1752 + SWAP DUP 32 < \ y #d f  RS=f
 IF     R> DROP  256 +          EXIT            \ January?
 THEN   DUP  60 R@ + <                          \ February?
 IF     R> DROP  31 -  512 +    EXIT            \
 THEN   R> -  DUP  91 <                         \ March?
 IF     59 -  768 +             EXIT            \
 THEN   DUP  121 <                              \ April?
 IF     90 -  1024 +            EXIT            \
 THEN   DUP  152 <                              \ May?
 IF     120 -  1280 +           EXIT            \
 THEN   DUP  182 <                              \ June?
 IF     151 -  1536 +           EXIT            \
 THEN   DUP  213 <                              \ July?
 IF     181 -  1792 +           EXIT            \
 THEN   DUP  244 <                              \ August?
 IF     212 -  2048 +           EXIT            \
 THEN   DUP  274 <                              \ September?
 IF     243 -  2304 +           EXIT            \
 THEN   DUP  305 <                              \ October?
 IF     273 -  2560 +           EXIT            \
 THEN   DUP  335 <                              \ November?
 IF     304 -  2816 +           EXIT            \
 THEN   334 -  3072 +           ;               \ December


\ >$HH:MM:SS:DD hm ds -- $
\ Converts the time integers hm ds to a time string in the
\ 24 hour format hh:mm:ss:dd.

: >$HH:MM:SS:DD ( hm ds -- $ )
        DUP  255 AND 0 <# # # ASCII : HOLD #> >$      \ Decisecs
             256 /   0 <# # # ASCII : HOLD #> >$ $CAT \ Seconds
        DUP  255 AND 0 <# # # ASCII : HOLD #> >$ $CAT \ Minutes
             256 /   0 <# # # #>              >$  $CAT  ; \ Hrs


\ $HH:MM:SS:DD> $ -- hm ds
\ Converts the time string in the 24 hour format hh:mm:ss:dd to
\ the time integers hm ds.

: $HH:MM:SS:DD> ( $ -- hm ds )
        $DUP $>D 1+ 0$ C@ SWAP - $RIGHT DROP 256 * \ Hours
        $DUP $>D 1+ 0$ C@ SWAP - $RIGHT DROP +     \ Minutes
        $DUP $>D 1+ 0$ C@ SWAP - $RIGHT DROP 256 * \ Seconds
             $>D 2DROP +  ;                        \ Decisecs

        $DUP  4 $LEFT
