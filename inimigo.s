.data

#0 -> direita
#1 -> cima
#2 -> esquerda
#3 -> baixo

#39 movimentos

MOVIMENTOS:	.byte 0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,3,2,2,2,2,2,2,3,3
MOV_COUNT:	.byte 0
INIMIGO_POS:.byte 1,12	#coluna, linha
INIMIGO_POS_A:.byte 1,12

.text


#controla os movimentos do inimigo
#return a0= acabou (0 para nao acabou, 1 para acabou)
INIMIGO_CTRL:
	addi sp,sp,-4
	sw ra,0(sp)

	csrr t0,3073
	sub t0,t0,s7					#s7 tem o tempo do ultimo movimento
	li t1,200
	li a0,0
	bltu t0,t1,INIMIGO_CTRL_END		#se nao passou 750 ms, nao move
	
	la t0,MOV_COUNT
	lb t1,0(t0)
	li a0,1
	li t2,38
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
	
	li a0,0
	jal ANIMACAO_INIMIGO
	
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
	
	li a0,1
	jal ANIMACAO_INIMIGO
	
	j INIMIGO_MV_END

INI_MV_E:
	li a0,-1
	li a1,7
	la a2,INIMIGO_POS
	la a3,MATRIZ
	la a4,M_SIZE
	li a5,0
	
	jal MV_H						#move o inimigo 1 quadrado para esquerda
	
	li a0,2
	jal ANIMACAO_INIMIGO
	
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
	
	li a0,3
	jal ANIMACAO_INIMIGO

INIMIGO_MV_END:
	lw ra,0(sp)
	addi sp,sp,4
	ret
	

#0 -> direita
#1 -> cima
#2 -> esquerda
#3 -> baixo
#a0= direcao
ANIMACAO_INIMIGO:
	addi sp,sp,-8
	sw ra,0(sp)
	sw a0,4(sp)

	li t0,0
	beq a0,t0,I_A_D
	
	li t0,1
	beq a0,t0,I_A_C
	
	li t0,2
	beq a0,t0,I_A_E
	
	li t0,3
	beq a0,t0,I_A_B


I_A_D:
	la t0,INIMIGO_POS_A
	lb t1,0(t0)
	
	mv a2,t1
	lb a3,1(t0)
	slli a2,a2,4			#a tela eh dividida em quadrados de 16x16
	slli a3,a3,4
	
	li s0,0					#contador
	
I_A_D_LOOP:
	la a0,boss_lamar_r
	la a1,mapa5
	jal APAGAR
	
	la a0,boss_lamar_r
	addi a1,a2,4
	mv a2,a3
	jal D_SETUP
	
	li a0,10
	li a7,32
	ecall
	
	mv a3,a2
	mv a2,a1
	
	addi s0,s0,1
	li t3,4
	blt s0,t3,I_A_D_LOOP
	
	la t0,INIMIGO_POS_A
	lb t1,0(t0)
	addi t1,t1,1
	sb t1,0(t0)

	j ANIMACAO_INIMIGO_END

I_A_C:
	la t0,INIMIGO_POS_A
	lb t1,0(t0)
	
	mv a2,t1
	lb a3,1(t0)
	slli a2,a2,4			#a tela eh dividida em quadrados de 16x16
	slli a3,a3,4
	
	li s0,0					#contador
	
I_A_C_LOOP:
	la a0,boss_lamar_u
	la a1,mapa5
	jal APAGAR
	
	la a0,boss_lamar_u
	addi a1,a2,-1280
	mv a2,a3
	jal D_SETUP
	
	li a0,10
	li a7,32
	ecall
	
	mv a3,a2
	mv a2,a1
	
	addi s0,s0,1
	li t3,4
	blt s0,t3,I_A_C_LOOP
	
	la t0,INIMIGO_POS_A
	lb t1,1(t0)
	addi t1,t1,-1
	sb t1,1(t0)
	
	j ANIMACAO_INIMIGO_END

I_A_E:
	la t0,INIMIGO_POS_A
	lb t1,0(t0)
	
	mv a2,t1
	lb a3,1(t0)
	slli a2,a2,4			#a tela eh dividida em quadrados de 16x16
	slli a3,a3,4
	
	li s0,0					#contador
	
I_A_E_LOOP:
	la a0,boss_lamar_l
	la a1,mapa5
	jal APAGAR
	
	la a0,boss_lamar_l
	addi a1,a2,-4
	mv a2,a3
	jal D_SETUP
	
	li a0,10
	li a7,32
	ecall
	
	mv a3,a2
	mv a2,a1
	
	addi s0,s0,1
	li t3,4
	blt s0,t3,I_A_E_LOOP
	
	la t0,INIMIGO_POS_A
	lb t1,0(t0)
	addi t1,t1,-1
	sb t1,0(t0)
	
	j ANIMACAO_INIMIGO_END

I_A_B:
	la t0,INIMIGO_POS_A
	lb t1,0(t0)
	
	mv a2,t1
	lb a3,1(t0)
	slli a2,a2,4			#a tela eh dividida em quadrados de 16x16
	slli a3,a3,4
	
	li s0,0					#contador
	
I_A_B_LOOP:
	la a0,boss_lamar_d
	la a1,mapa5
	jal APAGAR
	
	la a0,boss_lamar_d
	addi a1,a2,1280
	mv a2,a3
	jal D_SETUP
	
	li a0,10
	li a7,32
	ecall
	
	mv a3,a2
	mv a2,a1
	
	addi s0,s0,1
	li t3,4
	blt s0,t3,I_A_B_LOOP
	
	la t0,INIMIGO_POS_A
	lb t1,1(t0)
	addi t1,t1,1
	sb t1,1(t0)


ANIMACAO_INIMIGO_END:
	lw ra,0(sp)
	lw s0,4(sp)
	addi sp,sp,8
	ret
	

