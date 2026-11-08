
                       Editors and Editing Technique:
                  A Review of Fancy and Practical Features
               in the Evolution of the MMSFORTH Screen Editor

                    A. Richard Miller and Jill A. Miller
                       Miller Microcomputer Services
                    61 Lake Shore Road, Natick MA 01760
                               (617/653-6136)

                                 June 1985

 Abstract

The program editor is the ultimate utility for the Forth programmer, as it
is the one with which he or she works most completely.  And since it is apt
to be written in Forth, it is easily adapted to new ideas. Thus the
important and malleable Forth editor receives great attention and is a
logical focus for objective and subjective design considerations.

Since 1978, the MMSFORTH Editor has evolved through many standard and
special versions. Some of the more interesting features and user
techniques, from our earliest line editor through the sophisticated screen
editor in our new MMSFORTH V2.4, are discussed.


Getting There is ALL the Fun!:

What programmer hasn't wished for better tools with which to write and
debug his or her programs? Alas, the perfect editor has not yet been
written. What's more, it won't be! While this paper may suggest a set of
good ideas, neither it nor any other specification can provide the ultimate
editor. That which constitutes usefulness must vary according to the
project, the video display, the amount of surplus memory and other factors.
And opinions concerning elegance, like any other opinions concerning
beauty, will vary from one user to another.

Although finding the perfect program editor is no more likely than finding
the Holy Grail, the quest remains an attractive one and can provide
positive results.  In this regard, the Forth programmer is very lucky
indeed.  Unlike most computer languages, the typical Forth system includes
an editor with complete source code. So even a neophyte Forth programmer
can hope to make minor adjustments to taste.  As experience builds, most
Forth programmers will stop carving out new programs long enough to design
their own personal carving tool, a custom editor.

In seven years evolving MMSFORTH, we at MMS haven't stopped improving our
own editor utilities, either.  Here's where we've been and what we've
learned. We'll also guess at where we might be going.


Pre-history ( -1980):

In 1978, various groups including MMS were seeking a good version of Forth
to use on the new appliance microcomputers. By then Radio Shack's popular
TRS-80 Model I microcomputer was already a year old. This was barely enough
time for its disk support to become available and reliable, but more than
enough time to force MMS to seek better tools than BASIC and DOS for our
own custom programming on that machine.

MMS might have programmed in MicroForth, but Forth Inc. decided not to
offer a version for the TRS-80.  With its blessing, MMS teamed up with Tom
Dowling, who already had produced several original Forth implementations.
In the Spring of 1979 we pronounced MMSFORTH V1.5 to be smooth enough for
general use and started selling it as well as our own custom programming
services.

Documentation at today's sophisticated level, however, was not a realistic
early goal for any Forth producer. Instead of diverting our early attention
to this project, MMS bought the right to use Forth Inc.'s MicroForth Primer
and supplemented it with a brief MMSFORTH addendum.  (Early University of
Rochester Forth users may remember our second-choice Forth book from 1979,
this school's own URTH Tutorial.)

The borrowed documentation resulted in some good news and some bad news. We
were able to offer more software sooner, for less money, and with greater
compatability with Micro-Forth's word usage (which was a de facto standard
in 1979; the 79-Standard did not become generally available until 1981).
And we provided plenty of system and application source code on disk, to
make our points. But to more closely track the MicroForth manual, we also
deleted a few better features from MMSFORTH. A strong editor was one.
Instead, Tom wrote a simple line editor with the functions described in the
MicroForth Primer. This short and simple line editor design, born when
teletype terminals were more common than video displays, lived on into
PolyForth, and has since been described in the popular 1st edition of
Starting Forth, by Leo Brodie.

Great things were accomplished with that tiny line editor, though in
retrospect we might wonder how.  It involved hunting and pecking your way
through program code, sneaking small glimpses instead of seeing the entire
block at once.  The Model I's video memory hardware was a strong lure to
instantaneous full-screen editing; that spelled programmer efficiency, and
became a MMS priority.

Tom worked further and, in MMSFORTH V1.9, MMS hesitantly offered a
one-block "advanced screen editor" which the experienced and daring user
was invited to load above the line editor.  Although such concepts were not
unknown it was unusual at the time, and it made quite a hit when we
demonstrated it in California in October 1979 -- to a major TRS-80 User
Group, to the Forth International Standards Team meeting that created the
FORTH 79-Standard, and to the Forth Interest Group.  By the following
Spring, other implementors were offering similar ones and our own users
were reporting that the screen editor had big advantages over the line
editor for beginners, not just for advanced users. It made it easy to see
what you were editing, to move smoothly to adjacent words or lines, and
even replaced LIST for visual browsing on the source disk.

When MMS finally offered its own home-grown MMSFORTH Users Manual for V2.0
in 1981, an improved version was simply referred to as the Editor; by now,
screen editing was taken for granted and the line editor had disappeared.
EDIT and E were the usual MMSFORTH words; LIST and L remained only to
comfort users of other Forths, or to read the disk of a remote host
computer.


Recent History (1981-1984):

MMSFORTH is optimized for a few popular computers rather than for maximum
portability across many. Thus MMS design choices avoided function keys
without mnemonic value, and also avoided "diamond" positions on the
keyboard such as are still popular under CP/M. Instead, we were able to
concentrate on very strong mnemonic values for our control keys. On the
early TRS-80 Model I, we implemented the scheme which still seems best for
MMSFORTH and many application programs. We used each letter key on four
ascending levels: alone, combined with a [Shift] key, combined with the
[Clear] key to compensate for the TRS-80's lack of a true [Control] key, or
-- anticipating the IBM PC's [Alternate] key -- combined with [Shift] and
[Clear] at once. Thus, if [Uparrow] goes back one line, [Control-Uparrow]
might go back one block.

This approach worked well initially and continues to apply.  In MMSFORTH
V2.0, it enabled us to offer the first full-ASCII support on the limited
keyboard of the Model I. (Adding, for example, underline, backslash,
square-brackets and braces, backtick and others -- each with an obvious
mnemonic used in conjunction with the new [Control] key.) More recently,
the same approach permits remarkably sensible, "natural" and portable
keyboard usage across the varying keyboard designs of the TRS-80 Models 1,
3, 4 and 4P, plus the IBM PC and many of its near compatibles.

It takes a while to measure the limits of new tools. After we developed
dexterity with the full-screen editor, we adjusted keys for better sense or
function, and added more features to streamline common tasks. The screen
editor, initially a one-block overlay to a small line editor, became a
four-block self-contained utility and invited further utilities in its
support. These included separate utilities such as:

COPIES for "smart" copying or shifting of ranges of blocks;
SEARCH to scan forward for a Forth word across the disk, landing in
    the Editor with the cursor on the word in question; and
2EDITS to scan two ranges of blocks, landing in the Editor with the
    cursor on the first mismatched byte.


Today:

Our just-released MMSFORTH V2.4 offers some old editor features and some
new ones, based on very similar user requirements.  The editor source code
has grown to nine blocks (although, thanks to MMSFORTH's new
temporary-heads and temporary-definitions support, its many new features
compile into less than 3K of RAM). It still offers near-instant response.
It no longer has (or wants) a vocabulary incorporating their features into
key-press operations of its own. And it has more:

EDITOR KEYSTROKES for UPDATE, un-UPDATE, and SAVE-BUFFERS;
n-LINE PAD to copy, delete, replace, insert, or exchange one or more lines
    at once;
FIND Forth words, forward or backward, across blocks;
SET and REPLACE of any character string at cursor position;
AUTOMATIC upper/lowercase conversion;
DIRECT INSERTION of keyboard literals and non-ASCII values;
FORTH INPUT of expressions while in editor mode;
AUTOMATIC MARKING OF BLOCKS: date and initials, -->, and standard
    stack notation symbols to encourage good commenting;
BUFFERS-EXCHANGE to flicker-compare and update two or more similar
    blocks;
PAIRS-EDITING to load the two primary block buffers at once with a
    suitable block-offset (flexible support to compare and update similar
    source code, to maintain shadow blocks, etc.);
MATCH-EDITING to auto-scan and compare two ranges, forward or backward;
SCREEN-MASKING for rapid discrimination of non-printable characters;
STATUS INDICATORS for UPDATE, PAIRS-EDITING, SCREEN-MASKING, value under
    cursor, number of lines in PAD, etc.;
EDIT-BLOCK WINDOWING with color attributes, etc.;
GREATER COMPATIBILITY across computers using our new SYS format which
    uses the same 5K per side of track on all our computers, permitting
    editing of any version (and running of most code, too!) on any MMSFORTH
    computer;
GREATER COMPATABILITY with keyboard usage in THE NOTEPAD (an extended
    n-block "page editor" suitable for simple letter-writing or scrolling
    program editing), FORTHWRITE full-proportional word processor, and
    similar MMS editing software.

These facilities have made simple editing a joy, difficult editing faster
and more error-free, and permit multiprogrammer projects concurrently
developed in multiple versions for different computers and CPU's.

Miller Microcomputer Services invites interested listeners to experience
these MMSFORTH V2.4 editor features at convenient times during this
conference.


Good Ideas We Didn't Use:

Not all good things can be squeezed into the same small bag.  MMS
considered and rejected the following enticing ideas which would either add
overhead to the standard editor beyond their perceived value, increase the
risk of user errors, or create an awkward user image of the system:

RING BUFFER(S) to delete and undelete a long string of characters, a
    series of lines, etc.;
FIND STRING (not just a Forth word), with wild cards;
INCREMENTAL STRINGS find "deeper" as each character is entered (a la
    EMACS);
MANIPULATE BLOCKS like lines;
MULTIPLE-BLOCK WINDOWING;
ACCORDION BLOCKS which are compacted into dense disk storage;
UNBLOCKED SOURCE CODE which, unFORTHlike, scrolls unlimited through
    thousands of lines (MMSFORTH does include THE NOTEPAD, an alternative
    editor which can scroll through at least 20 blocks);
EDITOR SCREEN INTERACTIVE WITH SCROLLING FORTH WINDOW;
INTERACTIVE ALPHA-HEX DUAL DISPLAY MODE (MMSFORTH does include a
    separate ADUMP display and its Editor displays the cursor-cell value);
HELP MENUS other than simple prompts and strong mnemonic keys.

MMS also continues to favor the traditional, "pure" Forth approach to disk
I/O: do it yourself, rather than through DOS.  This is the key to our use
of the same data disks in all supported computers, to our fast, compact and
more flexible directory design and the ability to do without any directory
where none is required.  A PC-DOS version is available, however, for
appropriate projects.

These alternatives still merit consideration.  Although they did not make
our list for MMSFORTH V2.4, they might blend better into some other design
in the unending quest for the "perfect" Forth editor.

Credits:

In 1984 Nicholas Spies designed a good Forth editor incorporating ring
{buffers and he offered it to MMS. Although it did not incorporate smoothly
into this release of MMSFORTH, we do look forward to its publication in an
upcoming and major Forth text co-authored by Spies and Mahlon Kelly.

Initial concepts for Forth line editors stem from the early work of Charles
Moore and Elizabeth Rather at Forth Inc.  So does much practical philosophy
for simplicity in design, which tempers our occasional desire to pile one
kluge upon another in the quest for completeness.

Detailed information on the MMSFORTH Editor is contained in Chapter 2 of
the MMSFORTH Users Manual. Source code for the MMSFORTH Editor is included
on the MMSFORTH System Diskette, strictly for licensed users of the
MMSFORTH System.

The principle contributors to MMS editor software are: Tom Dowling, John
Rible, Dick Miller, and Bent Schmidt-Neilsen.  Good ideas and comments from
hundreds of others also are gratefully acknowledged.

(end of paper)


