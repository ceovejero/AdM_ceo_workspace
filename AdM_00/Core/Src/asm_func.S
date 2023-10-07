.syntax unified
.thumb
.text

@ Simbolos exportados --> No olvidar de colocar los nombres de las funciones aquí
.global asm_svc
.global asm_sum
.global asm_zeros
.global asm_producto_escalar32
.global asm_producto_escalar16
.global asm_eco
.global asm_generaEco
.global asm_generaEcoSIMD


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_svc (void)
@
.thumb_func
    asm_svc:
        svc 0		//supervisor call
        bx lr


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   uint32_t asmSum (uint32_t firstOperand, uint32_t secondOperand)
@
@ Parametros recibidos:
@   r0: firstOperand
@   r1: secondOperand
@
@ Valor de retorno:
@   r0: resultado de la suma de firstOperand y secondOperand
@
.thumb_func
    asm_sum:
        add r0, r1  @ r0 = r0 + r1
        bx lr       @ vuelve adonde fue llamada (especificamente, si "pc"
                    @ es la direccion, en el codigo del programa, de la
                    @ instruccion "bl asm_sum" usada para saltar a
                    @ esta funcion, entonces "lr" contiene ese "pc" + 4).
                    @ el valor de retorno debe quedar en el registro r0.
                    @ En este caso, r0 es el resultado de r0 + r1.

        @ Otras alternativas para el retorno
        @ mov pc,lr
        @ bx lr
        @ push {lr} ... pop {pc}


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_zeros (uint32_t * vector, uint32_t longitud);
@
@ Parametros recibidos:
@   r0: vector
@   r1: longitud
@
@
.thumb_func
    asm_zeros:
    	// Guardas de seguridad
    	cbz r0, exit
    	cbz r1, exit

        mov r2, #0  @ Cargo el literal 0 en r2

        loop:
        	subs r1, #1 //Decremento en 1 el contador
        	str r2, [r0, r1, LSL #2] // *(r0 + (r1<<2)) = r2
        	bne loop

        exit:
        	bx lr       @ vuelve adonde fue llamada (especificamente, si "pc"
            	        @ es la direccion, en el codigo del programa, de la
                	    @ instruccion "bl asm_sum" usada para saltar a
                    	@ esta funcion, entonces "lr" contiene ese "pc" + 4).
            	        @ el valor de retorno debe quedar en el registro r0.
                	    @ En este caso, r0 es el resultado de r0 + r1.

		@ Otras alternativas para el retorno
		@ mov pc,lr
		@ bx lr
		@ push {lr} ... pop {pc}


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_producto_escalar32(uint32_t* vector_in, uint32_t* vector_out, uint32_t longitud, uint32_t escalar);
@
@ Parametros recibidos:
@   r0: vector_in
@   r1: vector_out
@   r2: longitud
@   r3: escalar
@
.thumb_func
    asm_producto_escalar32:
        // Guardas de seguridad. Tener mas en cuenta para divisiones por 0
        // cbz r0, exit_producto_escalar32
        // cbz r1, exit_producto_escalar32
        // cbz r2, exit_producto_escalar32
        // cbz r3, exit_producto_escalar32

        push {r4}

        loop_producto_escalar32:
            subs r2, #1 // Decremento en uno el "contador"

            ldr r4, [r0, r2, LSL #2] // Guardo en r4 (auxiliar) *(r0 + (r2<<2)) = r4

            //mul Rd, Rn, Rm -> Rd = Rn*Rm
            mul r4, r4, r3 // r4 = r4*r3 (r3 ganancia)
            str r4, [r1, r2, LSL #2] // *(r1 + (r2<<2)) = r4 (equivalente a decir que escribo el producto por un escalar en el vector de salida)

            bne loop_producto_escalar32


        pop {r4}
        exit_producto_escalar32:
            bx lr       @ vuelve adonde fue llamada (especificamente, si "pc"
                        @ es la direccion, en el codigo del programa, de la
                        @ instruccion "bl asm_sum" usada para saltar a
                        @ esta funcion, entonces "lr" contiene ese "pc" + 4).
                        @ el valor de retorno debe quedar en el registro r0.
                        @ En este caso, r0 es el resultado de r0 + r1.

        @ Otras alternativas para el retorno
        @ mov pc,lr
        @ bx lr
        @ push {lr} ... pop {pc}

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_producto_escalar16(uint16_t* vector_in, uint16_t* vector_out, uint32_t longitud, uint16_t escalar);
@
@ Parametros recibidos:
@   r0: vector_in
@   r1: vector_out
@   r2: longitud
@   r3: escalar
@
.thumb_func
    asm_producto_escalar16:
        // Guardas de seguridad. Tener mas en cuenta para divisiones por 0
        // cbz r0, exit_producto_escalar32
        // cbz r1, exit_producto_escalar32
        // cbz r2, exit_producto_escalar32
        // cbz r3, exit_producto_escalar32

        push {r4}

        loop_producto_escalar16:
            subs r2, #1 // Decremento en uno el "contador"

            ldrh r4, [r0, r2, LSL #1] // Guardo en r4 (auxiliar) *(r0 + (r2<<1)) = r4

            //mul Rd, Rn, Rm -> Rd = Rn*Rm
            mul r4, r4, r3 // r4 = r4*r3 (r3 ganancia)
            strh r4, [r1, r2, LSL #1] // *(r1 + (r2<<1)) = r4 (equivalente a decir que escribo el producto por un escalar en el vector de salida)

            bne loop_producto_escalar16


        pop {r4}
        exit_producto_escalar16:
            bx lr       @ vuelve adonde fue llamada (especificamente, si "pc"
                        @ es la direccion, en el codigo del programa, de la
                        @ instruccion "bl asm_sum" usada para saltar a
                        @ esta funcion, entonces "lr" contiene ese "pc" + 4).
                        @ el valor de retorno debe quedar en el registro r0.
                        @ En este caso, r0 es el resultado de r0 + r1.

        @ Otras alternativas para el retorno
        @ mov pc,lr
        @ bx lr
        @ push {lr} ... pop {pc}

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@













@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_eco (int16_t * vectorIn, int16_t * vectorEco, uint32_t longitud, uint32_t eco);
@
@ Parametros recibidos:
@   r0: vectorIn
@   r1: vectorEco
@   r2: longitud
@   r3: eco
@
.thumb_func
    asm_eco:
        // Guardas de seguridad. Tener mas en cuenta para divisiones por 0
        // cbz r0, exit_producto_escalar32
        // cbz r1, exit_producto_escalar32
        // cbz r2, exit_producto_escalar32
        // cbz r3, exit_producto_escalar32

        push {r4-r5}
		//subs r2, #1 // Decremento en uno el "contador"
        loop10:
        	subs r2, #1 // Decremento en uno el "contador"
            cmp r2,r3
            it mi
            bmi saltar


            ldrh r4, [r0, r2, LSL #1] // Guardo en r4 (auxiliar) *(r0 + (r2<<1)) = r4
			asr r5, r4, #1    //divido x 2 r4 y guardo en r5
			add r5, r5,r4     // sumo r4 con r5 y guardo en r5
			ssat r4, #16, r5					// agrego saturacion
			strh r5, [r1, r2, lsl #1]   // guardo r5 en r1 en donde apunta r2
			b otroSalto

		saltar:
			ldrh r4, [r0, r2, LSL #1] // Guardo en r4 (auxiliar) *(r0 + (r2<<1)) = r4
			mov r5, r4
			strh r5, [r1, r2, lsl #1]   // guardo r5 en r1 en donde apunta r2

		otroSalto:
			//sub r2, 1
			cbz r2, exit10
			b loop10


        exit10:
        	pop {r4-r5}
            bx lr       @ vuelve adonde fue llamada (especificamente, si "pc"
                        @ es la direccion, en el codigo del programa, de la
                        @ instruccion "bl asm_sum" usada para saltar a
                        @ esta funcion, entonces "lr" contiene ese "pc" + 4).
                        @ el valor de retorno debe quedar en el registro r0.
                        @ En este caso, r0 es el resultado de r0 + r1.

        @ Otras alternativas para el retorno
        @ mov pc,lr
        @ bx lr
        @ push {lr} ... pop {pc}

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@




@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_generaEco(int16_t *vectorIn, int16_t *vectorOut, uint32_t longitud, uint32_t msegRetardo)
@
@ Parametros recibidos:
@   r0: dirección del vector entrada
@   r1: dirección del vector de salida
@   r2: longitud
@   r3: retardo del eco
@
@ Valor de retorno: Nada
@

#define SAMPLE_FREQ	44100

.thumb_func
    asm_generaEco:
    	push {r4-r10}
    	// Calcular muestra a partir de donde se inicia el eco --> r4
    	// La cuenta es SampleOffset = msegRetardo*SAMPLE_FREQ/1000
    	mov r4, #SAMPLE_FREQ  // r4 será el límite a partir de donde se aplicará el eco
    	mul r4, r4, r3    // r4 = SAMPLE_FREQ*msegRetardo
    	mov r3, #1000  // Se recicla r3 --> 1000 por que son milisegundos, y la frecuencia está en segundos
    	udiv r4, r4, r3  // r4 = r4/1000 (para el ej 10 debería da 882)
    	sub r2, #1  // longitud = longitud - 1
    	mov r6, #-1

    _for9:
    	sub r3, r2, r4  // Se recicla r3 = longitud - muestraEco(882 en el ejemplo)
    	ldrsh r5, [r0, r2, LSL #1]  // Desde la última muestra
    	ldrsh r6, [r0, r3, LSL #1]  // Desde la muestra del eco
    	asr r6, #1	// Muestra de eco dividido por dos
    	add r5, r5, r6 // Se compone la muestra con el eco
    	ssat r6, #16, r5
    	strh r6, [r1, r2, LSL #1] // Se guarda con el índice r2
    	cmp r2, r4  // Si el índice es igual al offset del eco, se debe dejar de añadir
    	sub r2, #1	// Se decrementa el índice, sin modificar el APSR
    	bne _for9

    _for10:
    	// Muestras sin eco
    	ldrh r5, [r0, r2, LSL #1]
    	strh r5, [r1, r2, LSL #1]
    	subs r2, #1
    	bne _for10

    	pop {r4-r10}
        bx lr       @ vuelve adonde fue llamada (especificamente, si "pc"
                    @ es la direccion, en el codigo del programa, de la
                    @ instruccion "bl asm_sum" usada para saltar a
                    @ esta funcion, entonces "lr" contiene ese "pc" + 4).
                    @ el valor de retorno debe quedar en el registro r0.
                    @ En este caso, r0 es el resultado de r0 + r1.

        @ Otras alternativas para el retorno
        @ mov pc,lr
        @ bx lr
        @ push {lr} ... pop {pc}

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_generaEcoSIMD(int16_t *vectorIn, int16_t *vectorOut, uint32_t longitud, uint32_t msegRetardo)
@
@ Parametros recibidos:
@   r0: dirección del vector entrada
@   r1: dirección del vector de salida
@   r2: longitud
@   r3: retardo del eco
@
@ Valor de retorno: Nada
@

.thumb_func
    asm_generaEcoSIMD:
    	push {r4-r10}
    	// Calcular muestra a partir de donde se inicia el eco --> r4
    	// La cuenta es SampleOffset = msegRetardo*SAMPLE_FREQ/1000
    	mov r4, #SAMPLE_FREQ  // r4 será el límite a partir de donde se aplicará el eco
    	mul r4, r4, r3    // r4 = SAMPLE_FREQ*msegRetardo
    	mov r3, #1000  // Se recicla r3 --> 1000 por que son milisegundos, y la frecuencia está en segundos
    	udiv r4, r4, r3  // r4 = r4/1000 (para el ej 10 debería da 882)
    	lsr r4, #1 // Como ahora se cargan 2 registros los índices se dividen por 2
    	lsr r2, #1 // Como ahora se cargan 2 registros los índices se dividen por 2
    	sub r2, #1  // longitud = longitud - 1
    	mov r7, #0  // Es un registro dummy, para poder hacer la atenuación por 2 (shift a la derecha) en la muestra con eco

    _for11:
    	// Como ahora se cargan 2 registros los índices se incrementan el doble
    	sub r3, r2, r4  // Se recicla r3 = (longitud - muestraEco)/2 --> (441 en el ejemplo)
    	ldr r5, [r0, r2, LSL #2]  // Desde la última muestra (ahora se cargan 32 bits)
    	ldr r6, [r0, r3, LSL #2]  // Desde la muestra del eco (ahora se cargan 32 bits)
    	shadd16 r6, r6, r7 // muestra de eco dividido por 2 (r7 = 0, por lo que no afecta a r6)
    	qadd16 r6, r6, r5	// r6 = sat(r6 + r5, 16bits)
    	str r6, [r1, r2, LSL #2] // Se guarda con el índice r2
    	cmp r2, r4  // Si el índice es igual al offset del eco, se debe dejar de añadir
    	sub r2, #1	// Se decrementa el índice, sin modificar el APSR
    	bne _for11

    _for12:
    	// Muestras sin eco
    	ldrh r5, [r0, r2, LSL #1]
    	strh r5, [r1, r2, LSL #1]
    	subs r2, #1
    	bne _for12

    	pop {r4-r10}
        bx lr       @ vuelve adonde fue llamada (especificamente, si "pc"
                    @ es la direccion, en el codigo del programa, de la
                    @ instruccion "bl asm_sum" usada para saltar a
                    @ esta funcion, entonces "lr" contiene ese "pc" + 4).
                    @ el valor de retorno debe quedar en el registro r0.
                    @ En este caso, r0 es el resultado de r0 + r1.

        @ Otras alternativas para el retorno
        @ mov pc,lr
        @ bx lr
        @ push {lr} ... pop {pc}


