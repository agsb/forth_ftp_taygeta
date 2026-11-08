
file: dynam.fth

scr #0
 0>      dynamic memory management
 1>
 2>
 3>
 4>
 5>
 6>              by
 7>    bruce o'neel copyright 1986
 8>
 9>  created 9/6/86
10>  modified 9/6/86
11>
12>
13>
14>
15>



file: dynam.fth

scr #1
 0> // dynamic memory directory screen
 1> 3 load  // load dynamic memory
 2>
 3>
 4>
 5>
 6>
 7>
 8>
 9>
10>
11>
12>
13>
14>
15>



file: dynam.fth

scr #2
 0>
 1>
 2>
 3>
 4>
 5>
 6>
 7>
 8>
 9>
10>
11>
12>
13>
14>
15>



file: dynam.fth

scr #3
 0> // dynamic memory load screen
 1> 1 fh 11 fh thru
 2>
 3>
 4>
 5>
 6>
 7>
 8>
 9>
10>
11>
12>
13>
14>
15>



file: dynam.fth

scr #4
 0>    // dynam.  constants and storage allocation
 1> 4 constant headersize  // size in bytes for two addresses
 2> 1000 constant dynam-size // size in bytes of dynamic memory
 3>
 4> variable begin-dynam  // starting pointer variable
 5>
 6> create bom    dynam-size allot
 7> here constant tom
 8>
 9>
10>
11>
12>
13>
14>
15>



file: dynam.fth

scr #5
 0>    // dynam. ^next ^size init-dynam
 1>
 2> : ^next ; // <n---m> takes n, pointer to dynam area
 3>           // returns m, pointer to next dynam area pointer
 4>
 5> : ^size 2+ ; // <n---m> same as ^next but to size address
 6>
 7>
 8> : init-dynam  // inits dynamic memory
 9>     bom ^next off   // no next block
10>     tom bom 4 + - // size of free area
11>     bom ^size !  // save it
12>     bom begin-dynam ! ;  // store start pointer
13>
14> init-dynam
15>



file: dynam.fth

scr #6
 0>    // dynam. smallest-block ?split-block
 1>
 2> 20 constant smallest-block // smallest block, make larger
 3>    // if memory becomes too fragmented,
 4>    // make smaller if memory runs out too easily
 5>
 6> : ?split-block   // <a,n---f> true if a can be split
 7>      swap ^size @   // get size
 8>      smallest-block - // subtract smallest block size
 9>      headersize - // subtrace out header size
10>      < ;  // compare them
11>
12>
13> : <=  // <n1,n2---f> true if n1 <= n2
14>     2dup < >r = r> or ;
15>



file: dynam.fth

scr #7
 0>    // dynam.  split-block
 1> : split-block // <a1,n---a2> split block a2 of size n off of a1
 2>     2dup swap
 3>     ^size @
 4>     headersize -  // subtract out header
 5>     swap - >r over r@
 6>     swap ^size !  // store new size
 7>     swap r> +  // add current size
 8>     headersize +  // add in header length
 9>     dup >r
10>     ^size !  // store size of a2
11>     r> ; // next pointer is left indeterminate
12>
13>
14>
15>



file: dynam.fth

scr #8
 0>    // dynam.  find-good-block
 1> : find-good-block  // <n---a> steps along chain to find block
 2>    // a which will hold n bytes
 3>   begin-dynam @
 4>   begin
 5>      swap over
 6>      ^size @   // get this blocks size
 7>      <=        // is it good enough?
 8>      if exit then  // if so, exit
 9>      ^next @ dup 0=   // test end condition
10>   until
11>   true abort" dynamic memory allocation error" ;  // error exit
12>
13>
14>
15>



file: dynam.fth

scr #9
 0>    // dynam.  calloc  memory allocation
 1> : calloc  // <n---a> returns pointer to block of size n
 2>    dup find-good-block // find one at least large enough
 3>    swap 2dup
 4>    ?split-block   // can it be split?
 5>    if
 6>       split-block  // if so, split it
 7>    else
 8>       drop
 9>    then dup begin-dynam @ =
10>    abort" dynamic memory full"
11>    headersize + ; // point to beginning of block
12>       // not beginning of header
13>
14>
15>



file: dynam.fth

scr #10
 0>    // dynam.  ?between
 1> : ?between  // <n1,n2,n3---> true if n1 is between n2 and n3
 2>     >r over < swap r> < and ;
 3>
 4>
 5>
 6>
 7>
 8>
 9>
10>
11>
12>
13>
14>
15>



file: dynam.fth

scr #11
 0>    // dynam. find-between
 1> : find-between  // <a1---a2> finds a2 to link with a1
 2>     begin-dynam @
 3>     begin
 4>        2dup
 5>        dup ^next @
 6>        dup 0= if
 7>           2drop drop swap drop exit
 8>        then
 9>        ?between if
10>           swap drop exit
11>        then
12>     again ;
13>
14>
15>



file: dynam.fth

scr #12
 0>    // dynam.  ?merge-dynam  merge-dynam
 1> : ?merge-dynam  // <a1,a2---f> true if a1 can be merged with a2
 2>      dup 0= if 2drop false exit then  // exit if a2 is 0
 3>      swap over ^size @ headersize + rot + = ;
 4>
 5>
 6> : merge-dynam  // <a1,a2---> merge a1 with a2
 7>     swap ^size @ headersize +
 8>     swap ^size  +! ;
 9>
10>
11>
12>
13>
14>
15>



file: dynam.fth

scr #13
 0>    // dynam.  link-in
 1> : link-in  // <a1,a2---> link a2 into chain at a1
 2>     swap >r        // save a2
 3>     dup  ^next @ // forward link from a1
 4>     r@ ^next !   // link a2 forward
 5>     r> swap  ^next ! ; // link a1 forward to a2
 6>
 7>
 8>
 9>
10>
11>
12>
13>
14>
15>



file: dynam.fth

scr #14
 0>    // dynam. cfree
 1> : cfree  // <a---> free up block pointed to by a
 2>     headersize -   // get back to my pointers
 3>     dup find-between  // find where it goes
 4>     2dup ?merge-dynam if
 5>          2dup merge-dynam
 6>          swap drop dup ^next @ swap 2dup
 7>          ?merge-dynam if 2dup swap ^next @ swap !
 8>          merge-dynam else 2drop then
 9>     else 2dup ^next @ ?merge-dynam if
10>          merge-dynam
11>     else link-in then then ;
12>
13>
14>
15>






