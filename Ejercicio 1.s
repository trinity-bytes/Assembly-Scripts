; Programa para realizar una operacion matematica compuesta
; *********************************************************

	JMP start		; Vamos a a equiqueta de inicio del programa

; Se agregan variables para almacenar cada numero de la operacion, asi como los resultados de las mismas y una para la conversion ascii
num1: DB 10			; Primer numero
num2: DB 2			; Segundo numero
num3: DB 30			; Tercer numero
num4: DB 3			; Cuarto numero
num5: DB 7			; Quinto numero
num6: DB 3			; Sexto numero
num7: DB 2			; Septimo numero
resultado1: DB 0		; Almacena resultado de 10/2
resultado2: DB 0		; Almacena resultado de 30/3
resultado3: DB 0		; Almacena resultado de (7+3)
resultado4: DB 0		; Almacena resultado de (7+3)*2
resultado_final: DB 0		; Almacena resultado final
ascii: DB 48			; Variable ASCII

start:				; Iniciamos el programa

; PASO 1: Calculamos 10/2
	MOV A, [num1]		; Carga en el registro A el valor 10
	MOV B, [num2]		; Carga en el registro B el valor 2
	DIV B			; Divide A entre B (A = 10/2 = 5)
	MOV [resultado1], A	; Almacena el resultado en el registro A
	MOV C, A		; Guarda el resultado parcial en el registro C
	

; PASO 2: Calculamos 30/3
	MOV A, [num3]		; Carga en el registro A el valor 30
	MOV B, [num4]		; Carga en el registro B el valor 3
	DIV B			; Divide A entre B
	MOV [resultado2], A	; Almacena el resultado en memoria


; PASO 3: Sumamos los primeros dos resultados (10/2 + 30/3)
	ADD A, C		; Suma A + C (10 + 5 = 15)
	MOV C, A		; Guarda el resultado parcial en C (15)
	

; PASO 4: Calcular (7+3) = 10
	MOV A, [num5]		; Carga en A el valor 7
	MOV B, [num6]		; Carga en B el valor 3
	ADD A, B		; Suma A + B
	MOV [resultado3], A	; Almacena el resultado (10) en memoria


; PASO 5: Calcular (7+3) * 2 = 10 * 2 = 20
	MOV B, [num7]		; Carga en B el valor 2
	MUL B			; Multiplica A * B
	MOV [resultado4], A	; Almacena el resultado (20) en memoria


; PASO 6: Sumar resultado final (15 + 20 = 35)
	ADD A, C		; Suma A + C
	MOV [resultado_final], A; Almacena el resultado final en memoria
	MOV D, A		; Mueve el resultado final al registro D


; PASO 7: Imprimimos resultado en el OUTPUT
	CALL imprimir_resultado	; Llama a la rutina que imprime el resultado
	

	HLT			; Detenemos la ejecucion del programa

; -------------

imprimir_resultado:		; Rutina para imprimir el resultado
	MOV A, D		; Copia el valor de D a A (A = 35)
	MOV B, D		; Tambien guarda el valor original en B (B = 35)
	
	DIV 10			; Divide A entre 10: A = 3 (decenas), D = 5 (unidades en residuo)
	MOV C, A		; Guarda las decenas en C (C = 3)
	MUL 10			; Multiplica A por 10: A = 3 * 10 = 30
	SUB B, A		; Resta para obtener unidades: B = 35 - 30 = 5
	
	ADD B, [ascii]		; Convierte unidades a ASCII: B = 5 + 48 = 53 ('5')
	ADD C, [ascii]		; Convierte decenas a ASCII: C = 3 + 48 = 51 ('3')
	
	MOV A, 232		; A apunta al OUTPUT
	MOV [A], C		; Escribe 3 en OUTPUT
	INC A			; Incrementa puntero
	MOV [A], B		; Escribe 5 en OUTPUT
	
	RET			; Retorna al programa principal	