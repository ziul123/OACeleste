.data
morango:	.string "voce coletou um lamar!"

.text


#joga o player 3 quadrados para cima
#a0= unidades a mover (negativo para cima, positivo para baixo)
#a1= o que vai ser movido (1 para player, etc)
#a2= posicao do que vai ser movido (coluna, linha)
#a3= matriz do jogo
#a4= tamanho da matriz do jogo (n_linhas, n_colunas)
MOLA:
	addi sp,sp,-4
	sw ra,0(sp)
	
	li s9,1
	
	li a0,-1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0
	li a6,1
	
	jal MV_V
	
	li a0,-1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0
	li a6,0
	
	jal MV_V
	
	li a0,-1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0
	li a6,0
	
	jal MV_V
	

MOLA_END:
	lw ra,0(sp)
	addi sp,sp,4
	ret
	
	

#funcao de coletar morango
#
MORANGO:
	addi sp,sp,-4
	sw ra,0(sp)

	la a0,morango
	li a7,4
	ecall

MORANGO_END:
	lw ra,0(sp)
	addi sp,sp,4
	ret
	
	
	

#funcao de coletar chave
#
CHAVE:
	addi sp,sp,-4
	sw ra,0(sp)
#linha 10, coluna 18

	la t0,LINHA10
	sw zero,72(t0)				#escreve 0 no lugar da porta
	
	#apagar porta

CHAVE_END:
	lw ra,0(sp)
	addi sp,sp,4
	ret
