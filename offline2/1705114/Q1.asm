INCLUDE "EMU8086.INC"
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC
    ;INPUTA
    MOV AH , 1
    INT 21H
    MOV BL , AL
    
    ;INPUTB
    MOV AH , 1
    INT 21H
    MOV BH , AL
    
    ;INPUTC
    MOV AH , 1
    INT 21H
    MOV CL , AL
    
    ;NEW LINE
    MOV AH , 2
    MOV DL , 0AH
    INT 21H
    MOV DL , 0DH
    INT 21H
    CMP BH , CL
    
    CASE1:      ;996
        CMP BL , BH
        JNE CASE2
        CMP BH , CL
        JG PRINTC
        JNE CASE2
    
    CASE2:       ;699
        CMP BH , CL
        JNE CASE3
        CMP BL , BH
        JL PRINTA
        JNE CASE3
    
    CASE3:        ;969
        CMP BL , CL
        JNE HERE
        CMP BL , BH
        JG PRINTB
        JNE HERE
        
    ;EQUAL
    PRINTN "All the numbers are equal"
    JMP ENDF
    
    HERE:
        CMP BL , BH
        JG IF
        JNG ELSE
    
    IF:
        CMP BH , CL
        JG PRINTB
        CMP CL , BL
        JG PRINTA  
    
    PRINTC:
        MOV DL , CL
        INT 21H
        JMP ENDF
    
    PRINTB:
        MOV DL , BH
        INT 21H
        JMP ENDF
    
    PRINTA:
        MOV DL , BL
        INT 21H
        JMP ENDF
    
    ELSE:
        CMP BH , CL
        JL PRINTB
        CMP CL , BL
        JL PRINTA
    
    JMP PRINTC
    
    
    ENDF:
    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP
END MAIN
    
    