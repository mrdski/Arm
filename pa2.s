.section .data

input_prompt  :   .asciz  "Please enter a string: \n"
input_format:    .asciz "%[^\n]"
output_format:   .asciz "%c"
new_line_format: .ascii "\n"

.section .text

.global main

main:

ldr x0,=input_prompt
bl printf

sub sp, sp, #16

ldr x30,[sp,#8]
	
ldr x0,=input_format
mov x1, sp
bl scanf

#base address
mov x4, sp

#index
mov x3, #0

bl revstr

ldr x0, =new_line_format
bl printf

#get off stack
ldr x30,[sp,#8]
add sp,sp,#16

b exit


revstr:
	#load character and check if not null
	ldrb w7,[x4,x3]
	cbnz w7, printChar
	str x30,[sp,#0]

basecase:
	ldr x0, =new_line_format
	bl printf
	ldr x30,[sp,#0]
	br x30

	
printChar:

	sub sp, sp, #24
	stur x3,[sp,#16]
	stur x4,[sp,#8]
	stur x30,[sp,#0]

	ldr x0, =output_format
	mov w1,w7
	bl printf

	#restore index and base address
	ldr x4,[sp,#8]
	ldr x3,[sp,#16]
	
	add x3, x3, #1

	bl revstr
	
	ldr x4,[sp,#8]
	ldr x3,[sp,#16]

	ldrb w7,[x4,x3]
	ldr x0, =output_format
	mov w1,w7
	bl printf

	ldr x30,[sp,#0]
	add sp, sp, #24
	br x30


# branch to this label on program completion
exit:
    mov x0, 0
    mov x8, 93
    svc 0
    ret

