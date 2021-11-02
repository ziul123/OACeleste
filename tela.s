.data

tPLAYER_POS:	.byte 1,5

.include "mapas/mapa1.data"
.include "mapas/mapa2.data"
.include "mapas/mapa3.data"
.include "mapas/mapa4.data"
.include "mapas/mapa5.data"

.include "sprites/walk_r.data"
.include "sprites/walk_l.data"
.include "sprites/dash_r.data"
.include "sprites/dash_l.data"
.include "sprites/jump_r.data"
.include "sprites/lamar_colec.data"
.include "sprites/cafe.data"


.text
	
#	la a0,mapa1
#	mv a1,zero
#	mv a2,zero
#	jal D_SETUP
#	
#	la a0,walk_r
#	li a1,1
#	li a2,5
#	slli a1,a1,4			#a tela eh dividida em quadrados de 16x16
#	slli a2,a2,4	
#	jal D_SETUP


#LOOP:

#	jal GET_KEY

#	bltz a0,END

#	j LOOP


#END:
#	li a7,10
#	ecall





##return a0= flag (-1 para quit, 0 para tecla pressionada, 1 para tecla n pressionada)
#GET_KEY:
#	addi sp,sp,-4
#	sw ra,0(sp)
#	
#	
#	li t0,0xFF200000		#endereco do controle do teclado
#	lw t1,0(t0)
#	andi t1,t1,0x01
#	li a0,1
#	beqz t1,GET_KEY_END		#se nao foi pressionada tecla, pula
#	lw t1,4(t0)				#t1 = tecla pressionada pelo usuario
#	
#	li t0,'a'
#	beq t1,t0,a
#	
#	li t0,'d'
#	beq t1,t0,d
#	
#	li t0,'p'
#	beq t1,t0,p
#	
#	li t0,'D'
#	beq t1,t0,D
#	
#	j GET_KEY_END
#	
#	
#a:

#	li a0,2
#	la a1,mapa1
#	jal ANIMACAO
#	
#	li a0,0
#	
#	j GET_KEY_END
#	
#d:

#	li a0,1
#	la a1,mapa1
#	jal ANIMACAO
#	
#	li a0,0
#	
#	j GET_KEY_END
#	
#p:
#	li a0,-1
#	
#	j GET_KEY_END
#	
#D:
#	li a0,3
#	la a1,mapa1
#	jal ANIMACAO
#	
#	li a0,3
#	la a1,mapa1
#	jal ANIMACAO
#	
#	li a0,0
#	
#GET_KEY_END:
#	lw ra,0(sp)
#	addi sp,sp,4
#	ret




#a0= o que desenhar
#a1= x	
#a2= y
D_SETUP:
	addi sp,sp,-12
	sw ra,0(sp)
	sw a1,4(sp)
	sw a2,8(sp)

	lw t0,0(a0)				#t0 = largura
	lw t1,4(a0)				#t1 = altura
	addi a0,a0,8
	
	li t2,0xFF000000		#inicio da frame 0
	li t3,320				#largura da tela
	mul t3,t3,a2
	add t3,t3,a1			#t3 = y*320 + x
	add t2,t2,t3			#t2 = tela + offset

	mv a1,t2
	mv a2,t0
	mv a3,t1
	jal DESENHAR
	
	


D_SETUP_END:
	lw ra,0(sp)
	lw a1,4(sp)
	lw a2,8(sp)
	addi sp,sp,12
	ret


#a0= o que vai ser apagado
#a1= fundo
#a2= x
#a3= y
APAGAR:
	addi sp,sp,-12
	sw ra,0(sp)
	sw a2,4(sp)
	sw a3,8(sp)

	lw t0,0(a0)				#t0 = largura
	lw t1,4(a0)				#t1 = altura

	
	li t2,0xFF000000		#inicio da frame 0
	li t3,320				#largura da tela
	mul t3,t3,a3
	add t3,t3,a2			#t3 = y*320 + x
	add t2,t2,t3			#t2 = tela + offset

	li t3,320
	addi a1,a1,8			#ignora a largura e altura do fundo
	mul t3,t3,a3
	add t3,t3,a2			#t3 = y*320 + x
	add a0,a1,t3			#a0 = fundo + offset

	mv a1,t2
	mv a2,t0
	mv a3,t1

	mv t3,zero				#t3 = contador de linhas
	mv t4,zero				#t4 = contador de colunas

A_LOOP:
	lw t5,0(a0)				#t5 = 4 pixeis do fundo
	sw t5,0(a1)				#desenha os pixeis na tela
	
	addi a0,a0,4			#proximos pixeis
	addi a1,a1,4			#proximo lugar na tela
	addi t4,t4,4			#contador de colunas++
	
	blt t4,a2,A_LOOP		#se n terminou de desenhar a linha, continua
	
	mv t4,zero				#zera o contador de colunas
	
	sub a0,a0,t0
	addi a0,a0,320			#volta o fundo para a coluna inicial mas na proxima linha
	
	sub a1,a1,t0
	addi a1,a1,320			#volta a tela para a coluna inicial mas na proxima linha
	addi t3,t3,1			#contador de linhas++

	blt t3,a3,A_LOOP		#se n terminou de desenhar a imagem, desenha a proxima linha



APAGAR_END:
	lw ra,0(sp)
	lw a2,4(sp)
	lw a3,8(sp)
	addi sp,sp,12
	ret
	

	
#a0= endereco de onde comeca o que desenhar
#a1= endereco de onde desenhar na tela
#a2= largura
#a3= altura
DESENHAR:
	addi sp,sp,-4
	sw ra,0(sp)

	mv t3,zero				#t3 = contador de linhas
	mv t4,zero				#t4 = contador de colunas

D_LOOP:
	lw t5,0(a0)				#t5 = 4 pixeis da imagem
	sw t5,0(a1)				#desenha os pixeis na tela
	
	addi a0,a0,4			#proximos pixeis
	addi a1,a1,4			#proximo lugar na tela
	addi t4,t4,4			#contador de colunas++
	
	blt t4,a2,D_LOOP		#se n terminou de desenhar a linha, continua
	
	mv t4,zero				#zera o contador de colunas
	sub a1,a1,a2
	addi a1,a1,320			#volta a tela para a coluna inicial mas na proxima linha
	addi t3,t3,1			#contador de linhas++

	blt t3,a3,D_LOOP		#se n terminou de desenhar a imagem, desenha a proxima linha

DESENHAR_END:
	lw ra,0(sp)
	addi sp,sp,4
	ret



#0 -cair
#1 -andar para direita
#2 -andar para esquerda
#3 -andar para direita com dash
#4 -andar para esquerda com dash
#5 -pular diagonal direita
#6 -pular diagonal esquerda
#7 -pular diagonal direita com dash
#8 -pular diagonal esquerda com dash
#9 -pular baixo diagonal direita com dash
#10 -pular baixo diagonal esquerda com dash
#11 -pulo reto
#12 -pulo reto com dash
#13 -cair reto com dash

#executa a animacao do movimento especificado
#a0= movimento a ser animado
#a1= endereco do fundo
ANIMACAO:
	addi sp,sp,-8
	sw ra,0(sp)
	sw s0,4(sp)

	mv s0,a1

	li t0,0
	beq a0,t0,ANIMACAO_0
	
	li t0,1
	beq a0,t0,ANIMACAO_1
	
	li t0,2
	beq a0,t0,ANIMACAO_2
	
	li t0,3
	beq a0,t0,ANIMACAO_3
	
	li t0,4
	beq a0,t0,ANIMACAO_4
	
	li t0,5
	beq a0,t0,ANIMACAO_5
	
	li t0,6
	beq a0,t0,ANIMACAO_6
	
	li t0,7
	beq a0,t0,ANIMACAO_7
	
	li t0,8
	beq a0,t0,ANIMACAO_8
	
	li t0,9
	beq a0,t0,ANIMACAO_9
	
	li t0,10
	beq a0,t0,ANIMACAO_10
	
	li t0,11
	beq a0,t0,ANIMACAO_11
	
	li t0,12
	beq a0,t0,ANIMACAO_12
	
	li t0,13
	beq a0,t0,ANIMACAO_13
	
ANIMACAO_0:

	j ANIMACAO_END

ANIMACAO_1:
	la t0,tPLAYER_POS
	lb t1,0(t0)
	
	la a0,walk_r
	mv a1,s0
	mv a2,t1
	lb a3,1(t0)
	slli a2,a2,4			#a tela eh dividida em quadrados de 16x16
	slli a3,a3,4
	jal APAGAR
	
	la a0,walk01_r
	addi a1,a2,4
	mv a2,a3
	jal D_SETUP

	
	
	li a0,150
	li a7,32
	ecall
	
	
	la a0,walk01_r
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	la a0,walk02_r
	addi a1,a2,4
	mv a2,a3
	jal D_SETUP
	
	
	
	li a0,150
	li a7,32
	ecall
	
	
	la a0,walk02_r
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	la a0,walk03_r
	addi a1,a2,4
	mv a2,a3
	jal D_SETUP

	
	
	li a0,150
	li a7,32
	ecall
	
	
	la a0,walk03_r
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	
	la t0,tPLAYER_POS
	lb t1,0(t0)
	addi t1,t1,1
	sb t1,0(t0)
	
	
	la a0,walk_r
	mv a1,t1
	lb a2,1(t0)
	slli a1,a1,4			#a tela eh dividida em quadrados de 16x16
	slli a2,a2,4
	jal D_SETUP
	
	j ANIMACAO_END

ANIMACAO_2:
	la t0,tPLAYER_POS
	lb t1,0(t0)
	
	la a0,walk_l
	mv a1,s0
	mv a2,t1
	lb a3,1(t0)
	slli a2,a2,4			#a tela eh dividida em quadrados de 16x16
	slli a3,a3,4
	jal APAGAR
	
	la a0,walk01_l
	addi a1,a2,-4
	mv a2,a3
	jal D_SETUP

	
	
	li a0,150
	li a7,32
	ecall
	
	
	la a0,walk01_l
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	la a0,walk02_l
	addi a1,a2,-4
	mv a2,a3
	jal D_SETUP
	
	
	
	li a0,150
	li a7,32
	ecall
	
	
	la a0,walk02_l
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	la a0,walk03_l
	addi a1,a2,-4
	mv a2,a3
	jal D_SETUP

	
	
	li a0,150
	li a7,32
	ecall
	
	
	la a0,walk03_l
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	
	la t0,tPLAYER_POS
	lb t1,0(t0)
	addi t1,t1,-1
	sb t1,0(t0)
	
	
	la a0,walk_l
	mv a1,t1
	lb a2,1(t0)
	slli a1,a1,4			#a tela eh dividida em quadrados de 16x16
	slli a2,a2,4
	jal D_SETUP

	j ANIMACAO_END

ANIMACAO_3:
	la t0,tPLAYER_POS
	lb t1,0(t0)
	
	la a0,dash_r
	mv a1,s0
	mv a2,t1
	lb a3,1(t0)
	slli a2,a2,4			#a tela eh dividida em quadrados de 16x16
	slli a3,a3,4
	jal APAGAR
	
	la a0,dash01_r
	addi a1,a2,4
	mv a2,a3
	jal D_SETUP

	
	
	li a0,30
	li a7,32
	ecall
	
	
	la a0,dash01_r
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	la a0,dash02_r
	addi a1,a2,4
	mv a2,a3
	jal D_SETUP
	
	
	
	li a0,30
	li a7,32
	ecall
	
	
	la a0,dash02_r
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	la a0,dash03_r
	addi a1,a2,4
	mv a2,a3
	jal D_SETUP

	
	
	li a0,30
	li a7,32
	ecall
	
	
	la a0,dash03_r
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	
	la t0,tPLAYER_POS
	lb t1,0(t0)
	addi t1,t1,1
	sb t1,0(t0)
	
	
	la a0,dash_r
	mv a1,t1
	lb a2,1(t0)
	slli a1,a1,4			#a tela eh dividida em quadrados de 16x16
	slli a2,a2,4
	jal D_SETUP
	
	
	j ANIMACAO_END

ANIMACAO_4:

	j ANIMACAO_END

ANIMACAO_5:

	j ANIMACAO_END

ANIMACAO_6:

	j ANIMACAO_END

ANIMACAO_7:

	j ANIMACAO_END

ANIMACAO_8:

	j ANIMACAO_END

ANIMACAO_9:

	j ANIMACAO_END

ANIMACAO_10:

	j ANIMACAO_END

ANIMACAO_11:

	j ANIMACAO_END

ANIMACAO_12:

	j ANIMACAO_END

ANIMACAO_13:

	

ANIMACAO_END:
	lw ra,0(sp)
	lw s0,4(sp)
	addi sp,sp,8
	ret

	
