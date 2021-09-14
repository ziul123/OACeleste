.text

#move algo na horizontal
#a0= unidades a mover (negativo para esquerda, positivo para direita)
#a1= o que vai ser movido (1 para player, etc)
#a2= posicao do que vai ser movido (coluna, linha)
#a3= matriz do jogo
#a4= tamanho da matriz do jogo (n_linhas, n_colunas)
#a5= ignora obstaculos (0 para n ignorar, 1 para ignorar)
#return a0= moveu (0 se moveu, -1 se n moveu)
MV_H:
	addi sp,sp,-4
	sw ra,0(sp)

	lb t0,0(a2)				#t0 = indice da coluna onde o objeto esta
	add t1,t0,a0			#t1 = indice da coluna destino
	bltz t1,MV_H_END		#se o objeto n conseguir mover tanto para esquerda, n move
	lw t5,4(a4)				#t5 = numero de colunas
	bge t1,t5,MV_H_END	#se o objeto n conseguir mover tanto para a direita, n move
	lb t2,1(a2)				#t2 = indice da linha onde o objeto esta
	slli t2,t2,2			#como cada linha e um word, multiplica o indice por 4
	add t2,t2,a3			#t2 = endereco da linha na matriz
	lw t3,0(t2)				#t3 = linha
	slli t2,t1,2
	add t2,t2,t3			#t2 = endereco destino
	lw t4,0(t2)				#t4 = objeto no endereco destino
	li t5,2
	bnez a5,IGNORA_H
	beq t4,t5,MV_H_END	#se o objeto no destino for parede, n move
IGNORA_H:
	slli t4,t0,2
	add t4,t4,t3			#t4 = endereco original
	sw zero,0(t4)			#coloca 0 no endereco original
	sw a1,0(t2)				#coloca o objeto no novo endereco
	sb t1,0(a2)				#muda a posicao do objeto

MV_H_END:
	lw ra,0(sp)
	addi sp,sp,4
	ret







#move algo na vertical
#a0= unidades a mover (negativo para cima, positivo para baixo)
#a1= o que vai ser movido (1 para player, etc)
#a2= posicao do que vai ser movido (coluna, linha)
#a3= matriz do jogo
#a4= tamanho da matriz do jogo (n_linhas, n_colunas)
#a5= ignora obstaculos (0 para n ignorar, 1 para ignorar)
#return a0= moveu (0 se moveu, -1 se n moveu)
MV_V:
	addi sp,sp,-8
	sw ra,0(sp)
	sw s0,4(sp)

	mv s0,a0
	li a0,-1

	lb t0,1(a2)				#t0 = indice da linha onde o objeto esta
	add t1,t0,s0			#t1 = indice da linha destino
	bltz t1,MV_V_END		#se o objeto n conseguir mover tanto para cima, n move
	lw t5,0(a4)				#t5 = numero de linhas
	bge t1,t5,MV_V_END	#se o objeto n conseguir mover tanto para a baixo, n move
	lb t2,0(a2)				#t2 = indice da coluna onde o objeto esta
	slli t2,t2,2			#t2 = offset da coluna
	slli t3,t0,2
	add t3,t3,a3			#t3 = endereco da linha original
	lw t3,0(t3)				#t3 = linha original
	slli t4,t1,2
	add t4,t4,a3			#t4 = endereco da linha destino
	lw t4,0(t4)				#t4 = linha destino
	add t5,t2,t4			#t5 = endereco destino
	lw t6,0(t5)				#t6 = objeto no endereco destino
	li t0,2
	bnez a5,IGNORA_V
	beq t6,t0,MV_V_END	#se o objeto no destino for parede, n move
IGNORA_V:
	li a0,0
	add t6,t2,t3			#t6 = endereco original
	sw zero,0(t6)			#coloca 0 no endereco original
	sw a1,0(t5)				#coloca o objeto no novo endereco
	sb t1,1(a2)				#muda a posicao do objeto

MV_V_END:
	lw ra,0(sp)
	lw s0,4(sp)
	addi sp,sp,8
	ret








#move algo para diagonal esquerda ou direita para cima
#a0= unidades a mover (negativo para diagonal esquerda, positivo para diagonal direita)
#a1= o que vai ser movido (1 para player, etc)
#a2= posicao do que vai ser movido (coluna, linha)
#a3= matriz do jogo
#a4= tamanho da matriz do jogo (n_linhas, n_colunas)
#a5= ignora obstaculos (0 para n ignorar, 1 para ignorar)
#return a0= moveu (0 se moveu, -1 se n moveu)
MV_DG_C:
	addi sp,sp,-12
	sw ra,0(sp)
	sw s0,4(sp)
	sw s1,8(sp)
	
	
	mv t0,a0				#indice da linha destino = indice da linha original - |a0|
	bltz t0,MV_DG_C_NUM_NEG	#se a0 < 0, a0 = - |a0|
	sub t0,zero,t0			#t0 = -|a0|
	
MV_DG_C_NUM_NEG:
	lb t1,1(a2)				#t1 = indice da linha original
	add t0,t0,t1			#t0 = indice da linha destino
	bltz t0,MV_DG_C_END		#se o indice da linha destino for < 0, n move
	mv s0,t0
	slli t0,t0,2
	add t0,t0,a3			#t0 = endereco da linha de destino
	lb t2,0(a2)				#t2 = indice da coluna original
	add t3,t2,a0			#t3 = indice da coluna destino
	bltz t3,MV_DG_C_END		#se o indice da coluna destino for < 0, n move
	lw t5,4(a4)				#numero de colunas
	bge t3,t5,MV_DG_C_END	#se o indice de coluna destino for <= n_colunas, n move
	mv s1,t3
	slli t3,t3,2
	lw t0,0(t0)				#t0 = linha destino
	add t3,t3,t0			#t3 = endereco destino
	lw t4,0(t3)				#t4 = objeto no destino
	li t5,2
	bnez a5,IGNORA_DG_C
	beq t4,t5,MV_DG_C_END	#se o objeto no destino for parede, n move
	
IGNORA_DG_C:
	slli t1,t1,2
	add t1,t1,a3			#t1 = endereco da linha original
	slli t2,t2,2
	lw t1,0(t1)
	add t2,t2,t1			#t2 = endereco original
	sw zero,0(t2)			#coloca 0 no endereco original
	sw a1,0(t3)				#coloca o objeto no novo endereco
	sb s1,0(a2)				#muda a coluna do objeto
	sb s0,1(a2)				#muda a linha do objeto

MV_DG_C_END:
	lw ra,0(sp)
	lw s0,4(sp)
	lw s1,8(sp)
	addi sp,sp,12
	ret





#move algo para diagonal esquerda ou direita para baixo
#a0= unidades a mover (negativo para diagonal esquerda, positivo para diagonal direita)
#a1= o que vai ser movido (1 para player, etc)
#a2= posicao do que vai ser movido (coluna, linha)
#a3= matriz do jogo
#a4= tamanho da matriz do jogo (n_linhas, n_colunas)
#a5= ignora obstaculos (0 para n ignorar, 1 para ignorar)
#return a0= moveu (0 se moveu, -1 se n moveu)
MV_DG_B:
	addi sp,sp,-12
	sw ra,0(sp)
	sw s0,4(sp)
	sw s1,8(sp)
	

	mv t0,a0				#indice da linha destino = indice da linha original + |a0|
	bgtz t0,MV_DG_B_NUM_POS	#se a0 > 0, a0 = |a0|
	sub t0,zero,t0			#t0 = |a0|

MV_DG_B_NUM_POS:
	lb t1,1(a2)				#t1 = indice da linha original
	add t0,t0,t1			#t0 = indice da linha destino
	lw t2,0(a4)				#t2 = numero de linhas
	bge t0,t2,MV_DG_B_END	#se o indice da linha destino esta fora da matriz, n move
	mv s0,t0
	slli t0,t0,2
	add t0,t0,a3			#t0 = endereco da linha de destino
	lb t2,0(a2)				#t2 = indice da coluna original
	add t3,t2,a0			#t3 = indice da coluna destino
	bltz t3,MV_DG_B_END		#se o indice da coluna destino for < 0, n move
	lw t5,4(a4)				#numero de colunas
	bge t3,t5,MV_DG_B_END	#se o indice de coluna destino for <= n_colunas, n move
	mv s1,t3
	slli t3,t3,2
	lw t0,0(t0)				#t0 = linha destino
	add t3,t3,t0			#t3 = endereco destino
	lw t4,0(t3)				#t4 = objeto no destino
	li t5,2
	bnez a5,IGNORA_DG_B
	beq t4,t5,MV_DG_B_END	#se o objeto no destino for parede, n move
	
IGNORA_DG_B:
	slli t1,t1,2
	add t1,t1,a3			#t1 = endereco da linha original
	slli t2,t2,2
	lw t1,0(t1)
	add t2,t2,t1			#t2 = endereco original
	sw zero,0(t2)			#coloca 0 no endereco original
	sw a1,0(t3)				#coloca o objeto no novo endereco
	sb s1,0(a2)				#muda a coluna do objeto
	sb s0,1(a2)				#muda a linha do objeto
	
	

MV_DG_B_END:
	lw ra,0(sp)
	lw s0,4(sp)
	lw s1,8(sp)
	addi sp,sp,12
	ret





#retorna endereco do elemento de coordenadas especificadas
#a0= coluna
#a1= linha
#a2= matriz
#a3= tamanho da matriz (n_linhas, n_colunas)
#return a0= endereco do elemento
#return a1= esta fora da matriz (0 para nao, 1 para sim)
GET_ELEMENT:
	mv t1,a1
	li a1,1
	bltz a0,GET_ELEMENT_END	#se indice da coluna < 0, esta fora da matriz
	bltz t1,GET_ELEMENT_END	#se indice da linha < 0, esta fora da matriz
	lw t2,0(a3)
	bge t1,t2,GET_ELEMENT_END	#se o indice da linha for >= n_linhas, esta fora da matriz
	lw t2,4(a3)
	bge a0,t2,GET_ELEMENT_END	#se o indice da coluna for >= n_colunas, esta fora da matriz
	li a1,0
	
	slli t0,t1,2
	add t0,t0,a2			#t0 = endereco da linha
	lw t0,0(t0)				#t0 = linha
	slli a0,a0,2
	add a0,a0,t0			#a0 = endereco do elemento

GET_ELEMENT_END:
	ret
	
	
	
	
	
#checa se algo esta flutuando
#a0= posicao do objeto
#a1= matriz
#a2= tamanho da matriz (n_linhas, n_colunas)
#return a0= esta flutuando (0 se nao estiver, 1 se estiver)
#return a1= esta na ultima linha (0 se nao estiver, 1 se estiver)
FLUTUANDO:
	addi sp,sp,-4
	sw ra,0(sp)
	
	mv a3,a2
	mv t0,a0
	mv a2,a1
	lb a0,0(t0)				#a0 = coluna do objeto
	lb a1,1(t0)
	addi a1,a1,1			#a1 = linha em baixo do objeto
	
	jal GET_ELEMENT
	bgtz a1,FLUTUANDO_END	#se o que esta abaixo esta fora da matriz, entao esta na ultima linha
	
	mv t0,a0
	lw t0,0(t0)
	li a0,1
	li t1,2
	bne t0,t1,FLUTUANDO_END	#se embaixo n tiver parede, esta flutuando
	li a0,0

FLUTUANDO_END:
	lw ra,0(sp)
	addi sp,sp,4
	ret
	
	
	
