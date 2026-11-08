
\ STRUCTL.4TH  8feb87rdb
\
\ STRUCTL	( ... addr cnt level - sys ) ( -- ptr )
\ Defining word for self-initializing global data structure.
\ Used in the form:
\	 <2var> cnt level STRUCTL <name>
\ When it is first used, STRUCTL adds <name> to the dictionary,
\ compiling the address of <2var>, the appropriate offset into
\ the data structure indicated by cnt and level (including data
\ left by previous use of STRUCTL), and the total size of the
\ data structure.
\
\ At compile time, if the level is greater than the previous 
\ level, the new structure is given the same offset as the 
\ structure of the previous level, else the new structure is 
\ given the offset of the last structure of the same level, 
\ plus that structure's cnt.  Overlapping data structures 
\ created with STRUCTL are terminated with END-STRUCT.  There
\ can be no values on the stack other than sys left by previous
\ invokations of STRUCTL.
\
\ An example of the compile time syntax is:
\
\	2VARIABLE	vTAB		\ Pointer to struct
\
\	vTAB 32 0	STRUCTL	TABLE	\ Returns vTAB 2@
\	  vTAB 12 1	STRUCTL	T1A	\ Returns vTAB 2@
\	  vTAB 16 1	STRUCTL	T1B	\ Returns vTAB 2@ 12 +
\	    vTAB 10 2	STRUCTL	T2A	\ Returns vTAB 2@ 12 +
\	    vTAB 6  2	STRUCTL	T2B	\ Returns vTAB 2@ 22 +
\	  vTAB 4  1	STRUCTL	T1C	\ Returns vTAB 2@ 28 +
\	END-STRUCT			\ Terminates definition
\
\ When <name> is later executed, the value held at <ptr> is
\ returned and compared to NULPTR.  If equal, the memory for
\ the global data structure is requested from the memory
\ manager.  If available, the memory is allocated, the base
\ pointer of the global data structure is stored at <ptr> and 
\ the offset is added to the base pointer and returned.  If
\ memory is not available, NULPTR is returned.  If the value
\ held at <ptr> is not equal to NULPTR, that value is assumed
\ to be a valid pointer to the global data structure, is added
\ to the offset and is returned.
\
\ The purpose for this definer is to be able to refer to
\ different offsets into a data structure in impure memory by 
\ different names without having to initialize the structure
\ and with the least amount of runtime overhead.

ASM				\ Get assembler

: STRUCTL			\ Create overlapping structure
 CREATE	( addr cnt level -- sys )
	NULPTR  5 PICK  2!		\ Init ptrvar
	ROT  ,  DUP  0=			\ Get ptr, check level
 IF	0  -ROT  0 ,			\ 0 offset
 ELSE	2 PICK  OVER <			\ Nest a level?
  IF	4 PICK  DUP ,  -ROT		\ Compile/save offset
  ELSE	SWAP  >R >R			\ RS= cnt level
   BEGIN  R@  >				\ Level > prev_level?
   WHILE  2DROP				\ Drop cnt & offset
   REPEAT +  R> R>  SWAP  2 PICK  ,	\ Compile offs cnt
  THEN
 THEN	DUP  3 *  1+ PICK  ,		\ Total #bytes

\ DOES>	( pfa -- addr )
\	DUP @ 2@  2DUP  NULPTR=		\ Struct^ initialized?
\ IF	2DROP  DUP WSIZE 2* + @  MALLOC	\ Allocate RAM
\ 	2DUP  NULPTR= NOT		\ Make sure we got it
\  IF	2DUP  4 PICK  @  2!  THEN	\ Init struct^
\ THEN	ROT  WSIZE +  @  0  D+  ;	\ Return ptr

 ;CODE		( DI=pfa -- addr )
	BX		PUSH		\ Save TOS
	BX, 0 [DI]	MOV		\ Get ptr addr
	BX, 0 [BX]	MOV		\ Get seg addr
	BX, BX		OR		\ Null ptr?
	2$		JNZ		\ Not null ptr
	BX, 4 [DI]	MOV		\ Total #bytes
	BX, # 1		SHR		\ Convert to paragraphs
	BX, # 1		SHR		\
	BX, # 1		SHR		\
	BX, # 1		SHR		\
	BX		INC		\ Just for good luck
	AH, # 72	MOV		\ Allocate memory
	33		INT		\ Call DOS (21h)
	1$		JNC		\ Got the memory?
	BX, BX		XOR		\ Oops!
	3$		JMP		\ Get out
 1$:	BX, 0 [DI]	MOV		\ Get ptr addr
	2 [BX], AX	MOV		\ Store seg addr
	BX, AX		MOV		\ Put in BX
 2$:	BX, 2 [DI]	ADD		\ Add offset
 3$:	BX		PUSH		\ Segment/low word
	BX, BX		XOR		\ Clear high word
			NEXT,		\ Macro for inline next
	END-CODE

: END-STRUCT	( sys -- )
 BEGIN	-ROT  2DROP  0=
 UNTIL	;


