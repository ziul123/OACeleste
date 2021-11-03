.data

ABERTURA_JOJO:
CUTSCENE_INICIO:
CUTSCENE_FINAL:	

CONTADOR_DE_FRAME:	.word 0
TEMPO_DA_ULTIMA:	.word 0
.text


#toca uma cutscene
#a0= cutscene a ser tocada
PLAY_CUTSCENE:
	addi sp,sp,-4
	sw ra,0(sp)

	

PLAY_CUTSCENE_END:
	lw ra,0(sp)
	addi sp,sp,4
	ret
