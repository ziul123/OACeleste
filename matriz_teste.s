.data

LINHA0:	.word 0,0,2,0
LINHA1:	.word 2,0,0,1
LINHA2:	.word 0,0,0,2
LINHA3:	.word 0,2,0,0
MATRIZ:	.word LINHA0,LINHA1,LINHA2,LINHA3
PLAYER_POS:	.byte 3,1	#coluna,linha
M_SIZE:	.word 4,4		#n_linhas, n_colunas

esp:	.string " "
n:		.string "\n"

.text

MAIN:


	la a0,MATRIZ
	la t0,M_SIZE
	lw a1,0(t0)
	lw a2,4(t0)
	jal M_SHOW

	jal GET_KEY
	
	bltz a0,END
	
	la a0,n
	li a7,4
	ecall
	
	j MAIN
	
	#la a0,MATRIZ
	#li a1,3
	#li a2,3
	#jal M_SHOW

END:
	li a7,10
	ecall

# a = 0x61
# d = 0x64
# e = 0x65
# q = 0x71
# s = 0x73
# w = 0x77
#
GET_KEY:
	addi sp,sp,-4
	sw ra,0(sp)
	
	
	li a7,12
	ecall

	li t0,0x61
	beq a0,t0,a
	
	li t0,0x64
	beq a0,t0,d
	
	li t0,0x65
	beq a0,t0,e

	li t0,0x73
	beq a0,t0,s
	
	li t0,0x77
	beq a0,t0,w

	j GET_KEY_END

a:

	li a0,-1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE

	jal MOVE_H

	#lb t0,0(s1)		#coluna onde o player esta
	#beqz t0,a_END	#se for a coluna 0, n move para esquerda
	#lb t1,1(s1)		#linha onde o player esta
	#slli t1,t1,2
	#add t1,t1,s0	#endereco da linha na matriz
	#lw t2,0(t1)		#t2 = linha
	#addi t0,t0,-1
	#slli t5,t0,2
	#add t5,t5,t2
	#lw t3,0(t5)		#t3 = o que tem a esquerda do player
	#li t4,2			#objeto que impede o player
	#beq t3,t4,a_END
	#li t4,1
	#sw t4,0(t5)
	#sw zero,4(t5)
	#sb t0,0(s1)
	
#a_END:
	li a0,0
	j GET_KEY_END

d:

	li a0,1
	li a1,1
	la a2,PLAYER_POS
	la a3,MATRIZ
	la a4,M_SIZE

	jal MOVE_H


	li a0,0
	j GET_KEY_END


e:
	li a0,-1
	j GET_KEY_END

s:




	li a0,0
	j GET_KEY_END

w:





	li a0,0
	j GET_KEY_END

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

#a0= int vetor[][], a1=linhas, a2=colunas
#return void
M_SHOW:
	addi sp,sp,-20
	sw ra,0(sp)
	sw s0,4(sp)
	sw s1,8(sp)
	sw s2,12(sp)
	sw s3,16(sp)
	
	mv s0,a0	#s0 = vetor
	mv s1,a1	#s1 = linhas
	mv s2,a2	#s2 = colunas
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
	
.include "teste.s"
