.MODEL SMALL

.STACK 100H

.DATA
    X DB ?
    Y DB ?
    Z DB ?
    MSG1 DB "ENTER X:$"
    MSG2 DB "ENTER Y:$" 
    
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    ;MSG1 PRINT
    MOV AH , 9
    LEA DX , MSG1
    INT 21H
    
    ;INPUT X
    MOV AH , 1
    INT 21H
    MOV X , AL
    SUB X , 48
     
    ;NEW LINE
    MOV AH , 2
    MOV DL , 0AH
    INT 21H
    MOV DL , 0DH
    INT 21H
    
    ;MSG2 PRINT
    MOV AH , 9
    LEA DX , MSG2
    INT 21H
    
    ;INPUT Y
    MOV AH , 1
    INT 21H
    MOV Y , AL
    SUB Y , 48
    
    ;NEW LINE
    MOV AH , 2
    MOV DL , 0AH
    INT 21H
    MOV DL , 0DH
    INT 21H
    
    ;Z = X-2Y
    MOV AL , X
    ADD Z , AL
    MOV AL , Y
    SUB Z , AL
    SUB Z , AL
    
    ;Z = 25-(X+Y)
    ADD Z , 25
    MOV AL , X
    SUB Z , AL
    MOV AL , Y
    SUB Z , AL
    
    ;Z = 2X-3Y
    MOV AL , X
    ADD Z , AL
    ADD Z , AL
    MOV AL , Y
    SUB Z , AL
    SUB Z , AL
    SUB Z , AL
    
    ;Z = Y-X+1
    MOV AL , Y
    ADD Z , AL
    MOV AL , X
    SUB Z , AL
    ADD Z , 1
    
    ADD Z , 48
    MOV AH , 2
    MOV DL , Z
    INT 21H    
    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP
END MAIN
