.text

#
#a0= unidades a mover (negativo para esquerda, positivo para direita)
#a1= o que vai ser movido (1 para player, etc)
#a2= posicao do que vai ser movido (coluna, linha)
#a3= matriz do jogo
#a4= tamanho da matriz do jogo (n_linhas, n_colunas)
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
	beq t4,t5,MOVE_H_END	#se o objeto no destino for parede, n move
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
	beq t6,s0,MOVE_V_END	#se o objeto no destino for parede, n move
	add t6,t2,t3			#t6 = endereco original
	sw zero,0(t6)			#coloca 0 no endereco original
	sw a1,0(t5)				#coloca o objeto no novo endereco
	sb t1,1(a2)				#muda a posicao do objeto


MOVE_V_END:
	lw s0,0(sp)
	addi sp,sp,4
	ret
