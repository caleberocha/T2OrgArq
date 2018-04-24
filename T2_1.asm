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
	bez r3,print_numbers
	slt r3,r2,r1
	bnz r3,print_numbers
	bnz sp,read_number

print
	ldw r1,sp
	add sp,2
print_loop
	ldb r2,r1
	stw r2,0xf000
	add r1,1
	bnz r2,print_loop
	
	bnz sp,sr


print_numbers
	ldw r1,sp
	add sp,2
	stw r1,0xf002
	ldi r1,32
	stw r1,0xf000

	ldw r1,order
	sub r1,1
	stw r1,order
	bnz r1,print_numbers
	
	hcf

p_amount		"Quantos numeros? "
p_number		"Digite o numero "
p_number_end	": "
amount			0
order			0
