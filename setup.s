.data

#0 = ar
#1 = jogador
#2 = chao/parede
#3 = mola
#4 = morango
#5 = espinho
#6 = cristal
#7 = inimigo
#8 = chave

LINHA0:		.space 80
LINHA1:		.space 80
LINHA2:		.space 80
LINHA3:		.space 80
LINHA4:		.space 80
LINHA5:		.space 80
LINHA6:		.space 80
LINHA7:		.space 80
LINHA8:		.space 80
LINHA9:		.space 80
LINHA10:	.space 80
LINHA11:	.space 80
LINHA12:	.space 80
LINHA13:	.space 80
LINHA14:	.space 80

MATRIZ:		.word LINHA0,LINHA1,LINHA2,LINHA3,LINHA4,LINHA5,LINHA6,LINHA7,LINHA8,LINHA9,LINHA10,LINHA11,LINHA12,LINHA13,LINHA14

LEVEL1:		.word	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,
					2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,
					2,2,2,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,
					2,2,2,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,
					2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,
					2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					2,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					2,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					2,0,2,0,0,0,0,0,0,0,0,0,4,0,2,2,2,2,2,2,
					2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,
					2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,
					2,0,0,0,0,0,0,0,0,0,0,0,3,0,0,2,2,2,2,2,
					2,2,0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,2,
					2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,
					2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2



LEVEL2:		.word	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,
					2,2,2,0,0,0,0,0,0,2,2,0,0,0,0,0,0,0,2,2,
					2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,
					2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,
					2,0,0,0,0,0,0,0,0,2,2,2,2,0,0,0,0,0,0,0,
					2,0,0,0,0,4,0,0,0,2,2,2,2,0,0,0,0,0,0,0,
					2,0,0,0,0,0,0,0,0,0,2,2,2,0,0,0,0,0,0,0,
					2,0,0,0,0,2,2,0,0,0,2,2,2,2,2,0,0,0,2,2,
					2,0,0,0,0,0,0,0,0,0,0,2,2,0,0,0,0,0,0,2,
					2,0,0,0,0,0,0,0,0,0,0,2,2,0,0,0,0,0,0,2,
					0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,2,2,0,2,
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,
					0,1,0,0,0,0,0,2,0,0,0,0,0,0,0,2,0,0,0,2,
					2,2,0,0,0,0,0,2,0,0,0,0,0,0,2,2,0,0,0,2,
					2,2,0,0,2,2,2,2,2,2,2,2,2,0,0,0,0,0,0,2



LEVEL3:		.word	2,0,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,
					2,0,2,0,0,0,0,0,0,0,0,2,2,0,0,0,0,0,2,2,
					2,0,0,0,0,0,0,0,0,0,0,2,2,0,0,0,0,0,2,2,
					2,0,0,0,0,0,0,0,0,0,0,2,2,0,0,0,0,0,2,2,
					2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,
					0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,
					2,2,2,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,2,2,
					2,2,2,0,0,0,2,2,0,0,0,0,0,0,0,0,0,0,2,2,
					2,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,
					2,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,
					2,2,2,2,2,0,0,0,0,0,0,0,0,2,2,2,0,0,2,2,
					2,2,2,2,2,5,0,0,0,0,0,0,0,0,2,2,2,2,2,2,
					2,2,2,2,2,2,5,5,5,5,5,5,5,5,2,2,2,2,2,2



LEVEL4:		.word	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,
					2,2,0,0,0,0,0,2,0,0,0,0,0,2,0,0,0,0,2,2,
					2,2,0,0,0,0,0,2,0,0,0,0,0,2,0,0,0,0,2,2,
					2,2,0,0,0,2,2,2,0,0,0,0,0,2,0,0,0,0,2,2,
					2,2,0,0,0,2,2,2,0,0,0,0,0,2,0,0,0,0,2,2,
					2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,
					0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,
					2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,
					2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,4,
					2,2,0,0,0,0,0,0,0,0,8,0,0,0,2,2,2,2,2,2,
					2,2,2,2,2,2,0,0,2,2,2,2,2,2,2,2,2,2,2,2,
					2,2,2,2,2,2,0,0,2,2,2,2,2,2,2,2,2,2,2,2,
					2,2,2,2,2,2,0,0,0,2,2,2,2,2,2,2,2,2,2,2



LEVEL5:		.word	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,
					2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,
					2,2,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,2,
					2,2,2,2,2,2,0,2,2,2,2,2,2,2,2,2,2,2,0,2,
					2,2,2,2,2,2,0,2,2,2,2,2,2,2,2,2,2,2,0,2,
					2,2,2,2,2,2,0,2,2,2,2,2,2,2,2,2,2,2,0,2,
					2,2,2,2,2,2,0,2,2,2,2,2,0,0,0,0,0,0,0,2,
					2,2,2,2,2,2,0,2,2,2,2,2,0,2,2,2,2,2,2,2,
					2,2,2,2,2,2,0,2,2,2,2,2,0,2,2,2,2,2,2,2,
					2,2,2,2,2,2,0,2,2,2,2,2,0,0,0,0,0,0,0,0,
					2,2,2,2,2,2,0,2,2,2,0,0,0,0,0,0,0,0,0,2,
					2,2,2,2,2,2,0,2,2,2,0,0,0,0,0,0,0,0,0,2,
					0,7,0,0,1,0,0,2,2,2,0,0,0,0,0,0,0,0,0,2,
					2,2,2,2,2,2,2,2,2,2,0,0,0,0,0,0,0,0,0,2,
					2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2


LEVELS:		.word LEVEL1,LEVEL2,LEVEL3,LEVEL4,LEVEL5



.text





#copia a matriz do nivel especificado para a matriz do jogo
#a0= nivel desejado
#return a0= matriz do jogo
COPIA:
	addi sp,sp,-8
	sw ra,0(sp)
	sw s0,4(sp)

	la s0,MATRIZ				#s0 = matriz do jogo

	addi a0,a0,-1				#a0 = indice da matriz do nivel
	la t0,LEVELS				#t0 = vetor dos niveis
	slli t1,a0,2				#t1 = offset do nivel no vetor
	add t1,t1,t0				#t1 = endereco do ponteiro do nivel
	lw t0,0(t1)					#t0 = endereco do nivel
	
	mv t2,zero					#t2 = contador de linhas
	mv t3,zero					#t3 = contador de colunas
	
	li t1,15					#t1 = numero de linhas
	li t6,20					#t6 = numero de colunas
	
COPIA_LOOP_1:
	slli t4,t2,2				#t4 = offset da linha
	add t4,s0,t4				#t4 = endereco do ponteiro da linha
	lw t4,0(t4)					#t4 = endereco da linha
	
COPIA_LOOP_2:
	lw t5,0(t0)					#t5 = o que tem no nivel
	sw t5,0(t4)					#copia t5 na matriz de jogo
	addi t0,t0,4				#t0 = proximo item do nivel
	addi t4,t4,4				#t4 = proximo item da linha
	addi t3,t3,1
	blt t3,t6,COPIA_LOOP_2
	
	mv t3,zero
	
	addi t2,t2,1
	blt t2,t1,COPIA_LOOP_1
	
	mv a0,s0

COPIA_END:
	lw ra,0(sp)
	lw s0,4(sp)
	addi sp,sp,8
	ret


#desenha o nivel
#a0= nivel
DESENHO_DO_NIVEL:
	addi sp,sp,-4
	sw ra,0(sp)
	
	la t1,PLAYER_POS
	
	la t3,PLAYER_POS_A

	li t0,1
	beq a0,t0,L1
	
	li t0,2
	beq a0,t0,L2
	
	li t0,3
	beq a0,t0,L3
	
	li t0,4
	beq a0,t0,L4
	
	li t0,5
	beq a0,t0,L5
	
L1:
	li t2,1
	sb t2,0(t1)
	sb t2,0(t3)
	li t2,5
	sb t2,1(t1)
	sb t2,1(t3)
	
	la a0,mapa1
	li a1,0
	li a2,0
	jal D_SETUP
	
	la a0,walk_r
	li a1,1
	li a2,5
	slli a1,a1,4
	slli a2,a2,4
	jal D_SETUP
	
	la a0,lamar_colec
	li a1,12
	li a2,8
	slli a1,a1,4
	slli a2,a2,4
	jal D_SETUP
	
	j DESENHO_DO_NIVEL_END

L2:
	li t2,1
	sb t2,0(t1)
	sb t2,0(t3)
	li t2,12
	sb t2,1(t1)
	sb t2,1(t3)
	
	la a0,mapa2
	li a1,0
	li a2,0
	jal D_SETUP
	
	la a0,walk_r
	li a1,1
	li a2,12
	slli a1,a1,4
	slli a2,a2,4
	jal D_SETUP
	
	la a0,lamar_colec
	li a1,5
	li a2,5
	slli a1,a1,4
	slli a2,a2,4
	jal D_SETUP
	
	j DESENHO_DO_NIVEL_END
	
L3:
	li t2,1
	sb t2,0(t1)
	sb t2,0(t3)
	li t2,7
	sb t2,1(t1)
	sb t2,1(t3)
	
	la a0,mapa3
	li a1,0
	li a2,0
	jal D_SETUP
	
	la a0,walk_r
	li a1,1
	li a2,7
	slli a1,a1,4
	slli a2,a2,4
	jal D_SETUP
	
	la a0,lamar_colec
	li a1,9
	li a2,6
	slli a1,a1,4
	slli a2,a2,4
	jal D_SETUP
	
	la a0,cafe
	li a1,10
	li a2,8
	slli a1,a1,4
	slli a2,a2,4
	jal D_SETUP
	
	j DESENHO_DO_NIVEL_END
	
L4:
	li t2,1
	sb t2,0(t1)
	sb t2,0(t3)
	li t2,8
	sb t2,1(t1)
	sb t2,1(t3)
	
	la a0,mapa4
	li a1,0
	li a2,0
	jal D_SETUP
	
	la a0,walk_r
	li a1,1
	li a2,8
	slli a1,a1,4
	slli a2,a2,4
	jal D_SETUP
	
	la a0,lamar_colec
	li a1,19
	li a2,10
	slli a1,a1,4
	slli a2,a2,4
	jal D_SETUP
	
	j DESENHO_DO_NIVEL_END
	
L5:
	li t2,4
	sb t2,0(t1)
	sb t2,0(t3)
	li t2,12
	sb t2,1(t1)
	sb t2,1(t3)
	
	la t1,INIMIGO_POS
	li t2,1
	sb t2,0(t1)
	li t2,12
	sb t2,1(t1)
	
	la a0,mapa5
	li a1,0
	li a2,0
	jal D_SETUP
	
	la a0,walk_r
	li a1,4
	li a2,12
	slli a1,a1,4
	slli a2,a2,4
	jal D_SETUP
	
DESENHO_DO_NIVEL_END:
	mv a1,zero
	mv a2,zero
	#jal D_SETUP
	
	lw ra,0(sp)
	addi sp,sp,4
	ret
	
	
#setup do nivel
#a0= nivel
#return a0= matriz do jogo
SETUP:
	addi sp,sp,-8
	sw ra,0(sp)
	sw s0,4(sp)

	mv s0,a0

	jal DESENHO_DO_NIVEL
	
	mv a0,s0
	jal COPIA

SETUP_END:
	lw ra,0(sp)
	lw s0,4(sp)
	addi sp,sp,8
	ret
	
.include "tela.s"
