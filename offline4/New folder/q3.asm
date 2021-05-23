INCLUDE "EMU8086.INC"
.MODEL SMALL
.STACK 100H

.DATA
    COUNT DW 1
    VAL DW ?   

.CODE
   MAIN PROC
    MOV AX, @DATA        
     MOV DS, AX
     
        MOV BX , 0
        MOV CX , 1
        
        CALL INDEC        
        MOV VAL , BX
        MOV BX , 0
        MOV CX , 1
        CALL FIBONACCI
     MOV AH, 4CH
     INT 21H
   MAIN ENDP
   
FIBONACCI PROC
    
    MOV AX , COUNT
    CMP AX , VAL
    JG RETURN 
    
    CMP COUNT , 1
    JE BASE1
    
    CMP COUNT , 2
    JE BASE2
    
    JMP ELSE_
    
    BASE1:
        CALL OUTDEC1
        INC COUNT
        CALL FIBONACCI
    
    BASE2:
        CALL OUTDEC1
        INC COUNT
        CALL FIBONACCI
    
    
    ELSE_:
        MOV AX , CX
        ADD CX , BX
        MOV BX , AX
        MOV AX , CX
        MOV AH , 2
        ;INT 21H
        PRINT ","
        INC COUNT
        CALL OUTDEC1
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

OUTDEC1 PROC
   
   MOV BX , AX
   CMP BX, 0
   JGE @START1 
   MOV AH, 2   
   MOV DL, "-" 
   INT 21H     

   NEG BX  

   @START1:

   MOV AX, BX
   XOR CX, CX
   MOV BX, 10

   @REPEAT1:   
     XOR DX, DX
     DIV BX    
     PUSH DX   
     INC CX    
     OR AX, AX 
   JNE @REPEAT1

   MOV AH, 2   

   @DISPLAY1:
     POP DX              
     OR DL, 30H      
     INT 21H            
   LOOP @DISPLAY1        

   RET            
OUTDEC1 ENDP
                                                                         
END MAIN