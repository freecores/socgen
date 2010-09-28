;/**********************************************************************/
;/*                                                                    */
;/*             -------                                                */
;/*            /   SOC  \                                              */
;/*           /    GEN   \                                             */
;/*          /  FIRMWARE  \                                            */
;/*          ==============                                            */
;/*          |            |                                            */
;/*          |____________|                                            */
;/*                                                                    */
;/*  mouse control program                                             */
;/*                                                                    */
;/*                                                                    */
;/*  Author(s):                                                        */
;/*      - John Eaton, jt_eaton@opencores.org                          */
;/*                                                                    */
;/**********************************************************************/
;/*                                                                    */
;/*    Copyright (C) <2010>  <Ouabache Design Works>                   */
;/*                                                                    */
;/*  This source file may be used and distributed without              */
;/*  restriction provided that this copyright statement is not         */
;/*  removed from the file and that any derivative work contains       */
;/*  the original copyright notice and the associated disclaimer.      */
;/*                                                                    */
;/*  This source file is free software; you can redistribute it        */
;/*  and/or modify it under the terms of the GNU Lesser General        */
;/*  Public License as published by the Free Software Foundation;      */
;/*  either version 2.1 of the License, or (at your option) any        */
;/*  later version.                                                    */
;/*                                                                    */
;/*  This source is distributed in the hope that it will be            */
;/*  useful, but WITHOUT ANY WARRANTY; without even the implied        */
;/*  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR           */
;/*  PURPOSE.  See the GNU Lesser General Public License for more      */
;/*  details.                                                          */
;/*                                                                    */
;/*  You should have received a copy of the GNU Lesser General         */
;/*  Public License along with this source; if not, download it        */
;/*  from http://www.opencores.org/lgpl.shtml                          */
;/*                                                                    */
;/**********************************************************************/





	list	p=16c57
	#include p16c5x.inc


main	; Main code entry


	; SETUP all ports
	clrw
	movwf	PORTA
	movwf	PORTB
	movwf	PORTC
	tris	PORTA
	tris	PORTB
	tris	PORTC

	; Send FF (reset command to mouse)
	movlw	0xff	
        call  send_ps

        call  rcv_ps
        call  rcv_ps

	call  delay
	call  delay
	call  delay
	call  delay

        movlw 0xf3	
        call  send_ps
	call  delay
	
        movlw 0xc8	
        call  send_ps
	call  delay

        movlw 0xf3	
        call  send_ps
	call  delay

        movlw 0x64	
        call  send_ps
	call  delay

        movlw 0xf3	
        call  send_ps
	call  delay

        movlw 0x50	
        call  send_ps
	call  delay
	

        movlw 0xf2
        call  send_ps
	call  delay

        call  rcv_ps

	call  delay

        movlw 0xe8	
        call  send_ps
	call  delay


        movlw 0x03	
        call  send_ps
	call  delay

        movlw 0xf3	
        call  send_ps
	call  delay
	

        movlw 0x28	
        call  send_ps
	call  delay

	movlw 0xf4	
        call  send_ps
	call  delay
	

	movlw	0x44
	movwf	PORTB
	
	movlw	0x01
	movwf	PORTA


	
; start uart
	movlw	0x24
	movwf	PORTB
	movlw	0xc0
	movwf	PORTA

	movlw	0x64	
        call    put_c


	
; wait for received  byte from mouse
wait_rcv

	movlw	0x30
	movwf	PORTB
        nop
	nop
	nop
	
	btfss	PORTA,2
	goto	wait_rcv


	movlw	0x22
	movwf	PORTB
        nop
	nop
	nop
		
	movlw	0x01
        addwf   PORTA,0
	
        ;;         movf    PORTA,0
	call    put_c
        nop
	nop
	goto	wait_rcv






put_c
	movwf	8
	movlw	0x30
	movwf	PORTB
        nop
	nop
	nop
wait_tx
	btfss	PORTA,3
	goto	wait_tx
	movlw	0x20
	movwf	PORTB
        movf    8,0
	movwf	PORTA
        retlw   0

	
send_ps
	movwf	8
	movlw	0x40
	movwf	PORTB
        movf    8,0
	movwf	PORTA

	; force ps2_clk low
	movlw	0x44
	movwf	PORTB
	
	movlw	0x02
	movwf	PORTA

	; set umicrosec timer to 100
	movlw	0x52
	movwf	PORTB
	
	movlw	0x64
	movwf	PORTA
        nop
	nop
	nop
	nop

	; Now wait 100 us until porta is 0x00
wait_100

        movf    PORTA,0
	btfss	STATUS,2
	goto	wait_100

	nop
	nop


	; force ps2_clk high
	movlw	0x44
	movwf	PORTB
	
	movlw	0x00
	movwf	PORTA
	nop
	nop
	nop
	nop


	; wait for received  byte from mouse
rcv_ps
	movlw	0x42
	movwf	PORTB
	nop
	nop
	nop
	nop
	nop
	nop
	
	nop
	nop
	nop
	nop
	nop
	nop

	btfss	PORTA,6
	goto	rcv_ps

	movlw	0x40
	movwf	PORTB

	nop
	nop
	nop
	nop
	nop
	nop
	
	nop
	nop
	nop
	nop
	nop
	nop



	

        movf    PORTA,0
	movwf	9
	movlw	0x00
	movwf	PORTB

        retlw   0
	nop
	nop
	nop
	nop


delay
	movlw	0xff
	movwf	10
	
del_loop
	
	decfsz	10,1   
	goto	del_loop	

        retlw   0
	nop
	nop
	nop
	nop	
	
	
   END

