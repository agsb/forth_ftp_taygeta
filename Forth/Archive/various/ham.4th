
Listing One:  tiny tools


: NIP  ( n m - m )     SWAP DROP ;  ( drops second on stack  )
: TUCK ( n m - m n m ) SWAP OVER ;  ( tucks top under second )
: -ROT ( a b c - c a b ) ROT ROT ;  ( opposite of ROT )     

: INCR ( a - )  1 SWAP +! ;   ( increments a variable )
: DECR ( a - ) -1 SWAP +! ;   ( decrements a varaible )

  ( ERRCNT INCR increments the variable ERRCNT )
  ( #LINES DECR decrements the variable #LINES ) 

: ON  ( a - )  -1 SWAP ! ;  ( forces variable to true value )
: OFF ( a - )   0 SWAP ! ;  ( forces variable to false value )

   27 CONSTANT ESC

: NUF? ( - f ) ?TERMINAL DUP IF KEY 2DROP KEY ESC = THEN ;

  ( NUF? is used inside a DO LOOP structure; when a key is   )
  ( pressed, NUF? stops to wait for a second keypress.       )
  ( If no key was struck or the second key is not the Escape )
  ( key, the flag is false; otherwise, the flag is true.     )

  ( The word ?TERMINAL is vendor-specific.  Your Forth might  )
  ( use ?KEY or some other word instead.  It is the word that )
  ( returns a true flag if a key has been pressed and a false )
  ( flag otherwise; the key's value is then retrieved with the) 
  ( standard word KEY. )


: LISTIT  #LINES 0 DO I LIST-LINE NUF? IF LEAVE THEN LOOP ;

 ( Example of NUF?:  LISTIT will pause after listing a line )
 ( when a key is pressed.  Pressing Escape will then leave  )
 ( the loop, interrupting the task; any key except Escape   )
 ( does not interrupt but resumes the task. )

    0 CONSTANT F     
   -1 CONSTANT T

: ESC-HIT? ( - f ) ( leaves T if Escape key pressed )
   F ?TERMINAL IF BEGIN KEY ESC = OR ?TERMINAL NOT UNTIL THEN ;

 ( ESC-HIT? is like NUF? without the pause.  It is used much )
 ( like NUF? and would also work in the above example.  Note )
 ( that ESC-HIT? discards the contents of the key buffer as  )
 ( it rummages through looking for an Escape keypress.       )

: BYTE-SWAP ( x - x' ) 256 UM* OR ;

 ( This word swaps the two bytes in a cell.  Bill Muench of  )
 ( Santa Cruz thought of this little gem. ) 



Listing Two: array-defining word 1


: ARRAY  CREATE ( # - ) 2* ALLOT   ( reserves # cells in memory )
         DOES>  ( n <adr> - adr ) SWAP 2* + ; ( adr of nth cell )

( This array allocates the number of cells specified, but does )
( not initialize them to zero. ) 

  8 ARRAY TOM   ( defines TOM as having 8 cells = 16 bytes )
  125 5 TOM !   ( stores 125 in cell 5 of TOM )
  0 TOM @       ( retrieves the contents of cell 0 of TOM )




Listing Three:  array-defining word 2


  1 CONSTANT BYTES
  2 CONSTANT CELLS
  4 CONSTANT DOUBLES 

: FOR  CREATE ( #slots type - ) DUP C, * HERE OVER ERASE ALLOT
       DOES>  ( index <adr>  - adr ) COUNT ROT * + ;

  11 BYTES FOR FRED
  35 CELLS FOR JOAN
  17 DOUBLES FOR JOHN

 ( These arrays will deliver the address of the slot based  )
 ( on the type of the entry.  The array is initialized to   )
 ( zeroes at creation time.  It is the programmer's job to  )
 ( use C!, !, 2!, C@, @, and 2@ as appropriate.  Note that  )
 ( FRED's 11 slots are numbered 0 through 10, JOAN's 35 are )
 ( numbered 0 through 34, and JOHN's 17 are 0 through 16.   )

  213 3 FRED C!       ( stores 213 into byte 3 of FRED )
  31 JOAN @           ( fetches contents of cell 31 of JOAN )
  3142352. 15 JOHN 2! ( stores 3142352. into slot 15 of JOHN )
  



Listing Four:  array-defining word 3


  1 CONSTANT PUT   ( flags for the IF statement )
  0 CONSTANT GET   ( in the DOES> part of FOR   )

  CREATE STORES   ] C! ! NOOP 2! [  ( NOOP stored to put 2! )
  CREATE FETCHES  ] C@ @ NOOP 2@ [  ( and 2@ in right spot  ) 

: FOR  CREATE ( #slots type - ) DUP C, * HERE OVER ERASE ALLOT
       DOES>  ( datum 1 ndx <adr> --  |   0 ndx <adr> -- datum )
          COUNT DUP >R ( save type ) ROT * +   R> 1- 2*   ROT 
             IF STORES  ELSE FETCHES  THEN  + @ EXECUTE ;

 ( This version of FOR takes care of the fetching and storing  )
 ( given the appropriate flag; the programmer does not have to )
 ( remember whether it is a byte, cell, or double-precision    )
 ( array.  This could easily be extended for floating-point    )
 ( numbers as well. In the stack comment, "|" is read as "or." ) 

  11 BYTES FOR FRED
  35 CELLS FOR JOAN
  17 DOUBLES FOR JOHN


  213 PUT 3 FRED        ( stores 213 in byte 3 of FRED )
  GET 31 JOAN           ( retrieves contents of cell 31 of JOAN )
  3142352. PUT 15 JOHN  ( stores 3142352. in slot 15 of JOHN )




Listing Five:  bit tools 


  CREATE BITBYTES  1 C, 2 C, 4 C, 8 C, 16 C, 32 C, 64 C, 128 C,

: FLAG ( ? - f ) 0= NOT ; ( forces to a Boolean flag: -1 or 0 )

: AIM  ( # adr - bit# adr' ) SWAP 8 /MOD ROT + ;

: +BIT ( # adr - ) AIM SWAP MASK OVER C@  OR SWAP C! ;

: -BIT ( # adr - ) AIM SWAP MASK NOT OVER C@ AND SWAP C! ;

: @BIT ( # adr - f ) AIM C@ SWAP MASK AND FLAG ;

: ~BIT ( # adr - f ) AIM 2DUP @BIT IF -BIT ELSE +BIT THEN ;




Listing Six:  array-defining word 4


  0 CONSTANT BITS      ( for bit arrays )

: BITS>BYTES ( #bits - #bytes ) 8 /MOD SWAP IF 1+ THEN ;

: FOR   CREATE ( #slots type - ) DUP C, ?DUP
               IF *   ELSE BITS>BYTES   THEN
               HERE OVER ERASE ALLOT   
        DOES> ( datum 1 ndx <adr> --  |  0 ndx <adr> -- datum )
               COUNT ?DUP  ( nonzero = numbers; 0 = bits ) 
               IF DUP >R ( save type )  ROT * +  R> 1- 2*  ROT
                  IF STORES  ELSE FETCHES  THEN  + @ EXECUTE
               ELSE  ROT ( action flag: 1 = store, 0 = fetch  )
                  IF ROT ?DUP ( nonzero means 1 bit or toggle )
                     IF 0<  IF ~BIT  ELSE +BIT THEN
                     ELSE -BIT THEN
                  ELSE @BIT THEN THEN ;


  1 1  2CONSTANT SET     ( By placing two values on  ) 
  0 1  2CONSTANT ZAP     ( the stack, these words in ) 
 -1 1  2CONSTANT FLIP    ( effect include the PUT.   )

  23 BITS FOR BIT    ( reserves 4 bytes for bit array )

   SET 16 BIT    ( turns bit 16 on )
   ZAP  5 BIT    ( turns bit 5 off )
   FLIP 0 BIT    ( toggles bit 0   )

   GET 3 BIT     ( retrieve bit 3 as boolean flag )
  
   ( Examples shown in Listing 4 will also work with this word.)




Listing Seven:  array-defining word 5

: >TYPE  ( adr - adr' ; from #slots-adr to type-adr )  2+ ;

: >DATA  ( adr - adr' ; from #slots-adr to data-adr )  3 + ;

: FOR   CREATE ( #slots type - )
               OVER , ( #slots )   DUP C, ( type )  ?DUP
               IF *   ELSE BITS>BYTES   THEN
               HERE OVER ERASE ALLOT 
        DOES> ( datum 1 ndx <adr> --  |  0 ndx <adr> -- datum )
               >TYPE COUNT ?DUP ( nonzero = numbers; 0 = bits )
               IF DUP >R ( save size ) ROT * + R> 1- 2* ROT
                  IF STORES  ELSE FETCHES  THEN  + @ EXECUTE
               ELSE  ROT ( action flag:  1 = store, 0 = fetch )  
                  IF ROT ?DUP ( nonzero means 1 bit or toggle )
                     IF 0< IF ~BIT ELSE +BIT THEN
                     ELSE -BIT THEN
                  ELSE @BIT THEN THEN ;



Listing Eight:  array display word


: "TYPES ." bit   byte  cell        double" ;

: .TYPE ( type - ) 6 * ['] "TYPES >BODY 3 + + 6 -TRAILING TYPE ;

: DOUBLE? ( type - f ) 4 = ;

: }LINE  ( type n - type ) OVER DOUBLE?  IF DUP 5  ELSE DUP 10
    THEN   MOD  IF DROP  ELSE CR 4 .R ."  | " THEN ;

: VITALS ( array-adr - data-adr #slots type ) DUP >TYPE 
    OVER >DATA ROT @ ( #slots ) ROT C@ ( type ) ;

: TITLE  ( #slots type - ) CR CR SWAP . .TYPE ." s:" ;

: DISPLAY ( adr -- )  VITALS 2DUP TITLE  ?DUP 
    IF ( numbers ) SWAP 0 DO I }LINE 2DUP I * + ( adr )
        OVER DUP >R ( save type ) 1- 2* FETCHES + @ EXECUTE 
        R> DOUBLE?   IF 12 D.R   ELSE 7 .R   THEN
        NUF? IF LEAVE THEN LOOP 2DROP
    ELSE ( bits ) 0 DO I DUP }LINE OVER @BIT 
        2 SPACES  IF ASCII 1  ELSE ASCII -  THEN EMIT
        NUF? IF LEAVE THEN LOOP DROP
    THEN CR ;

: SPILL ( - ; name ) BL WORD FIND
   IF   >BODY DISPLAY
   ELSE DROP CR ." No such array " THEN ;


16 DOUBLES FOR MIKE 
1892735. PUT  0 MIKE 
7802472. PUT 15 MIKE 
1263.    PUT  8 MIKE 
SPILL MIKE

16 doubles:
  0 |      1892735           0           0           0           0
  5 |            0           0           0        1263           0
 10 |            0           0           0           0           0
 15 |      7802472


16 BITS FOR STEVE 
SET  0 STEVE 
SET 15 STEVE 
FLIP 11 STEVE 
SPILL STEVE

16 bits:
  0 |   1  -  -  -  -  -  -  -  -  -
 10 |   -  1  -  -  -  1




