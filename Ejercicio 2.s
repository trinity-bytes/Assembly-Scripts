; Programa: Validador de Letras Minusculas
; - Si letra es minuscula (a-z): imprime " a En mayuscula es = A"
; - Si letra NO es minuscula: imprime " * no es una letra"
; ***************************************************************

	JMP start		; Salta a la etiqueta start para iniciar el programa

; datos
letra: DB "*"			; Caracter a validar
limite_inf: DB 97		; Limite inferior del rango: ASCII 97 = a
limite_sup: DB 122		; Limite superior del rango: ASCII 122 = z

; Cadenas de texto
msg_mayuscula: DB " En mayuscula es = " ; primera cadena de texto
	       DB 0		; Terminador de cadena (marca el fin del string)

msg_no_letra: DB " no es una letra" ; segunda cadena de texto
	      DB 0		; Terminador de cadena


start:
	MOV A, [letra]		; Carga el caracter desde memoria al registro A
	MOV B, [limite_inf]	; Carga el limite inferior (97) en registro B
	CMP A, B		; Compara A con B (verifica si letra >= 'a')
	JB no_es_letra		; Si A < B (Below), salta a no_es_letra
	
	MOV B, [limite_sup]	; Carga el limite superior (122) en registro B
	CMP A, B		; Compara A con B (verifica si letra <= 'z')
	JA no_es_letra		; Si A > B (Above), salta a no_es_letra
	
; Si llegamos aqui, la letra esta en el rango [a-z]
	CALL imprimir_es_letra	; Llama a la funcion que imprime el mensaje de mayuscula
	HLT			; Detiene la ejecucion del programa
	
no_es_letra:
	; Si llegamos aqui, el caracter NO es una letra minuscula
	CALL imprimir_no_es_letra; Llama a la funcion que imprime el mensaje de error
	HLT			; Detiene la ejecucion del programa



imprimir_es_letra:		; Funcion para imprimir texto si es letra
	MOV D, 232		; Carga 232 en D (direccion del OUTPUT en memoria)

; Imprimir la letra  original
	MOV A, [letra]		; Carga el caracter original desde memoria
	MOV [D], A		; Escribe el caracter en OUTPUT
	INC D			; Incrementa D para la siguiente posicion
	
; Imprimir " En mayuscula es = "
	MOV C, msg_mayuscula	; Carga en C la direccion del mensaje
	CALL imprimir_cadena	; Llama a la funcion generica que imprime la cadena
	
; Convertir a mayuscula e imprimir
	MOV A, [letra]		; Carga nuevamente el caracter original
	SUB A, 32		; Resta 32 para convertir minuscula a mayuscula (a=97, A=65)
	MOV [D], A		; Escribe el caracter en mayuscula en OUTPUT
	
	RET			; Retorna al punto donde se llamo la funcion


imprimir_no_es_letra:		; Funcion para imprimir texto si no es letra
	MOV D, 232		; Carga 232 en D (direccion del OUTPUT en memoria)
; Imprimir el caracter original
	MOV A, [letra]		; Carga el caracter desde memoria
	MOV [D], A		; Escribe el caracter en OUTPUT
	INC D			; Incrementa D para la siguiente posicion
	
; Imprimir " no es una letra"
	MOV C, msg_no_letra	; Carga en C la direccion del mensaje
	CALL imprimir_cadena	; Llama a la funcion generica que imprime la cadena
	
	RET			; Retorna al punto donde se llamo la funcion


imprimir_cadena:		; Funcion que imprime la cadena almacenada
	PUSH A			; Guarda el valor actual de A en la pila
	PUSH B			; Guarda el valor actual de B en la pila
	MOV B, 0		; Carga 0 en B (sera el terminador de cadena)
	
.loop:				; sub rutina del bucle
	MOV A, [C]		; Lee el byte en la direccion apuntada por C
	CMP A, B		; Compara el caracter con 0 (terminador)
	JZ .fin			; Si es 0 (Zero flag), salta a .fin (termina el bucle)
	MOV [D], A		; Escribe el caracter en la direccion del OUTPUT
	INC C			; Incrementa C para apuntar al siguiente caracter
	INC D			; Incrementa D para apuntar a la siguiente posicion del OUTPUT
	JMP .loop		; Salta incondicionalmente al inicio del bucle (repite)
	
.fin:				; sub rutina de finalizacion (se ejecuta cuando A == 0)
	POP B			; Restaura el valor original de B desde la pila
	POP A			; Restaura el valor original de A desde la pila
	RET			; Retorna al punto donde se llamo la funcion	