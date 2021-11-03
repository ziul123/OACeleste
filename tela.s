.data

PLAYER_POS_A:	.byte 1,5

.include "mapas/mapa1.data"
.include "mapas/mapa2.data"
.include "mapas/mapa3.data"
.include "mapas/mapa4.data"
.include "mapas/mapa5.data"


.include "sprites/walk_r.data"
.include "sprites/walk_l.data"
.include "sprites/dash_r.data"
.include "sprites/dash_l.data"
.include "sprites/jump_r.data"
.include "sprites/jump_l.data"
.include "sprites/lamar_colec.data"
.include "sprites/cafe.data"

MAPAS:	.word mapa1,mapa2,mapa3,mapa4,mapa5

.text
	


#a0= o que desenhar
#a1= x	
#a2= y
D_SETUP:
	addi sp,sp,-12
	sw ra,0(sp)
	sw a1,4(sp)
	sw a2,8(sp)

	lw t0,0(a0)			#t0 = largura
	lw t1,4(a0)
					#t1 = altura
	addi a0,a0,8
	
	li t2,0xFF000000		#inicio da frame 0
	li t3,320			#largura da tela
	
	mul t3,t3,a2
	add t3,t3,a1			#t3 = y*320 + x
	add t2,t2,t3			#t2 = tela + offset

	mv a1,t2
	mv a2,t0
	mv a3,t1
	jal DESENHAR
	
D_SETUP_END:
	lw ra,0(sp)
	lw a1,4(sp)
	lw a2,8(sp)
	addi sp,sp,12
	ret

#a0= o que vai ser apagado
#a1= fundo
#a2= x
#a3= y
APAGAR:
	addi sp,sp,-12
	sw ra,0(sp)
	sw a2,4(sp)
	sw a3,8(sp)

	lw t0,0(a0)				#t0 = largura
	lw t1,4(a0)				#t1 = altura
	
	li t2,0xFF000000		#inicio da frame 0
	li t3,320				#largura da tela
	mul t3,t3,a3
	add t3,t3,a2			#t3 = y*320 + x
	add t2,t2,t3			#t2 = tela + offset

	li t3,320
	addi a1,a1,8			#ignora a largura e altura do fundo
	mul t3,t3,a3
	add t3,t3,a2			#t3 = y*320 + x
	add a0,a1,t3			#a0 = fundo + offset

	mv a1,t2
	mv a2,t0
	mv a3,t1

	mv t3,zero				#t3 = contador de linhas
	mv t4,zero				#t4 = contador de colunas

A_LOOP:
	lw t5,0(a0)				#t5 = 4 pixeis do fundo
	sw t5,0(a1)				#desenha os pixeis na tela
	
	addi a0,a0,4			#proximos pixeis
	addi a1,a1,4			#proximo lugar na tela
	addi t4,t4,4			#contador de colunas++
	
	blt t4,a2,A_LOOP		#se n terminou de desenhar a linha, continua
	
	mv t4,zero				#zera o contador de colunas
	
	sub a0,a0,t0
	addi a0,a0,320			#volta o fundo para a coluna inicial mas na proxima linha
	
	sub a1,a1,t0
	addi a1,a1,320			#volta a tela para a coluna inicial mas na proxima linha
	addi t3,t3,1			#contador de linhas++

	blt t3,a3,A_LOOP		#se n terminou de desenhar a imagem, desenha a proxima linha



APAGAR_END:
	lw ra,0(sp)
	lw a2,4(sp)
	lw a3,8(sp)
	addi sp,sp,12
	ret
	

#a0= endereco de onde comeca o que desenhar
#a1= endereco de onde desenhar na tela
#a2= largura
#a3= altura
DESENHAR:
	addi sp,sp,-4
	sw ra,0(sp)

	mv t3,zero				#t3 = contador de linhas
	mv t4,zero				#t4 = contador de colunas

D_LOOP:
	lw t5,0(a0)				#t5 = 4 pixeis da imagem
	sw t5,0(a1)				#desenha os pixeis na tela
	
	addi a0,a0,4			#proximos pixeis
	addi a1,a1,4			#proximo lugar na tela
	addi t4,t4,4			#contador de colunas++
	
	blt t4,a2,D_LOOP		#se n terminou de desenhar a linha, continua
	
	mv t4,zero				#zera o contador de colunas
	sub a1,a1,a2
	addi a1,a1,320			#volta a tela para a coluna inicial mas na proxima linha
	addi t3,t3,1			#contador de linhas++

	blt t3,a3,D_LOOP		#se n terminou de desenhar a imagem, desenha a proxima linha

DESENHAR_END:
	lw ra,0(sp)
	addi sp,sp,4
	ret



#0- Queda
#1- S8=0 Andar para esquerda, S8=1 Andar para direita.
#2- S8=0 Dash para esquerda, S8=1 Dash para direita.
#3- Pulo Cima
#4- S8=0 Pulo diagonal para esquerda, S8=1 pulo diagonal para direita.
#5- S8=0 Dash Cima para esquerda, S8=1 Dash Cima diagonal para direita.
#6- S8=0 Dash Baixo para esquerda, S8=1 Dash Baixo diagonal para direita.
#7- Dash Cima
#8- Dash Baixo

#executa a animacao do movimento especificado
#a0= movimento a ser animado
#a1= endereco do fundo
ANIMACAO:
	addi sp,sp,-8
	sw ra,0(sp)
	sw s0,4(sp)
	mv s0,a1

	li t0,0
	beq a0,t0,ANIMACAO_0
	
	li t0,1
	beq a0,t0,ANIMACAO_1
		
	li t0,2
	beq a0,t0,ANIMACAO_2
	
	li t0,3
	beq a0,t0,ANIMACAO_3
	
	li t0,4
	beq a0,t0,ANIMACAO_4
	
	li t0,5
	beq a0,t0,ANIMACAO_5
	
	li t0,6
	beq a0,t0,ANIMACAO_6
	
	li t0,7
	beq a0,t0,ANIMACAO_7
	
	li t0,8
	beq a0,t0,ANIMACAO_8
	
	li t0,9
	beq a0,t0,ANIMACAO_9
	
ANIMACAO_0:

	la t0,PLAYER_POS_A
	lb t1,0(t0)
	beqz s8,AN0_L0
	la a0,jump_r
	beqz zero, AN0_CONT0
AN0_L0:	
	la a0,jump_l
AN0_CONT0:
	mv a1,s0
	mv a2,t1
	lb a3,1(t0)
	slli a2,a2,4			#a tela eh dividida em quadrados de 16x16
	slli a3,a3,4
	jal APAGAR
	
	beqz s8,AN0_L1
	la a0,jump_r
	addi a1,a2,1280
	beqz zero, AN0_CONT1
AN0_L1:
	la a0,jump_l
	addi a1,a2,1280
AN0_CONT1:
	mv a2,a3
	jal D_SETUP

	li a0,10
	li a7,32
	ecall
	beqz s8,AN0_L2	
	la a0,jump_r
	beqz zero, AN0_CONT2
AN0_L2:
	la a0,jump_l
AN0_CONT2:	
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	beqz s8,AN0_L3	
	la a0,jump_r
	addi a1,a2,1280
	beqz zero, AN0_CONT3
AN0_L3:	
	la a0,jump_l
	addi a1,a2,1280
AN0_CONT3:	
	mv a2,a3
	jal D_SETUP
	
	li a0,10
	li a7,32
	ecall
	
	beqz s8,AN0_L4
	la a0,jump_r
	beqz zero, AN0_CONT4
AN0_L4:
	la a0,jump_l
AN0_CONT4:		
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	beqz s8,AN0_L5
	la a0,jump_r
	addi a1,a2,1280
	beqz zero, AN0_CONT5
AN0_L5:	
	la a0,jump_l
	addi a1,a2,1280
AN0_CONT5:	
	mv a2,a3
	jal D_SETUP

	li a0,10
	li a7,32
	ecall
	
	beqz s8,AN0_L6
	la a0,jump_r
	beqz zero AN0_CONT6
AN0_L6:	
	la a0,jump_l
AN0_CONT6:	
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	la t0,PLAYER_POS_A
	lb t1,1(t0)
	addi t1,t1,1
	sb t1,1(t0)
	beqz s8,AN0_L7
	la a0,jump_r
	beqz zero AN0_CONT7
AN0_L7:
	la a0,jump_l
AN0_CONT7:		
	lb a1,0(t0)
	lb a2,1(t0)
	slli a1,a1,4			#a tela eh dividida em quadrados de 16x16
	slli a2,a2,4
	jal D_SETUP
		
	j ANIMACAO_END

ANIMACAO_1:
	la t0,PLAYER_POS_A
	lb t1,0(t0)
	beqz s8,AN1_L0
	la a0,walk_r
	beqz zero, AN1_CONT0
AN1_L0:	
	la a0,walk_l
AN1_CONT0:
	mv a1,s0
	mv a2,t1
	lb a3,1(t0)
	slli a2,a2,4			#a tela eh dividida em quadrados de 16x16
	slli a3,a3,4
	jal APAGAR
	
	beqz s8,AN1_L1
	la a0,walk01_r
	addi a1,a2,4
	beqz zero AN1_CONT1
AN1_L1:
	la a0,walk01_l
	addi a1,a2,-4
AN1_CONT1:
	mv a2,a3
	jal D_SETUP

	li a0,60
	li a7,32
	ecall
	
	beqz s8,AN1_L2	
	la a0,walk01_r
	beqz zero AN1_CONT2
AN1_L2:
	la a0,walk01_l
AN1_CONT2:	
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	beqz s8,AN1_L3	
	la a0,walk02_r
	addi a1,a2,4
	beqz zero AN1_CONT3
AN1_L3:	
	la a0,walk02_l
	addi a1,a2,-4
AN1_CONT3:	
	mv a2,a3
	jal D_SETUP
	
	li a0,60
	li a7,32
	ecall
	
	beqz s8,AN1_L4
	la a0,walk02_r
	beqz zero AN1_CONT4
AN1_L4:
	la a0,walk02_l
AN1_CONT4:		
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	beqz s8,AN1_L5
	la a0,walk03_r
	addi a1,a2,4
	beqz zero AN1_CONT5
AN1_L5:	
	la a0,walk03_l
	addi a1,a2,-4
AN1_CONT5:	
	mv a2,a3
	jal D_SETUP
	
	li a0,60
	li a7,32
	ecall
	
	beqz s8,AN1_L6
	la a0,walk03_r
	beqz zero AN1_CONT6
AN1_L6:	
	la a0,walk03_l
AN1_CONT6:	
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	la t0,PLAYER_POS_A
	lb t1,0(t0)
	beqz s8,AN1_L7
	addi t1,t1,1
	sb t1,0(t0)
	la a0,walk_r
	beqz zero AN1_CONT7
AN1_L7:
	addi t1,t1,-1
	sb t1,0(t0)
	la a0,walk_l
AN1_CONT7:		
	mv a1,t1
	lb a2,1(t0)
	slli a1,a1,4			#a tela eh dividida em quadrados de 16x16
	slli a2,a2,4
	jal D_SETUP
	
	j ANIMACAO_END

ANIMACAO_2:
	la t0,PLAYER_POS_A
	lb t1,0(t0)
	beqz s8,AN2_L0
	la a0,dash_r
	beqz zero, AN2_CONT0
AN2_L0:	
	la a0,dash_l
AN2_CONT0:
	mv a1,s0
	mv a2,t1
	lb a3,1(t0)
	slli a2,a2,4			#a tela eh dividida em quadrados de 16x16
	slli a3,a3,4
	jal APAGAR
	
	beqz s8,AN2_L1
	la a0,dash01_r
	addi a1,a2,4
	beqz zero, AN2_CONT1
AN2_L1:	
	la a0,dash01_l
	addi a1,a2,-4
AN2_CONT1:
	mv a2,a3
	jal D_SETUP
	
	li a0,20
	li a7,32
	ecall
	
	beqz s8,AN2_L2
	la a0,dash01_r
	beqz zero, AN2_CONT2
AN2_L2:
	la a0,dash01_l
AN2_CONT2:	
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	beqz s8,AN2_L3
	la a0,dash02_r
	addi a1,a2,4
	beqz zero, AN2_CONT3
AN2_L3:
	la a0,dash02_l
	addi a1,a2,-4
AN2_CONT3:	
	mv a2,a3
	jal D_SETUP
	
	li a0,20
	li a7,32
	ecall
	
	beqz s8,AN2_L4
	la a0,dash02_r
	beqz zero, AN2_CONT4
AN2_L4:
	la a0,dash02_l
AN2_CONT4:	
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	beqz s8,AN2_L5	
	la a0,dash03_r
	addi a1,a2,4
	beqz zero, AN2_CONT5
AN2_L5:
	la a0,dash03_l
	addi a1,a2,-4
AN2_CONT5:	
	mv a2,a3
	jal D_SETUP

	li a0,20
	li a7,32
	ecall
	
	beqz s8,AN2_L6
	la a0,dash03_r
	beqz zero, AN2_CONT6
AN2_L6:
	la a0,dash03_l
AN2_CONT6:	
	
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	la t0,PLAYER_POS_A
	lb t1,0(t0)
	beqz s8,AN2_L7
	addi t1,t1,1
	sb t1,0(t0)
	la a0,dash_r
	beqz zero, AN2_CONT7
AN2_L7:
	addi t1,t1,-1
	sb t1,0(t0)
	la a0,dash_l
AN2_CONT7:
	mv a1,t1
	lb a2,1(t0)
	slli a1,a1,4			#a tela eh dividida em quadrados de 16x16
	slli a2,a2,4
	jal D_SETUP
	
	j ANIMACAO_END

ANIMACAO_3:
	la t0,PLAYER_POS_A
	lb t1,0(t0)
	beqz s8,AN3_L0
	la a0,jump_r
	beqz zero, AN3_CONT0
AN3_L0:	
	la a0,jump_l
AN3_CONT0:
	mv a1,s0
	mv a2,t1
	lb a3,1(t0)
	slli a2,a2,4			#a tela eh dividida em quadrados de 16x16
	slli a3,a3,4
	jal APAGAR
	
	beqz s8,AN3_L1
	la a0,jump_r
	addi a1,a2,-1280
	beqz zero, AN3_CONT1
AN3_L1:
	la a0,jump_l
	addi a1,a2,-1280
AN3_CONT1:
	mv a2,a3
	jal D_SETUP

	li a0,10
	li a7,32
	ecall
	beqz s8,AN3_L2	
	la a0,jump_r
	beqz zero, AN3_CONT2
AN3_L2:
	la a0,jump_l
AN3_CONT2:	
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	beqz s8,AN3_L3	
	la a0,jump_r
	addi a1,a2,-1280
	beqz zero, AN3_CONT3
AN3_L3:	
	la a0,jump_l
	addi a1,a2,-1280
AN3_CONT3:	
	mv a2,a3
	jal D_SETUP
	
	li a0,10
	li a7,32
	ecall
	
	beqz s8,AN3_L4
	la a0,jump_r
	beqz zero, AN3_CONT4
AN3_L4:
	la a0,jump_l
AN3_CONT4:		
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	beqz s8,AN3_L5
	la a0,jump_r
	addi a1,a2,-1280
	beqz zero, AN3_CONT5
AN3_L5:	
	la a0,jump_l
	addi a1,a2,-1280
AN3_CONT5:	
	mv a2,a3
	jal D_SETUP

	li a0,10
	li a7,32
	ecall
	
	beqz s8,AN3_L6
	la a0,jump_r
	beqz zero AN3_CONT6
AN3_L6:	
	la a0,jump_l
AN3_CONT6:	
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	la t0,PLAYER_POS_A
	lb t1,1(t0)
	
	addi t1,t1,-1
	sb t1,1(t0)
	beqz s8,AN3_L7
	la a0,jump_r
	beqz zero AN3_CONT7
AN3_L7:
	la a0,jump_l
AN3_CONT7:		
	lb a1,0(t0)
	lb a2,1(t0)
	slli a1,a1,4			#a tela eh dividida em quadrados de 16x16
	slli a2,a2,4
	jal D_SETUP
		
	j ANIMACAO_END

ANIMACAO_4:
	la t0,PLAYER_POS_A
	lb t1,0(t0)
	beqz s8,AN4_L0
	la a0,jump_r
	beqz zero, AN4_CONT0
AN4_L0:	
	la a0,jump_l
AN4_CONT0:
	mv a1,s0
	mv a2,t1
	lb a3,1(t0)
	slli a2,a2,4			#a tela eh dividida em quadrados de 16x16
	slli a3,a3,4
	jal APAGAR
	
	beqz s8,AN4_L1
	la a0,jump_r
	addi a1,a2,-1276
	beqz zero, AN4_CONT1
AN4_L1:
	la a0,jump_l
	addi a1,a2,-1284
AN4_CONT1:
	mv a2,a3
	jal D_SETUP

	li a0,150
	li a7,32
	ecall
	
	beqz s8,AN4_L2	
	la a0,jump_r
	beqz zero, AN4_CONT2
AN4_L2:
	la a0,jump_l
AN4_CONT2:	
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	beqz s8,AN4_L3	
	la a0,jump_r
	addi a1,a2,-1276
	beqz zero, AN4_CONT3
AN4_L3:	
	la a0,jump_l
	addi a1,a2,-1284
AN4_CONT3:	
	mv a2,a3
	jal D_SETUP
	
	li a0,150
	li a7,32
	ecall
	
	beqz s8,AN4_L4
	la a0,jump_r
	beqz zero, AN4_CONT4
AN4_L4:
	la a0,jump_l
AN4_CONT4:		
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	beqz s8,AN4_L5
	la a0,jump_r
	addi a1,a2,-1276
	beqz zero, AN4_CONT5
AN4_L5:	
	la a0,jump_l
	addi a1,a2,-1284
AN4_CONT5:	
	mv a2,a3
	jal D_SETUP

	li a0,150
	li a7,32
	ecall
	
	beqz s8,AN4_L6
	la a0,jump_r
	beqz zero AN4_CONT6
AN4_L6:	
	la a0,jump_l
AN4_CONT6:	
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	la t0,PLAYER_POS_A
	lb t1,1(t0)
	lb t2,0(t0)
	addi t1,t1,-1
	sb t1,1(t0)
	beqz s8,AN4_L7
	addi t2,t2,1
	la a0,jump_r
	beqz zero AN4_CONT7
AN4_L7:
	addi t2,t2,-1
	la a0,jump_l
AN4_CONT7:
	sb t2,0(t0)		
	mv a1,t2
	mv a2,t1
	slli a1,a1,4			#a tela eh dividida em quadrados de 16x16
	slli a2,a2,4
	jal D_SETUP	
	j ANIMACAO_END
ANIMACAO_5:
	la t0,PLAYER_POS_A
	lb t1,0(t0)
	beqz s8,AN5_L0
	la a0,dash_r
	beqz zero, AN5_CONT0
AN5_L0:	
	la a0,dash_l
AN5_CONT0:
	mv a1,s0
	mv a2,t1

	lb a3,1(t0)
	slli a2,a2,4			#a tela eh dividida em quadrados de 16x16
	slli a3,a3,4
	jal APAGAR
	
	beqz s8,AN5_L1
	la a0,dash01_r
	addi a1,a2,-1276
	beqz zero, AN5_CONT1
AN5_L1:
	la a0,dash01_l
	addi a1,a2,-1284
AN5_CONT1:
	mv a2,a3
	jal D_SETUP

	li a0,150
	li a7,32
	ecall
	
	beqz s8,AN5_L2	
	la a0,dash01_r
	beqz zero, AN5_CONT2
AN5_L2:
	la a0,dash01_l
AN5_CONT2:	
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	beqz s8,AN5_L3	
	la a0,dash02_r
	addi a1,a2,-1276
	beqz zero, AN5_CONT3
AN5_L3:	
	la a0,dash02_l
	addi a1,a2,-1284
AN5_CONT3:	
	mv a2,a3
	jal D_SETUP
	
	li a0,150
	li a7,32
	ecall
	
	beqz s8,AN5_L4
	la a0,dash02_r
	beqz zero, AN5_CONT4
AN5_L4:
	la a0,dash02_l
AN5_CONT4:		
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	beqz s8,AN5_L5
	la a0,dash03_r
	addi a1,a2,-1276
	beqz zero, AN5_CONT5
AN5_L5:	
	la a0,dash03_l
	addi a1,a2,-1284
AN5_CONT5:	
	mv a2,a3
	jal D_SETUP

	li a0,150
	li a7,32
	ecall
	
	beqz s8,AN5_L6
	la a0,dash03_r
	beqz zero AN5_CONT6
AN5_L6:	
	la a0,dash03_l
AN5_CONT6:	
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	la t0,PLAYER_POS_A
	lb t1,1(t0)
	lb t2,0(t0)
	addi t1,t1,-1
	sb t1,1(t0)
	beqz s8,AN5_L7
	addi t2,t2,1
	la a0,dash_r
	beqz zero AN5_CONT7
AN5_L7:
	addi t2,t2,-1
	la a0,dash_l
AN5_CONT7:
	sb t2,0(t0)		
	mv a1,t2
	mv a2,t1
	slli a1,a1,4			
	slli a2,a2,4
	jal D_SETUP
		
	j ANIMACAO_END

ANIMACAO_6:
	la t0,PLAYER_POS_A
	lb t1,0(t0)
	beqz s8,AN6_L0
	la a0,dash_r
	beqz zero, AN6_CONT0
AN6_L0:	
	la a0,dash_l
AN6_CONT0:
	mv a1,s0
	mv a2,t1
	lb a3,1(t0)
	slli a2,a2,4			#a tela eh dividida em quadrados de 16x16
	slli a3,a3,4
	jal APAGAR
	
	beqz s8,AN6_L1
	la a0,dash01_r
	addi a1,a2,1284
	beqz zero, AN6_CONT1
AN6_L1:
	la a0,dash01_l
	addi a1,a2,1276
AN6_CONT1:
	mv a2,a3
	jal D_SETUP

	li a0,150
	li a7,32
	ecall
	beqz s8,AN6_L2	
	la a0,dash01_r
	beqz zero, AN6_CONT2
AN6_L2:
	la a0,dash01_l
AN6_CONT2:	
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	beqz s8,AN6_L3	
	la a0,dash02_r
	addi a1,a2,1284
	beqz zero, AN6_CONT3
AN6_L3:	
	la a0,dash02_l
	addi a1,a2,1276
AN6_CONT3:	
	mv a2,a3
	jal D_SETUP
	
	li a0,150
	li a7,32
	ecall
	
	beqz s8,AN6_L4
	la a0,dash02_r
	beqz zero, AN6_CONT4
AN6_L4:
	la a0,jump_l
AN6_CONT4:		
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	beqz s8,AN6_L5
	la a0,dash03_r
	addi a1,a2,1284
	beqz zero, AN6_CONT5
AN6_L5:	
	la a0,dash03_l
	addi a1,a2,1276
AN6_CONT5:	
	mv a2,a3
	jal D_SETUP

	li a0,150
	li a7,32
	ecall
	
	beqz s8,AN6_L6
	la a0,dash03_r
	beqz zero AN6_CONT6
AN6_L6:	
	la a0,dash03_l
AN6_CONT6:	
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	la t0,PLAYER_POS_A
	lb t1,1(t0)
	lb t2,0(t0)
	addi t1,t1,1
	sb t1,1(t0)
	beqz s8,AN6_L7
	addi t2,t2,1
	la a0,dash_r
	beqz zero AN6_CONT7
AN6_L7:
	addi t2,t2,-1
	la a0,dash_l
AN6_CONT7:
	sb t2,0(t0)		
	mv a1,t2
	mv a2,t1
	slli a1,a1,4			#a tela eh dividida em quadrados de 16x16
	slli a2,a2,4
	jal D_SETUP
		
	j ANIMACAO_END

ANIMACAO_7:
	la t0,PLAYER_POS_A
	lb t1,0(t0)
	beqz s8,AN7_L0
	la a0,dash_r
	beqz zero, AN7_CONT0
AN7_L0:	
	la a0,dash_l
AN7_CONT0:
	mv a1,s0
	mv a2,t1
	lb a3,1(t0)
	slli a2,a2,4			#a tela eh dividida em quadrados de 16x16
	slli a3,a3,4
	jal APAGAR
	
	beqz s8,AN7_L1
	la a0,dash01_r
	addi a1,a2,-1280
	beqz zero, AN7_CONT1
AN7_L1:
	la a0,dash01_l
	addi a1,a2,-1280
AN7_CONT1:
	mv a2,a3
	jal D_SETUP

	li a0,150
	li a7,32
	ecall
	beqz s8,AN7_L2	
	la a0,dash01_r
	beqz zero, AN7_CONT2
AN7_L2:
	la a0,dash01_l
AN7_CONT2:	
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	beqz s8,AN7_L3	
	la a0,dash02_r
	addi a1,a2,-1280
	beqz zero, AN7_CONT3
AN7_L3:	
	la a0,dash02_l
	addi a1,a2,-1280
AN7_CONT3:	
	mv a2,a3
	jal D_SETUP
	
	li a0,150
	li a7,32
	ecall
	
	beqz s8,AN7_L4
	la a0,dash02_r
	beqz zero, AN7_CONT4
AN7_L4:
	la a0,dash02_l
AN7_CONT4:		
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	beqz s8,AN7_L5
	la a0,dash03_r
	addi a1,a2,-1280
	beqz zero, AN7_CONT5
AN7_L5:	
	la a0,dash03_l
	addi a1,a2,-1280
AN7_CONT5:	
	mv a2,a3
	jal D_SETUP

	li a0,150
	li a7,32
	ecall
	
	beqz s8,AN7_L6
	la a0,dash03_r
	beqz zero AN7_CONT6
AN7_L6:	
	la a0,dash03_l
AN7_CONT6:	
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	la t0,PLAYER_POS_A
	lb t1,1(t0)
	addi t1,t1,-1
	sb t1,1(t0)
	beqz s8,AN7_L7
	la a0,dash_r
	beqz zero AN7_CONT7
AN7_L7:
	la a0,dash_l
AN7_CONT7:		
	lb a1,0(t0)
	lb a2,1(t0)
	slli a1,a1,4			#a tela eh dividida em quadrados de 16x16
	slli a2,a2,4
	jal D_SETUP
		
	j ANIMACAO_END

ANIMACAO_8:
	la t0,PLAYER_POS_A
	lb t1,0(t0)
	beqz s8,AN8_L0
	la a0,dash_r
	beqz zero, AN8_CONT0
AN8_L0:	
	la a0,dash_l
AN8_CONT0:
	mv a1,s0
	mv a2,t1
	lb a3,1(t0)
	slli a2,a2,4			#a tela eh dividida em quadrados de 16x16
	slli a3,a3,4
	jal APAGAR
	
	beqz s8,AN8_L1
	la a0,dash01_r
	addi a1,a2,1280
	beqz zero, AN8_CONT1
AN8_L1:
	la a0,dash01_l
	addi a1,a2,1280
AN8_CONT1:
	mv a2,a3
	jal D_SETUP

	li a0,150
	li a7,32
	ecall
	beqz s8,AN8_L2	
	la a0,dash01_r
	beqz zero, AN8_CONT2
AN8_L2:
	la a0,dash01_l
AN8_CONT2:	
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	beqz s8,AN8_L3	
	la a0,dash02_r
	addi a1,a2,1280
	beqz zero, AN8_CONT3
AN8_L3:	
	la a0,dash02_l
	addi a1,a2,1280
AN8_CONT3:	
	mv a2,a3
	jal D_SETUP
	
	li a0,150
	li a7,32
	ecall
	
	beqz s8,AN8_L4
	la a0,dash02_r
	beqz zero, AN8_CONT4
AN8_L4:
	la a0,dash02_l
AN8_CONT4:		
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	beqz s8,AN8_L5
	la a0,dash03_r
	addi a1,a2,1280
	beqz zero, AN8_CONT5
AN8_L5:	
	la a0,dash03_l
	addi a1,a2,1280
AN8_CONT5:	
	mv a2,a3
	jal D_SETUP

	li a0,150
	li a7,32
	ecall
	
	beqz s8,AN8_L6
	la a0,dash03_r
	beqz zero AN8_CONT6
AN8_L6:	
	la a0,dash03_l
AN8_CONT6:	
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	la t0,PLAYER_POS_A
	lb t1,1(t0)
	addi t1,t1,1
	sb t1,1(t0)
	beqz s8,AN8_L7
	la a0,dash_r
	beqz zero AN8_CONT7
AN8_L7:
	la a0,dash_l
AN8_CONT7:		
	lb a1,0(t0)
	lb a2,1(t0)
	slli a1,a1,4			#a tela eh dividida em quadrados de 16x16
	slli a2,a2,4
	jal D_SETUP
		
	j ANIMACAO_END
	
ANIMACAO_9:
	la t0,PLAYER_POS_A
	lb t1,0(t0)
	beqz s8,AN9_L0
	la a0,jump_r
	beqz zero, AN9_CONT0
AN9_L0:	
	la a0,jump_l
AN9_CONT0:
	mv a1,s0
	mv a2,t1
	lb a3,1(t0)
	slli a2,a2,4			#a tela eh dividida em quadrados de 16x16
	slli a3,a3,4
	jal APAGAR
	
	beqz s8,AN9_L1
	la a0,jump_r
	addi a1,a2,1284
	beqz zero, AN9_CONT1
AN9_L1:
	la a0,jump_l
	addi a1,a2,1276
AN9_CONT1:
	mv a2,a3
	jal D_SETUP

	li a0,150
	li a7,32
	ecall
	beqz s8,AN9_L2	
	la a0,jump_r
	beqz zero, AN9_CONT2
AN9_L2:
	la a0,jump_l
AN9_CONT2:	
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	beqz s8,AN9_L3	
	la a0,jump_r
	addi a1,a2,1284
	beqz zero, AN9_CONT3
AN9_L3:	
	la a0,jump_l
	addi a1,a2,1276
AN9_CONT3:	
	mv a2,a3
	jal D_SETUP
	
	li a0,150
	li a7,32
	ecall
	
	beqz s8,AN9_L4
	la a0,jump_r
	beqz zero, AN9_CONT4
AN9_L4:
	la a0,jump_l
AN9_CONT4:		
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	beqz s8,AN9_L5
	la a0,jump_r
	addi a1,a2,1284
	beqz zero, AN9_CONT5
AN9_L5:	
	la a0,jump_l
	addi a1,a2,1276
AN9_CONT5:	
	mv a2,a3
	jal D_SETUP

	li a0,150
	li a7,32
	ecall
	
	beqz s8,AN9_L6
	la a0,jump_r
	beqz zero AN9_CONT6
AN9_L6:	
	la a0,jump_l
AN9_CONT6:	
	mv a3,a2
	mv a2,a1
	mv a1,s0
	jal APAGAR
	
	la t0,PLAYER_POS_A
	lb t1,1(t0)
	lb t2,0(t0)
	addi t1,t1,1
	sb t1,1(t0)
	beqz s8,AN9_L7
	addi t2,t2,1
	la a0,jump_r
	beqz zero AN9_CONT7
AN9_L7:
	addi t2,t2,-1
	la a0,jump_l
AN9_CONT7:
	sb t2,0(t0)		
	mv a1,t2
	mv a2,t1
	slli a1,a1,4			#a tela eh dividida em quadrados de 16x16
	slli a2,a2,4
	jal D_SETUP
		
	j ANIMACAO_END

ANIMACAO_END:
	lw ra,0(sp)
	lw s0,4(sp)
	addi sp,sp,8
	ret
