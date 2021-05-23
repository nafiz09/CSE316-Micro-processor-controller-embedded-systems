INCLUDE "EMU8086.INC"
.MODEL SMALL
.STACK 100H

.DATA
    COUNT DW 1
    VAL DW ?
    TEMP DW ?
    TEMP2 DW ?
    SIGN DB ?   

.CODE
   MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    CALL INDEC     
    MOV VAL , BX
    
    MOV BX , 0
    MOV CX , 1
           
    
    CALL FIBONACCI
    MOV AH, 4CH
    INT 21H
   MAIN ENDP
   
FIBONACCI PROC
    
    MOV AX , VAL
    CMP AX , COUNT
    JG RETURN 
    
    CMP COUNT , 1
    JE BASE1
    
    CMP COUNT , 2
    JE BASE2
    
    JMP ELSE_
    
    BASE1:
        MOV AH , 2
        MOV DX , BX
        INT 21H
        PRINT ","
        INC COUNT
        CALL FIBONACCI
    
    BASE2:
        MOV AH , 2
        MOV DX , CX
        INT 21H
        PRINT ","
        INC COUNT
        CALL FIBONACCI
    
    
    ELSE_:
        MOV AX , CX
        ADD CX , BX
        MOV BX , AX
        MOV DX , CX
        MOV AH , 2
        INT 21H
        PRINT ","
        INC COUNT
        CALL FIBONACCI
    
    RETURN:
        RET
    
FIBONACCI ENDP

INDEC PROC
                         
   XOR BX, BX
   XOR CX, CX

   MOV AH, 1 
   INT 21H

   CMP AL, "-"
   JE @MINUS  

   CMP AL, "+"
   JE @PLUS  
   JMP @INPUT

   @MINUS:   
   MOV CX, 1

   @PLUS:   
   INT 21H 
   CMP AL, 0DH
   JE @END

   @INPUT: 
     CMP AL, 30H
     JL @PLUS   

     CMP AL, 39H    
     JG @PLUS

     AND AX, 000FH  

     PUSH AX  

     MOV AX, 10 
     MUL BX
     MOV BX, AX

     POP AX

     ADD BX, AX

     MOV AH, 1
     INT 21H

     CMP AL, 0DH
     JNE @INPUT
                                   
   @END:

   OR CX, CX   
   JE @EXIT    
   NEG BX      

   @EXIT:      

   RET      
INDEC ENDP
                                                                         
END MAIN