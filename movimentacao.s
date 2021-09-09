.text

#
#a0= unidades a mover (negativo para esquerda, positivo para direita)
#a1= o que vai ser movido (1 para player, etc)
#a2= posicao do que vai ser movido (coluna, linha)
#a3= matriz do jogo
#a4= tamanho da matriz do jogo (n_linhas, n_colunas)
#a5= ignora obstaculos (0 para n ignorar, 1 para ignorar)
#return void
MOVE_H:
	lb t0,0(a2)				#t0 = indice da coluna onde o objeto esta
	add t1,t0,a0			#t1 = indice da coluna destino
	bltz t1,MOVE_H_END		#se o objeto n conseguir mover tanto para esquerda, n move
	lw t5,4(a4)				#t5 = numero de colunas
	bge t1,t5,MOVE_H_END	#se o objeto n conseguir mover tanto para a direita, n move
	lb t2,1(a2)				#t2 = indice da linha onde o objeto esta
	slli t2,t2,2			#como cada linha e um word, multiplica o indice por 4
	add t2,t2,a3			#t2 = endereco da linha na matriz
	lw t3,0(t2)				#t3 = linha
	slli t2,t1,2
	add t2,t2,t3			#t2 = endereco destino
	lw t4,0(t2)				#t4 = objeto no endereco destino
	li t5,2
	bnez a5,IGNORA_H
	beq t4,t5,MOVE_H_END	#se o objeto no destino for parede, n move
IGNORA_H:
	slli t4,t0,2
	add t4,t4,t3			#t4 = endereco original
	sw zero,0(t4)			#coloca 0 no endereco original
	sw a1,0(t2)				#coloca o objeto no novo endereco
	sb t1,0(a2)				#muda a posicao do objeto

MOVE_H_END:
	ret



#
#a0= unidades a mover (negativo para cima, positivo para baixo)
#a1= o que vai ser movido (1 para player, etc)
#a2= posicao do que vai ser movido (coluna, linha)
#a3= matriz do jogo
#a4= tamanho da matriz do jogo (n_linhas, n_colunas)
#a5= ignora obstaculos (0 para n ignorar, 1 para ignorar)
#return void
MOVE_V:
	addi sp,sp,-4
	sw s0,0(sp)

	lb t0,1(a2)				#t0 = indice da linha onde o objeto esta
	add t1,t0,a0			#t1 = indice da linha destino
	bltz t1,MOVE_V_END		#se o objeto n conseguir mover tanto para cima, n move
	lw t5,0(a4)				#t5 = numero de linhas
	bge t1,t5,MOVE_V_END	#se o objeto n conseguir mover tanto para a baixo, n move
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
	li s0,2
	bnez a5,IGNORA_V
	beq t6,s0,MOVE_V_END	#se o objeto no destino for parede, n move
IGNORA_V:
	add t6,t2,t3			#t6 = endereco original
	sw zero,0(t6)			#coloca 0 no endereco original
	sw a1,0(t5)				#coloca o objeto no novo endereco
	sb t1,1(a2)				#muda a posicao do objeto


MOVE_V_END:
	lw s0,0(sp)
	addi sp,sp,4
	ret




#
#a0= unidades a mover (negativo para diagonal esquerda, positivo para diagonal direita)
#a1= o que vai ser movido (1 para player, etc)
#a2= posicao do que vai ser movido (coluna, linha)
#a3= matriz do jogo
#a4= tamanho da matriz do jogo (n_linhas, n_colunas)
#a5= ignora obstaculos (0 para n ignorar, 1 para ignorar)
#return void
MOVE_DG:

	addi sp,sp,-8
	sw s0,0(sp)
	sw s1,4(sp)
	
	
	mv t0,a0				#indice da linha destino = indice da linha original - |a0|
	bltz t0,MV_DG_NUM_NEG	#se a0 < 0, a0 = - |a0|
	sub t0,zero,t0			#t0 = -|a0|
	
MV_DG_NUM_NEG:
	lb t1,1(a2)				#t1 = indice da linha original
	add t0,t0,t1			#t0 = indice da linha destino
	bltz t0,MOVE_DG_END		#se o indice da linha destino for < 0, n move
	mv s0,t0
	slli t0,t0,2
	add t0,t0,a3			#t0 = endereco da linha de destino
	lb t2,0(a2)				#t2 = indice da coluna original
	add t3,t2,a0			#t3 = indice da coluna destino
	bltz t3,MOVE_DG_END		#se o indice da coluna destino for < 0, n move
	lw t5,4(a4)				#numero de colunas
	bge t3,t5,MOVE_DG_END	#se o indice de coluna destino for <= n_colunas, n move
	mv s1,t3
	slli t3,t3,2
	lw t0,0(t0)				#t0 = linha destino
	add t3,t3,t0			#t3 = endereco destino
	lw t4,0(t3)				#t4 = objeto no destino
	li t5,2
	bnez a5,IGNORA_DG
	beq t4,t5,MOVE_DG_END	#se o objeto no destino for parede, n move
	
IGNORA_DG:
	slli t1,t1,2
	add t1,t1,a3			#t1 = endereco da linha original
	slli t2,t2,2
	lw t1,0(t1)
	add t2,t2,t1			#t2 = endereco original
	sw zero,0(t2)			#coloca 0 no endereco original
	sw a1,0(t3)				#coloca o objeto no novo endereco
	sb s1,0(a2)				#muda a coluna do objeto
	sb s0,1(a2)				#muda a linha do objeto

MOVE_DG_END:
	lw s0,0(sp)
	lw s1,4(sp)
	addi sp,sp,8
	ret


