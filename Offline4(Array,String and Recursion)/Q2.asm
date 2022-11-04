INCLUDE "EMU8086.INC"
.MODEL SMALL
.STACK 100H

.DATA
    N DW ?
    COUNT DW 0

.CODE
   MAIN PROC
     MOV AX, @DATA        
     MOV DS, AX
     
     CALL INDEC
     MOV N , BX
     
     LP:
     MOV AX , COUNT
     PUSH AX
     CALL FIBONACCI     
     CALL OUTDEC
     INC COUNT
     MOV AX , COUNT
     CMP N , AX
     JE BRK
     PRINT ","
     JMP LP
        
     BRK:
     MOV AH, 4CH
     INT 21H
   MAIN ENDP
   
FIBONACCI PROC
    PUSH BP
    MOV BP , SP
    MOV AX , [BP+4]
    
    CMP AX , 00H
    JE RETURN
    CMP AX , 01H
    JE RETURN
    
ELSE_:
    MOV CX , [BP+4]
    DEC CX
    PUSH CX
    CALL FIBONACCI
    PUSH AX
    
    MOV CX , [BP+4]
    DEC CX
    DEC CX
    PUSH CX
    CALL FIBONACCI
    
    POP BX
    ADD AX , BX

RETURN:
       POP BP
       RET 2
       
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


OUTDEC PROC
   
   MOV BX , AX
   CMP BX, 0
   JGE @START 
   MOV AH, 2   
   MOV DL, "-" 
   INT 21H     

   NEG BX  

   @START:

   MOV AX, BX
   XOR CX, CX
   MOV BX, 10

   @REPEAT:   
     XOR DX, DX
     DIV BX    
     PUSH DX   
     INC CX    
     OR AX, AX 
   JNE @REPEAT

   MOV AH, 2   

   @DISPLAY:
     POP DX              
     OR DL, 30H      
     INT 21H            
   LOOP @DISPLAY        

   RET            
OUTDEC ENDP
     
END MAIN