/*
 * App.c
 *
 *  Created on: 22 sep. 2023
 *      Author: CEO
 */

#include "App.h"
#include "asm_func.h"

// (1) función que inicializa un vector con ceros
void zeros (uint32_t * vector, uint32_t longitud)
{
	for (uint32_t i = 0; i < longitud; i++)
		{
	    	vector[i] = 0;
		}

}


// (2) función que realiza el producto de un vector y un escalar (cambiar el nivel de amplitud de una señal)
void productoEscalar32 (uint32_t * vectorIn, uint32_t * vectorOut, uint32_t longitud, uint32_t escalar)
{
	for (uint32_t i = 0; i < longitud; i++)
		{
	    	vectorOut[i] = vectorIn[i] * escalar;
		}

}


// (3) Adapte la función del ejercicio 2 para realizar operaciones sobre vectores de 16 bits
void productoEscalar16 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitud, uint16_t escalar)
{
	for (uint32_t i = 0; i < longitud; i++)
			{
		    	vectorOut[i] = vectorIn[i] * escalar;
			}

}


// (4) Adapte la función del ejercicio 3 para saturar el resultado del producto a 12 bits
void productoEscalar12 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitud, uint16_t escalar)
{

}

// (5) función que implemente un filtro de ventana móvil de 10 valores sobre un vector de muestras.
void filtroVentana10(uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitudVectorIn)
{

}








//#############################################################################

void PrivilegiosSVC()
{
	//Leemos el regitro CONTROL deberia dar 0
	uint32_t control = __get_CONTROL();

	control |= 0b01;
	__set_CONTROL(control);

	control = __get_CONTROL();

	control &= ~0b01;
	__set_CONTROL(control);

	asm_svc();

	control = __get_CONTROL();

}

// se agrega codigo en funcion void SVC_Handler(void) del archivo stm32f4xx_it.c
//	__set_CONTROL(0b00);

// funcion extraida del main, por lo que se quito la caracteristica static
//##############################################################################

