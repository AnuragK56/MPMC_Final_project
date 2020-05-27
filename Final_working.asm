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
    ARR2 DW  25,33,1,72,69,71,23,31,84,45,29,6,54,19,41,52,79,47,32,57,63,66,70,4,61,50,80,93,5,14,7,85,95,92,65,17,77,73,97,43,49,37,76,94,48,51,83,98,62,81,82,91,30,12,28,9,34,20,96,89,42,8,58,64,40,21,3,2,59,99,87,53,35,16,86,74,22,90,60,36,55,44,24,75,18,27,13,67,88,39,10,68,26,46,11,15,38,56,78,0    ;Declare the array with null values 
    i DW 0               ; Act as loop variable
    j DW 0               ; Act as loop variable
    r DW 4               ; Variable used for deciding factor of Random
         
                                                                  
                                                                  
;/////=========CODE SEGMENT ======//////
                                                                  
                                                                                                                                   
.CODE  
    ;/////=========MAIN PROCEDURE WHERE ALL OTHER PROCEDURES ARE CALLED ======//////
    MAIN PROC  
        CALL RANDOMIZE              ; Procedure Randomly store the elements in array
        PRINTN 'Sorting...'         ;Displays "Sorting" on the screen`
        PRINTN                      ;Moves to New Line
        CALL SORT_ASCEND            ; Procedure to sort the array in ascending order    
        CALL SORT_DESCEND           ; Procedure to sort the array in descending order    
        PRINTN 'Array Sorted!'      ;Displays "Array Sorted" on the screen
        PRINTN                      ;Moves to New Line
        PRINTn 'The Ascending order:';Displays "The Ascending order" on the screen
        PRINTN                      ;Moves to New Line
        CALL PRINT_ASC              ; Procedure to print the Ascending array
        PRINTN 'The Descending order:';Displays "The Descending order" on the scree
        PRINTN                      ;Moves to New Line
        CALL PRINT_DES              ; Procedure to print the Descending array  
        RET  
    MAIN ENDP

 
 
;/ 
RANDOMIZE PROC
    MOV SI ,0000H   
    MOV DI ,00002H      
    MOV CX , 100
array3:
    MOV AX, ARR2[SI] 
    MOV DX, ARR2[DI] 
    XCHG AX,DX
    MOV ARR2[SI],AX 
    MOV  ARR2[DI],DX
    MOV BX,r
    ADD DI, BX
    ADD SI, BX
    SUB CX, 1
    JNZ array3
PRINTN
RET

RANDOMIZE ENDP

;/////=========Procdure for Sorting and Storing the Ascending order(DS:2000H) of array  ======//////
SORT_ASCEND PROC
                 
 mov CX,LEN   ;CX=LEN=10
 Sub CX,1     ; CX=CX-1
Outer:MOV SI,0000                ;SI=0000H 
      MOV DX,00                  ;DX=0000
      MOV j,DX                   ;j=DX
      Inner:MOV DI,SI;           ;DI=SI
            ADD DI,2             ;DI=DI+2
            Mov Bx,ARR2[SI]       ;BX=ARR[SI]
            MOV DX,ARR2[DI]       ;DX=ARR[DI]      
            CMP BX,DX            ;Comparing BX with DX
            JLE next:            ;Jump if less than or equal to next
                XCHG BX,DX       ;Swapping values of BX and DX
                MOV ARR2[SI], BX  ;ARR[SI]=BX
                MOV ARR2[DI], DX  ;ARR[DI]=DX
            next:
                 MOV SI,DI       ;SI=DI
                 MOV BX,LEN      ;BX=LEN
                 SUB BX,i        ;BX=BX-i
                 SUB BX,1        ;BX=BX-1
                 MOV AX,j        ;AX=j
                 ADD AX,1;       ;AX=AX+1
                 MOV j,AX        ;j=AX
                 CMP  AX,BX      ;Comparing AX with BX
                 JL Inner        ;Jump if less than to Inner
       MOV AX,i                  ;AX=i
       ADD AX,1                  ;AX=AX+1
       MOV i,AX                  ;i=AX                         
LOOP outer                       ;While CX!=0 go back to outer
MOV SI,0000                      ;SI=0000
MOV AX,2000H                     ;AX=2000H
MOV ES,AX                        ;ES=AX=2000H
MOV DI,2000H                     ;DI=2000H
MOV CX , LEN                     ;CX=LEN=10
  STORE_ASC:                     
        MOV AX,ARR2[SI]           ;AX=ARR[SI]
        MOV ES:[DI],AX           ;ES:[DI]=AX
        ADD SI, 2                ;SI=SI+2
        ADD DI, 2                ;DI=DI+2
        SUB CX, 1                ;CX=CX-1
        JNZ STORE_ASC            ;Jump if not zero to STORE_ASC       
RET     
SORT_ASCEND ENDP                 ;END OF PROCEDURE SORT_ASCEND
 


;/////=========Procdure for Sorting and Storing the Descending order(DS:3000H) of array  ======//////


SORT_DESCEND PROC
 mov AX,00h                      ;AX=00h
 mov i,AX                        ;i=AX=00
 mov CX,LEN                      ;CX=LEN=10
 Sub CX,1                        ;CX=CX-1
Outer2:MOV SI,0000               ;SI=0000H 
      MOV DX,00                  ;DX=0000
      MOV j,DX                   ;j=DX
      Inner2:MOV DI,SI;          ;DI=SI
            ADD DI,2             ;DI=DI+2
            Mov Bx,ARR2[SI]       ;BX=ARR[SI]
            MOV DX,ARR2[DI]       ;DX=ARR[DI]      
            CMP BX,DX            ;Comparing BX with DX
            JG next2             ;Jump greater to next2
                XCHG BX,DX       ;Swapping values of BX and DX
                MOV ARR2[SI], BX  ;ARR[SI]=BX
                MOV ARR2[DI], DX  ;ARR[DI]=DX
            next2:
                 MOV SI,DI       ;SI=DI
                 MOV BX,LEN      ;BX=LEN
                 SUB BX,i        ;BX=BX-i
                 SUB BX,1        ;BX=BX-1
                 MOV AX,j        ;AX=j
                 ADD AX,1;       ;AX=AX+1
                 MOV j,AX        ;j=AX
                 CMP  AX,BX      ;Comparing AX with BX
                 JL Inner2        ;Jump if less than to Inner2
       MOV AX,i                  ;AX=i
       ADD AX,1                  ;AX=AX+1
       MOV i,AX                  ;i=AX
       
                                
LOOP outer2                      ;While CX!=0 go back to outer2
MOV SI,0000                      ;SI=0000H
MOV AX,2000H                     ;AX=2000H
MOV ES,AX                        ;ES=AX=2000H
MOV DI,3000H                     ;DI=3000H
MOV CX , LEN                     ;CX=LEN=10
  STORE_DES:
        MOV AX,ARR2[SI]          ;AX=ARR2[SI]
        MOV ES:[DI],AX           ;ES:[DI]=AX
        ADD SI, 2                ;SI=SI+2
        ADD DI, 2                ;DI=DI+2
        SUB CX, 1                ;CX=CX-1
        JNZ STORE_DES            ;Jump if not zero to STORE_DES          
RET     
SORT_DESCEND ENDP         ;END OF PROCEDURE SORT_DESCEND
 
  
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
    MOV AX,2000H         ;AX=2000H
    MOV ES,AX            ;ES=AX=2000H
    MOV DI , 3000H       ;DI=3000H
    MOV CX , LEN         ;CX=LEN=10
    AND CX, 0FH          ;To convert Hexa-Decimal to Integer 
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
RET
END
