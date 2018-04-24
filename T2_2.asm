main
	ldi r1,palavra
	ldi r2,frase
	
	sub sp,2
	stw r1,sp
	sub sp,2
	stw r2,sp
	ldi sr,prn_start
	bnz sp,instr

prn_start
	ldi r1,out_start
	sub sp,2
	stw r1,sp
	ldi sr,prn_palavra
	bnz sp,print
prn_palavra
	ldi r1,34
	stw r1,0xf000
	ldi r1,palavra
	sub sp,2
	stw r1,sp
	ldi sr,prn_part2
	bnz sp,print
prn_part2
	ldi r1,34
	stw r1,0xf000
	ldi r1,aparece
	sub sp,2
	stw r1,sp
	ldi sr,prn_instr_count
	bnz sp,print
prn_instr_count
	ldw r1,instr_count
	stw r1,0xf002
	sub r1,1
	bnz r1,prn_vezes
prn_vez
	ldi r1,vez
	sub sp,2
	stw r1,sp
	ldi sr,end
	bnz sp,print
prn_vezes
	ldi r1,vezes
	sub sp,2
	stw r1,sp
	ldi sr,end
	bnz sp,print

end
	hcf
	

print
	ldw r1,sp
	add sp,2
print_loop
	ldb r2,r1
	stw r2,0xf000
	add r1,1
	bnz r2,print_loop
	
	bnz sp,sr

instr
	ldw r1,sp
	add sp,2
	ldw r2,sp
	add sp,2
	sub sp,2
	stw sr,sp
	sub sp,2
	stw r2,sp
	ldi sr,substring_begin
	bnz sp,string_length
substring_begin
	ldw sr,sp
	add sp,2
	stw lr,palavra_len
substring_loop
	ldb r3,r1
	ldb r4,r2
	bez r3,sr
	sub r3,r4,r3
	bnz r3,reset_counter
count_increment
	ldw r3,substring_equal_counter
	add r3,1
	stw r3,substring_equal_counter
	ldw r4,palavra_len
	sub r3,r3,r4
	bez r3,substring_found
	add r1,1
	add r2,1
	bnz sp,substring_loop
substring_found
	ldw r4,instr_count
	add r4,1
	stw r4,instr_count
reset_counter
	ldw r3,substring_equal_counter
	xor r3,r3,r3
	stw r3,substring_equal_counter
	add r1,1
	ldi r2,palavra
	bnz sp,substring_loop
string_length
	ldw r3,sp
	add sp,2
	xor lr,lr,lr
string_length_loop
	ldb r4,r3
	bez r4,sr
	add lr,1
	add r3,1
	bnz sp,string_length_loop

palavra					"saber"
frase					"A equipe de suporte precisa saber que a normalizacao da data facilitou a resolucao de conflito do carregamento de JSON delimitado por linhas."
out_start				"A palavra "
aparece					" aparece "
vez						" vez."
vezes					" vezes."
instr_count				0
palavra_len				0
substring_equal_counter	0
