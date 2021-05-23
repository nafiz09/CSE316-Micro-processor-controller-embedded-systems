.MODEL SMALL

.STACK 100H

.DATA
    VAR DB ?

.CODE
MAIN PROC  
    ;INPUT
    MOV AH , 1
    INT 21H
    MOV VAR , AL
    
    ;CALCULATION
    NEG VAR
    SUB VAR , 1
    
    ;NEW LINE
    MOV AH , 2
    MOV DL , 0AH
    INT 21H
    MOV DL , 0DH
    INT 21H
    
    ;PRINT
    MOV AH , 2
    MOV DL , VAR
    INT 21H
    
    MOV AH , 4CH
    INT 21H
    MAIN ENDP
END MAIN