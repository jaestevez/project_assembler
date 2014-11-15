.model small
.stack 256
.data
    VECT1 DB 06h,02h,08h,04h,05h,01h,07h,03h,09h,0Ah
    VECT2 DB 05h,09h,02h,07h,06h,0Ah,04h,03h,08,01h
    SUM DB ?,?,?,?,?,?,?,?,?,?
.code
.start  
    ; punteros SI y DI
    MOV AX,0E00h
    MOV SP,AX   
       
    VEC1:
        LEA BX,VECT1
        MOV BP,BX
        CALL ORDENAR
    
    VEC2:
        LEA BX,VECT2  
        MOV BP,BX
        CALL ORDENAR 
    CALL SUMA 
    CALL SALIR
    
    ORDENAR:   
        ;MOV AX,BP
        ;ADD AX,09h  
        ;CMP SI,AX
        ;JE SALIR    
        MOV SI,BP
        MOV CX,0FFFFh
        VECTOR:        
            MOV BX,SI
            MOV AL,[BX]
            
            MOV DI,SI
            INC DI
            MOV BX,DI
            MOV AH,[BX]
            SUB AH,AL  
            JC CAMBIO 
            
            INC SI 
            
        MOV AX,BP
        ADD AX,09h  
        CMP SI,AX
        JE SIG
        
        LOOP VECTOR  
        
        RET
        SIG:
            MOV CX,00h
            RET
    CAMBIO:
        MOV BX,SI
        MOV AL,[BX]
        MOV BX,DI
        MOV AH,[BX]
        
        MOV [BX],AL
        MOV BX,SI        
        MOV [BX],AH
        
        JMP ORDENAR
    SUMA:
        LEA SI,VECT1
        LEA DI,VECT2
        LEA BX,SUM  
        MOV CX,09h
        SUMANDO:   
            MOV DL,[SI]
            ADD DL,[DI]
            MOV [BX],DL
            INC SI
            INC DI
            INC BX
        LOOP SUMANDO
        
    SALIR:
        NOP
        .exit
END