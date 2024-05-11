.section .data

input_x_prompt  :   .asciz  "Please enter x: "
input_y_prompt  :   .asciz  "Please enter y: "
input_spec  :   .asciz  "%d"
result      :   .asciz  "x*y = %d\n"

.section .text

.global main

main:

#create room on stack for x
sub sp, sp, 8
# input x prompt
ldr x0, = input_x_prompt
bl printf	
#get input x value
# spec input
ldr x0, = input_spec
mov x1, sp
bl scanf
ldrsw x19, [sp]


#get y input value
# enter y output
ldr x0, = input_y_prompt
bl printf
# spec input
ldr x0, = input_spec
mov x1, sp
bl scanf
ldrsw x20, [sp]

cbz x19, zero
cbz x20, zero

#loop for multiplication(adding)
#add x21, x19, x20
#original y value
# NEED TO MAKE SURE TO CHECK IF Y IS NEGATIVE
# AND CHANGE RESULT TO OPPOSITE SIGN IF NEGATIVE
mov x3, x20
mov x21, #0

cmp x3, #0
blt negY
#original x value
addLoop:
	add x21, x21, x19
	sub x3, x3, #1
	cbnz x3, addLoop

cmp x20, #0
blt changeS

mov x1, x21

ldr x0, =result
bl printf
b exit

negY:
	neg x3, x3
	b addLoop
changeS:
	neg x21, x21
	mov x1, x21
	ldr x0, =result
	bl printf
	b exit
zero:
	mov x1, #0
	ldr x0, =result
	bl printf
	b exit

# branch to this label on program completion
exit:
    mov x0, 0
    mov x8, 93
    svc 0
    ret


