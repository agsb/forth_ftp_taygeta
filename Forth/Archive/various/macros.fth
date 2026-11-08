
\ MACROS.FTH                                        by ROGER BICKNELL
\       8710042210

\ The interpreter takes character strings from the input stream and
\ either compiles them as 'words' into the dictionary for later retrieval
\ or immediately executes them depending on the state of the system.

\ It would be desirable to be able to replace text from the
\ input stream with other text - and even to modify the order of the words in
\ the input stream. For example consider a new data type 'PARM' which
\ is an alias for CONSTANT. When a <parm> is executed it would leave its
\ value on the stack. The code { ' <parm> >body } would return the <parm>'s
\ address. A value could be stored in a <parm> with the code 
\ { ' <parm> >body ! }.

\ The following code will create macros - the ability to replace a list of
\ words with just one word.  A macro compiles the replacable code into the
\ dictionary as a new word - just like any colon definition - but first it
\ compiles 'macro' as the first word in the pfa of the new word. A macro word
\ is an immediate word; thus it is always executed. The first word executed
\ is 'macro'.  'macro' is like 'interpret' except it doesn't take its words
\ from the input stream but rather from the dictionary. Precisely, it takes
\ its words from the parameter field of the word in which it itself is
\ contained. When the list is exhausted it then returns control back to the
\ next word at the higher level.
 
variable (ip)   \ parameter field pointer

\ /n = #bytes in cell size.

: macro   ( pfa -- )
    (ip) !                          \ save parameter field pointer
    begin
        (ip) @ @ ['] unnest <>      ( -- )
    while ( cfa <> unnest )         \ while list is not exhausted
        (ip) @ @ dup                \ get next word in list and
        immediate? do-defined       \ 'macro interpret' it.
        /n (ip) +!                  \ point to next word in parm field
    repeat
;

: MACRO          \ name
    create ]                        \ create macro and compile following
    does> macro                     \ words. Executes 'macro' when run.
;

: ;macro
    [compile] ; immediate
; immediate

\ ###########################################################################

\ EEBIDY EEBIDY.. THAT'S ALL FOLKS..

\ some examples..

: PARM constant ;                       \ *new* data type.

MACRO &    \ <parm>
    ' >body
;macro

MACRO to   \ <parm>
    & !
;macro


