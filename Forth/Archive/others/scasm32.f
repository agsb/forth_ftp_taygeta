
\ scasm32.f ...
\ assembler for SC32 in JForth
\ 1989 jack j. woehr
\ permission to distribute and use freely granted
\ to Forth Interest Group MEMBERS ONLY !!!
\ pay yer dues, cheapskate!
\ and attend your local FIG Chapter regularly!
\ jax@well.UUCP JAX on GEnie


\ Minimal instruction assembler written in JForth for the Johns Hopkins
\ JPL 32-bit stack machine known as the SC32.
\ references:
\             3m SC32 Prelim          Silicon Composers, Inc., 32-Bit
\                                     Stack-Chip Microprocessor Preliminary,
\                                     4/12/89.
\                                     1989, Silicon Composers, Palo Alto, CA


\	24 April 1989
\ 
\	Dr. George Nichol
\	Silicon Composers, Inc.
\	210 California Ave.,
\	Suite K
\	Palo Alto, CA 94306
\
\
\	Dear George,
\ 
\	Thank you for the prompt delivery of the preliminary document
\	on the SC32, dated 4/12/89. On the basis of this document, this
\	weekend I tossed together a minimal but complete instruction
\	cross-assembler for the SC32 in JForth ( A JSR-Threaded Forth
\	running on the Amiga), a printout of which I enclose for your
\	amusement. Its "Forthish" assembly syntax basically runs like this:
\	
\ 	<instr.> <field-contents> <field-name> ... <field-contents> <field-name>
\
\	followed by a comma ( , ) which is redefined to compile to the target
\	buffer, which latter may be saved to a file.
\
\ [ Examples:
\
\	CALL 1234567 ADDRESS ,
\
\	ALU/SHIFT NEXT U3 SOURCE S0 DEST PUSHS-POPR STACK 0 CIN DST<ALU BUSSRC
\	V ALUCOND FL<ALUCOND FLAG S0&SRC ALU ,
\ ]
\
\	Any comments would be welcome.
\
\	In the course of writing this cross-assembler, a couple of items
\	from the Preliminary document attracted my attention:
\
\		1) Stack overflow/underflow ... the SOver field (Table 2)
\		is presumably for indicating the 16mod pointer value at
\		which stack overflow occurs ... how is underflow managed,
\		or is it automatic? [ * ]
\
\		2) In Table 14, the Shift Operation bits seem to be
\		mislabled in the documentation. Should they not be
\		Bit 6 and Bit 5, instead of Bit 30 and Bit 29?
\
\		3) Referring to tables 8, 11 and 16 as regards the
\		Step Field and Cin Field during a Shift/step instruction:
\		If the the Step Field (Bits 3 and 2) holds binary 11,
\		indicating S0+Src+Cin(_FL') ("not ef-el-prime") and the
\		Cin Field (Bits 9 and 8) holds binary 10, indication that
\		the carry input to the ALU is from FL' ( as opposed to
\		_FL', "not ef-el-prime"), what is the result?
\
\		4) What is the proper state in which to leave the
\		don't-care bit (Bit 0) of a Shift Instruction,
\		(Figure 7) to provide "upward software compatibility"
\		(if any upward development of this chip is forseen
\		at this point)?
\
\		Looking forward to the success of the SC32, I remain,
\
\		Yours truly,
\
\		/s/ Jack Woehr
\
\	[ * ] have since figured this out, underflow control is automatic.
\

hex

only forth definitions also

vocabulary SCASM32

also SCASM32 definitions also

\ *** Instruction Logic

\ Instruction Types
\ SC32 Prelim  pg. 6

00000000 constant call
20000000 constant branch
40000000 constant branch?
60000000 constant ALU/shift
80000000 constant load
A0000000 constant store
C0000000 constant load-addr-low
E0000000 constant load-addr-high

\ convenient op name aliases

load-addr-low  constant lal
load-addr-high constant lah

\ Next Bit
\  SC32 Prelim  pg. 6

10000000 constant  #next

\ Src & Dst Bit Patterns
\  SC32 Prelim  pg. 7

14 constant dst-field
18 constant src-field

00 constant s0
01 constant s1
02 constant s2
03 constant s3
04 constant r0
05 constant r1
06 constant r2
07 constant r3
08 constant u0
09 constant u1
0A constant u2
0B constant u3
0C constant pc
0D constant psw
0E constant zero

( 0F reserved)

\ Stack Bit Patterns
\  SC32 Prelim  pg. 7

10 constant stack-field

00 constant nop \ This also applies for the Flag Field of the ALU/Logic ops.
01 constant popr
02 constant pushr

( 03 reserved)

04 constant pops
05 constant pops-popr
06 constant pops-pushr

( 07 reserved )

08 constant pushs
09 constant pushs-popr
0A constant pushs-pushr

( 0B - 0F reserved )

\ ALU/Shift 
\  SC32 Prelim  pp. 7-9

\ Fields

0F constant subtype-field
0E constant bussrc-field
0A constant alucond-field
08 constant cin-field
07 constant flag-field
00 constant alu-operation-field

\ SubT Field Bit Patterns

0 constant alu/logic
1 constant shift/step

\ BusSrc Field Bit Patterns

0 constant dst<fl
1 constant dst<alu

\ ALU Condition Field Bit Patterns

( 00 constant 0) \ These conveniently are unambiguously themselves!
( 01 constant 1) \ Likewise with the Cin instructions.

02 constant V
03 constant _V
04 constant _((NxV)|Z)
05 constant (NxV)|Z
06 constant N
07 constant _N
08 constant Z
09 constant _Z
0A constant _(_C|Z)
0B constant _C|Z
0C constant NxV
0D constant _(NxV)
0E constant C	\ watch out with the hex numbers, always precede w/ 0 !!
0F constant _C

\ Cin Field Bit Patterns

( 00 constant 0) \ Conveniently, unambiguously themselves ...
( 01 constant 1) \ ... as w/ ALU Conditions above

02 constant FL'
03 constant _FL'

\ Flag Field Bit Patterns

( 0 constant nop ) \ Same as above in the Stack Field Bit Patterns

1 constant fl<alucond

\ ALU Operations

15 constant _(s0&src)
17 constant s0|_src
1D constant _s0|src
1F constant s0|src
20 constant 0
21 constant _s0
22 constant neg1
23 constant s0
24 constant _src
2C constant src
2F constant s0xsrc
41 constant _s0+cin
43 constant s0+cin
44 constant _src+cin
45 constant _s0+_src+cin
46 constant _src-_cin
47 constant s0-src-_cin
49 constant _s0-_cin
4B constant s0-_cin
4C constant src+cin
4D constant src-s0-_cin
4E constant src-_cin
4F constant s0+src+cin
55 constant s0&src
57 constant _s0&src
5D constant S0&_src
5F constant _(s0|src)
6F constant _(s0xsrc)

\ Shift Instructions
\ Shift Fields

5 constant shift-field
4 constant shiftin-field
2 constant step-field
1 constant flagin-field

\ Shift Field Bit Patterns

\ Shift

( 0 constant nop)	\ Once again, this is conveniently already defined

1 constant right
2 constant left

\ Shiftin

0 constant <alucond
1 constant <FL'

\ Step

0 constant step:src+cin
1 constant step:src-s0-cin
2 constant step:s0+src+cin(FL')
3 constant step:s0+src+cin(_FL')

\ Flagin

( 0 constant <alucond)	\ already defined above in Shiftin

1 constant <shiftoutput

\ *** Forming Instructions

\ Control Flow

: address	\ control-instruction address --- instruction'
	1FFFFFFF and or ;

\ Shifting Bit Pattern to Instruction Field

: shift-into-field	\ instruction bits field --- instruction'
	<< or ;

\ Set Next Bit

: next	\ instruction --- instruction'
 	#next or ;

\ Src & Dst

: source	\ instruction register --- instruction'
	src-field shift-into-field ;

: dest	\ instruction register --- instruction'
	dst-field shift-into-field ;

\ Stack Action

: stack	\ instruction stackop --- instruction'
	stack-field shift-into-field ;

\ Load and Store

: zero-extended-offset	\ instruction addr-offset --- instruction'
	0ffff and or ;

: zeo	\ i a-o --- i'	\ convenient alias
	zero-extended-offset ;

\ ALU/Shift Instructions

\ ALU Operations

: subtype	\ instruction subtype --- instruction'
	subtype-field shift-into-field ;

: bussrc	\ instruction bussrc --- instruction'
	bussrc-field shift-into-field ;

: alucond	\ instruction type --- instruction'
	alucond-field shift-into-field ;

: cin	\ instruction type --- instruction'
	cin-field shift-into-field ;

: flag	\ instruction type --- instruction'
	flag-field shift-into-field ;

: alu	\ instruction operation ---
	alu-operation-field shift-into-field ;

\ Shift Operations

: shift	\ instruction shift-op --- instruction'
	shift-field shift-into-field ;

: shiftin	\ instruction shifter-input --- instruction'
	shiftin-field shift-into-field ;

: step	\ instruction step-op --- instruction'
	step-field shift-into-field ;

: flagin	\ instructions flagin ---
	flagin-field shift-into-field ;

\ *** Assembly Buffer Management

   4 constant buff-hdr-size	\ link to next allocated buffer | 0
1000 constant buff-size	\ each buffer same size
   4 constant opsize	\ each op is a longword on SC32

variable 1st-buffer	\ as it says
variable last-buffer	\ latest allocated buffer

variable asm-ptr	\ the "dictionary pointer" for our assembler

: asm-ptr.init	\ ---	\ start off set to zero
	asm-ptr off ;

: here	\ --- next-available-assembly-relative-address
	asm-ptr @ ;

: (there)	\ addr --- offset-in-any-buffer
	buff-size mod ;

: there	\ here --- real-address
	(there) last-buffer @ buff-hdr-size + + ;

\ allocate $1004 bytes for assembly and a buffer-linking header.

: buff-err? \ ---
	abort" No Buffer Memory" ;

: get-buffer	\ --- absmemaddr|0
	[ buff-hdr-size buff-size + ] literal MEMF_CLEAR
	[ forth ] exec? call exec_lib allocmem [ scasm32 ] ;

: free-buffer	\ reladdr ---
	>abs
	[ buff-hdr-size buff-size + ] literal
	[ forth ] call exec_lib freemem drop [ scasm32 ] ;

: free-all-buffers	\ ---
	1st-buffer @
	begin
	dup @ swap free-buffer
	dup 0=
	until drop ;

: get-1st-buffer	\ ---
	get-buffer dup
	if >rel dup 1st-buffer ! last-buffer !
	else true buff-err?
	then ;

: get-subsequent-buffer	\ ---
	get-buffer dup
	if >rel dup last-buffer @ ! last-buffer !
	else true buff-err?
	then ;

: manage-buffers	\ ---
	here (there) 0= here 0> and
	if get-subsequent-buffer then ;

\ *** Output File Handling

create out-filename 100 allot
variable out-fileptr
variable outfile-buff

: outfile-err?	\ t|f ---
	abort" Couldn't Open Output File" ;

: writefile-err?	\ t|f ---
	abort" Error While Writing Output File" ;

: out-filename.default	\ ---
	0" ram:scasm32.out" 0count 1+ out-filename swap cmove ;

: open-outfile	\ ---	\ what the heck is going on here?
	out-filename new 0fopen
	dup out-fileptr !
	0= outfile-err?
	out-fileptr @ fclose
	out-filename 0fopen dup
	0= outfile-err?
	out-fileptr ! ;

: close-outfile	\ ---
	out-fileptr @ fclose ;

: (get-outfile-buff)	\ --- 0|abs_addr
	here MEMF_CLEAR
	[ forth ] exec? call exec_lib allocmem [ scasm32 ] ;

: get-outfile-buff	\ ---
	(get-outfile-buff) dup 0= abort" Couldn't Get Outfile Buff"
	>rel outfile-buff ! ;

: free-outfile-buff	\ ---
	outfile-buff @ >abs here
	[ forth ] call exec_lib freemem drop [ scasm32 ] ;

: fill-outfile-buff	\ ---
	here buff-size /mod		\ how many 4k buffs to consolidate?
	outfile-buff @			\ get the file buffer
	1st-buffer @ rot		\ get the first asm buffer
	0 do				\ JForth DO is a ?DO
		dup buff-hdr-size +	\ move to data area
		2 pick			\ get file buffer address
		buff-size cmove>	\ move data
		@ swap buff-size + swap	\ get next data buff, inc file buff adr
	  loop
	rot dup				\ is there a modulus remaining?
	if				\ yes, copy rest of data
		swap buff-hdr-size + -rot cmove>
	else
		2drop drop		\ drop data-adr filebuf-adr 0ct
	then ;

: write-outfile	\ ---
	out-fileptr @ outfile-buff @ here fwrite
	0= abort" Error Writing Assembly to File" ;
	
: save-assembly	\ ---
	open-outfile
	get-outfile-buff fill-outfile-buff
	write-outfile close-outfile free-outfile-buff ;

\ *** Assemble to Memory

\ all SC32 operands are longwords

: ,	\ longword ---
	manage-buffers here there ! 4 asm-ptr +! ;
 
\ *** Initialization

: scasm32.init	\ ---
	scasm32 get-1st-buffer asm-ptr.init out-filename.default ;

: wrapup	\ ---
	save-assembly free-all-buffers ;

decimal


