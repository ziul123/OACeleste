.data

#15 linhas, 20 colunas


PLAYER_POS:	.byte 1,5		#coluna,linha
M_SIZE:		.word 15,20		#n_linhas, n_colunas
NIVEL:		.byte 1
LAMAR_COUNT:.byte 0
TOCANDO:	.byte 0

esp:		.string " "
n:			.string "\n"
ganhou:		.string "ganhou"

test:		.string "aqui"

.text

MAIN:
	li a0,0
	jal CUTSCENE_SETUP
	jal PLAY_CUTSCENE

	la a0,MATRIZ
	la a1,M_SIZE
	#jal M_SHOW
	
	la a0,n
	li a7,4
	#ecall
	
	
#s5 = musica
#s6	= musica
#s7 = timer do inimigo
#s8 = lado que o jogador esta virado (0 para esquerda, 1 para direita)
#s9 = dash (0 nao pode, 1 pode)
#s10 = flututando (0 se nao estiver, 1 se estiver)
#s11 = timer da gravidade
LOOP:
	la t0,NIVEL
	lb t0,0(t0)
	li t1,5
	bne t0,t1,N_NIVEL_5
	jal INIMIGO_CTRL
	li t0,1
	beq a0,t0,END
N_NIVEL_5:
	la t0,TOCANDO
	lb t0,0(t0)
	beqz t0,PULA_MUSICA
	jal PLAY_MUSICA
PULA_MUSICA:
	bnez s9,TEM_DASH
	
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	
	la a0,cafe
	li a2,19
	li a3,0
	slli a2,a2,4
	slli a3,a3,4
	jal APAGAR
	j TEM_DASH_CONT

TEM_DASH:
	la a0,cafe
	li a1,19
	li a2,0
	slli a1,a1,4
	slli a2,a2,4
	jal D_SETUP

TEM_DASH_CONT:
	la t0,PLAYER_POS
	lb t0,0(t0)
	li t1,19
	beq t0,t1,PROX_NIVEL

	jal GET_KEY
	
	bltz a0,END
	bgtz a0,NO_KEY
	
	la a0,MATRIZ
	la a1,M_SIZE
	#jal M_SHOW

	
	la a0,n
	li a7,4
	#ecall
	
NO_KEY:	
	beqz s10,N_GRAV
	csrr t0,3073
	sub t0,t0,s11			#s11 tem o tempo da ultima gravidade
	li t1,180
	bltu t0,t1,LOOP

	li a0,1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0
	li a6,0

	jal MV_V				#desce o player por 1 posicao
	
	bnez a0,N_CAIR
	
	csrr s11,3073			#salva o tempo da ultima gravidade
	
	li a0,0
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	jal ANIMACAO
	
N_CAIR:
	
	
	la a0,PLAYER_POS
	la a1,MATRIZ
	la a2,M_SIZE
	jal FLUTUANDO			#checa se o player ainda esta flutuando
	mv s10,a0
	bnez s10,N_RES_DASH
	li s9,1
	
N_RES_DASH:
	addi sp,sp,-4
	sw a1,0(sp)
	

	la a0,MATRIZ
	la a1,M_SIZE
	#jal M_SHOW
	
	
	la a0,n
	li a7,4
	#ecall
	
	lw t0,0(sp)
	addi sp,sp,4
	bgtz t0,MORREU
	
	
N_GRAV:
	j LOOP
	

PROX_NIVEL:
	la t0,NIVEL
	lb t1,0(t0)
	addi t1,t1,1
	sb t1,0(t0)
	mv a0,t1
	jal SETUP
	
	j LOOP

END:
	la a0,ganhou
	li a7,4
	ecall
	li a7,10
	ecall



#return a0= flag (-1 para quit, 0 para tecla pressionada, 1 para tecla n pressionada)
GET_KEY:
	addi sp,sp,-4
	sw ra,0(sp)
	
	
	li t0,0xFF200000		#endereco do controle do teclado
	lw t1,0(t0)
	andi t1,t1,0x01
	li a0,1
	beqz t1,GET_KEY_NO_KEY		#se nao foi pressionada tecla, pula
	lw t1,4(t0)					#t1 = tecla pressionada pelo usuario

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
	
	li t0,'w'
	beq t1,t0,w
	
	li t0,'A'
	beq t1,t0,A
	
	li t0,'C'
	beq t1,t0,C
	
	li t0,'D'
	beq t1,t0,D
	
	li t0,'E'
	beq t1,t0,E
	
	li t0,'Q'
	beq t1,t0,Q
	
	li t0,'W'
	beq t1,t0,W
	
	li t0,'Z'
	beq t1,t0,Z
	
	li t0,'1'
	beq t1,t0,T1
	
	li t0,'2'
	beq t1,t0,T2
	
	li t0,'3'
	beq t1,t0,T3
	
	li t0,'4'
	beq t1,t0,T4
	
	li t0,'5'
	beq t1,t0,T5

	j GET_KEY_NO_KEY

T1:
	li a0,1
	jal SETUP
	
	la t0,NIVEL
	li t1,1
	sb t1,0(t0)
	
	li a0,0
	j GET_KEY_END

T2:
	li a0,2
	jal SETUP
	
	la t0,NIVEL
	li t1,2
	sb t1,0(t0)
	
	li a0,0
	j GET_KEY_END

T3:
	li a0,3
	jal SETUP
	
	la t0,NIVEL
	li t1,3
	sb t1,0(t0)
	
	li a0,0
	j GET_KEY_END

T4:
	li a0,4
	jal SETUP
	
	la t0,NIVEL
	li t1,4
	sb t1,0(t0)
	
	li a0,0
	j GET_KEY_END

T5:
	li a0,5
	jal SETUP
	
	la t0,NIVEL
	li t1,5
	sb t1,0(t0)
	
	li a0,0
	j GET_KEY_END

a:
	li s8,0					#jogador vira para a esquerda
	
	li a0,-1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MV_H				#move o jogador um espaco para esquerda
	
	bnez a0,a_CONT
	
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	
	bnez s10,a_FLUT
	
	li a0,1
	jal ANIMACAO
	
	j a_CONT
	
a_FLUT:
	li a0,9
	jal ANIMACAO
	
a_CONT:
	bnez s10,JA_FLUTUANDO	#se ja esta flutuando, termina
	la a0,PLAYER_POS
	la a1,MATRIZ
	la a2,M_SIZE
	jal FLUTUANDO			#checa se esta flutuando depois de mover
	mv s10,a0
	#xori s9,a0,1
	
	csrr s11,3073			#comeca o timer da gravidade
	
	li a0,0
	j GET_KEY_END

d:
	li s8,1					#jogador vira para a direita

	li a0,1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MV_H				#move o jogador um espaco para direita

	bnez a0,d_CONT
	
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	
	bnez s10,d_FLUT
	
	li a0,1
	jal ANIMACAO
	
	j d_CONT
	
d_FLUT:
	li a0,9
	jal ANIMACAO
	
d_CONT:
	bnez s10,JA_FLUTUANDO	#se ja esta flutuando, termina
	
	la a0,PLAYER_POS
	la a1,MATRIZ
	la a2,M_SIZE
	jal FLUTUANDO			#checa se esta flutuando depois de mover
	mv s10,a0
	#xori s9,a0,1
	
	csrr s11,3073			#comeca o timer da gravidade

	li a0,0
	j GET_KEY_END


e:
	li s8,1					#jogador vira para a direita
	la a0,PLAYER_POS
	la a1,MATRIZ
	la a2,M_SIZE
	
	jal PAREDE_LADO			#checa se o jogador esta do lado de uma parede
	beqz a0,e_PULO_PAREDE
	bnez s10,N_PULA			#se esta flutuando, nao pula
e_PULO_PAREDE:
	li a0,1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MV_DG_C				#move o player 1 espaco para a diagonal cima direita
	
	bnez a0,e_CONT
	
	li a0,4
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	jal ANIMACAO
	
e_CONT:
	
	li s10,1				#depois de pular, esta flutuando
	csrr s11,3073
	
	li a0,0
	j GET_KEY_END

p:
	li a0,-1
	j GET_KEY_NO_KEY


q:
	li s8,0					#jogador vira para a esquerda
	la a0,PLAYER_POS
	la a1,MATRIZ
	la a2,M_SIZE
	
	jal PAREDE_LADO			#checa se o jogador esta do lado de uma parede
	beqz a0,q_PULO_PAREDE
	bnez s10,N_PULA
q_PULO_PAREDE:
	li a0,-1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MV_DG_C
	
	bnez a0,q_CONT
	
	li a0,4
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	jal ANIMACAO
	
q_CONT:
	
	li s10,1
	csrr s11,3073
	
	li a0,0
	j GET_KEY_END


w:
	la a0,PLAYER_POS
	la a1,MATRIZ
	la a2,M_SIZE
	
	jal PAREDE_LADO			#checa se o jogador esta do lado de uma parede
	beqz a0,w_PULO_PAREDE
	bnez s10,N_PULA
w_PULO_PAREDE:
	li a0,-1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0
	li a6,0

	jal MV_V

	bnez a0,w_CONT
	
	li a0,3
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	jal ANIMACAO
	
w_CONT:
	li s10,1
	csrr s11,3073

	li a0,0
	j GET_KEY_END
	
A:
	beqz s9,N_DASH
	li s8,0					#jogador vira para a esquerda
	
	li s9,0
	
	li a0,-1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MV_H				#move o jogador um espaco para esquerda
	
	bnez a0,A_CONT
	
	li a0,2
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	jal ANIMACAO
	
	li a0,-1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MV_H				#move o jogador um espaco para esquerda
	
	bnez a0,A_CONT
	
	li a0,2
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	jal ANIMACAO
	
A_CONT:
	bnez s10,JA_FLUTUANDO	#se ja esta flutuando, termina
	
	la a0,PLAYER_POS
	la a1,MATRIZ
	la a2,M_SIZE
	jal FLUTUANDO			#checa se esta flutuando depois de mover
	mv s10,a0
	xori s9,a0,1

	csrr s11,3073			#comeca o timer da gravidade
	
	li a0,0
	j GET_KEY_END

C:
	beqz s9,N_DASH
	li s8,1					#jogador vira para a direita
	
	li s9,0
	
	li a0,1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MV_DG_B				#move o player 1 espaco para a diagonal baixo direita
	
	bnez a0,C_CONT
	
	li a0,6
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	jal ANIMACAO
	
	li a0,1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MV_DG_B				#move o player 1 espaco para a diagonal baixo direita
	
	bnez a0,C_CONT
	
	li a0,6
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	jal ANIMACAO
	
C_CONT:
	bnez s10,JA_FLUTUANDO	#se ja esta flutuando, termina
	
	la a0,PLAYER_POS
	la a1,MATRIZ
	la a2,M_SIZE
	jal FLUTUANDO			#checa se esta flutuando depois de mover
	mv s10,a0
	xori s9,a0,1

	csrr s11,3073			#comeca o timer da gravidade
	
	li a0,0
	j GET_KEY_END


D:
	beqz s9,N_DASH
	li s8,1					#jogador vira para a direita
	
	li s9,0

	li a0,1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MV_H				#move o jogador um espaco para direita
	
	bnez a0,D_CONT
	
	li a0,2
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	jal ANIMACAO
	
	li a0,1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MV_H				#move o jogador um espaco para direita
	
	bnez a0,D_CONT
	
	li a0,2
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	jal ANIMACAO

D_CONT:
	bnez s10,JA_FLUTUANDO	#se ja esta flutuando, termina
	
	la a0,PLAYER_POS
	la a1,MATRIZ
	la a2,M_SIZE
	jal FLUTUANDO			#checa se esta flutuando depois de mover
	mv s10,a0
	xori s9,a0,1

	csrr s11,3073			#comeca o timer da gravidade


	li a0,0
	j GET_KEY_END

E:
	beqz s9,N_DASH
	li s8,1					#jogador vira para a direita
	
	li s9,0

	li a0,1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MV_DG_C				#move o player 1 espaco para a diagonal cima direita
	
	bnez a0,E_CONT
	
	li a0,5
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	jal ANIMACAO
	
	li a0,1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MV_DG_C				#move o player 1 espaco para a diagonal cima direita
	
	bnez a0,E_CONT
	
	li a0,5
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	jal ANIMACAO

E_CONT:
	li s10,1
	csrr s11,3073

	li a0,0
	j GET_KEY_END

Q:
	beqz s9,N_DASH
	li s8,0					#jogador vira para a esquerda
	
	li s9,0

	li a0,-1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MV_DG_C				#move o player 1 espaco para a diagonal cima esquerda
	
	bnez a0,Q_CONT
	
	li a0,5
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	jal ANIMACAO
	
	li a0,-1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MV_DG_C				#move o player 1 espaco para a diagonal cima esquerda
	
	bnez a0,Q_CONT
	
	li a0,5
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	jal ANIMACAO

Q_CONT:

	li s10,1
	csrr s11,3073
	
	li a0,0
	j GET_KEY_END

S:
	beqz s9,N_DASH
	
	li a0,1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0
	li a6,0

	jal MV_V				#move o jogador 1 espaco para baixo
	
	bnez a0,S_CONT
	
	li a0,8
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	jal ANIMACAO
	
	li a0,1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0
	li a6,0

	jal MV_V				#move o jogador 1 espaco para baixo
	
	bnez a0,S_CONT
	
	li a0,8
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	jal ANIMACAO

S_CONT:

	li s9,0
	li s10,1
	csrr s11,3073

	li a0,0
	j GET_KEY_END

W:
	beqz s9,N_DASH
	
	li s9,0
	
	li a0,-1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0
	li a6,0

	jal MV_V				#move o jogador 1 espaco para cima
	
	bnez a0,W_CONT
	
	li a0,7
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	jal ANIMACAO
	
	li a0,-1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0
	li a6,0

	jal MV_V				#move o jogador 1 espaco para cima
	
	bnez a0,W_CONT
	
	li a0,7
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	jal ANIMACAO

W_CONT:
	li s10,1
	csrr s11,3073

	li a0,0
	j GET_KEY_END


Z:
	beqz s9,N_DASH
	li s8,0					#jogador vira para a esquerda
	
	li s9,0

	li a0,-1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MV_DG_B				#move o jogador 1 espaco para a diagonal baixo esquerda
	
	bnez a0,Z_CONT
	
	li a0,6
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	jal ANIMACAO
	
	li a0,-1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0

	jal MV_DG_B				#move o jogador 1 espaco para a diagonal baixo esquerda
	
	bnez a0,Z_CONT
	
	li a0,6
	la t0,NIVEL
	la t1,MAPAS
	lb t0,0(t0)
	slli t0,t0,2
	add t1,t1,t0
	lw a1,-4(t1)
	jal ANIMACAO

Z_CONT:
	bnez s10,JA_FLUTUANDO	#se ja esta flutuando, termina
	la a0,PLAYER_POS
	la a1,MATRIZ
	la a2,M_SIZE
	jal FLUTUANDO			#checa se esta flutuando depois de mover
	mv s10,a0
	xori s9,a0,1

	csrr s11,3073			#comeca o timer da gravidade
	

	li a0,0
	j GET_KEY_END


JA_FLUTUANDO:
N_PULA:
N_DASH:
	li a0,0
	j GET_KEY_END


GET_KEY_END:


GET_KEY_NO_KEY:	
	lw ra,0(sp)
	addi sp,sp,4
	ret




MORREU:
	la t0,LAMAR_COUNT
	sb zero,0(t0)
	
	la t0,NIVEL
	lb a0,0(t0)
	jal SETUP
	j LOOP


.include "movimentacao.s"
.include "inimigo.s"
.include "show.s"
.include "setup.s"
.include "tela.s"
.include "musica.s"
.include "extras.s"
.include "cutscenes.s"
