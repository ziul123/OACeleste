.data

#0 -> direita
#1 -> cima
#2 -> esquerda
#3 -> baixo

#39 movimentos

MOVIMENTOS:	.byte 0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,3,2,2,2,2,2,2,3,3
MOV_COUNT:	.byte 0
INIMIGO_POS:.byte 1,12	#coluna, linha

.text


#controla os movimentos do inimigo
#return a0= acabou (0 para nao acabou, 1 para acabou)
INIMIGO_CTRL:
	addi sp,sp,-4
	sw ra,0(sp)

	csrr t0,3073
	sub t0,t0,s7					#s7 tem o tempo do ultimo movimento
	li t1,750
	li a0,0
	bltu t0,t1,INIMIGO_CTRL_END		#se nao passou 750 ms, nao move
	
	la t0,MOV_COUNT
	lb t1,0(t0)
	li a0,1
	li t2,39
	bgt t1,t2,INIMIGO_CTRL_END		#se ja foi o ultimo movimento, termina
	
	la t2,MOVIMENTOS
	add t2,t2,t1					#t2 = endereco do proximo movimento
	lb t2,0(t2)						#t2 = proximo movimento
	
	addi t1,t1,1
	sb t1,0(t0)
	
	mv a0,t2
	
	jal INIMIGO_MV
	
	csrr s7,3073

INIMIGO_CTRL_END:
	lw ra,0(sp)
	addi sp,sp,4
	ret
	
	

#move o inimigo na direcao especificada
#a0= direcao
INIMIGO_MV:
	addi sp,sp,-4
	sw ra,0(sp)

	li t0,0
	beq a0,t0,INI_MV_D
	
	li t0,1
	beq a0,t0,INI_MV_C
	
	li t0,2
	beq a0,t0,INI_MV_E
	
	li t0,3
	beq a0,t0,INI_MV_B
	
	
	
INI_MV_D:
	li a0,1
	li a1,7
	la a2,INIMIGO_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0
	
	jal MV_H						#move o inimigo 1 quadrado para direita
	
	j INIMIGO_MV_END

INI_MV_C:
	li a0,-1
	li a1,7
	la a2,INIMIGO_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0
	li a6,0
	
	jal MV_V						#move o inimigo 1 quadrado para cima
	
	j INIMIGO_MV_END

INI_MV_E:
	li a0,-1
	li a1,7
	la a2,INIMIGO_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0
	
	jal MV_H						#move o inimigo 1 quadrado para esquerda
	
	j INIMIGO_MV_END

INI_MV_B:
	li a0,1
	li a1,7
	la a2,INIMIGO_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0
	li a6,0
	
	jal MV_V						#move o inimigo 1 quadrado para baixo
	

INIMIGO_MV_END:
	lw ra,0(sp)
	addi sp,sp,4
	ret
	
	
	
.include "movimentacao.s"
