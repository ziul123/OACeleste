.data

#0 -> direita
#1 -> cima
#2 -> esquerda
#3 -> baixo

#39 movimentos

MOVIMENTOS:	.byte 0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,3,2,2,2,2,2,2,3,3
MOV_CONT:	.byte 0
INIMIGO_POS:.byte 1,12	#coluna, linha

.text
#s7 = timer do inimigo

#controla os movimentos do inimigo
#return a0= acabou (0 para nao acabou, 1 para acabou)
INIMIGO_CTRL:
	addi sp,sp,-4
	sw ra,0(sp)

	csrr t0,3073
	sub t0,t0,s7
	li t1,1000
	li a0,0
	blt t0,t1,INIMIGO_CTRL_END
	
	la t0,MOV_COUNT
	lb t1,0(t0)
	li a0,1
	li t2,39
	bgt t1,t2,INIMIGO_CTRL_END
	
	

INIMIGO_CTRL_END:
	lw ra,0(sp)
	addi sp,sp,4
	ret
