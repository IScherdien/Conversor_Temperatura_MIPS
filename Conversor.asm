.data
tamanho: .space 40
opcao: .asciiz "\nConversor de temperatura\n1- Fahrenheit para Celsius\n2- Celsius para Fahrenheit\n3- Celsius para Kelvin\n4- Kelvin para Celsius\n5- Kelvin para Fahrenheit\n6- Fahrenheit para Kelvin\n7- Sair\nInsira a escolha: "
inF: .asciiz "\nInsira a temperatura em Fahrenheit: "
inC: .asciiz "\nInsira a temperatura em Celsius: "
inK: .asciiz "\nInsira a temperatura em Kelvin: "

saida: .asciiz "\nTemperatura convertida para: "
C: .asciiz " Celsius\n"
F: .asciiz " Fahrenheit\n"
K: .asciiz " Kelvin\n"

num1: .float 32.0
num2: .float 273.15
num5: .float 5.0
num9: .float 9.0

.text
	l.s $f1, num1
	l.s $f2, num2
	l.s $f3, num5
	l.s $f4, num9
	add $t2, $zero, $zero	
	la $t3, tamanho
	
menu:
	la $a0, opcao
	jal imprimeString
		
	jal leInt
		
	beq $t1, 1, FtoC
	beq $t1, 2, CtoF
	beq $t1, 3, CtoK
	beq $t1, 4, KtoC
	beq $t1, 5, KtoF
	beq $t1, 6, FtoK
	beq $t1, 7, sair

FtoC: #Fahrenheit para Celsius
	la $a0, inF
	jal imprimeString

	jal leFloat
	mov.s $f6, $f0
		
	sub.s $f6, $f6, $f1 		
	mul.s $f6, $f6, $f3 		
	div.s $f6, $f6, $f4

	la $a0, saida
	jal imprimeString
		
	mov.s $f12, $f6
	jal imprimeFloat
	
	la $a0, C
	jal imprimeString	
		
	jal armazena
			
	j menu
	

CtoF: #Celsius para Fahrenheit
	la $a0, inC
	jal imprimeString
	
	jal leFloat
	mov.s $f6, $f0

	mul.s $f6, $f6, $f4
	div.s $f6, $f6, $f3
	add.s $f6, $f6, $f1

	la $a0, saida
	jal imprimeString
	
	mov.s $f12, $f6
	jal imprimeFloat
	
	la $a0, F
	jal imprimeString	
			
	jal armazena
	
	j menu
	
	
CtoK: #Celsius para Kelvin
	la $a0, inC
	jal imprimeString

	jal leFloat
	mov.s $f6, $f0

	add.s $f6, $f6, $f2

	la $a0, saida
	jal imprimeString
		
	mov.s $f12, $f6
	jal imprimeFloat
	
	la $a0, K
	jal imprimeString
	
	jal armazena
	
	j menu

KtoC: #Kelvin para Celsius
	la $a0, inK
	jal imprimeString

	jal leFloat
	mov.s $f6, $f0

	sub.s $f6, $f6, $f2

	la $a0, saida
	jal imprimeString
		
	mov.s $f12, $f6
	jal imprimeFloat
	
	la $a0, C
	jal imprimeString
	
	jal armazena
	
	j menu
	
KtoF: #Kelvin para Fahrenheit
	la $a0, inK
	jal imprimeString

	jal leFloat
	mov.s $f6, $f0

	sub.s $f6, $f6, $f2
	mul.s $f6, $f6, $f4
	div.s $f6, $f6, $f3
	add.s $f6, $f6, $f1

	la $a0, saida
	jal imprimeString
		
	mov.s $f12, $f6
	jal imprimeFloat
	
	la $a0, F
	jal imprimeString
	
	jal armazena
	
	j menu

FtoK: #Fahrenheit para Kelvin
	la $a0, inF
	jal imprimeString

	jal leFloat
	mov.s $f6, $f0

	sub.s $f6, $f6, $f1
	mul.s $f6, $f6, $f3
	div.s $f6, $f6, $f4
	add.s $f6, $f6, $f2

	la $a0, saida
	jal imprimeString
		
	mov.s $f12, $f6
	jal imprimeFloat
	
	la $a0,K
	jal imprimeString
	
	jal armazena
	
	j menu

armazena:
	s.s $f6, ($t3)
	addi $t3, $t3, 4		
	beq $t2, 9, sair
	addi $t2, $t2, 1 	#contador++
	jr $ra

leFloat:
	li $v0, 6 
	syscall 
	jr $ra
	
leInt:
	li $v0, 5              
	syscall 
	move $t1, $v0
	jr $ra

imprimeString:
	li $v0, 4
	syscall
	jr $ra

imprimeFloat:
	li $v0, 2
	syscall
	jr $ra
	
sair:	
	li $v0, 10
	syscall
	
