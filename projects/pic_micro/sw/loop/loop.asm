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
;/*  Simple loop for outputing data on porta                           */
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

	clrw
	movwf	PORTA
	movwf	PORTB
	movwf	PORTC
	

loop
	call    foo
	nop
	goto	loop



foo
	incfsz	PORTA
	goto    foo
        call    foo1
	retlw   1
	

foo1
	incfsz 	PORTB
	retlw   1
        call    foo2
	retlw   1

foo2
	incfsz	PORTC
	retlw   1
	
infin
	goto    infin
	nop
	nop
	nop
	

	
   END

