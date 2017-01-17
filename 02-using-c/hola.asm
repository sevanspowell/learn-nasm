; ------------------------------------------------------------------------------
; Writes "Hola, mundo" to the console using a C library. Runs on Linux or any
; other system that does not use underscores for symbols in its C library. To
; assemble and run:
;
; 	/usr/local/bin/nasm -f macho64 hola.asm && gcc -arch x86_64 -o hola hola.o && ./hola
; ------------------------------------------------------------------------------

  global _main
  extern _puts

  section .text
_main:                          ; This is called by the C library startup code
  sub     rsp, 8                ; Pad stack frame as required for 64-bit OSX
                                ;  - must be 16-byte aligned
  lea     rdi, [message]        ; First integer (or pointer) argument in rdi
  call    _puts                 ; puts(message)
  add     rsp, 8                ; Get our old stack pointer back (OSX only)
  ret                           ; Return from main back into C library wrapper

  section .data
message:
default rel
  db   "Hola, mundo",0          ; Note that strings must be terminated with 0
                                ;  in C
