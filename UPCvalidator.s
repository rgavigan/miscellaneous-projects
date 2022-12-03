         AREA question1, CODE, READONLY
         ENTRY
		 
         ; Initialize UPC Pointer and Counter
Start    ADR   r0, UPC - 1          ; pointer to 1 byte before UPC list to work with incrementing
         MOV   r1, #Counter         ; initializes loop counter in r1 to 6 to add all UPC digits
         MOV   r2, #0               ; initializes running sum
		 
         ; Loop To Get UPC Sum
Sum      LDRB  r3, [r0, #1] !       ; copy odd digit pointed at by r0 to r3
         SUBS  r3, r3, #Excess      ; subtract digit by ASCII code of 0 to get int value
         ADD   r3, r3, LSL#1        ; multiply by 3 by adding r3 to r3*2
		 
         LDRB  r4, [r0, #1] !       ; copy even digit pointed at by r0 to r4 by first incrementing
         SUBS  r4, r4, #Excess      ; subtract digit by ASCII code of 0 to get int value
		 
         ADD   r2, r3               ; add odd digit * 3 to running sum
         ADD   r2, r4               ; add even digit to running sum
         SUBS  r1, r1, #1           ; decrement loop counter
         BNE   Sum                  ; repeat until entire UPC code has been added to sum
	 
         ; Check For Validity By Repeated Subtraction
Div      CMP   r2, #0               ; compare r2 to 0 initially (handle base case of 0)
         MOVEQ r0, #1               ; set r0 to 1 if equal to 0
         MOVMI r0, #2               ; set r0 to 2 if negative
         SUBS  r2, r2, #Minus       ; subtract sum by 10 to decrement to <= 0
         BLE   Loop                 ; exit loop if the UPC has been checked successfully
         BNE   Div                  ; do not exit if UPC has not been checked

Loop     B     Loop
		 
	 
UPC      DCB   "000000000000" ; correct UPC string
Counter  EQU   6
Excess   EQU   48
Minus    EQU   10
         END