# Arquitectura de Microprocesadores 

# Carrera de Especialización en Sistemas Embebidos - Universidad de Buenos Aires 

## Preguntas orientadoras 


> `1. Describa brevemente los diferentes perfiles de familias de microprocesadores/microcontroladores de ARM. Explique alguna de sus diferencias características.`



Los perfiles se definen de la siguiente manera:

`ARMv7-A`

`Application:` Son procesadores de **alto rendimiento** y están orientados a sistemas operativos embebidos de alta performance y **alto nivel de paralelismo**.

- Varios núcleos (alta frecuencia)
- “Mucha” memoria RAM
- Memoria caché…

`ARMv7-R`

`Realtime:` Son procesadores orientados a sistemas de tiempo real donde es necesario implementar soluciones de **baja latencia**, **alta predictibilidad** y **alta capacidad de cómputo**. Suelen utilizarse en **sistemas críticos**. Ejemplo: sistemas del automóvil
(control de tracción, frenos, etc.); dispositivos críticos: médicos, industriales, etc

`ARMv7-M`

`Microcontroller:` Son procesadores orientados a dispositivos de **consumo masivo** y sistemas **embebidos compactos**. Están diseñados para alta densidad de código y ser programados en C.


## Cortex M

> `1. Describa brevemente las diferencias entre las familias de procesadores Cortex M0, M3 y M4. `

- `Cortex M0/M0+:` Pensados para una implementación mínima, de bajo consumo y bajo costo.

- `Cortex M3/M4/M7:` Agregan mayor performance, más funcionalidades (división por hardware), FPU, MPU, etc.

> `2. ¿Por qué se dice que el set de instrucciones Thumb permite mayor densidad de código? Explique. `

ARM incorporó un novedoso mecanismo llamado arquitectura “Thumb”. 
El set de instrucciones Thumb es una forma comprimida a 16 bits del set de instrucciones ARM de 32 bits original y emplea hardware dedescompresión dinámica en la instrucción pipeline, para descomprimir las instrucciones de 16 a 32 bits.
Por supuesto, la etapa extra requerida para manejar instrucciones de 16 bits afecta el rendimiento.
La densidad del código Thumb es mejor que la alcanzada por la mayoría de los procesadores CISCs.

 
> `3.	¿Qué entiende por arquitectura load-store? ¿Qué tipo de instrucciones no posee este tipo de arquitectura?` 

Como la mayoría de los procesadores RISCs, el ARM emplea una arquitectura carga-almacenamiento. Esto significa que el set de instrucciones solamente procesará (adición, substracción, etc.) valores que estén en los registros o directamente especificados dentro de la instrucción en sí misma y siempre se obtendrá el resultado de tales procesos en un registro. 

Las únicas operaciones que se aplican a la memoria son aquellas que copian datos de la memoria en los registros (instrucciones de carga) o copian datos de los registros en la memoria (instrucciones de almacenamiento).

**ARM no soporta operaciones memoria a memoria.** Por lo tanto todas las instrucciones ARM caen en una de las tres categorías siguientes:
- 1. Instrucciones que procesan datos. Solamente usan y modifican valores en registros. Una instrucción, por ejemplo, puede sumardos registros y ubicar el resultado en otro registro.
- 2. Instrucciones de transferencia de datos. Estas copian los datos de la memoria en registros (instrucciones de carga) o copian los datos de los registros en la memoria (instrucciones de almacenamiento). Una forma adicional, útil solamente en códigos de sistemas, intercambian un dato en memoria con un dato en un registro.
- 3. Instrucciones de control de flujo. Normalmente se ejecutan instrucciones ubicadas en direcciones de memorias consecutivas. Aunque frecuentemente el control del flujo de las instrucciones ocasiona que la ejecución conmute en una dirección diferente, ya sea en forma permanente (instrucciones de salto) o guarde una dirección de retorno para recuperar la secuencia original (instrucciones de salto y retorno) o ejecute un código de llamadas al supervisor del sistema, instrucciones tipo trapping, “atrapadas”.

> `4.	¿Cómo es el mapa de memoria de la familia? `  
5.	¿Qué ventajas presenta el uso de los “shadowed pointers” del PSP y el MSP? 
6.	Describa los diferentes modos de privilegio y operación del Cortex M, sus relaciones y como se conmuta de uno al otro. Describa un ejemplo en el que se pasa del modo privilegiado a no priviligiado y nuevamente a privilegiado. 
7.	¿Qué se entiende por modelo de registros ortogonal? Dé un ejemplo 
8.	¿Qué ventajas presenta el uso de intrucciones de ejecución condicional (IT)? Dé un ejemplo 
9.	Describa brevemente las excepciones más prioritarias (reset, NMI, Hardfault).  
10.	Describa las funciones principales de la pila. ¿Cómo resuelve la arquitectura el llamado a funciones y su retorno? 
11.	Describa la secuencia de reset del microprocesador.  
12.	¿Qué entiende por “core peripherals”? ¿Qué diferencia existe entre estos y el resto de los periféricos? 
13.	¿Cómo se implementan las prioridades de las interrupciones? Dé un ejemplo 
14.	¿Qué es el CMSIS? ¿Qué función cumple? ¿Quién lo provee? ¿Qué ventajas aporta? 
15.	Cuando ocurre una interrupción, asumiendo que está habilitada ¿Cómo opera el microprocesador para atender a la subrutina correspondiente? Explique con un ejemplo 
16.	¿Cómo cambia la operación de stacking al utilizar la unidad de punto flotante?
17.	Explique las características avanzadas de atención a interrupciones: tail chaining y late arrival. 
18.	¿Qué es el systick? ¿Por qué puede afirmarse que su implementación favorece la portabilidad de los sistemas operativos embebidos? 
19.	¿Qué funciones cumple la unidad de protección de memoria (MPU)?  
20.	¿Cuántas regiones pueden configurarse como máximo? ¿Qué ocurre en caso de haber solapamientos de las regiones? ¿Qué ocurre con las zonas de memoria no cubiertas por las regiones definidas? 
21.	¿Para qué se suele utilizar la excepción PendSV? ¿Cómo se relaciona su uso con el resto de las excepciones? Dé un ejemplo 
22.	¿Para qué se suele utilizar la excepción SVC? Expliquelo dentro de un marco de un sistema operativo embebido.

## ISA

1.	¿Qué son los sufijos y para qué se los utiliza? Dé un ejemplo 
2.	¿Para qué se utiliza el sufijo ‘s’? Dé un ejemplo 
3.	¿Qué utilidad tiene la implementación de instrucciones de aritmética saturada? Dé un ejemplo con operaciones con datos de 8 bits. 
4.	Describa brevemente la interfaz entre assembler y C ¿Cómo se reciben los argumentos de las funciones? ¿Cómo se devuelve el resultado? ¿Qué registros deben guardarse en la pila antes de ser modificados? 
5.	¿Qué es una instrucción SIMD? ¿En qué se aplican y que ventajas reporta su uso? Dé un ejemplo.






