
(This file was downloaded from CompuServe.  Most of the files mentioned
at the end of this are available here on GEnie as well.  If you can't
find one leave a note for the sysop.)  -scott


INTRO.4TH                 12-Oct-88 19328              51

    Keywords: PD FREE OS REFERENCE FORTH 4TH
    
    Overview of the most powerful programming language there is.
      By Giles
    
    

        INTRO.4TH
       (ADVANTAGES OF FORTH)

    Preface:
  The purpose of this file is not just to tell u "Forth is
Great", but rather to clarify just what advantages Forth has
over other languages, and to communicate th "feel" of Forth in
relation to programming tasks.
  I hope it does that job well enough to give u a sense of th
possibilities, so that, when u pursue ur desire to see for
urself what u can accomplish w/ it, u will be expecting to
create elegance.  And if u are intent,  u will be gratified.
  Please read this w/o bias, and if u doubt any statements
made, th author is prepared to provide proof or acceptable
evidence, or upload a corrected version of this file.
  If, on th other hand, u are not willing to find out that
there is a programming language considerably more capable &
elegant than what u r familiar with, then better to not
even give it a single quick scan! (grin)
                                                    Giles


    Topic Headings

Abreviation Definitions
Commands That Fit
Programming Environment
Personal Experience
What is Forth?
Different Installations
Examples
Small Concept= Large Capability
Grand Scale Programming
Use
My plans
Your application
Availability on CIS
Learning Forth
Social Aspects
Problems


    Abreviation Definitions

#, Number
&, And
cmd, Command
hdw, Hardware
r, Are
sfw, software
th, The
u, You
u're, You're
ur, Your
u've, You've
w/, With
w/o, Without
4th, Forth


    Commands That Fit

  Have u ever wished:

1. A particular command went about things just a little
differently?

2. A particular command behaved consistantly, rather than
doing th wrong thing at just th wrong time?

3. U had a particular command, that would make things
SOOooooo simple?

  In Forth, th process of finding th code of a command &
installing a rewritten version is trivial.


    Programming Environment

  Have u ever felt that programming would always be a
pleasant experience, if only U never had to program around
bad system sfw?

  Have u ever wished:

1. U could program twice as fast? ..Five times as fast?
..TEN times as fast?! And that u could debug th program as
u write it, so that (generally) when u finished writing a
module u wouldn't have to come back to it?

2. That all th clever little subroutines u've worked out
were instantly available, w/o having to look for them, or
take any special pains to integrate them into th present
program.

3. That calling a subroutine required nothing more than
naming it?

4. That someway ur programming environment would help u
keep track of where u r, & how th routine u r working on
now will affect other routines, or which ones will be
affected?

5. That u could change th way ur compiler behaves?  Or that u
could add th ability to handle special cases w/o changing
anything else?

6. That u could use hi-level commands, & a magic genie would
come along & convert them to efficient machine code?  Or maybe
just th ones needing speed, & leaving th others in th most
compact form to save memory?

7. That u never had to worry about linking library routines, or
that ONE copy of routines would suffice for ALL processes?

8. That u could have a multitasking, multiuser operating system
w/ all th features of, say for instance, OS9, but ALSO have th
immediate utility of a powerful toolbox & programming language
combined?

9. That u could bring th same, familiar environment &
applications from obsolete hdw. to new hdw. w/ expanded
capabilites, & easily add features to take advantage of th new
hdw w/o having to change much if any of what u already have?
 Examples: Transfer ur system & applications to a Tandy Color
Computer in order to have graphix that beat some MS-DOS &
Macintosh machines at a fraction of th price.
 Or to an IBM styled machine, in order to take advantage of all
th hdw options available, yet having an EFFECTIVE multasker,
instead of being stuck w/ OS2.

10. That u had a powerful environment on which u could write a
similar environment, (but with all ur own improvements, of
course), and compile th new environment & have a system of ur
very own, w/ no royalties owed to anyone?  (Perhaps for ur own
system to be manufactured & sold.)

11. To have th ability to implement other languages, such
as BASIC, LISP, Pascal, Prolog simply & efficiently?

  In Forth, u can move about freely. There is no "black
box" compiler to shackle u w/ unnecessary restraints.  No
restriction to predefined data structures.  U cannot get
lost in GOTOs or jumps because 4th neither has nor needs
them.
  Forth assumes u know what u r doing, & often how u do it is
implicit.


    Personal Experience

  Before I knew of the existance of Forth I knew I would
have to have a language that was infinitely extensible, and
selfcompiling to do the things I wanted to do.  When I
learned what Forth was, it was like manna from heaven.
  With systems such as OS9 having some of th advantages of
Forth, & excellent file handling, and w/ the availability
of a powerful text editor such as TSEdit, a person has a
very effective system for gathering textual data piecemeal
& editing it.
  But in using such a system, I have had to program around
deficiencies of other languages,  been so hampered in
reaching the hdw. functions of the machine, that some
applications that should have been done were not practical
to tackle, (because of time restraints) and as a result
been forced to use sfw for which we haven't the source. 
And so have been unable to adapt it exactly to our needs,
or add enhancements and upgrades that we should have had.
  So, I am FORCED to incorporate the advantages of OS9 into
Forth, as I can no longer do without 4th's other, inherent
advantages.


    What is Forth?

  Forth is an infinitely extensible metacompilable
language/op system in which subroutining is inherent.
(Metacompilable is a Forth term meaning it can compile new
versions of itself from source)
  The stack's use is direct and largely automatic, and you
can directly manipulate it.
  Tho most implementations are sparse from an applications
viewpoint, (tho I know of none that do not include an
editor & assembler), it is so trivial to extend it, that
you can relatively easily write a LISP or BASIC
interpreter, C compiler, or a Prolog extension. (I have
seen most of these in sigs or elsewhere.)
  Since Forth is so compact, (it compiles to only
subroutine addresses), and so fast, (tho slower than
Machine Lang. to do exactly the same operations,
practically it's often faster, because of the better
organization of the functional blocks), and it can
duplicate the power of any existing language, as well as
any you dream up that are MORE powerful, it's hard to deny
that Forth can be the MOST powerful language there is.  As
a practical matter, complete control is in the programmer's
hands, so the extensions will be just as bad as the
programmer forces them to be! (grin)
  On the other hand, you don't have to say "stupid compiler
writer! Why didn't he do it THIS way?!".  You can just
recompile the whole system to suit yourself!  Good idea to,
because that way, it is your own system. to sell as an
application, developmment system, arcade game, or whatever,
with no royalties owed to anyone, and as a complete
standalone system.


    Different Installations

  It is also easily transportable.  You can redefine the
primitives for the new cpu, and recompile it, with all the
resources of the present system at hand.
  And because of th small # of necessary primitives, & of
th extreme modularity & interactive method of programming
this allows, u will not believe how easy such a port is
until u see it!


    Examples

  You may know that the RSdos BASIC PALETTE cmd (for th
Coco) takes a slot number (0-15) and puts a color value
(0-63) into it.  The zero slot's hdw address is 65456.  So
I defined a PALETTE cmd in Forth thusly:
  : PAL -80 + C! ;
  : is a word called Colon, and is the most commonly used
compiler. It enters the following word, (a word is a group
of non-space characters bounded by spaces, in this case
PAL), into the dictionary, and compiles the addresses of
the following words, (which normally must have already been
defined), into the dictionary as it's definition.
  -80 is the signed 16 bit integer equivalent of 65456.
Mention of a number puts it on the stack.
  + takes the 2 top stack entries and adds them, leaving
the result on top of the stack.
  ! is pronounced "store". It takes the second stack item
and stores it in the address on top of the stack. But it
stores SIXTEEN bit values. In this case we only want to
store 1 byte, so we use Cstore, C being for "character". Of
course C! is a different word from !.
  ; terminates all definitions started with :.
  So now instead of PALETTE8,38 as I would use in basic, I
can do 38 8 PAL.
  38 pushes 38 on the stack.
  8 pushes on the 8.
  PAL first takes the top item and adds it and 65456 to
give the address of slot 8, then stores 38 (second stack
item) into one byte at that address. And all of a sudden,
your text is orange.(grin)
  To make this cmd "system independent", you could first
define a constant, SL0T, thusly:
 65456 CONSTANT SL0T
 (Constant is a compiling word that compiles...You got it,
Constants! (grin)
  Then define PAL thusly:
 : PAL SL0T + C! ;
  That way, only SL0T would have to be changed for another
system. All system dependent values could be stored in a
single place, and so be easy to set up for a different
system.
  Here's an edited example of th procedure for installing a
rewritten primitive, as explained by my friend Bob McIsaac:
--------------
 ' <EMIT> DUMP ..display code being used.
  You can figure a new version then install the hex code
using:
 CREATE EMIT NNNN , NNNN , NNNN , NEXT SMUDGE
  If it works then install it:-
 ' EMIT ' <EMIT> CFA ! FREEZE
  This works because the code field addrs of a word always
points to executable code and this can be anywhere in
memory.
---------------
In this example:
  A dictionary header is made up like this:
Up to th 1st 31 bytes are th name field.
Next 2 bytes are th LINK FIELD, which points to th
previously defined word.
Next 2 bytes r th CODE FIELD, & point to executable code.
(Th following parameter field, if th word is a primitive.)
The remaining bytes r th PARAMETER FIELD, which may contain
executable code, addresses for other words, variable
storage, constant storage, tables, or what have u.
  ' (pronounced "tick") puts th PFA (Parameter Field
Address) of th word following it, on th stack.
  DUMP gives a hex dump starting at th address on th stack.
  CREATE creates a dictionary header for th word following
it, in which th 1st character is altered (smudged, by
flipping a bit) so that it can't be found, (while it is
being defined).
  , (Comma) Inserts th 16 bit value on top th stack at th
current end of th dictionary, & bumps th dictionary pointer
16 bits, (to th NEW end of dictionary).
  NEXT puts code in place for a "return" for th virtual
Forth machine.
  SMUDGE flips th flipped bit in th altered letter of th
keyword, so that actually, in this case, it's working more
like an "unsmudge". (grin)
  CFA takes a PFA & converts it to a CFA (Code Field
Address). In this case, th PFA of <EMIT> is converted to
its CFA
  ! Takes th second stack item (in this case, th PFA of
EMIT) & stores it in 16 bits at th address on top of th
stack, (in this case, th CFA of <EMIT>).
  FREEZE sets th system so that it permanently recognizes
this installation.


    Small Concept= Large Capability

  Just a few additional concepts give u a great deal of
added power.  Understanding "Compile time" & "Run time"
behaviors of words, and "Compiling" words, allows u to do
things in th most direct way possible.
  And th "Reverse Polish Notation" use of th stack allows
elimination of all other local variables.
  I find Forth the easiest language in which to
conceptualize a task.  Many procedures that would not be
trivial in any OTHER design of language, can b programed in
Forth out of hand.  Each part of the problem can always be
programmed seperately, as a preliminary word to the final
word that does the whole job.  Also you can start out with
a word that just handles limited conditions, and keep
adding new functions to it as you elaborate on the problem.
 If you choose word names carefully, Forth is self
documenting, also you can add comments inside (or outside,
of course), the definition.


    Grand Scale Programming

  I have talked about designing or redesigning whole
systems, for customization, or porting to new hdw, & I
expect it sounds like something that someone might spend
months, or maybe even years doing, but it more likely would
take u only a matter of days, because:

1. Forth systems tend to be very small

2. U usually have th tools to do things in th most direct
way possible.  When u don't, u can MAKE them.

3. Th combination of interactive programing w/ very small
modules which are all subroutines usable individually,
allows u to very efficiently "snowball" th power of ur
code.  In other words, tho in any language a good
programmer tries to write code whose power increases
geometrically w/ th amount of code he writes, Forth was
designed to allow u to do this very efficiently.

4. Th modularity, interactivity, use of subroutines by
naming them, as well as automatic stack use, makes
debugging a breeze!


    Use

  You can code interactively, at the term, to test things,
but then for real work, you enter the editor, and edit
scripts or source onto disk.
  Then you can take input from disk with a LOAD cmd, and do
execution and compiling directly from disk (until your file
gives the cmd to take input from term).
  Forth can accomplish everything OS9 can, simpler.


    My plans

  I've always wanted to write my own OS because I
eventually wanted to put out my own hdw, and wanted
complete control of maintenance and no royalties. There are
many PD Forths, and Forth workalikes out there to build
upon.
  The system I want to develop now, would include
"Universal Random Block Access", or URBA which means the
ability to access all common disk formats, (Mac, MSdos,
Amiga, OS9, RSdos, CPM, ProDOS, CDOS, etc.)  Each format
description would be contained in a "DOS Descriptor Block"
data structure, and if a new format became popular, you
could just add another DDB.  With additional device
descriptors, and drivers, you could access WORMs, and VHS,
etc.
  Naturally it will have multitasking, & I want to add all
the most useful commands of OS9.  Of course it will always
have the advantage of being a programming lang. as well as
an OS, over OS9.


    Your Application

  Altho there are versions that run on top of OS9, Flex,
CPM, MSdos, etc., etc, to get the greatest advantages, you
need Forth on the bottom!


    Availability on CIS

  Put your checkbook away!  You can get versions of Forth
for the popular CPUs for down-load time:

    6809

  The TIL09 system is on Cocosig (g coco), in "Languages &
Op. Systems" Lib.  It makes ROM calls on the Tandy Color
Computer.
  Here is a list of necessary files:
TIL09.DOC, &
M4TH.DOC, Describe operation & capabilities of TIL09.
TEDIT.DOC, Describes editor use, & other necessary commands
imbedded in th editor.
TILBUG.4TH, Bug fixes.
TIL09.GLO, System glossary.
TILASM.DOC, Overview of assembler.
TIL09.BIN, Executable system.  From BASIC, do
LOADM"TIL09":EXEC. Uses logical sector/block disk access.
TILDOS.ARC, TILDOS uses RSDOS disk files. Instructions are
included.
META1.BIN, &
META2.BIN, are source for TIL09.
TDCMP.BIN, is source for th metacompiler/decompiler.
TEDIT.BIN, is th source for th editor.
TILASM.4TH, source for th assembler.

    68000

  Do a g clm332 to get to Computer Languages Magazine's
forum, & there, in th Forth library u can find:
  README.68K, installation instructions.
  F83-68.BIN, the executable Forth system. (Uses CPM disk
access.)
  KER68K.SCR, source, necessary for adapting the system &
helpful in understanding it.
  META68.SCR, source for the metacompiler, n case you want
to alter the system, or make a completely new one.
  UTL68K.SCR, source for utilities.
  Atari16 forum has basically th same forth as F83-68K, but
different disk access extensions for a non CP/M Forth.

    8086

  Also in CLM's Forth Libr.:
README.PC, Dox for MS-DOS 4th.
CMD4TH.BIN, IBM-PC dedicated Forth. (Does NOT go thru
PC-DOS)
F83-86.BIN, DOES go thru PC/MS-DOS.
KER-86.SCR, System source.
CPU-86.SCR, Assembler source.
META86.SCR, Metacompiler source.

    8080

  Also in CLM's Forth Libr.:
README.80, Dox.
KERNAL.SCR, System source. (CPM80)
F83-80.BIN, Executable system.(CPM80)


    Learning Forth

  For a first text, I'd recommend:
 "Starting Forth" by Leo Brodie.  A glossary is in Cocosigs
DL9...
 TIL09.GLO.  Maybe not Forth '83 de rigueur, but it is
helpful.  Th entire text for th:
 Forth '83 Standard is available in th Forth forum, (g
forth), as FORTH-.DOC.
  There is also a reference file in Forth lib in CLM (g
clm332)....
 4THRES.TX0 (Forth resorce).  You will also find FIG's
address in here.
  We r planning a 4th workshop in Cocosig.  Anyone
interested may contact me for th schedule.
  Also, if anyone knows of other live "Forth
Introductions", I'll appreciate hearing of them.


    Social Aspects

  There are people, some of whom r pretty good programmers,
that consider Forth a "Cult" language.  I've tried to figure
why this is so, (*I* don't feel like a cultist.(grin)), & so
far I've come up w/ these possibilities:

1. Forth IS after all fundamentally "different" from any
other language. (Despite its similarity to LISP.)

2. Once some people realize how much they can accomplish w/
Forth, they may get overexcited, & sound as tho they have
gone overboard! (Hehe..couldn't happen to ME!)

3. I think it likely that Forth is better than what they
(th people that call it a "cult" lang.) are used to, & maybe,
for whatever reason, they would rather not find that out!(grin)

4. Tho Forth tends to attract good programmers, (Th best!),
it also attracts a few poor ones.  (I once saw a guy use a
whole screen to define a single primitive. (grin))  Such a
programmer is not likely to present Forth to a newcommer in
its best light, also if th newcommer is himself a fairly
good programmer, he's likely to figure that if his less
capable friend thinks well of a language, it's probably a
dud! hehe
  So, then, if he hears th enthusiasm of someone who really
knows & uses th potential of Forth somewhere near its
fullest, he's likely to attribute such enthusiasm to
"cultism". (grin).



    Problems

 Plex or contact me as follows:
  Giles Spruill 73347,2651
  Advanced Automation, Inc.
  1217 N.E. Miami Ct., Suite 6
  Miami, FL 33132
  Ph# (305) 371-6408

I would also appreciate any advice that would help make
this file better.


