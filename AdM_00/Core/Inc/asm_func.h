#pragma once

#include <stdint.h>


void asm_svc (void);
uint32_t asm_sum (uint32_t firstOperand, uint32_t secondOperand);


// (1) función que inicializa un vector con ceros
void asm_zeros (uint32_t * vector, uint32_t longitud);

// (2) función que realiza el producto de un vector y un escalar (cambiar el nivel de amplitud de una señal)
void asm_asm_producto_escalar32 (uint32_t * vector_in, uint32_t * vector_out, uint32_t longitud, uint32_t escalar);

// (3) Adapte la función del ejercicio 2 para realizar operaciones sobre vectores de 16 bits
void asm_asm_producto_escalar16 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitud, uint16_t escalar);


// (4) Adapte la función del ejercicio 3 para saturar el resultado del producto a 12 bits
void asm_productoEscalar12 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitud, uint16_t escalar);


// (5) función que implemente un filtro de ventana móvil de 10 valores sobre un vector de muestras.
void asm_filtroVentana10(uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitudVectorIn);


// (6) función que reciba un vector de números signados de 32 bits y los “empaquete” en
//     otro vector de 16 bits. La función deberá adecuar los valores de entrada a la nueva precisión.
void asm_pack32to16 (int32_t * vectorIn, int16_t *vectorOut, uint32_t longitud);


// (7) función que reciba un vector de números signados de 32 bits y devuelva la posición del máximo del vector.
int32_t asm_max (int32_t * vectorIn, uint32_t longitud);


// (8) función que reciba un vector de muestras signadas de 32 bits y lo decime descartando una cada N muestras.
void asm_downsampleM (int32_t * vectorIn, int32_t * vectorOut, uint32_t longitud, uint32_t N);


// (9) función que reciba un vector de muestras no signadas de 16 bits e invierta su orden.
void asm_invertir (uint16_t * vector, uint32_t longitud);


/* (10) función que recibe un vector de 4096 valores de 16 bits (signados), que corresponden a muestras
		de audio tomadas a una tasa de muestreo de 44.100 muestras/s. La función
		debe introducir un “eco” de la mitad de la amplitud de la muestra original
		a los 20ms de comenzada la grabación.
		Nota: El eco consiste en adicionar a la señal original, la propia señal original dividida por dos y
		atrasada en 20ms, como muestra la ilustración debajo.
		Por qué la cantidad de muestras copiadas iguales es de 882?
		Variante: Una vez implementada la función, programar una nueva versión que utilice las
		instrucciones SIMD para optimizar la ejecución del algoritmo.
*/
//void asm_eco (int16_t * vectorIn);
void asm_eco (int16_t * vectorIn, int16_t * vectorEco, int32_t longitud, int32_t eco);

void asm_generaEco(int16_t *vectorIn, int16_t *vectorOut, uint32_t longitud, uint32_t msegRetardo);

void asm_generaEcoSIMD(int16_t *vectorIn, int16_t *vectorOut, uint32_t longitud, uint32_t msegRetardo);


// (11) función que calcule la correlación entre dos vectores. Luego optimice utilizando instrucciones SIMD.
void asm_corr (int16_t * vectorX, int16_t * vectorY, int16_t * vectorCorr, uint32_t longitud);
