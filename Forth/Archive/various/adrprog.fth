
( name task )                    ( use base 10 )
TASK ADRPROG                     DECIMAL

( length of record )             ( max num of records )
200 CONSTANT RECLEN              100 CONSTANT MAX-REC

( str. variable for filename )   ( initialize filename )
12 $VARIABLE ADR-FILE            $" TESTFILE.ADR" ADR-FILE $!

( variable for file handle )     ( initialize to 0 )
VARIABLE ADRHNDL                 0 ADRHNDL !

( string constant containing item delimiter )
$" |" $CONSTANT DELIM

( byte array to show if record used; 0 if record free, 1 if used )
MAX-REC CARRAY REC-USE

( initialize MAX-REC elements to zero )
0 REC-USE MAX-REC 0 FILL

255 $VARIABLE TEST$ ( string variable for search string )

\ comment after a word name shows stack contents before and after.
\ MAKE-ADR-FILE is normally used as ADR-FILE MAKE-ADR-FILE
\ and must be used at leas once to set up a file to which records
\ may be added with ENTER-ADR
: MAKE-ADR-FILE ( $adr -- )
  DUP ADR-FILE $! MAKE-OUTPUT ( store name, make file)
  ( next line vectors output to file and initializes MAX-REC number )
  ( of zeros in start of file; used to store REC-USE array )
  ( CRT vectors output back to the video screen )
  >FILE   MAX-REC 0   DO 0 EMIT LOOP   CRT   CLOSE-OUTPUT ;
\ if ADRHNDL contains less than 5 file has not been opened
: OKFILE? ( -- ) ADRHNDL @ 5 < ABORT" File not open." ;
\ returns number of first free record in file, looking at REC-USE
: FIND-FREE ( -- first-free-rec-num )
  MAX-REC 0 DO
    ( LEAVE exits loop if REC-USE entry of 0 is found, with )
    ( loop index on the stack )
    I REC-USE C@ 0=    IF I LEAVE THEN
    ( if I+1 reaches MAX-REC there is no 0 entry in REC-USE )
    MAX-REC I 1+ = ABORT" No room for record."
  LOOP ;
\ calculate offset of file pointer given record number
: FIND-PTR ( rec-num -- lo of ptr ) RECLEN 2+ * MAX-REC + ;
\ sets MS-DOS's file pointer to calculated file pointer for a record
: FIND-REC ( rec-num -- )   OKFILE?
  ( LSEEK expects lo val. of pointer, hi val. of pointer, handle )
  ( on stack, then sets MS-DOS pointer with 42 hex system function )
  ( call; DROPs needed because LSEEK returns pointer value )
  FIND-PTR 0 ADRHNDL @ LSEEK DROP DROP ;
\ puts the low value of the end of file pointer on the stack
: FIND-EOF ( -- lo of EOF ) OKFILE?
  ( LSEEK++ with 0 as lo offset, 0 as hi offset, and handle on stack )
  ( sets MS-DOS pointer to EOF and returns lo and hi value of EOF )
  0 0 ADRHNDL @ LSEEK++
  ( set pointer to SOF, drop all but lo value of EOF )
  0 0 ADRHNDL @ LSEEK DROP DROP DROP ;
\ opens for output the filename stored in ADR-FILE ; sets ADRHNDL
\ to value of handle returned by OPEN-OUTPUT
: OPEN-ADR-OUT ( -- ) ADR-FILE OPEN-OUTPUT OUTPUT @ ADRHNDL ! ;
\ if output file is open, closes it, resets ADRHNDL
: CLOSE-ADR-OUT ( -- ) OKFILE? CLOSE-OUTPUT OUTPUT @ ADRHNDL ! ;
\ same as OPEN-ADR-OUT , but for input file
: OPEN-ADR-IN ( -- ) ADR-FILE OPEN-INPUT INPUT @ ADRHNDL ! ;
\ same as CLOSE-ADR-OUT , but for input file
: CLOSE-ADR-IN ( -- ) OKFILE? CLOSE-INPUT INPUT @ ADRHNDL ! ;
\ if number of bytes put into record is greater than the
\ number in RECLEN , it is an error; ABORT
: TOOBIG? ( len of entry -- ) RECLEN > ABORT" Record full." ;
\ fetch and store item; expects number of bytes already put into
\ record on stack, asks for string input with IN$ , fetches length
\ from count byte of string, adds 1 for delimiter that will be put
\ in, ROT rotates third on stack, old record count, to top, +
\ calculates new record byte count, DUP duplicates it, TOOBIG?
\ checks for record overrun error
: @&!ITEM ( used -- new-used ) IN$ DUP C@ 1+ ROT + DUP TOOBIG?
  ( SWAP puts string addr on top of stack, >FILE $. DELIM $. CRT )
  ( vectors output to file, prints inputted string, prints end of )
  ( item marker, |, and returns output to video display )
  SWAP >FILE $. DELIM $. CRT ;
\ moves the contents of REC-USE from the file to the array
: GET-REC-USE ( -- ) OPEN-ADR-IN
  ( <FILE vectors input from file, MAX-REC GX takes first MAX-REC )
  ( bytes from the file to a string; 1+ 0 REC-USE MAX-REC CMOVE )
  ( moves the bytes into the REC-USE array; then closes file )
  <FILE MAX-REC GX KBRD 1+ 0 REC-USE MAX-REC CMOVE CLOSE-ADR-IN ;
\ moves the contents of REC-USE from the array to the file
: PUT-REC-USE ( -- ) OPEN-ADR-OUT
  ( LSEEK sets MS-DOS pointer to start of file, then )
  ( 0 REC-USE MAX-REC >FILE TYPE "types" contents to file )
  0 0 ADRHNDL @ LSEEK DROP DROP 0 REC-USE MAX-REC >FILE TYPE CRT
  CLOSE-ADR-OUT ;
\ queries user for information then puts to file
: ENTER-ADR ( -- )
  ( gets REC-USE contents from file and finds a free record number )
  GET-REC-USE FIND-FREE
  ( marks the record used by storing a 1 in the byte, puts to file )
  1 OVER REC-USE C! PUT-REC-USE
  ( open file and move MS-DOS pointer to start of record )
  OPEN-ADR-OUT  FIND-REC 0
  ( query for information and store to file )
  CR ." Name"       @&!ITEM
  CR ." Street"     @&!ITEM
  CR ." City/State" @&!ITEM
  CR ." Phone"      @&!ITEM
  CR ." Comment"    @&!ITEM
  ( fill to end of record with 255 ASCII [ignored] and close file )
  ( "printing" a CR or carriage return to file makes EOR marker )
  >FILE RECLEN SWAP - 0 DO 255 EMIT LOOP CR CRT CLOSE-ADR-OUT ;
\ LIMIT$ is an array containing the input delimiters used by parser
\ this sets 124, ASCII for |, the item delimiter, as needed in LIMIT$
: SET-DELIM 124 LIMIT$ 1 + C! 124 LIMIT$ 2 + C! 124 LIMIT$ 3 + C! ;
\ FIND-NAME accepts a string address on the stack and searches the
\ name fields of each record to see if the string is any part of a
\ name string. It then displays the record number and name string
\ that was found..
: FIND-NAME ( $addr -- )
  ( store the search string in TEST$ ; sets | delimiter for parsing )
  TEST$ $! SET-DELIM
  ( open file, vector from file, GC , get cursor, does tab )
  ( to beyond where the byte array is stored )
  OPEN-ADR-IN <FILE MAX-REC GC
  ( start search in loop; R# @ returns record number counter. If it )
  ( is zero the EOF was found so file is closed, control is returned )
  ( to the keyboard by KBRD , and message is given )
  MAX-REC 0  DO   R# @ 0=
    IF CLOSE-ADR-IN KBRD CR ." Search complete." ABORT THEN
    ( G$ parses item using delimiter in LIMIT$ ; DUP TEST$ INSTR )
    ( returns non-zero or true if search string was in parsed string )
    G$ DUP TEST$ INSTR
    ( if string found show with $. and display record was found in )
    IF CR $. ."  Found in record " I .
    ELSE DROP ( otherwise drop the address of the parsed string )
    THEN
    NR        ( go to the next record and do again with loop )
  LOOP KBRD CLOSE-ADR-IN CR ." Search complete." ;
\ SHOW-ADR expects record number on stack and displays contents
: SHOW-ADR ( rec# -- )
  ( return a true if the record is empty and abort with message )
  DUP GET-REC-USE REC-USE C@ 0= ABORT" Empty record"
  ( set up the delimiters and open the file )
  SET-DELIM OPEN-ADR-IN
  ( return a true if the needed pointer is beyond the EOF )
  DUP FIND-PTR FIND-EOF >=
  ( and if it is close the file with an error message )
  IF DROP CLOSE-ADR-IN CR ." Beyond EOF." ABORT THEN
  ( set the MS-DOS pointer to the start of record and vector input )
  FIND-REC <FILE
  ( parse 5 items and display them, then close file )
  5 0 DO CR G$ $. LOOP KBRD CLOSE-ADR-IN ;
\ DEL-ADR displays the contents of a record and asks if it should be
\ deleted. If yes, the appropriate element in REC-USE is set to 0
\ and the record is blanked by placing 5 | delimiters with nothing
\ between them in the record
: DEL-ADR ( rec# -- ) DUP SHOW-ADR
  ( KEY gets a character from the keyboard; if it is not ASCII 89 )
  ( which is Y, the function is aborted )
  CR ." Delete it (Y/N)? " KEY DUP EMIT 89 <> IF ABORT THEN
  ( get the array, store 0 as needed put it to file, find the record )
  GET-REC-USE 0 OVER REC-USE C! PUT-REC-USE OPEN-ADR-OUT FIND-REC
  ( vector output to file and write 5 consecutive delimiters )
  >FILE 5 0 DO DELIM $. LOOP CRT
  CLOSE-ADR-OUT ;


