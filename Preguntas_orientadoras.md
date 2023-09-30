# Arquitectura de Microprocesadores 

# Carrera de Especialización en Sistemas Embebidos - Universidad de Buenos Aires 

## Preguntas orientadoras 


#### 1. Describa brevemente los diferentes perfiles de familias de microprocesadores/microcontroladores de ARM. Explique alguna de sus diferencias características.



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

#### 1. Describa brevemente las diferencias entre las familias de procesadores Cortex M0, M3 y M4.

- `Cortex M0/M0+:` Pensados para una implementación mínima, de bajo consumo y bajo costo.

- `Cortex M3/M4/M7:` Agregan mayor performance, más funcionalidades (división por hardware), FPU, MPU, etc.

#### 2. ¿Por qué se dice que el set de instrucciones Thumb permite mayor densidad de código? Explique.

ARM incorporó un novedoso mecanismo llamado arquitectura “Thumb”. 
El set de instrucciones Thumb es una forma comprimida a 16 bits del set de instrucciones ARM de 32 bits original y emplea hardware dedescompresión dinámica en la instrucción pipeline, para descomprimir las instrucciones de 16 a 32 bits.
Por supuesto, la etapa extra requerida para manejar instrucciones de 16 bits afecta el rendimiento.
La densidad del código Thumb es mejor que la alcanzada por la mayoría de los procesadores CISCs.

 
#### 3.	¿Qué entiende por arquitectura load-store? ¿Qué tipo de instrucciones no posee este tipo de arquitectura? 

Como la mayoría de los procesadores RISCs, el ARM emplea una arquitectura carga-almacenamiento. Esto significa que el set de instrucciones solamente procesará (adición, substracción, etc.) valores que estén en los registros o directamente especificados dentro de la instrucción en sí misma y siempre se obtendrá el resultado de tales procesos en un registro. 

Las únicas operaciones que se aplican a la memoria son aquellas que copian datos de la memoria en los registros (instrucciones de carga) o copian datos de los registros en la memoria (instrucciones de almacenamiento).

**ARM no soporta operaciones memoria a memoria.** Por lo tanto todas las instrucciones ARM caen en una de las tres categorías siguientes:
- 1. Instrucciones que procesan datos. Solamente usan y modifican valores en registros. Una instrucción, por ejemplo, puede sumardos registros y ubicar el resultado en otro registro.
- 2. Instrucciones de transferencia de datos. Estas copian los datos de la memoria en registros (instrucciones de carga) o copian los datos de los registros en la memoria (instrucciones de almacenamiento). Una forma adicional, útil solamente en códigos de sistemas, intercambian un dato en memoria con un dato en un registro.
- 3. Instrucciones de control de flujo. Normalmente se ejecutan instrucciones ubicadas en direcciones de memorias consecutivas. Aunque frecuentemente el control del flujo de las instrucciones ocasiona que la ejecución conmute en una dirección diferente, ya sea en forma permanente (instrucciones de salto) o guarde una dirección de retorno para recuperar la secuencia original (instrucciones de salto y retorno) o ejecute un código de llamadas al supervisor del sistema, instrucciones tipo trapping, “atrapadas”.

En la arquitectura de carga-almacenamiento utilizada en ARM, las instrucciones se dividen en dos categorías: acceso a la memoria (carga y almacenamiento entre la memoria y los registros) y operaciones ALU (que solo ocurren entre los registros). A diferencia de una arquitectura de registro-memoria, como x86, donde uno de los operandos para una operación ADD puede estar en la memoria mientras que el otro está en un registro. Por lo tanto, las instrucciones que no se admiten en este tipo de arquitectura son aquellas que realizan operaciones directamente en posiciones de memoria.

En cuanto a la arquitectura ARM en general, se basa en una arquitectura RISC y utiliza el enfoque de carga-almacenamiento. Las instrucciones se dividen en dos categorías: acceso a la memoria (carga y almacenamiento entre la memoria y los registros) y operaciones ALU (que solo ocurren entre los registros)3. Esto significa que las operaciones se realizan principalmente entre registros y no directamente en posiciones de memoria.


#### 4.	¿Cómo es el mapa de memoria de la familia? 

El mapa de memoria de la familia ARM varía dependiendo del modelo específico y la implementación de la arquitectura. Sin embargo, en términos generales, la familia ARM utiliza una estructura de memoria en la que se divide el espacio de direcciones
en diferentes regiones.
A modo de descripción general del mapa de memoria típico de la familia ARM, podemos considerar la siguiente subdivisión de regiones:

* Zona de código (Code Section): Esta zona se utiliza para almacenar el código ejecutable, como las instrucciones del programa y las constantes. Es una región de solo lectura (read-only) y suele estar ubicada en la parte inferior del espacio de direcciones.
* Zona de datos (Data Section): Esta zona se utiliza para almacenar los datos del programa, como variables globales y estáticas. Puede ser de lectura y escritura (read-write) y suele estar ubicada en la parte superior del espacio de direcciones.
* Pila (Stack): La pila se utiliza para almacenar las variables locales y los registros de activación de las funciones. Generalmente crece hacia abajo en la memoria y se encuentra en la parte superior del espacio de direcciones.
* Montón (Heap): El montón se utiliza para almacenar datos dinámicos, como objetos o estructuras de datos creados en tiempo de ejecución. Generalmente crece hacia arriba en la memoria y se encuentra en la parte inferior del espacio de direcciones.
* Además de estas regiones principales, también puede haber otras regiones en el mapa de memoria, como zonas reservadas para el sistema operativo, controladores de dispositivos, tablas de vectores de interrupción, entre otros.
      
|------------------------------------|
|        Zona de código (ROM)        |
|------------------------------------|
|        Zona de código (RAM)        |
|------------------------------------|
|        Zona de datos (RAM)         |
|------------------------------------|
|               Pila                 |
|------------------------------------|
|               Montón               |
|------------------------------------|
|        Zona de dispositivos        |
|------------------------------------|     
|          Zona de sistema           |
|------------------------------------|

#### 5.	¿Qué ventajas presenta el uso de los “shadowed pointers” del PSP y el MSP? 

El uso de "shadowed pointers" (punteros en sombra) en el PSP (Process Stack Pointer) y el MSP (Main Stack Pointer) en la arquitectura ARM presenta varias ventajas:
* Seguridad: Los "shadowed pointers" permiten tener una copia de seguridad de los punteros de pila principales (PSP y MSP). 
Esto es útil en caso de que se produzca un desbordamiento de pila o un error en el programa, ya que se puede acceder a la copia en sombra para recuperar la integridad del sistema.
* Protección contra overflow (desbordamiento) de pila: El uso de "shadowed pointers" puede ayudar a detectar y proteger contra desbordamientos de pila. Si se produce un overflow en el PSP o el MSP, la copia en sombra se mantendrá intacta y se podrá utilizar para detectar el overflow y tomar medidas correctivas.
* Facilidad de depuración: Al tener una copia en sombra de los punteros de pila, se facilita la depuración de errores relacionados con la pila. Se pueden utilizar herramientas de depuración para comparar los valores de los punteros en sombra con los valores actuales y detectar cualquier discrepancia o anomalía.
* Recuperación de errores: En caso de que se produzca un error crítico en el programa y se pierda la integridad de los punteros de pila principales, los "shadowed pointers" pueden utilizarse para recuperar el sistema y restaurar los valores correctos de los punteros de pila.
En resumen, el uso de "shadowed pointers" en el PSP y el MSP proporciona una capa adicional de seguridad y protección contra desbordamientos de pila, facilita la depuración de errores relacionados con la pila y permite la recuperación del sistema en caso de errores críticos.

#### 6.	Describa los diferentes modos de privilegio y operación del Cortex M, sus relaciones y como se conmuta de uno al otro. Describa un ejemplo en el que se pasa del modo privilegiado a no priviligiado y nuevamente a privilegiado. 

El procesador Cortex-M de ARM utiliza un modelo de seguridad basado en modos de privilegio y operación para garantizar la protección y el aislamiento entre diferentes niveles de software. Los modos de privilegio y operación en el Cortex-M son los siguientes:
* Modo Handler (Privilegiado): Este modo es el más alto en términos de privilegios y se utiliza para ejecutar rutinas de manejo de excepciones y eventos, como interrupciones y excepciones de sistema. En este modo, se tiene acceso completo a todas las instrucciones y registros del procesador.
* Modo Thread (Privilegiado): Este modo se utiliza para la ejecución de tareas normales del programa. En este modo, se tiene acceso completo a todas las instrucciones y registros del procesador.
* Modo Unprivileged (No privilegiado): Este modo es el de menor privilegio y se utiliza para ejecutar tareas con restricciones de seguridad. En este modo, se restringe el acceso a ciertas instrucciones y registros del procesador, lo que ayuda a proteger el sistema operativo y las aplicaciones de software de posibles amenazas.
La conmutación entre los diferentes modos de privilegio y operación se realiza mediante el cambio de bits específicos en el registro de estado (PSR) del procesador. El bit de Control (CONTROL) en el PSR se utiliza para habilitar o deshabilitar el cambio de modo privilegiado a no privilegiado y viceversa.
A continuación, se describe un ejemplo de cómo se pasa del modo privilegiado al no privilegiado y nuevamente al modo privilegiado:
* Inicialmente, el procesador se encuentra en el modo privilegiado (Modo Handler o Modo Thread).
* Se ejecuta una instrucción que cambia el bit de Control en el PSR para habilitar el modo no privilegiado.
* A partir de ese momento, el procesador se encuentra en el modo no privilegiado, donde se restringe el acceso a ciertas instrucciones y registros.
* Durante la ejecución en el modo no privilegiado, se produce una excepción o interrupción.
* El procesador cambia automáticamente al modo privilegiado (Modo Handler) para manejar la excepción o interrupción.
* Una vez finalizada la rutina de manejo de excepciones, se ejecuta una instrucción que cambia nuevamente el bit de Control en el PSR para habilitar el modo privilegiado.
* A partir de ese momento, el procesador se encuentra nuevamente en el modo privilegiado (Modo Handler o Modo Thread).
No se puede regresar directamente del modo no privilegiado al modo privilegiado. Si se desea hacerlo, se debe disparar una interrupción o excepción que saque al sistema del modo no privilegiado y lo lleve al modo Handler (privilegiado); sólo estando en un modo privilegiado se puede cambiar el bit de control de PSR para habilitar el modo privilegiado. 

#### 7.	¿Qué se entiende por modelo de registros ortogonal? Dé un ejemplo 


#### 8.	¿Qué ventajas presenta el uso de intrucciones de ejecución condicional (IT)? Dé un ejemplo 


#### 9.	Describa brevemente las excepciones más prioritarias (reset, NMI, Hardfault).  


#### 10.	Describa las funciones principales de la pila. ¿Cómo resuelve la arquitectura el llamado a funciones y su retorno? 


#### 11.	Describa la secuencia de reset del microprocesador.  


#### 12.	¿Qué entiende por “core peripherals”? ¿Qué diferencia existe entre estos y el resto de los periféricos? 


#### 13.	¿Cómo se implementan las prioridades de las interrupciones? Dé un ejemplo 


#### 14.	¿Qué es el CMSIS? ¿Qué función cumple? ¿Quién lo provee? ¿Qué ventajas aporta? 


#### 15.	Cuando ocurre una interrupción, asumiendo que está habilitada ¿Cómo opera el microprocesador para atender a la subrutina correspondiente? Explique con un ejemplo 


#### 16.	¿Cómo cambia la operación de stacking al utilizar la unidad de punto flotante?


#### 17.	Explique las características avanzadas de atención a interrupciones: tail chaining y late arrival. 


#### 18.	¿Qué es el systick? ¿Por qué puede afirmarse que su implementación favorece la portabilidad de los sistemas operativos embebidos? 


#### 19.	¿Qué funciones cumple la unidad de protección de memoria (MPU)?  


#### 20.	¿Cuántas regiones pueden configurarse como máximo? ¿Qué ocurre en caso de haber solapamientos de las regiones? ¿Qué ocurre con las zonas de memoria no cubiertas por las regiones definidas? 


#### 21.	¿Para qué se suele utilizar la excepción PendSV? ¿Cómo se relaciona su uso con el resto de las excepciones? Dé un ejemplo 


#### 22.	¿Para qué se suele utilizar la excepción SVC? Expliquelo dentro de un marco de un sistema operativo embebido.

## ISA

#### 1.	¿Qué son los sufijos y para qué se los utiliza? Dé un ejemplo 


#### 2.	¿Para qué se utiliza el sufijo ‘s’? Dé un ejemplo 


#### 3.	¿Qué utilidad tiene la implementación de instrucciones de aritmética saturada? Dé un ejemplo con operaciones con datos de 8 bits. 


#### 4.	Describa brevemente la interfaz entre assembler y C ¿Cómo se reciben los argumentos de las funciones? ¿Cómo se devuelve el resultado? ¿Qué registros deben guardarse en la pila antes de ser modificados? 


#### 5.	¿Qué es una instrucción SIMD? ¿En qué se aplican y que ventajas reporta su uso? Dé un ejemplo.






