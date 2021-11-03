.data

ABERTURA_JOJO:		.string "cutscenes/jojo.bin"	# 355 frames
CUTSCENE_INICIO:	.string "cutscenes/inicio.bin"	# 959 frames
CUTSCENE_FINAL:		.string "cutscenes/final.bin"	# 1018 frames
CUTSCENE_MORREU:	.string "cutscenes/morreu.bin"	# 82 frames

CONTADOR_DE_FRAME:	.word 0
TEMPO_DA_ULTIMA:	.word 0
NUMERO_DE_FRAMES:	.word 0
.text


#toca uma cutscene
#a0= file descriptor
PLAY_CUTSCENE:
	addi sp,sp,-8
	sw ra,0(sp)
	sw s0,4(sp)

	mv s0,a0

PLAY_CUTSCENE_LOOP:

	csrr t0,3073
	la t1,TEMPO_DA_ULTIMA
	lw t2,0(t1)
	sub t0,t0,t2
	li t3,40
	bltu t0,t3,PLAY_CUTSCENE_LOOP
	
	
	
	mv a0,s0	
	li a1,0xFF000000
	li a2,76800
	li a7,63
	ecall


PLAY_CUTSCENE_END:
	lw ra,0(sp)
	lw s0,4(sp)
	addi sp,sp,8
	ret
	



#0 -> jojo	
#1 -> inicio
#2 -> final
#3 -> morreu
#prepara uma cutscene para ser tocada
#a0= cutscene a ser tocada
#return a0= file descriptor
CUTSCENE_SETUP:
	addi sp,sp,-4
	sw ra,0(sp)

	la t1,NUMERO_DE_FRAMES
	li a1,0
	li a7,1024

	li t0,0
	beq a0,t0,C_SETUP_JOJO
	
	li t0,1
	beq a0,t0,C_SETUP_INICIO
	
	li t0,2
	beq a0,t0,C_SETUP_FINAL
	
	li t0,3
	beq a0,t0,C_SETUP_MORREU
	
C_SETUP_JOJO:
	li t3,355
	sw t3,0(t1)
	
	li a0,0
	jal SET_PL
	
	la a0,ABERTURA_JOJO
	ecall

	j CUTSCENE_SETUP_END

C_SETUP_INICIO:
	li t3,959
	sw t3,0(t1)
	
	li a0,1
	jal SET_PL
	
	la a0,CUTSCENE_INICIO
	ecall

	j CUTSCENE_SETUP_END
	
C_SETUP_FINAL:
	li t3,1018
	sw t3,0(t1)
	
	li a0,1
	jal SET_PL
	
	la a0,CUTSCENE_FINAL
	ecall

	j CUTSCENE_SETUP_END
	
C_SETUP_MORREU:
	li t3,82
	sw t3,0(t1)
	
	li a0,3
	jal SET_PL
	
	la a0,CUTSCENE_MORREU
	ecall


CUTSCENE_SETUP_END:
	lw ra,0(sp)
	addi sp,sp,4
	ret
