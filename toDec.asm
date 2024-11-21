section .data
	hello db "Look", 0xa
	helloLen equ $ - hello
	num dd 123456	
	result db 0
	tempRes db 0
	count dd 0

section .bss
	buffer resb 1

section .text
	global _start

_start:
	xor eax, eax
	mov [count], eax

	mov eax, 4
	mov ebx, 1
	mov ecx, hello
	mov edx, helloLen
	int 80h
	
	mov eax, 0
	push eax
convert:
	
	mov eax, [num]
	test eax, eax
	jz addS

	xor edx, edx
	mov ebx, 10
	div ebx

	add dl, '0'
	mov [tempRes], dl
	mov[num], eax	
	
	mov eax, [tempRes]
	push eax 
	
	mov eax, [count]	
	inc eax
	mov [count], eax
	xor eax, eax	
	loop convert	
addS:
	push eax
	jmp end
end:
	mov eax, [count]
	cmp eax, 0
	jl endEnd	
	pop eax	
	mov eax, [count]
	dec eax
	mov [count], eax
	
	pop eax
	mov [buffer], eax
	
	push eax	
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer
	mov edx, 1
	int 80h
	jmp end

endEnd:
	;xor eax, eax
	mov eax, 1
	xor ebx, ebx
	int 80h
