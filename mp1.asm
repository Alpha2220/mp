;Write X86/64 ALP to count number of positive and negative numbers from the ;array

%macro print 2
        mov eax,4
        mov ebx,1
        mov ecx,%1
        mov edx,%2
        int 80h
%endmacro

section .data
        arr dd -18888888h,18888888h,22222222h,11111111h
        n equ 4
        pmsg db 10,13,"The Count of Positive No: "
        plen equ $-pmsg
        nmsg db 10,13,"The Count of Negative No: "
        nlen equ $-nmsg
        nwline db 10,13
th db 10,13,"Program developed by Prof Umakant Butkar(SVIT, Chincholi, Nashik)"
thlen equ $-th

 
section .bss
        pcnt resq 1
        ncnt resq 1
        char_answer resb 8
  
section .text
        global _start
        _start:
                mov esi,arr
                mov edi,n
                mov ebx,0
                mov ecx,0
      
        up:  
                mov eax,[esi]
                cmp eax,00000000h
                js negative
  
        positive:       inc ebx
                        jmp next
        negative:       inc ecx
  
        next:   add esi,4
                dec edi
                jnz up

                mov [pcnt],ebx
                mov [ncnt],ecx

                print pmsg,plen
                mov eax,[pcnt]
                call display

                print nmsg,nlen
                mov eax,[ncnt]
                call display
              
        print th,thlen     
    print nwline,1
      
                mov eax,1
                mov ebx,0
                int 80h
      
      
;display procedure for 32bit      
display:
        mov esi,char_answer+7
        mov ecx,8

        cnt:    mov edx,0
                mov ebx,16h
                div ebx
                cmp dl,09h
                jbe add30
                add dl,07h
        add30:  add dl,30h
                mov [esi],dl
                dec esi
                dec ecx
                jnz cnt
        print char_answer,8
ret
