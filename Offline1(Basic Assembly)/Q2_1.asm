.MODEL SMALL

.STACK 100H

.DATA
    CHAR DB ?

.CODE
MAIN PROC
    ;INPUT CHARACTER
    MOV AH , 1
    INT 21H
    MOV CHAR , AL
    
    ;CALCULATE TARGETED CHARACTER
    ADD CHAR , 31
    
    ;NEW LINE
    MOV AH , 2
    MOV DL , 0AH
    INT 21H
    MOV DL , 0DH
    INT 21H
    
    ;PRINT TARGETED CHARACTER
    MOV AH , 2
    MOV DL , CHAR
    INT 21H
    
    MOV AH , 4CH
    INT 21H
    MAIN ENDP
END MAIN
    