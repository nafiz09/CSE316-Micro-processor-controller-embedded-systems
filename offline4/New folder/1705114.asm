INCLUDE "EMU8086.INC"
.MODEL SMALL
.STACK 100H

.DATA
   MATRIX1 DB 2DUP(0)
           DB 2DUP(0)

.CODE
   MAIN PROC
    XOR SI , SI
    MOV CX , 4
    
    PRINTN "Enter matrix 1"
    
    LOOP1:
        MOV AH , 1
        INT 21H
        SUB AL , 030H
        
        MOV MATRIX1[SI] , AL
        ADD SI , 1
        
        MOV AH , 1
        INT 21H
        
        CMP AL , 0DH
        JNE LOP
        
        ;NEW LINE
        MOV AH , 2
        MOV DL , 0AH
        INT 21H
        MOV DL , 0DH
        INT 21H
        
        LOP:
            LOOP LOOP1
    
    
    XOR SI , SI
    MOV CX , 4
    
    PRINTN "Enter matrix 2"
    
    LOOP2:
        MOV AH , 1
        INT 21H
        
        SUB AL , 030H
        ;MOV MATRIX2[SI] , AL
        ADD MATRIX1[SI] , AL
        INC SI
        
        MOV AH , 1
        INT 21H
        
        CMP AL , 0DH
        JNE LOP2
        
        ;NEW LINE
        MOV AH , 2
        MOV DL , 0AH
        INT 21H
        MOV DL , 0DH
        INT 21H
        
        LOP2:
            LOOP LOOP2    
    
    XOR SI , SI
    MOV CX , 4
    
    LOOP3:
    
        CMP MATRIX1[SI] , 10
        JGE DOUBLE
        MOV AH , 2
        MOV DL , MATRIX1[SI]
        ADD DL , 030H
        INT 21H
        JMP NEXT
        
        DOUBLE:
            MOV AH , 2
            MOV DL , 1
            ADD DL , 030H
            INT 21H
            
            MOV BL , 10
            MOV AL , MATRIX1[SI]
            IDIV BL
            MOV DL , AH
            ADD DL , 02EH
            MOV AH , 2
            INT 21H 
        
        NEXT:
        ADD SI , 1
         
        CMP CX , 3
        JE NEW
        
        MOV AH , 2
        MOV DL , 20H
        INT 21H
        JMP LOP3
        
        NEW:
            ;NEW LINE
            MOV AH , 2
            MOV DL , 0AH
            INT 21H
            MOV DL , 0DH
            INT 21H
            
        LOP3:
            LOOP LOOP3
    
     MOV AH, 4CH
     INT 21H
   MAIN ENDP
                                                                         
END MAIN