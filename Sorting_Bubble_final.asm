;/////========= Title:-         Implement sorting algorithms          ======//////    

 
;  Description: Write a program for storing 100 elements in random order and sort them
;               in descending order and in ascending order.(use comparison based sorting
;               technique:- Bubble)        

;   Authors:-Anurag Kandalkar
;          :-Shreyansh Shrey  
;          :-Mritunjuoy Chowdhary

ORG 100H

include 'emu8086.inc'

;/////=========DATA  SEGMENT TO DECLARE VARIABLE AND DATA======//////
.DATA
    LEN DW 10            ;Store the size of the array
    ARR DW 100 DUP(?)    ;Declare the array with null values    
    ARR2 DW 100 DUP(?)   ;Declare the array with null values 
    i DW 0               ; Act as loop variable
    j DW 0               ; Act as loop variable
         
                                                                  
                                                                  
;/////=========CODE SEGMENT ======//////
                                                                  
                                                                                                                                   
.CODE  
    ;/////=========MAIN PROCEDURE WHERE ALL OTHER PROCEDURES ARE CALLED ======//////
    MAIN PROC  
        CALL Take_Input             ; Procedure to take input 
        PRINTN 'Sorting...'         ;Displays "Sorting" on the scree
        PRINTN                      ;Moves to New Line
        CALL SORT_ASCEND            ; Procedure to sort the array in ascending order    
        CALL SORT_DESCEND           ; Procedure to sort the array in descending order    
        PRINTN 'Array Sorted!'      ;Displays "Array Sorted" on the screen
        PRINTN                      ;Moves to New Line
        PRINT 'The Ascending order:';Displays "The Ascending order" on the screen
        PRINTN                      ;Moves to New Line
        CALL PRINT_ASC              ; Procedure to print the Ascending array
        PRINT 'The Descending order:';Displays "The Descending order" on the scree
        PRINTN                      ;Moves to New Line
        CALL PRINT_DES              ; Procedure to print the Descending array
    MAIN ENDP

RET   


;/////=========Procdure for Taking input of 10 number ======//////


Take_Input PROC 
    PRINT 'Enter the values of the array: (Press enter after every value)'
    PRINTN 
    MOV AX , LEN                ;AX=LEN=10
    AND AX, 0FH                 ;To convert Hexa-Decimal to Integer
    input:  CALL scan_num       ;Calling predefined function scan_num to take input and it stores in CX
        MOV ARR[SI] , CX        ;ARR[SI]=CX   Storing the value into array ARR
        MOV ARR2[SI] , CX       ;ARR2[SI]=CX   Storing the value into array ARR2
        PRINTN                  ;Moves to New Line
        ADD SI, 2               ;SI=SI+2
        SUB AX, 1               ;AX=AX-1
        JNZ input
   
RET       
Take_Input ENDP 


;/////=========Procdure for Sorting and Storing the Ascending order(DS:2000H) of array  ======//////


SORT_ASCEND PROC
                 
 mov CX,LEN
 Sub CX,1
Outer:MOV SI,0000
      MOV DX,00
      MOV j,DX
      Inner:MOV DI,SI;
            ADD DI,2
            Mov Bx,ARR[SI]
            MOV DX,ARR[DI]             
            CMP BX,DX
            JLE next:
                XCHG BX,DX 
                MOV ARR[SI], BX
                MOV ARR[DI], DX
            next:
                 MOV SI,DI
                 MOV BX,LEN
                 SUB BX,i
                 SUB BX,1
                 MOV AX,j
                 ADD AX,1;
                 MOV j,AX
                 CMP  AX,BX 
                 JL Inner
       MOV AX,i
       ADD AX,1
       MOV i,AX          
                 
LOOP outer
MOV SI,0000
MOV AX,2000H
MOV ES,AX
MOV DI,2000H
MOV CX , LEN 
  STORE_ASC:
        MOV AX,ARR[SI] 
        MOV ES:[DI],AX
        ADD SI, 2
        ADD DI, 2
        SUB CX, 1
        JNZ STORE_ASC                   
RET     
SORT_ASCEND ENDP 


;/////=========Procdure for Sorting and Storing the Descending order(DS:3000H) of array  ======//////


SORT_DESCEND PROC
 mov ax,00h;
 mov i,ax;                
 mov CX,LEN
 Sub CX,1
Outer2:MOV SI,0000
      MOV DX,00
      MOV j,DX
      Inner2:MOV DI,SI;
            ADD DI,2
            Mov Bx,ARR2[SI]
            MOV DX,ARR2[DI]             
            CMP BX,DX
            JG next2:
                XCHG BX,DX 
                MOV ARR2[SI], BX
                MOV ARR2[DI], DX
            next2:
                 MOV SI,DI
                 MOV BX,LEN
                 SUB BX,i
                 SUB BX,1
                 MOV AX,j
                 ADD AX,1;
                 MOV j,AX
                 CMP  AX,BX 
                 JL Inner2
       MOV AX,i
       ADD AX,1
       MOV i,AX          
                 
LOOP outer2
MOV SI,0000
MOV AX,2000H
MOV ES,AX
MOV DI,3000H
MOV CX , LEN 
  STORE_DES:
        MOV AX,ARR2[SI]  
        MOV ES:[DI],AX
        ADD SI, 2
        ADD DI, 2
        SUB CX, 1
        JNZ STORE_DES                      
RET     
SORT_DESCEND ENDP
 
  
;/////=========PRINTING ASC ORDER STORED AT ES:2000H DI:2000H ======////// 
 

PRINT_ASC PROC     
    MOV AX,2000H      ;AX=2000H
    MOV ES,AX         ;ES=AX=2000H
    MOV DI , 2000H    ;DI=2000H
    MOV CX , LEN      ;CX=LEN=10
    AND CX, 0FH       ;To convert Hexa-Decimal to Integer
    array: 
        MOV AX, ES:[DI]   ;AX=ES:[DS]=2000:[2000]
        ADD DI, 2         ;DI=DI+2
        CALL print_num    ;Calling predefined function print_num to print the number stored in AX
        PRINT ' '         ;Moves to New Line
        SUB CX, 1         ;CX=CX-1
        JNZ array
    PRINTN
    
RET
PRINT_ASC ENDP          ;END OF PROCEDURE PRINT_ASC


;/////=========PRINTING DESC ORDER STORED AT ES:2000H DI:3000H ======//////


PRINT_DES PROC 
    MOV AX,2000H     ;AX=2000H
    MOV ES,AX        ;ES=AX=2000H
    MOV DI , 3000H   ;DI=3000H
    MOV CX , LEN     ;CX=LEN=10
    AND CX, 0FH       ;To convert Hexa-Decimal to Integer 
    array2: 
        MOV AX, ES:[DI]  ;AX=ES:[DS]=2000:[3000]
        ADD DI, 2        ;DI=DI+2
        CALL print_num   ;Calling predefined function print_num to print the number stored in AX
        PRINT ' '        ;Moves to New Line
        SUB CX, 1        ;CX=CX-1
        JNZ array2
    PRINTN               ;Moves to New Line
    
RET
PRINT_DES ENDP     ;END OF PROCEDURE PRINT_DES






;/////========= DEFINING PREDIFNED FUNCTIONS ======//////
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM_UNS
END