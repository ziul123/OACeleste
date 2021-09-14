.text

#a0= int vetor[], a1= int len(vetor)
#return void
V_SHOW:
	mv t0,a0
	mv t1,a1				#tamanho do vetor
	li t2,0					#contador
	
V_SHOW_LOOP:
	lw a0,0(t0)
	li a7,1					#ecall para print int
	ecall
	la a0,esp		
	li a7,4					#ecall para print str
	ecall
	addi t2,t2,1			#t2++
	addi t0,t0,4
	bltu t2,t1,V_SHOW_LOOP	#while(t2<length(vetor))
	
	ret

#a0= int matriz[][], a1= (n_linhas, n_colunas)
#return void
M_SHOW:
	addi sp,sp,-20
	sw ra,0(sp)
	sw s0,4(sp)
	sw s1,8(sp)
	sw s2,12(sp)
	sw s3,16(sp)
	
	mv s0,a0				#s0 = matriz
	lw s1,0(a1)				#s1 = linhas
	lw s2,4(a1)				#s2 = colunas
	li s3,0					#contador
	
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
	
