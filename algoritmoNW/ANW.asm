section .data
	
	mensajeInicio: db "Algoritmo Needleman-Wunsch",10,10,0

	mensajeArchivo1: db "Cual es el nombre del primer archivo *.adn?: ",0
	mensajeArchivo2: db "Cual es el nombre del segundo archivo *.adn?: ",0
	
	mensajePar: db "Desea cambiar el valor de las variables de la matriz? (s/n): ",0
	mensajeParMal: db "El caracter ingresado no es correcto, intenta de nuevo",10,0
	
	string: db "%s",0
	digit: db "Numero: %d",10,0
	
	matrizProteinasMensaje: db 10,"Matriz de la representacion de las proteinas:",10,0
	matrizProteinas1: db " - |  A |  G | C  |  T |",10,0
	matrizProteinas2: db " A |    |    |    |    |",10,0
	matrizProteinas3: db " G |    |    |    |    |",10,0
	matrizProteinas4: db " C |    |    |    |    |",10,0
	matrizProteinas5: db " T |    |    |    |    |",9,0
	matrizProteinas6: db"Gap:    ",10,10,0
	
	preguntaAA: db "Cual sera el nuevo valor para las proteinas cuando sean AA?: ",0
	preguntaAG: db "Cual sera el nuevo valor para las proteinas cuando sean AG?: ",0
	preguntaAC: db "Cual sera el nuevo valor para las proteinas cuando sean AC?: ",0
	preguntaAT: db "Cual sera el nuevo valor para las proteinas cuando sean AT?: ",0
	preguntaGG: db "Cual sera el nuevo valor para las proteinas cuando sean GG?: ",0
	preguntaGC: db "Cual sera el nuevo valor para las proteinas cuando sean GC?: ",0
	preguntaGT: db "Cual sera el nuevo valor para las proteinas cuando sean GT?: ",0
	preguntaCC: db "Cual sera el nuevo valor para las proteinas cuando sean CC?: ",0
	preguntaCT: db "Cual sera el nuevo valor para las proteinas cuando sean CT?: ",0
	preguntaTT: db "Cual sera el nuevo valor para las proteinas cuando sean TT?: ",0
	preguntaGap: db "Cual sera el nuevo valor para el GAP?: ",0
	
	
section .bss
	
	garbage: resb 4
	proteinas1: resb 1000000
	proteinas1Len: equ $-proteinas1
	proteinas2: resb 1000000
	proteinas2Len: equ $-proteinas2
	matrizProteinasX: resb 1000000
	matrizProteinasY: resb 1000000
	matrizProteinas: resb 1000000000000
	
	nombreArchivo1: resb 10
	nombreArchivo2: resb 10
	cAA: resb 2
	cAG: resb 2
	cAC: resb 2
	cAT: resb 2
	cGG: resb 2
	cGC: resb 2
	cGT: resb 2
	cCC: resb 2
	cCT: resb 2
	cTT: resb 2
	gap: resb 2
	
section .text
	extern printf    ; Llamadas de las funciones de C
	extern atoi
	extern stdin
	extern scanf
	global main 	; variable global de inicio
	
main:
	xor eax, eax	; limpieza de registros
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx
	xor edi, edi
	xor esi, esi
	
	push mensajeInicio ; Impresion de mensaje de inicio
	call printf
	add esp, 4
	
	push mensajeArchivo1 ; Impresion de mensaje
	call printf
	add esp, 4
	
	push nombreArchivo1 ; input por parte del usuario
	push string
	call scanf
	add esp,8
	
	mov ebx, nombreArchivo1 ;abre el archivo que se coloc� en el input
	mov eax, 5
	mov ecx, 0
	int 80h
	
	mov eax, 3				;carga a la memoria reservada el archivo
	mov ebx, eax
	mov ecx, proteinas1
	mov edx, proteinas1Len
	int 80h
	
	mov eax, 6				;cierra el archivo para dar chance al otro
	int 80h
	
	;mov eax, 4				;impresi�n DEBUG
	;mov ebx, 1
	;int 80h
	xor eax, eax			;Limpieza de registros
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx
	xor edi, edi
	xor esi, esi
	
	push mensajeArchivo2	;mensaje del 2 archivo
	call printf
	add esp, 4
	
	push nombreArchivo2		;input para el segundo archivo
	push string
	call scanf
	add esp,8
	
	mov ebx, nombreArchivo2	; abre el archivo
	mov eax, 5
	mov ecx, 0
	int 80h
	
	mov eax, 3				; carga a memoria el archivo que se llam� en el input
	mov ebx, eax
	mov ecx, proteinas2
	mov edx, proteinas2Len
	int 80h
	
	mov eax, 6				;cierra el archivo
	int 80h
	;mov eax, 4				; imprimir datos archivo DEBUG
	;mov ebx, 1
	;int 80h
	
CambioVar:
	push mensajePar			;Cambia los par�metros
	call printf
	add esp, 4
	
	push garbage			; Se guarda la opcion
	push string
	call scanf
	add esp, 8
	
	xor eax, eax			;se compara si es un "n" o "s"
	mov al, byte[garbage]
	cmp al, "s" 
	je cambiarVar
	cmp al, "n"
	je defaultVar
	push mensajeParMal
	call printf
	add esp, 4
	jmp CambioVar
	
cambiarVar:				;;;;;;;;;;;;;;;;;;;;; AQUI ES EL INPUT QUE SE DA�A la impresion de matriz
	
	push preguntaAA              ;;;;;; Impresion de pregunta
	call printf
	add esp, 4
	
	push garbage			;;;;; Input
	push string
	call scanf
	add esp, 8
	
	mov ax, word[garbage]				;;; Aqui deberia guardarse sin problema
	mov word[matrizProteinas2+5], ax		;;; el digito en la matriz de datos para
									;;  imprimir en pantalla, puede probar con
									;; la default, para que se de una idea
									;; tome las direcciones de default para dibujar
									
									;; Despu�s se debe hacer un atoi para almacenar
									;; los datos ingresados en cAA, cAC, etc
	jmp iniciarMatriz

defaultVar:
	xor eax, eax			;;;;;;;;;;;;;;;;;;;;; Parte logica para los valores de la matriz
	mov ax, 10
	mov word[cAA], ax
	mov ax, -1
	mov word[cAG], ax
	mov ax, -3
	mov word[cAC], ax
	mov ax, -4
	mov word[cAT], ax
	mov ax, 7
	mov word[cGG], ax
	mov ax, -5
	mov word[cGC], ax
	mov ax, -3
	mov word[cGT], ax
	mov ax, 9
	mov word[cCC], ax
	mov ax, 0
	mov word[cCT], ax
	mov ax, 8
	mov word[cTT], ax
	mov ax, -5
	mov word[gap],ax
	
	mov word[matrizProteinas2+4], "10" ;;;;;;;;;;;;;;;;;;; Parte "grafica"
	mov word[matrizProteinas3+4], "-1"
	mov word[matrizProteinas4+4], "-3"
	mov word[matrizProteinas5+4], "-4"
	mov word[matrizProteinas2+9], "-1"
	mov word[matrizProteinas3+9], " 7"
	mov word[matrizProteinas4+9], "-5"
	mov word[matrizProteinas5+9], "-3"
	mov word[matrizProteinas2+14], "-3"
	mov word[matrizProteinas3+14], "-5"
	mov word[matrizProteinas4+14], " 9"
	mov word[matrizProteinas5+14], " 0"
	mov word[matrizProteinas2+19], "-4"
	mov word[matrizProteinas3+19], "-3"
	mov word[matrizProteinas4+19], " 0"
	mov word[matrizProteinas5+19], " 8"
	mov word[matrizProteinas6+5], "-5"

iniciarMatriz:
	push matrizProteinasMensaje ; imprime la matriz de manera que la vea el usuario
	call printf
	add esp, 4
	push matrizProteinas1
	call printf
	add esp, 4
	push matrizProteinas2
	call printf
	add esp, 4
	push matrizProteinas3
	call printf
	add esp, 4
	push matrizProteinas4
	call printf
	add esp, 4
	push matrizProteinas5
	call printf
	add esp, 4
	push matrizProteinas6
	call printf
	add esp, 4
	
	
	;;;;;;;;;;;;; Imprimir el numero guardado a la hora de crear DEBUG
	;movsx ebx, word[gap]
	;push ebx
	;push digit
	;call printf
	;add esp,8
	
inicioAlgoritmo:
	.Matriz:
		xor ecx, ecx
		xor eax, eax,
		xor ebx, ebx
		mov ebx, matrizProteinas
		.forI:
			xor esi, esi
			cmp ecx, 1000000
			jl .forJ
			;jmp .imprimir
			.forJ:
				cmp esi, 1000000
				jl .inicializacion
				inc ecx
				jmp .forI
		.inicializacion:
			mov eax, ecx
				
			
salir:				;salida del programa
	mov eax, 1
	mov ebx, 0
	int 80h
	