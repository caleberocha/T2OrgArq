main
	ldi r1,p_amount
	sub sp,2
	stw r1,sp
	ldi sr,read_amount
	bnz sp,print

read_amount
	ldw r1,0xf006
	stw r1,amount
	ldi r1,10
	stw r1,0xf000

read_number
	ldi r1,p_number
	sub sp,2
	stw r1,sp
	ldi sr,read_number_order
	bnz sp,print
read_number_order
	ldw r1,order
	add r1,1
	stw r1,order
	stw r1,0xf002
read_number_end
	ldi r1,p_number_end
	sub sp,2
	stw r1,sp
	ldi sr,read_number_prompt
	bnz sp,print
read_number_prompt
	ldw r1,0xf006
	sub sp,2
	stw r1,sp
	ldi r1,10
	stw r1,0xf000
	ldw r1,order
	ldw r2,amount
	sub r3,r1,r2
	bez r3,count_numbers
	slt r3,r2,r1
	bnz r3,count_numbers
	bnz sp,read_number

count_numbers
	ldw r5,order
	bez r5,print_numbers
	sub r5,1
	stw r5,order

	ldw r1,sp
	add sp,2

	xor r6,r6,r6
	ldi r3,numbers_grouped
count_numbers_loop
	ldw r2,numbers_grouped_count
	sub r4,r6,r2
	bez r4,add_number

	ldw r2,r3
	sub r2,r1,r2
	bnz r2,count_numbers_next
	bnz sp,count_numbers_increment
add_number
	stw r1,r3
	ldw r2,numbers_grouped_count
	add r2,1
	stw r2,numbers_grouped_count
count_numbers_increment
	add r3,2
	ldw r2,r3
	add r2,1
	stw r2,r3
	bnz sp,count_numbers
count_numbers_next
	add r3,4
	add r6,1
	ldw r2,numbers_grouped_count
	sub r2,r6,r2
	bez r2,add_number
	bnz sp,count_numbers_loop

print_numbers
	ldi r1,header
	sub sp,2
	stw r1,sp
	ldi sr,print_numbers_begin
	bnz sp,print
print_numbers_begin
	ldi r1,10
	stw r1,0xf000
	ldi r1,numbers_grouped
	ldw r2,numbers_grouped_count
	xor r6,r6,r6
print_numbers_loop
	ldw r3,r1
	stw r3,0xf002
	ldi r3,9
	stw r3,0xf000
	add r1,2
	ldw r3,r1
	stw r3,0xf002
	ldi r3,10
	stw r3,0xf000
	add r1,2

	add r6,1
	sub r4,r6,r2
	bez r4,end
	
	bnz sp,print_numbers_loop
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

p_amount				"Quantos numeros? "
p_number				"Digite o numero "
p_number_end			": "
amount					0
order					0
numbers_grouped			0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
numbers_grouped_count	0
header					"Numero	Quantidade"
