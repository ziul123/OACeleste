###############################################
#  Programa de exemplo para Syscall MIDI      #
#  Implementação assíncrona (non-blocking)    #
#  ISC Oct 2020				      #
#  Davi Jesus de Almeida Paturi		      #
###############################################

.data
LAST_DURATION:	.word 0		# duracao da ultima nota
LAST_PLAYED:	.word 0		# quando a ultima nota foi tocada
MUSIC_NUM:	.word 2516	# total de notas

.text
	jal a0,SET_PL		# reseta os valores padrões (define o valor de retorno em a0)
M_LOOP:	jal PLAY		# tocar música


	j M_LOOP		# continuar main loop

PLAY:	la t1,LAST_PLAYED	# endereço do last played
	lw t1,0(t1)		# t1 = last played
	beq t1,zero,P_CONT	# if last played == 0 THEN continue loop (primeira ocorrência)

	li a7,30		# define o syscall Time
	ecall			# time
	la t0,LAST_DURATION	# endereço da last duration
	lw t0,0(t0)		# t0 = duracao da ultima nota
	sub t1,a0,t1		# t1 = agora - quando a ultima nota foi tocada (quanto tempo passou desde a ultima nota tocada)
	bge t1,t0,P_CONT	# if t1 >= last duration THEN continue loop (se o tempo que passou for maior que a duracao da nota, toca a proxima nota)
	ret			# retorna ao main loop

P_CONT:	bne s0,s1,P_NOTE	# if s0 != s1 THEN toca a proxima nota
	jal a0,SET_PL		# reseta os valores padrões (a musica vai ficar tocando num loop) (define o valor de retorno em a0)
	ret			# volta ao main loop

P_NOTE:	lw a0,0(s2)		# le o valor da nota
	lw a1,4(s2)		# le a duracao da nota
	li a7,31		# define a chamada de syscall
	ecall			# toca a nota
	
	la t0,LAST_DURATION	# endereço da last duration
	sw a1,0(t0)		# salva a duracao da nota atual no last duration

	li a7,30		# define o syscall Time
	ecall			# time
	la t0,LAST_PLAYED	# endereço do last played
	sw a0,0(t0)		# salva o instante atual no last played

	addi s2,s2,8		# incrementa para o endereço da próxima nota
	addi s0,s0,1		# incrementa o contador de notas
	ret			# volta ao main loop

# define os valores padrões
SET_PL: li s0,0			# contador notas
	la t0,MUSIC_NUM		# endereço do total de notas
	lw s1,0(t0)		# total de notas
	la s2,MUSIC_NOTAS	# endereço das notas

	li a2,0			# instrumento
	li a3,127		# volume
	jr a0			# volta a quem chamou
