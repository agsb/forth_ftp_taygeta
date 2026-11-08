
( Sound Words )
HEX
: SOUND ( frequency duration --- )  ( cycles/sec millisec )
  0B6 43 P!            ( 10110110B select timer 2; LSB, MSB )
  SWAP 533 ( 1331 ) 3E8 ( 1000 ) ROT */ 100 /MOD SWAP
  42 P! 42 P! ( send out frequency divisor to timer 2 )
  61 P@ ( current setting of Port B )  SWAP OVER 3 OR 61 P!
  ( turn speaker on, and latch it to timer 2 )
  5 * 0 DO LOOP  ( wait duration )
  61 P!  ( turn speaker off ) ;
( STAR TREK sounds: )
: RED-ALERT 5 0 DO 2020 1000 DO I 10 SOUND 20 +LOOP LOOP ;
: TORPEDO 80 1500 DO I 10 SOUND 3600 I - 10 SOUND -20 +LOOP ;
: PHASER  60 0 DO 800 10 SOUND 2500 8 SOUND LOOP ;
: ALARM 4 0 DO 1520 800 DO I 10 SOUND 20 +LOOP
        780 1500 DO I 10 SOUND -20 +LOOP LOOP ;   DECIMAL



