.model small
.stack 256
.data
    VECT1 DB 06h,02h,08h,04h,05h,01h,07h,03h,09h,0Ah
    VECT2 DB 14h,0Eh,0Dh,0Ch,0Fh,12h,11h,10h,0Bh,13h
    SUM DB ?,?,?,?,?,?,?,?,?,?
.code
.start  
    ; punteros SI y DI
       
    ORD_VEC1:
        LEA BX,VECT1
        MOV BP,BX
        CALL ORDENAR
    
    ORD_VEC2:
        LEA BX,VECT2  
        MOV BP,BX
        CALL ORDENAR 
        
    SUMAR1:
        LEA SI,VECT1
        LEA DI,VECT2
        LEA BX,SUM
        CALL SUMA 
        
    CALL SALIR
    
    ORDENAR:  
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
        JE SIG ; TERMINACION CICLO
        
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
        MOV DX,00h;SUMA VECTORES
          
        ;vectores entrada en SI yDI
        ;vector resultado BX
         
        MOV CX,0Ah
        SUMANDO:   
            ADD DH,[SI];SUMA VECTOR1
            ADD DL,[DI];SUMA VECTOR2
            
            MOV AL,[SI]
            ADD AL,[DI]
            MOV [BX],AL
            INC SI
            INC DI
            INC BX
        LOOP SUMANDO
        RET
        
    SALIR:
        NOP
        .exit
END