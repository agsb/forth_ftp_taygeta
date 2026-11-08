
( Stream data and text read and write )
These utilities read and write streams of data and text from
standard or BLOCKed files.

Text lines are read into the user buffer until either the buffer
is full, or the file is empty, or an #EOF or #EOL is read.
The terminating #EOF or #EOL , if present, is not read into the
buffer.  #LF ( linefeeds) are read but ignored.

Output files are assumed to be extensible.

For your convenience, the Standard Prelude and DDJ Controlled
Reference Word Set are duplicated in this file.



( LOAD screen for DDJ Standard Prelude and String Extension)
( MJT  Nov 22 1987 for DDJ February 1987)

(     2 LOAD ( Standard prelude)
      3 LOAD ( Augmented interpretation)
   4  5 THRU ( Controlled words)
   6  9 THRU ( Strings)
  10 13 THRU ( General file support)
\    14 LOAD ( Read and write data files)
  15 16 THRU ( Read and write BLOCKed data files)
     17 LOAD ( Read text file, no   #EOL)
\    18 LOAD ( Read text file, with #EOL)
     19 LOAD ( Write text file)
  20 22 THRU ( Some examples)


( FORTH-83 functions-- typical definitions)
( Adjust these words for your Forth.    See DDJ Oct 1987.)
( Note: functions already provided need not be redefined.)
: RECURSE   [COMPILE] MYSELF ;  IMMEDIATE
: INTERPRET   INTERPRET ;

: I> ( - 'data)   COMPILE R> ;  IMMEDIATE
: >I ( - 'data)   COMPILE >R ;  IMMEDIATE

( Used for alignment: )
: ALIGN    ( HERE 1 AND ALLOT) ;
: REALIGN  ( a - a' )  ( DUP 1 AND +) ;

2 CONSTANT CELL   : CELL+   2+ ;    : CELLS   2* ;

: UNDO   I> R> R> 2DROP >I ;  \ Undoes a DO-- LOOP.
( Required definitions - used to support further compilation)

: THRU ( n n2)   1+ SWAP DO  I LOAD  LOOP ;
\ LOADS screens n through n2.

: \   >IN @ 64 + -64 AND >IN ! ;  IMMEDIATE
\ comment to end of line.  For use in screens only.

: \\   1024 >IN ! ;  IMMEDIATE
\ stops interpreting or compiling screen immediately.

: \IF ( f )   0= IF  [COMPILE] \  THEN ;  IMMEDIATE
\ conditional interpretation or compilation.

: NEED ( - f)   32 ( ie blank) WORD FIND  SWAP DROP  0= ;
\ true if the following word is in the search order.
\ FORTH-83 Controlled Words

NEED  2* \IF  :  2*    DUP  + ;
NEED D2* \IF  : D2*   2DUP D+ ;

NEED HEX \IF  : HEX   16 BASE ! ;
NEED  C, \IF  : C, ( n )   HERE 1 ALLOT C! ;

NEED BL \IF  32 CONSTANT BL

NEED ERASE \IF  : ERASE ( a n)   00 FILL ;
NEED BLANK \IF  : BLANK ( a n)   BL FILL ;

NEED .R \IF  : .R ( n width)   >R DUP 0< R> D.R ;


\ DDJ Forth Column Controlled Words
NEED 2>R
\IF : 2>R   COMPILE SWAP COMPILE >R COMPILE >R ;  IMMEDIATE
NEED 2R>
\IF : 2R>   COMPILE R> COMPILE R> COMPILE SWAP ;  IMMEDIATE
NEED @EXECUTE \IF  : @EXECUTE   @ EXECUTE ;

NEED AGAIN
\IF  : AGAIN   0 [COMPILE] LITERAL [COMPILE] UNTIL ;  IMMEDIATE
NEED DLITERAL
DUP \IF  : DLITERAL  SWAP [COMPILE] LITERAL [COMPILE] LITERAL ;
    \IF   IMMEDIATE

NEED S>D  \IF  : S>D  ( n - d)    DUP 0< ;
NEED WITHIN   \IF  : WITHIN ( n n2 n3 - f)  OVER - >R - R> U< ;
NEED TRUE \IF  -1 CONSTANT TRUE
\ String operators    See  DDJ  December 1987
\ Only  /STRING  and  EVAL  are used in this application.

: /STRING ( a n n2 - a+n2 n-n2)   ROT OVER +  ROT ROT - ;
\ truncates leftmost n chars of string.  n may be negative.

: EVAL ( a n )
\ evaluates ("text interprets") a string.
   DUP >R  TIB SWAP CMOVE  R@ #TIB !
   0 >IN ! 0 BLK !  INTERPRET  R> >IN ! ;






\\ String operators from  STRINGS.ARC  are summarized here:

ASCII ( - c)       \ returns value of following character.
CTO"" ( c - a 1)   \ converts character to string.

SKIP ( a l c - a2 l2)
\ returns shorter string from first position unequal to byte.
SCAN ( a l byte - a2 l2)
\ returns shorter string from first position equal to byte.

" ( - a n)     \ STATE-smart string literal.





\\ String operators from  STRINGS.ARC  continue here:
VAL? ( a n - d 2 , n2 1 , 0)
\ string to number conversion primitive.  True if d is valid.
\ Returns d if number contains ",-./:"  and sets DPL = 0
\ Returns n if no punctuation present   and sets DPL = 0<

VAL ( a n - d f)
\ converts string to double number.  True if number is valid.
\ If number contains ",-./:" then sets DPL = 0
\ If no punctuation present  then sets DPL = 0<

-TEXT ( a n a2 - -1 , 0 , 1)
\ returns -1 if string a n < a2 n , 0 if equal, and 1 if >.

COMPARE  ( a n a2 n2 - -1 , 0 , 1)
\ returns -1 if a n < a2 n2 , 0 if equal, and 1 if >.
\ The corrected version of  MATCH

: MATCH ( a n a2 n2 - ???? 0 , offset -1)
\ returns the position of string a2 n2 in (a n).
\ Offset is zero if ( a n ) is found in first char position.
\ Returns false with invalid offset if ( a n ) isn't in a2 n2.
   DUP 0= IF  2DROP 2DROP   0 TRUE EXIT  THEN
   2SWAP  2 PICK OVER SWAP -
   DUP 0< IF  2DROP 2DROP   0 EXIT  THEN
   0   ( index ) SWAP 1+ 0
   DO  ( index ) >R
     2OVER 2OVER DROP  -TEXT 0=  ( equal? )
     IF  2DROP 2DROP  R> TRUE  UNDO EXIT  THEN
     1 /STRING   R> 1+
   LOOP  2DROP 2DROP  0 ;

\ Data stream general support
1024 CONSTANT 1K

: UMIN ( u u2 - u3)   2DUP U< 0= IF  SWAP  THEN  DROP ;

\ Adjust these constants for your system:
10 CONSTANT #LF    \ linefeed character.
13 CONSTANT #EOL   \ end-of-line character.
26 CONSTANT #EOF   \ end of file character (control-Z).

\ Adjust end-of-line and end-of-file sequence for your system:
CREATE ENDLINE   2 ( count) C,  #EOL C, #LF C,
CREATE ENDFILE   1 ( count) C,  #EOF C,



\ File size and position
\ Example of some of the structure of a file control block:

\ VARIABLE FCB   HERE FCB !  5 CELLS ALLOT  ( Containing: )
\    1 cell   current file handle-- ie selects current file.
\    2 cells  current file size in bytes (double number).
\    2 cells  current file position      (double number).

\\ You can implement CAPACITY and POSITION as 2VARIABLES.
\\ You must initialize CAPACITY to the size of your file.

2VARIABLE POSITION
2VARIABLE CAPACITY  ( eg  DSIZE CAPACITY 2! )



\ Set and reset file position
\ Given POSITION you can control the position of file access:

: MARKDATA ( - d)   POSITION 2@ ;
\ determines the position of the current file.

: SEEKDATA ( d )    POSITION 2! ;
\ changes the position of the current file.








\ Extend the file
\ If your Forth or operating system requires explicit extension,
\ supply an appropriate definition for  EXTEND .
\ Otherwise, use  : EXTEND ( d ) COMPILE 2DROP ;  IMMEDIATE

: EXTEND ( d ) COMPILE 2DROP ;  IMMEDIATE

\\
: EXTEND ( d )
\ properly extends current file by  d  bytes.
\ This example converts  d  to blocks and calls a MORE function.
   1K UM/MOD  SWAP IF  1+  THEN ( # of blocks to extend ) MORE ;




\ Read and write data files directly

: GETDATA ( a n - n2)   ;
\ reads n bytes of data from input file into address, n < 64K
\ Returns n2 bytes not read ( ie beyond end of file ).
\ Implement as a system call using CAPACITY and POSITION

: PUTDATA ( a n)   ;
\ writes n bytes of data to output file from address, n < 64K
\ Implement as a system call using CAPACITY POSITION and EXTEND






\ Read BLOCKed file as data file

: GETDATA ( a n - n2)
\ reads n bytes of data from input file into address, n < 64K
\ Returns n2 bytes not read ( ie beyond end of file ).
   ( calculate # of bytes to move < 64K : )  POSITION 2@
   BEGIN  2 PICK ( n ) DUP
     IF ( n ) >R  2DUP 1K UM/MOD  SWAP DROP  1+  1K UM*
        CAPACITY 2@ DMIN  2OVER D- 0= NOT OR  R> UMIN
     THEN  ?DUP
   WHILE  >R  2DUP 1K UM/MOD  BLOCK +  4 PICK R@ CMOVE
     R@ 0 D+  2SWAP  R> /STRING  2SWAP
   REPEAT  POSITION 2!  SWAP DROP ;



\ Write BLOCKed file as data file

: PUTDATA ( a n)
\ writes n bytes of data to output file from address, n < 64K
   ( extend the file as needed : )
   DUP 0  POSITION 2@ D+  CAPACITY 2@  2SWAP D-  DUP 0<
   IF  2DUP EXTEND  2OVER CAPACITY 2!  THEN  2DROP
   ( calculate # of bytes to move < 64K : )  POSITION 2@
   BEGIN  2 PICK ( n ) DUP
     IF ( n ) >R  2DUP 1K UM/MOD  SWAP DROP  1+  1K UM*
        CAPACITY 2@ DMIN  2OVER D- 0= NOT OR  R> UMIN
     THEN  ?DUP
   WHILE  >R  2DUP 1K UM/MOD  BLOCK +  4 PICK SWAP R@ CMOVE
     R@ 0 D+  2SWAP  R> /STRING  2SWAP   UPDATE
   REPEAT  POSITION 2!  2DROP ;

\ Read text file with #EOF

: GETTEXT ( a n - n2 f)
\ reads n bytes of text from input file into address, n < 64K
\ Returns n2 bytes not read ( ie end-of-line or beyond file)
\ Returns true if #EOL terminates line; false otherwise.
   POSITION 2@  CAPACITY 2@  2OVER D- 0= NOT OR ( limit to 64K)
   3 PICK UMIN  ?DUP 0= IF  2DROP SWAP DROP  0 EXIT  THEN  0
   DO  2DUP 1 0 D+  2SWAP 1K UM/MOD  BLOCK + C@ ( read a char )
      DUP #EOL = OVER #EOF = OR
      IF  >R  POSITION 2!  SWAP DROP  R> #EOL = UNDO EXIT  THEN
      DUP #LF -  ( a n dpos ch f )
      IF  >R  2SWAP  R@ 2 PICK C!  1 /STRING  2SWAP  R> THEN
      DROP
   LOOP  POSITION 2!  SWAP DROP  0 ;

\ Read text file without #EOF

: GETTEXT ( a n - n2 f)
\ reads n bytes of text from input file into address, n < 64K
\ Returns n2 bytes not read ( ie end-of-line or beyond file)
\ Returns true if #EOL terminates line; false otherwise.
   POSITION 2@  CAPACITY 2@  2OVER D- 0= NOT OR ( limit to 64K)
   3 PICK UMIN  ?DUP 0= IF  2DROP SWAP DROP  0 EXIT  THEN  0
   DO  2DUP 1 0 D+  2SWAP 1K UM/MOD  BLOCK + C@ ( read a char )
      DUP #EOL =
      IF  >R  POSITION 2!  SWAP DROP  R> #EOL = UNDO EXIT  THEN
      DUP #LF -  ( a n dpos ch f )
      IF  >R  2SWAP  R@ 2 PICK C!  1 /STRING  2SWAP  R> THEN
      DROP
   LOOP  POSITION 2!  SWAP DROP  0 ;

\ Read and write lines of text

: GETLINE ( a n - a n2 f)
\ reads n bytes of text from input file into address, n < 64K
\ n2 bytes are actually read; this is the opposite of GETTEXT
\ Returns true if #EOL terminates line; false otherwise.
   2DUP GETTEXT >R  -  DUP 0= 0=  R> OR ;

: PUTLINE ( a n )   PUTDATA  ENDLINE COUNT PUTDATA ;
\ writes n bytes of data to output file from address, n < 64K




\ Text stream examples

: TYPE-FILE   \ reads and prints the input text file.
\ Assumes zero-length string TYPEs nothing.
   SWITCH ( to input file saving currently active file)
   BEGIN  PAD 80  GETLINE ( n2 f)
   WHILE  CR TYPE  REPEAT  2DROP
   SWITCH ( back to current file) ;

: COPY-FILE
\ copies the input text file to the output text file.
\ Save and restore current file as needed.
   BEGIN  SWITCH ( to input  file)  PAD 80 GETLINE
          SWITCH ( to output file)
   WHILE  PUTLINE  REPEAT  2DROP  ENDFILE COUNT PUTDATA ;

\ Text stream examples
: BLOCK-TO-TEXT
\ copies the input BLOCK file to the output text file.
\ Save and restore current file as needed.
   BEGIN  SWITCH ( to input  file)  PAD 64 GETLINE
          SWITCH ( to output file)
   WHILE  -TRAILING  PUTLINE
   REPEAT  2DROP  ENDFILE COUNT PUTDATA ;

: TEXT-TO-BLOCK   0 ( previous line length )
\ copies the input text file to the output BLOCK file.
   BEGIN  SWITCH ( to input  file)
          PAD  64  2DUP BLANK  GETLINE  ROT ( a ) DROP
          SWITCH ( to output file)
   WHILE  DUP 0= ROT 64 = AND NOT IF  PAD 64 PUTDATA  THEN
   REPEAT  2DROP ;
\ Text stream examples

: EVAL-FILE   \ reads and interprets the input text file.
\ Assumes zero-length interpreted string does nothing.
   SWITCH ( to input file saving currently active file)
   BEGIN  PAD 80  GETLINE ( n2 f)
   WHILE  EVAL  REPEAT  2DROP
   SWITCH ( back to current file) ;


