; -----------------------------------------------------------------------------
; A 64-bit Mac OSX application that returns the maximum value of it's three
; 64-bit integer arguments. The function has the signature:
;
;    int64_t maxofthree(int64_t x, int64_t y, int64_t z)
;
; Note that the parameters have already been passed in rdi, rsi and rdx. We just
; have to return the value in rax.
;
; To compile:
;     /usr/local/bin/nasm -f macho64 maxofthree.asm
; ------------------------------------------------------------------------------

  global _maxofthree            ; OSX - remember to prepend with '_'

  section .text
_maxofthree:
  mov     rax, rdi              ; result (rax) initially holds x
  cmp     rax, rsi              ; is x less than y?
  cmovl   rax, rsi              ; if so, set the result to y
  cmp     rax, rdx              ; is max(x,y) less than z?
  cmovl   rax, rdx              ; if so, set result to z
  ret                           ; the max will be in rax
