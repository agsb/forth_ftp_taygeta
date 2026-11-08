
( Single Length Math Extentions - Screen 1 )

: MINUS NEGATE ;

                                                            -->











( Single Length Math Extentions - Screen 2 )

: 0>= 0< 0= ;

: 0<= 0> 0= ;

: SIGNX ( NUMBER --- SIGN ) DUP IF 0> DUP + 1 - THEN ;
 ( Returns 0 +1 or -1 if NUMBER is 0  positive  or negative )








( TEMP LOADING SCREEN )
1 LOAD
4 LOAD
7 LOAD
10 LOAD
12 LOAD
17 LOAD
22 LOAD
29 LOAD
39 LOAD
48 LOAD





( Double Length Words - Screen 1 )

: .D CR DEPTH 2 / DUP IF 0 SWAP ." (Bottom) " SPACE DO SP@ I 1-
  4 * + DUP @ SWAP 2 + @ SWAP D. -1 +LOOP SPACE ." (Top) "
  CR ELSE DROP ." .D: Stack empty. " CR THEN ;
  ( Non-destructive double length stack print )

: DMINUS DNEGATE ;





                                                            -->


( Double Length Words - Screen 2 )

( : D/  D U --- D  SWAP OVER /MOD >R SWAP U/ SWAP DROP R> ; )

: D* ( D U --- D ) DUP ROT * ROT ROT U* ROT + ;

( : D/MOD U/ ;   D U --- R Q )

: D+! DUP >R 2@ D+ R> 2! ;









