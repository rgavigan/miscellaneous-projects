         AREA CopyString, CODE, READWRITE
         ENTRY
		 
         ; Initialize string pointers and EoS
         ADR   r8, STRING1 - 1                  ; Let r0 point to String 1
         ADR   r1, STRING2                      ; Let r1 point to String 2
         LDRB  r2, EoS                          ; Let r2 equal end of string symbol
		 
         ; Label names for hex values
Empty    EQU   0x20
t        EQU   0x74
h        EQU   0x68
e        EQU   0x65
	
         BL TestF                               ; base case: check if start of string contains word "the"
		 
         ; Loop through all characters in String1
Repeat   LDRB  r3, [r8, #1]!                    ; Load value of current character into r3 and increment string ptr
         CMP   r3, #Empty                       ; check if character is a space
         BLEQ  TestF                            ; call function if "the " exists, skip 3 spaces
         STRB  r3, [r1], #1                     ; Store current character into new string and increment after
		 
         ; Check for end of string
         TEQ   r2, r3                           ; Check if at the end of the string
         BNE   Repeat                           ; Loop until all characters in string tested
Loop     B     Loop                             ; Parking loop

         ; Function to test that the next three bytes are "the"
TestF    LDRB  r4, [r8, #1]                     ; load r4 with first letter to test
         LDRB  r5, [r8, #2]                     ; load r5 with second letter to test
         LDRB  r6, [r8, #3]                     ; load r6 with third letter to test
         LDRB  r7, [r8, #4]                     ; load r7 with fourth letter to test
		 
         ; Test "the"
         CMP   r4, #t                           ; compare first register with t
         CMPEQ r5, #h                           ; compare second register with h
         CMPEQ r6, #e                           ; compare third register with e
		 
         ; Test for space after
         CMPEQ r7, #Empty                       ; compare fourth register with space
         ADDEQ r8, #3                           ; increment past 'the'
		 
         ; Test "the"
         CMP   r4, #t                           ; compare first register with t
         CMPEQ r5, #h                           ; compare second register with h
         CMPEQ r6, #e                           ; compare third register with e
		 
         ; Test for EoS after
         CMPEQ r7, r2                           ; compare fourth register with end of string
         ADDEQ r8, #3                           ; increment past 'the'
         BX    r14                              ; return
	  
         AREA CopyString, DATA, READWRITE
STRING1  DCB   "and the man said they must go"  ; String 1
EoS      DCB   0x00                             ; End of String 1
STRING2  space 0x7F                             ; Allocating 127 Bytes for String 2
         END
      