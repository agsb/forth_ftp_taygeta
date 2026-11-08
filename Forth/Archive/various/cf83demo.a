Status: R


                      Copyright  (c)  1991  
 Display this         by  M. David Johnson    If READER.BAS is 
 manual at 64             BDS Software        on this disk, use
 characters               P.O. Box 485        BACKUP to copy, 
 per line.          Glenview, IL 60025-0485   not COPY.

You may freely distribute this DEMO (CF83DEMO.BAS, CF83DEMO.BIN,
CF83DEMO.TXT, CF83DEM2.TXT, READER.BAS, and READER.BIN)  so long
as you do not alter it in any way.

                     "Thou shalt not steal" 
                          Exodus 20:15

Welcome to the CF83 Demonstrator.  CF83 is a 1983 Standard Forth
for the 64K CoCo II, 128K CoCo III, and 512K CoCo III, with at
least one standard RS-DOS SSDD floppy disk drive.  

If this DEMO was originally obtained on a dedicated floppy disk,
it should include CF83DEMO.BAS, CF83DEMO.BIN, READER.BAS, and
READER.BIN.  If this DEMO was originally obtained from DELPHI,
GEnie, a BBS, or similar "on-line" connection, or on a floppy
disk with other unrelated programs, it should include
CF83DEMO.BAS, CF83DEMO.BIN, CF83DEMO.TXT, and CF83DEM2.TXT.

If this DEMO is not complete, send us $3.00 and we'll send you a
complete DEMO on a dedicated floppy disk. 

This Demonstration software is provided "as is " without
warranty of any kind.  The entire risk as to the results and
performance of this software is assumed by you.  M. David
Johnson and BDS Software disclaim all warranties, either express
or implied, including but not limited to implied warranties of
merchantability and fitness for a particular purpose.  In no
event shall either M. David Johnson or BDS Software be liable
for any damages whatsoever (including without limitation damages
for loss of business profits, business interruption, loss of
information, or any other loss) arising out of the use of or
inability to use this software under any circumstances!

This Demonstration Package includes all of the Forth-83 Standard
Required Word Set, except for the words BLK, BLOCK, BUFFER,
FLUSH, LOAD, SAVE-BUFFERS, and UPDATE.  Thus, you can do
everything with this DEMO that you can with the complete CF83
Forth, except for Disk I/O.

For those who are not familiar with forth programming, we will
try to explain a little bit of how it works - it is very
different from just about any other programming language you
have ever seen.

You will gain the most from this manual if you print it out on
your printer and then use CF83 to follow along and work through
the examples.  

Put your CF83 Forth DEMO disk in Drive #0 and enter:

          RUN "CF83DEMO"

Press any key to clear the opening screen.  The "ok" prompt
appears. 

  ** KEYBOARD LAYOUT

The keyboard layout is the same as under BASIC except for the  
following characters:                                         

CHARACTER         CODE  KEYPRESS COMBINATION
    [               91      CLEAR 8                
    \               92      CLEAR /
    ]               93      CLEAR 9
    Up Arrow        94      CLEAR :             
    Underline       95      Shift @
    Backslanted '   96      CLEAR 7
    {              123      CLEAR ,
    Vertical Line  124      SHIFT CLEAR
    }              125      CLEAR .
    tilde          126      CLEAR SHIFT :

CODE = Decimal ASCII Code.

For Keypress Combination, hold down the left listed key or keys
and then press the right listed key.

After making a keypress combination, you must release all keys 
before making another keypress or keypress combination - CF83
does not provide for repeating of keypresses: you would have to 
develop your own "repeating" forth words if you want to have a 
repeating keypress feature. 





  ** MEMORY MAP

ADDRESSES (HEX)     CONTENTS

  0000 - 09FF       System Variables, Buffers, and Stacks       
  0A00 - 21FF       Screen Memory                               
  2200 - 31FF       Block Buffers (4)                           
  3200 - 5D3D       Low Level System Routines
  5D3E - 6DA1       System Dictionary Space (4,196 bytes)       
  6DA2 - FEFF       Application Dictionary Space (37,214 bytes) 
  FF00 - FFFF       Memory Mapped Hardware I/O

The Application Dictionary Space is the free memory space you  
have available for your applications.  The map shows the entire
address space of the CoCo II (logical address space - CoCo III).

The Data Stack space and Return Stack space are each 512 bytes.
The Terminal Input Buffer space is 256 bytes.  The PAD Buffer  
space is 150 bytes.

CF83 requires a 64K Coco II, 128K CoCo III, or 512K CoCo III;  
with at least one RS-DOS floppy disk drive; and a monochrome,  
composite color, or RGB color monitor (or TV set).


  **  THE FORTH CONCEPT

CF83 Forth is an Extensible, Stack Oriented, Reverse Polish,
Threaded Interpreter. 

( Ouch!  Is this tutorial going to be filled with big words like
these? -- No!  But this definition is critical: please stick
with us for just a few moments. )  

When you turn your CoCo on, you are in BASIC.  BASIC is an
interpreter.  When you LOAD and RUN a BASIC program, the BASIC
interpreter analyzes each program line, translates it into
machine code, and then executes that code.  BASIC programming is
interactive: you can make changes in your program and test those
changes immediately.  This makes program development and
debugging comparatively easy.  But, because BASIC must analyze
and translate each program line every time the program is run,
BASIC programs are also comparatively slow.

If you use an assembler (such as EDTASM) or a compiler (such as
C or PASCAL), you write your program in an ASCII source code
file and then assemble or compile and link it to a machine
language object code file.  When you want to run the program,
you simply LOADM and EXEC the machine language object code
file.  The machine language executes directly: it doesn't have
to be analyzed and translated each time the program is run. 
Therefore, machine language is comparatively fast.  But
assemblers and compilers are not interactive: if you make any
changes in the program, you have to re-assemble or re-compile
and re-link it before you can test the changes.  This makes
program development and debugging comparatively difficult.  

A threaded interpreter builds fully analyzed and translated
machine language code by compiling new words as you write them
into the program.  A forth program consists of a list of word
definitions, where each word definition is simply a list of
previously defined words.  Once it has been defined, a forth
word is like a BASIC subroutine - it can be called over and over
again, and it can be called from other subroutines which
themselves can be called over and over again, etc., etc.,
etc.!!  Depending on the application, forth programs can run
almost as fast as assembled machine code.  And they are almost
as easy to develop and debug as BASIC programs.

Aha!  The best of both worlds!

So........      Where's the catch?

Well......      First of all, you have to learn a whole new way
of thinking.  Forget everything you've ever learned about
computer programming!  Start from scratch.

CF83 Forth is an Extensible, Stack Oriented, Reverse Polish,
Threaded Interpreter. 

Forth is Stack Oriented.  BASIC and other languages are Variable
Oriented.  In BASIC, you store numbers in variables and then use
the variable name whenever you want to access the number or pass
it to a subroutine.  Forth also uses variables when it has to,
but most of the time it stores numbers on a stack and passes
numbers to other words via the stack. 

A stack is a simple Last-In, First-Out (LIFO) storage device. 
Suppose you have a handful of pennies and you stack them one on
top of the other on your desk.  Now, if you want a penny, you
take it off the top of the stack.  You don't try to take it from
the bottom or the middle of the stack because the entire stack
would fall down.  So, the last penny you put on the stack is the
first penny you take off the stack, i.e. LIFO.  The stack
orientation saves memory - less memory is devoted to variable
storage.  

You might think that the variable memory you save would be
offset by the memory needed for the stack.  But BASIC and other
languages also use stacks.  Programmers just aren't aware of
those stacks because programmers aren't allowed to use them
directly - the stacks are reserved for internal use by the
language itself.

CF83 Forth is an Extensible, Stack Oriented, Reverse Polish,
Threaded Interpreter. 

Stack operations are more efficient if you use Reverse Polish
Notation (RPN).  RPN should be familiar if you own one of the
more expensive Hewlett-Packard Scientific Calculators.  Some
less expensive HP calculators and most others use Algebraic
Notation (AN).  AN is familiar and easy to understand.  If we
want to add 3 and 5 with an AN calculator, we simply press:

          3 + 5 =

and the answer 8 appears in the display.  With a RPN calculator,
we press:

          3 ENTER 5 +

and the answer 8 appears in the display.  The answer is the
same, but the procedure isn't as clear or natural.

Similarly, under BASIC, we would enter:

          PRINT 3 + 5

but in CF83 Forth, we would enter:

          3 5 + .                ( When you try these examples
                                 using CF83, be sure to include
                                 the spaces - CF83 requires
                                 them. )

where "." in forth does the same thing as "PRINT" in BASIC.

Algebraic Notation makes things easier for us.  But RPN makes
things easier (spell that F A S T E R ) for the CoCo.  Forth
programmers will readily testify that the additional speed is
well worth the added effort.

CF83 Forth is an Extensible, Stack Oriented, Reverse Polish,
Threaded Interpreter. 

Forth is Extensible.  In BASIC and other languages you have a
set of reserved operators and keywords like:

           + - * / PRINT INPUT RETURN STRING$

etc.  These are the only words you can use in writing programs. 
If you want to PRINT "This Phrase" at three different points in
the program, you either have to repeat the program line three
times:

     110 PRINT "This Phrase" 
     .
     .    
     260 PRINT "This Phrase" 
     .
     .    
     430 PRINT "This Phrase" 

or set up a subroutine and call it three times:

     110 GOSUB 1000
     .
     .     
     260 GOSUB 1000
     .
     .     
     430 GOSUB 1000
     .
     .     
     1000 PRINT "This Phrase"
     1010 RETURN

But in CF83 Forth, when you define a new word, you can use it
just like any other word.  If you define the word ptf:

     : ptf ." This Phrase " cr ;      ( Remember those spaces! )

which does the same thing as the BASIC program line PRINT "This
Phrase", then you can use ptf anywhere and it will print the
phrase at that point.  You have just added a completely new
keyword - you have EXTENDED the CF83 Forth language.  This is
one of the most important features of forth: you can extend and
customize it to meet your own particular needs.  And, you can do
so almost without limit!  (Except, of course, that you can't use
the word until after you have defined it).

A second catch is that, unlike BASIC, CF83 Forth only allows
integer numbers, i.e. 5, 263, -4497, etc.  Floating point
numbers, like 1.23, 467.85, -33.21, etc. are not allowed.  You
can add floating point arithmetic if you need it, but Forth does
not initially come equipped with it.  Of course, integer
arithmetic is MUCH faster than floating point arithmetic, and
(almost) everything you can do in floating point can also be
done with appropriately scaled integers.  
 

  **  THE DICTIONARY

The CF83 Forth Dictionary contains the forth words you will use
to write your programs.  In BASIC, you can either execute a word
right away or you can use it in a program.  In BASIC, if you
enter a command directly, you get:

          PRINT "This Phrase"
          This Phrase
          ok

but if you enter it with a preceding line number, you get:

          10 PRINT "This Phrase"
          ok

Instead of executing your command, BASIC has stored your command
in program memory for later execution.  When you enter the RUN
command later, you get:

          RUN
          This Phrase
          ok 

CF83 Forth behaves in much the same way.  Forth has two states:
the Interpreting State and the Compiling State.  When you first
start CF83, it is in the Interpreting State.  If you enter:

          36 emit

you get:

          36 emit [] $ ok

>From here on, we will use the [] symbol to represent a press of
the ENTER key.  The characters to the left of [] are to be
entered by you.  The characters to the right of [] are CF83's
response.

36 is the ASCII code for the dollar sign.  When you touched the
ENTER key after typing 36 emit, the first thing CF83 did was put
the decimal number 36 on the top of the stack.  Then it executed
the forth word "emit" which is the word that takes an ASCII code
from the top of the stack and prints its corresponding character
on the screen.  

When CF83 encountered the characters "36 " (note the following
space - all forth words must be separated by at least one
space), it searched through the forth dictionary to see if it
could find a word that matched "36 ".  It couldn't find a
match.  So it checked to see if 36 was a valid number in the
current number base.  Since CF83 starts in base 10 (decimal), it
recognized "36 " as a valid number and pushed it to the top of
the stack.  In the Interpret State, whenever CF83 encounters a
valid number in your input, it pushes that number to the stack.

Next, CF83 encountered the characters "emit " (note the
following space again) and searched through the forth dictionary
until it found "emit ".  In the Interpret State, whenever CF83
finds a word in your input that matches a word in the forth
dictionary, it executes that word.  So, CF83 executed "emit "
and put the dollar sign on the screen.

Finally, CF83 encountered your press of the ENTER key and
printed the "ok" prompt to tell you it was ready for you to do
something else.  

Suppose you made a mistake and entered:

          36 emut []

You would get:

          36 emut [] emut ?

CF83 put the number 36 on the stack as before.  But, when it
searched for "emut ", it couldn't find it in the forth
dictionary and it also didn't recognize it as a valid number. 
So, it repeated the word (if you had input several words, you
would now know which one was an error) and printed the question
mark on the screen to let you know it didn't recognize your
input.  CF83 also took the 36 back off the stack.  Whenever CF83
encounters an input error like this,  it echoes the error,
prints the question mark, and empties the stack.  If it is in
the Compiling State when it encounters the error, it also
changes back to the Interpreting State.

If you notice a typing mistake before you press [], you can use
the left arrow key to back up to the error and correct it.  But
you must then retype everything following the error, whether or
not it is still on the screen. 

Suppose you enter:

          bucks []

You get:

          bucks [] bucks ?

because "bucks " can't be found in the forth dictionary either.

But now, suppose you enter:

          : bucks 36 emit ; []

You get:

          : bucks 36 emit ; [] ok

": " is a forth word which acts sort of like a line number in
BASIC.  When CF83 is in the Interpreting State and encounters
this word, it executes the word just like any other word.  But
": " does just two things: it changes CF83 to the Compiling
State and signals that the next word in the input stream is a
new word to be compiled into the dictionary.

So, when CF83 encounters "bucks " in the input stream, it
doesn't search the dictionary or check to see if it's a number:
it just starts a new dictionary entry for "bucks ".

In the Compiling State, when CF83 encounters "36 ", it compiles
it to the dictionary instead of pushing it to the stack.  And,
when it encounters "emit ", it compiles it to the dictionary
instead of executing it.   

"; " is a special partner of ": ".  Every forth word definition
that begins with ": " must end with "; ".    
 In the Compiling State, when CF83 encounters "; ", it executes
it instead of compiling it.  (In forth, words that execute
imediately, even in the Compiling State, are simply called
"immediate words").  When "; " executes, it finishes the final
details of compiling the new dictionary entry, and then resets
CF83 to the Interpreting State.

NOW, suppose you enter:

          bucks []

You get:

          bucks [] $ ok

NOW, when CF83 searched the forth dictionary for "bucks ", it
found the match.  "bucks" is now in the dictionary and can be
used just like any other forth word.

Try:

          : buckstoo bucks ; [] ok

and:

          buckstoo [] $ ok

and even:

          : bucks3 36 emit bucks buckstoo ; [] ok

so that:

          bucks3 [] $$$ ok

You have just extended the CF83 Forth dictionary to suit your
own particular programming needs.  In effect, you have actually
created a new programming language especially suited to YOUR
application!  You can't do THAT with BASIC!!!

Want to get fancy?        Enter these definitions:

          : plw cr 63 2443 @ @ ; [] ok
          : 2r rot rot ; [] ok
          : ck if drop 63 cr then over 2+ - ; [] ok
          : cx count 127 and ; [] ok
          : 2v over over ; [] ok
          : 2d drop drop cr ; [] ok
          : cln cx rot dup 2 pick 2+ < ck 2r ; [] ok
          : tw cln 2v + @ 2r type 2 spaces ; [] ok
          : words plw begin tw dup 0= until 2d ; [] ok

and then enter:

          words []

What happened?

If you entered everything correctly, CF83 just displayed a list
of all the words currently in the forth dictionary.  Can you
find the words you added?

Okay!  Now enter:

          : bucks 65 emit ; [] ok
          : abucks bucks ; [] ok

and then enter:

          words []

Examine the word list closely.  You should find "bucks " twice. 
Now enter:    

          bucks [] A ok
          abucks [] A ok

65 is the ASCII code for A.  You can define the same word more
than once in the dictionary.  When you use the word, the most
recent definition is the one that gets executed or compiled. 
Now enter:

          buckstoo [] $ ok          

Even though you have redefined "bucks ", "buckstoo " still uses
the version of "bucks " that was in effect when "buckstoo " was
defined.

Now enter:

          forget bucks [] ok
          bucks [] $ ok
          abucks [] abucks ?          
          words []

The word "forget" caused the most recent version of "bucks ",
and all other words defined after that version of "bucks " to be
removed from the dictionary.  They no longer exist.  To verify
this, enter:

          : abucks bucks ; [] ok
          abucks [] $ ok


  **  THE STACK

Try this:

          1763 [] ok
          3254 [] ok
          . . [] 3254 1763 ok

When you typed in 1763 and pressed the ENTER key, CF83 converted
the characters "1763" to the number 1763 and pushed it onto the
top of the stack.  When you typed in 3254 and pressed the ENTER
key, CF83 converted the characters "3254" to the number 3254 and
pushed it to the top of the stack, on top of the number 1763. 
When you typed in ". . " and pressed the ENTER key, CF83 looked
at the first ". ", found it in the dictionary, and executed it. 
Since the word ". " takes the number on the top of the stack and
displays it to the screen in the current number base, the result
was that "3254" appeared on the screen.  Similarly, the second
". " put "1763" to the screen.

Now try this:

          1763 [] ok
          3254 [] ok
          . . . [] 3254 1763 17222 ok

You may have got something else instead of 17222 as the last
number.  Whatever it was, the number is garbage.  You put two
numbers onto the stack and tried to take three off.  What
actually happened is called "Stack Underflow": CF83 printed out
the 16-bit number which happened to be stored in the two bytes
below the bottom of the stack.  Whatever that number is, it has
no real meaning.  Even though you got the "ok" prompt, this
result is not really okay: it is an error. 

Many of CF83's words are designed to operate on the stack. 
Before examining them in more detail, however, we need to
explain the concept of a stack comment.  Suppose you put the
numbers 665, 23, and 446 onto the stack in that order.  A
straightforward way to show the condition of the stack would be
to simply show a picture of it:

                                   446 
                                    23
                                   665

with 665 on the bottom, 23 in the middle, and 446 on top.  But


