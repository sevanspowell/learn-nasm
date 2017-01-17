; -----------------------------------------------------------------------------
; A 64-bit Mac OSX application that writes the first 90 Fibonacci numbers. To
; assemble and run:
;
;     /usr/local/bin/nasm -f macho64 fib.asm && gcc -arch x86_64 -o fib fib.o && ./fib
; -----------------------------------------------------------------------------

  global _main
  extern _printf

  section .text
_main:
  push    rbx                   ; we have to save this since we use it
                                ;  (we are required to preserve rbx)

  mov     ecx, 90               ; ecx will countdown to 0
  xor     rax, rax              ; rax will hold the current number (clear to 0)
  xor     rbx, rbx              ; rbx will hold the next number (clear to 0)
  inc     rbx                   ; rbx is originally 1

print:
  ; We need to call printf, but we are using rax, rbx and rcx. printf may
  ; destroy rax and rcx, so we will save these before the call and restore them
  ; afterwards.

  push    rax                   ; caller - save register
  push    rcx                   ; caller - save register

  lea     rdi, [format]         ; set 1st parameter (format)
  mov     rsi, rax              ; set 2nd parameter (current_number)
  xor     rax, rax              ; zero rax before call to printf
                                ;  note that rax is used to indicate the number
                                ;  of vector registers used with variable arg
                                ;  functions (such as printf)

  ; Stack is already aligned because we pushed three 8-byte registers and the
  ; call instruction will push the return address (which on a 64-bit machine,
  ; is 8 bytes). This gives us 32 bytes total, meaning the stack pointer is
  ; already 16-byte aligned.
  call    _printf               ; printf(format, current_number)

  pop     rcx                   ; restore caller-saved register
  pop     rax                   ; restore caller-saved register

  mov     rdx, rax              ; save the current number
  mov     rax, rbx              ; next number is now current
  add     rbx, rdx              ; get the new next number (fibonacci seq.)
  dec     ecx                   ; count down
  jnz     print                 ; continue until counter reaches 0

  pop     rbx                   ; restore rbx before returning
  ret

format:
default rel
  db    "%20ld", 10, 0
