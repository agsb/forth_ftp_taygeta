
\ INTERPRT.FTH                                by ROGER BICKNELL

\ The Fig-Forth outer interpreter is:

: interpret ( -- )
    begin -find
        if state @ <
            if cfa , else cfa execute then
        else here number dpl @ 1+
            if drop [compile] literal
            else    [compile] dliteral
            then
        then ?stack
    again
;

\ The biggest problem with this word is that it does more than one
\ thing. That's a no-no. A structured alternative which only uses words
\ that *one* thing is:

: interpret ( -- )
    begin bl word dup c@    ( string -- )
    while ( stringlength > 0 )  \ i.e. stream is not exhausted.
        "compile
    repeat drop
;

\ So 'interpret' continually gets words from the input stream and hands them
\ to '"compile' stopping when the input stream is exhausted. Here is "compile:

: "compile   ( string -- ?? )
    find  ( string 0 {notfound} | cfa -1 {nonimmediate} | cfa 1 {immediate} )
    dup
    if ( found )
        do-defined
    else ( not found )
        drop   ( -- string ) 
        literal?    ( -- string false | ?? true )
        if do-literal
        else do-undefined
        then
    then
;

\ The word is searched for in the dictionary. If it is found then 'do-defined'
\ is executed. If not then it is checked for 'literal-ness'. If not a literal
\ then 'do-undefined' is executed. simple.

\ Each of do-defined, do-literal, and do-undefined must have two behaviours.
\ One for compile time and another for execute time. Oh-oh.

\ Vectored execution to the rescue! Each of these words must be a vectored
\ word - like doer-make words {see "Thinking Forth", Leo Brodie}.

\ So that do-defined is either 'execute-do-defined' or else
\ 'compile-do-defined'.

: execute-do-defined    ( cfa -1 | cfa 1 -- ?? )
    drop execute
;

: compile-do-defined    ( cfa -1 | cfa 1 -- ?? )
    0> if execute       ( if immediate )
    else ,
    then
;

\ Like-wise do-undefined is either 'execute-do-undefined' or 
\ 'compile-do-undefined'. do-literal is either 'execute-do-literal' or
\ 'compile-do-literal'.

\ The words used to determine which of the two forms to use would naturally
\ be the words which determine the state, execute or compile.
\ These two words are ']' and '['.

\ There. Isn't that simple? The beauty of this scheme is that each of the
\ words can be used separately. If I need to compile/execute just one word
\ then it can easily be done.

\ The idea for this scheme for implementing the outer interpreter comes
\ from Mitch Bradley ( of Forthmacs fame ).


