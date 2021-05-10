org 100h

    section .text

                XOR CX, CX
                XOR AX, AX
                MOV CL, 5d
                MOV AL, 1d
                CMP CL, 00
                JZ salto

    condic      MUL CX 
                LOOP condic ; se realizan las iteraciones de 5! (hasta llegar a 120), terminando el bucle cuando el contador llega a cero
                            
    salto       MOV [20BH], AL; el resultado se guarda en 20BH

                int 20h;