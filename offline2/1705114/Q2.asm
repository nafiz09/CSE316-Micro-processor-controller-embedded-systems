INCLUDE "EMU8086.INC"
.MODEL SMALL
.STACK 100H
.DATA
    X DB 0
    Y DB 0
    Z DB 0
.CODE
MAIN PROC
    
    WHILE:
        MOV AH , 1
        INT 21H
        
        CMP AL , 21H
        JL ENDF
        CMP AL , 7EH
        JG ENDF
        
        
        LEV0:   ;CHECK SMALL LETTER
            CMP AL , 61H
            JL LEV1
            CMP AL , 7AH
            JG LEV1
        
            MOV X , 1
        
        LEV1:   ;CHECK CAPITAL LETTER
            CMP AL , 41H
            JL LEV2
            CMP AL , 5AH
            JG LEV2
        
            MOV Y , 1
         
        LEV2:   ;CHECK DIGIT
            CMP AL , 30H
            JL WHILE
            CMP AL , 39H
            JG WHILE
        
            MOV Z , 1
            
            JMP WHILE                
    
    ENDF:
    
    CMP X , 1
    JNZ INVALID
    CMP Y , 1
    JNZ INVALID
    CMP Z , 1
    JNZ INVALID
    
    VALID:
        PRINTN "Valid password"
        JMP ENDF1
    
    INVALID:
        PRINTN "Invalid password"
    
    ENDF1:        
    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP
END MAIN
    