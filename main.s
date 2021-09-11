.data

LINHA0:		.word 1,0,0,0,0,0,0,0
LINHA1:		.word 0,0,0,0,2,0,0,0
LINHA2:		.word 0,0,0,2,2,2,0,0
LINHA3:		.word 0,0,0,2,0,0,0,2
LINHA4:		.word 0,0,0,0,0,0,2,2
LINHA5:		.word 2,2,2,2,2,2,2,2
MATRIZ:		.word LINHA0,LINHA1,LINHA2,LINHA3,LINHA4,LINHA5
PLAYER_POS:	.byte 0,0		#coluna,linha
			.word LINHA0	#endereco
M_SIZE:		.word 6,8		#n_linhas, n_colunas

esp:		.string " "
n:			.string "\n"

.text

MAIN:
	la a0,MATRIZ
	la a1,M_SIZE
	jal M_SHOW
	
	la a0,n
	li a7,4
	ecall

#s9 = dash (0 nao pode, 1 pode)
#s10 = flututando (0 se nao estiver, 1 se estiver)
#s11 = timer da gravidade
LOOP:


	jal GET_KEY
	
	bltz a0,END
	bgtz a0,NO_KEY
	
	la a0,MATRIZ
	la a1,M_SIZE
	jal M_SHOW
	
	la a0,n
	li a7,4
	ecall
	
NO_KEY:	
	beqz s10,N_GRAV
	csrr t0,3073
	sub t0,t0,s11		#s11 tem o tempo da ultima gravidade
	li t1,300
	bltu t0,t1,LOOP

	li a0,1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MOVE_V			#desce o player por 1 posicao
	
	csrr s11,3073		#salva o tempo da ultima gravidade
	
	la a0,PLAYER_POS
	la a1,MATRIZ
	jal FLUTUANDO
	mv s10,a0


	la a0,MATRIZ
	la a1,M_SIZE
	jal M_SHOW
	
	la a0,n
	li a7,4
	ecall
	
	
	
	
N_GRAV:
	j LOOP
	


END:
	li a7,10
	ecall



#return a0= flag (-1 para quit, 0 para tecla pressionada, 1 para tecla n pressionada)
GET_KEY:
	addi sp,sp,-4
	sw ra,0(sp)
	
	
	li t0,0xFF200000	#endereco do controle do teclado
	lw t1,0(t0)
	andi t1,t1,0x01
	li a0,1
	beqz t1,GET_KEY_END	#se nao foi pressionada tecla, pula
	lw t1,4(t0)			#t1 = tecla pressionada pelo usuario

	li t0,'a'
	beq t1,t0,a
	
	li t0,'d'
	beq t1,t0,d
	
	li t0,'e'
	beq t1,t0,e

	li t0,'p'
	beq t1,t0,p
	
	li t0,'q'
	beq t1,t0,q

	li t0,'s'
	beq t1,t0,s
	
	li t0,'w'
	beq t1,t0,w
	
	li t0,'A'
	beq t1,t0,A
	
	li t0,'D'
	beq t1,t0,D
	
	li t0,'E'
	beq t1,t0,E
	
	li t0,'Q'
	beq t1,t0,Q
	
	li t0,'W'
	beq t1,t0,W

	j GET_KEY_END

a:
	li a0,-1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MOVE_H				#move o jogador um espaco para esquerda

	bnez s10,JA_FLUTUANDO	#se ja esta flutuando, termina
	la a0,PLAYER_POS
	la a1,MATRIZ
	jal FLUTUANDO			#checa se esta flutuando depois de mover
	mv s10,a0

	csrr s11,3073			#comeca o timer da gravidade
	

	li a0,0
	j GET_KEY_END

d:

	li a0,1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MOVE_H				#move o jogador um espaco para direita

	bnez s10,JA_FLUTUANDO	#se ja esta flutuando, termina
	
	la a0,PLAYER_POS
	la a1,MATRIZ
	jal FLUTUANDO			#checa se esta flutuando depois de mover
	mv s10,a0

	csrr s11,3073			#comeca o timer da gravidade


	li a0,0
	j GET_KEY_END


e:
	bnez s10,N_PULA			#se esta flutuando, nao pula

	li a0,1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MOVE_DG				#move o player 1 espaco para a diagonal cima direita
	
	li s10,1				#depois de pular, esta flutuando
	csrr s11,3073
	
	li a0,0
	j GET_KEY_END

p:
	li a0,-1
	j GET_KEY_END


q:
	bnez s10,N_PULA

	li a0,-1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MOVE_DG
	
	li s10,1
	csrr s11,3073

	li a0,0
	j GET_KEY_END


s:
	li a0,1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MOVE_V



	li a0,0
	j GET_KEY_END

w:
	bnez s10,N_PULA
	
	li a0,-1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MOVE_V


	li s10,1
	csrr s11,3073

JA_FLUTUANDO:
N_PULA:
	li a0,0
	j GET_KEY_END

A:


D:


E:


Q:


W:


GET_KEY_END:
	lw ra,0(sp)
	addi sp,sp,4
	ret




#a0= int vetor[], a1= int len(vetor)
#return void
V_SHOW:
	mv t0,a0
	mv t1,a1		#tamanho do vetor
	li t2,0			#contador
	
V_SHOW_LOOP:
	lw a0,0(t0)
	li a7,1			#ecall para print int
	ecall
	la a0,esp		
	li a7,4			#ecall para print str
	ecall
	addi t2,t2,1	#t2++
	addi t0,t0,4
	bltu t2,t1,V_SHOW_LOOP	#while(t2<length(vetor))
	
	ret

#a0= int matriz[][], a1= (n_linhas, n_colunas)
#return void
M_SHOW:
	addi sp,sp,-20
	sw ra,0(sp)
	sw s0,4(sp)
	sw s1,8(sp)
	sw s2,12(sp)
	sw s3,16(sp)
	
	mv s0,a0	#s0 = matriz
	lw s1,0(a1)	#s1 = linhas
	lw s2,4(a1)	#s2 = colunas
	li s3,0		#contador
	
M_SHOW_LOOP:
	slli t0,s3,2
	add t0,t0,s0
	lw a0,0(t0)
	mv a1,s2
	jal V_SHOW
	
	la a0,n
	li a7,4
	ecall
	
	addi s3,s3,1
	blt s3,s1,M_SHOW_LOOP
	
	lw ra,0(sp)
	lw s0,4(sp)
	lw s1,8(sp)
	lw s2,12(sp)
	lw s3,16(sp)
	addi sp,sp,20
	
	ret
	
.include "movimentacao.s"
