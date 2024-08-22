         *= $1000

;---------------------------------------
jumpback = $8000
         lda #<jumpback
         sta $0318
         lda #>jumpback
         sta $0319

;---------------------------------------
sl       = $fb
sh       = $fc
cl       = $fd
ch       = $fe
         lda #$00
         sta sl
         lda #$04
         sta sh
         lda #$00
         sta cl
         lda #$d8
         sta ch

;---------------------------------------
         lda #$15  ; uppercase
         sta $d018

;---------------------------------------
         ldx #$00
         ldy #$00
         sty srccol
         sty srcstart
         sty screenx

loop
         lda chrs,x
         sta (sl),y

         inc screenx
         lda screenx
         cmp #40
         bne skipscreenx

         lda #$00
         sta screenx
         lda srcstart
         clc
         adc #5
         sta srcstart
         lda srcstart
         cmp #25
         bne skipscreenx

         lda #$00
         sta srcstart

skipscreenx
         inc srccol
         lda srccol
         cmp #5
         bne skipsrccol
         lda #$00
         sta srccol
         ldx srcstart
         jmp wrapup

skipsrccol
         inx

wrapup
         iny
         bne loop
         ldy #$00
         inc sh
         lda sh ;TODO
         cmp #8 ;intro mach code p87 btm
                ;shows how to refine to
                ;avoid sprite pointers
         bne loop

end
         jmp end

;---------------------------------------
srccol   .byte $00
srcstart .byte $00
screenx  .byte $00

colors   .byte $06,$0e,$04,$0a,$08
         .byte $09,$05,$0d,$07,$03
         .byte $00

chrs     .byte $20,$e9,$df,$5f,$69
         .byte $df,$5f,$69,$20,$e9
         .byte $69,$20,$e9,$df,$5f
         .byte $e9,$df,$5f,$69,$20
         .byte $5f,$69,$20,$e9,$df
