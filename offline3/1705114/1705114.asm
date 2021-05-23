INCLUDE "EMU8086.INC"
.MODEL SMALL
.STACK 100H

.DATA
   TEMP DW ?
   TEMP2 DW ?
   SIGN DB ?

.CODE
   MAIN PROC
     MOV AX, @DATA        
     MOV DS, AX


     CALL INDEC     
     MOV TEMP , BX
     
     ;NEW LINE
     MOV AH , 2
     MOV DL , 0AH
     INT 21H
     MOV DL , 0DH
     INT 21H
     
     MOV AH , 1
     INT 21H
     MOV SIGN , AL
     
     
     ;NEW LINE
     MOV AH , 2
     MOV DL , 0AH
     INT 21H
     MOV DL , 0DH
     INT 21H
     
     CMP SIGN , '+'
     JE @CAL
     
     CMP SIGN , '-'
     JE @CAL
     
     CMP SIGN , '*'
     JE @CAL
     
     CMP SIGN , '/'
     JE @CAL
     
     CMP SIGN , 'q'
     JE ENDL
     
     PRINTN "Wrong operator"
     JMP ENDL
     
     @CAL:
     CALL INDEC    
     MOV TEMP2 , BX
     
     ;NEW LINE
     MOV AH , 2
     MOV DL , 0AH
     INT 21H
     MOV DL , 0DH
     INT 21H

     CALL OUTDEC1
     
     CMP SIGN , '+'
     JE ADDITION
     
     CMP SIGN , '-'
     JE SUBSTRACTION
     
     CMP SIGN , '*'
     JE MULTIPLICATION
     
     CMP SIGN , '/'
     JE DIVISION
     
     
     ADDITION:
        MOV DL , '+'
        INT 21H
        CALL OUTDEC2
        MOV DL , '='
        INT 21H
        MOV AX , TEMP
        ADD TEMP2 , AX
        CALL OUTDEC2
        JMP ENDL
        
        
     SUBSTRACTION:
        MOV DL , '-'
        INT 21H
        CALL OUTDEC2
        MOV DL , '='
        INT 21H
        MOV AX , TEMP2
        SUB TEMP , AX
        CALL OUTDEC1
        JMP ENDL
     
     MULTIPLICATION:
        MOV DL , '*'
        INT 21H
        CALL OUTDEC2
        MOV DL , '='
        INT 21H
        MOV AX , TEMP
        MOV BX , TEMP2
        IMUL BX 
        MOV TEMP2 , AX
        CALL OUTDEC2
        JMP ENDL
        
     DIVISION:
        MOV DL , '/'
        INT 21H
        CALL OUTDEC2
        MOV DL , '='
        INT 21H
        XOR DX ,DX
        MOV AX , TEMP
        MOV BX , TEMP2
        CWD
        IDIV BX 
        MOV TEMP2 , AX
        CALL OUTDEC2
        JMP ENDL   
     
     
     
     ENDL:
     
     MOV AH, 4CH
     INT 21H
   MAIN ENDP


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
   
   MOV BX , TEMP
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
                                                                          
OUTDEC2 PROC
   
   MOV BX , TEMP2
   CMP BX, 0
   JGE @START2 
   MOV AH, 2   
   MOV DL, "-" 
   INT 21H     

   NEG BX  

   @START2:

   MOV AX, BX
   XOR CX, CX
   MOV BX, 10

   @REPEAT2:   
     XOR DX, DX
     DIV BX    
     PUSH DX   
     INC CX    
     OR AX, AX 
   JNE @REPEAT2

   MOV AH, 2   

   @DISPLAY2:
     POP DX              
     OR DL, 30H      
     INT 21H            
   LOOP @DISPLAY2        

   RET            
OUTDEC2 ENDP
                                                                         
END MAIN