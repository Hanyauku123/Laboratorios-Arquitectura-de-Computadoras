        org     100h

        section .text

        XOR SI, SI;                           
        XOR DI, DI;
        XOR BX, BX;
        XOR CX, CX;
        XOR DX, DX;

        MOV     BP, arrByte     
        CALL    StoreArr        

        int     20h

        section .data

arrByte db      09,04,10,07,01,05,09     
divs equ        02

StoreArr:
        MOV     BL, divs       
iterar:  
        CMP     SI,10
        JE      end

        XOR     AX, AX; 
        MOV     AL, [BP+SI]
        MOV     BH,AL
        DIV     BL
        INC     SI

        CMP     AH, 0
        JE      par
        JNE     impar
        

par:
        MOV DI, CX    
        MOV     [300h+ DI], BH
        INC     DI
        MOV     CX, DI   
        jmp     iterar

impar:
        MOV DI, CX    
        MOV     [320h+DI], BH
        INC     DI
        MOV     DX, DI   
        jmp     iterar

end:    
        ret