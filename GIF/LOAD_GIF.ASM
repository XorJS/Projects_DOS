;-----------------------------------------------------------------------------
 TITLE LOADGIF.ASM   ; Load un Gif En 320x200
;-----------------------------------------------------------------------------
.286                            ; Active le jeu d'intruction du 286 et du
                                ; coprocesseur.
CLR=256                         ; Code d'effacement de l'alphabet
EOF=257                         ; (End Of File) Code de Fin de Fichier
;-----------------------------------------------------------------------------
; DEBUT DU SEGMENT DE DONNEES
;-----------------------------------------------------------------------------
DATA SEGMENT PUBLIC
  EXTRN GIFNAME:DATAPTR       ;Nom du File[Gif]+ db 0 
  EXTRN VSCREEN:DWORD         ;pointe sur la m‚moire de destination
  EXTRN PALETTE:DATAPTR       ;palette de destination
  EXTRN VRAM_POS:WORD         ;position … l'int‚rieur de la m‚moire d'‚cran
  EXTRN REST:WORD             ;nbre de codes restant … copier
  HANDLE     DW 0             ;handle DOS pour fichier Gif
  BUFF       DB 768 dup (0)   ;buffer des donn‚es lues      
  BUFFIND    DW 0             ;pointeur … l'int‚rieur de ce buffer
  ABSTACK    DB 1281 dup (0)  ;pile de d‚codage            
  AB_PRFX    DW 4096 dup (0)  ;alphabet, pr‚fixe 
  AB_SUFFX   DW 4096 dup (0)  ;alphabet, suffixe
  FREE       DW 0             ;position libre dans l'alphabet
  NBBIT      DW 0             ;nombre de bits dans un code
  MAX        DW 0             ;nombre maximum d'entr‚es dans un alphabet … nbbit
  STACKP     DW 0             ;pointeur dans la pile de l'alphabet
  RESTBITS   DW 0             ;nombre de bits … lire      
  RESTBYTE   DW 0             ;nombre d'octets disponibles dans le buffer
  CASSPECIAL DW 0             ;m‚moire pour le cas sp‚cial
  ACT_CODE   DW 0             ;code trait‚ 
  OLD_CODE   DW 0             ;code pr‚c‚dent     
  READBYT    DW 0             ;code en cours de lecture               
  LBYTE      DW 0             ;dernier code lu
DATA ENDS
;-----------------------------------------------------------------------------
; DEBUT DU PROGRAMME
;-----------------------------------------------------------------------------
CODE SEGMENT PUBLIC
ASSUME CS:CODE,DS:DATA
PUBLIC READGIF,SETPAL;
;-----------------------------------------------------------------------------
INIT_GRAPH PROC PASCAL FAR BEGIN,LGTH:WORD
;Transfere le pointeur [VSCREEN] dans la memoire d'ecran A000h
; [DS/SI] [ES/DI]
 PUSH DS                     ; Empile le registre [DS]
 LDS SI,DWORD PTR DS:VSCREEN ; Transfere dans [DS] le contenu de la memoire
                             ; adresses par la source.
 MOV AX,0A000h               ; Copie la memoire d'ecran dans [AX]
 MOV ES,AX                   ; Copie AX dans Es
 MOV DI,BEGIN                ; Copie Begin dans Di
 MOV CX,LGTH                 ; Prepare la boucle et lit le nombre de pixel
  @lp1:                      ;
   MOVSB                     ; Charge un byte
   ADD SI,3                  ; prochain byte source
   LOOP @lp1                 ; commence la boucle
   MOV DI,BEGIN              ; relit l'adresse de destination
   MOV CX,LGTH               ; lit la taille
   POP DS                    ; Depile le registre [DS]
   RET
ENDP
;-----------------------------------------------------------------------------
SETPAL PROC PASCAL FAR;
;Active la palette courante du gif
 PUSH SI                     ; Empile le registe [SI] sur la pile
 MOV SI,OFFSET PALETTE       ; Copie Le segment Palette dans SI
 MOV CX,768                  ; Prepare une boucle de 768 (256*3)
 XOR AL,AL                   ; Met a Zero Le Registe [AL]
 MOV DX,03C8h                ; port pour fixer initialiser la palette
                             ; pixel write address)
 OUT DX,AL                   ; ecrit la valeur de source dans le port d'adr
                             ; destination
 INC DX                      ; Incremente le registe [DX]}
 REP OUTSB                   ; REP=repetition}{effectue ecriture d'un octet
                             ; a la fois
 POP SI                      ; Depile le registe [SI] sur la pile
 RET
ENDP
;-----------------------------------------------------------------------------
GIFREAD PROC PASCAL N:WORD
; Lit (N) Octets dans le Fichier
 MOV AX,03F00h                  ; Fonction 3Fh(AH) Lit un Fichier ouvert
 MOV BX,HANDLE                  ; Charge le Handle Du Fichier
 MOV CX,N                       ; Nombre d'octets a lire
 LEA DX,BUFF                    ; Mov DX OFFSET Buff, Charge l'adresse
                                ; effective d'un mot memoire source/dest(16)
 INT 21h                        ; Declanche l'interruption 21h
 RET
GIFREAD ENDP
;-----------------------------------------------------------------------------
GIFOPEN PROC PASCAL
;Ouvre Le Fichier Gif
 MOV AH,03Dh                    ;Fonction 3dh: Ouvrir un file
 MOV AL,00h                     ;Le charge en mode Lecture uniquement
 LEA DX,GIFNAME+1               ;Pointe sur Le nom
                                ;(+1) saute le byte qui memoire la taille
 INT 21H                        ;Declanche l'interruption 21h
 MOV HANDLE,AX                  ;numero d'access pour le Fichier
 RET
GIFOPEN ENDP
;-----------------------------------------------------------------------------
GIFCLOSE PROC PASCAL
;Close Le Fichier Gif
 MOV AX,03E00h                  ;Fonction 3Eh: Ferme un file
 MOV BX,HANDLE                  ;Bx contient le numero d'access
 INT 21h                        ;Declanche l'interruption 21h
 RET
GIFCLOSE ENDP
;-----------------------------------------------------------------------------
GIFSEEK PROC PASCAL OFS:DWORD
;Positionne le pointeur du File
 Mov AH,042h                    ; Fonction 42h
 Mov AL,00h                     ; Base de l'Offset
 Mov BX,WORD PTR HANDLE         ; Handle Du Fichier
 Mov CX,WORD PTR OFS + 2        ; Charge le Mot de poids fort de l'OFFSET
 Mov DX,WORD PTR OFS            ; Charge le Mot de Poifs Faible De L'OFFSET
 Int 21h                        ; Declanche l'interruption 21h
 RET
ENDP
;-----------------------------------------------------------------------------
SHIFTPAL PROC PASCAL
; Convertie la Palette de 3 bytes au format Vga (18Bits)
; [DS/SI] [ES/DI]
 MOV AX,DS                      ; Charge le Segment de Donnee pour
 MOV ES,AX                      ; la Source et destination
 MOV SI,OFFSET BUFF             ; Ecriture Dans La Palette De Destination
 LEA DI,PALETTE                 ; Mov Di OFFSET Palette, Charge l'adresse
                                ; effective d'un mot memoire source/dest(16)
 MOV CX,768d                    ; Prepare un loop et traite (3*256c)
@L1:
 LODSB                          ; un Octet Loader dans la memoire d'adresse
                                ; [DS:SI] est charge en [AL], SI est (INC,1)
 SHR AL,2                       ; (convertit) Shift vers la droite de 2 bits
 STOSB                          ; Un Octet Loader de [AL] est charge dans la
                                ; memoire d'adresse [ES:DI], DI est (INC,1)
 LOOP @L1                       ; Fait Le Loop 768 fois
 RET
ENDP
;-----------------------------------------------------------------------------
FILLBUFF PROC PASCAL
; Lit tout un bloc du Fichier en Buff
 CALL GIFREAD PASCAL,1          ; Lit un Octet
 MOV AL,BYTE PTR BUFF[0]        ; Met Le Byte dans AL
 XOR AH,AH                      ; Met a Zero [AX]
 MOV WORD PTR RESTBYTE,AX       ; Le Memorise dans RestByte
 CALL GIFREAD PASCAL,AX        ; Lit les octets
 RET
ENDP
;-----------------------------------------------------------------------------
GetPhysByte proc pascal
; Lit un octet dans le buffer
 PUSH BX                        ; Save Sur la Pile Le registre BX
 CMP WORD PTR Restbyte,0        ; Compare Dans la memoire restbyte et 0
                                ; plus de donnees dans le buffer
 JA @YADURAB                    ; Banchement Non-Signee et Superieur
 PUSHA                          ; Empile le contenus de tous les registres
                                ; de 16bits(AX,CX,DX,BX,SP,BP,SI,DI)
 CALL FILLBUFF                  ; Lit tout un bloc du Fichier en buff
 POPA
 MOV WORD PTR BUFFIND,0         ; Charge le pointeur du buffer
@YADURAB:
 MOV BX, WORD PTR BUFFIND
 MOV AL,BYTE PTR BUFF[BX]       ; lit un octet
 INC WORD PTR BUFFIND           ; Deplace le Pointeur
 POP BX                         ; Depile
 RET                            ;
ENDP
;-----------------------------------------------------------------------------
GETLOGBYTE PROC PASCAL
; Lit un code dans le buffer en utilisant [Load_Byte_Buff]
 PUSH SI                        ; Empile [SI]
 MOV AX,WORD PTR NBBIT          ; Lit la taille en Bits
 MOV SI,AX                      ;
 MOV DX, WORD PTR RESTBITS      ;
 MOV CX,8                       ; Calcule
 SUB CX,DX                      ;         la Difference
 MOV AX,WORD PTR LBYTE          ; Dernier Byte dans AX
 SHR AX,CL                      ; Lance le Decalage
 MOV WORD PTR ACT_CODE,AX       ; Sauve le Code
 SUB SI,DX                      ; Soustraire Restbyte
@NEXTBYTE:
 CALL GETPHYSBYTE               ; Lit un nouvel octet
 XOR AH,AH                      ; Met a zero [AH]
 MOV WORD PTR LBYTE,AX          ; Le Met pour le prochain code
 DEC WORD PTR RESTBYTE          ; Octet traite

 MOV BX,1                       ; Masque les bits restants dans l'octet
 MOV CX,SI                      ; Fixe le nombre de Bits
 SHL BX,CL                      ; Shift vers la gauche en decalant de 1
 DEC BX                         ; et Decremente de 1
 AND AX,BX                      ; Masque le Code
 MOV CX,DX                      ; Effectue le Decalage Recherche
 SHL AX,CL                      ; Restbyte vers la gauche
 ADD WORD PTR ACT_CODE,AX       ; Ajoute le Resultat

 SBB DX,Word Ptr Nbbit          ; Diminue le nombre Restbits
 ADD DX,8                       ; Additionne de 8
 JNS @Positif                   ; brachement si Positif
 ADD DX,8
@Positif:
 SUB SI,8                       ; 8 bits cherchees
 JLE @FINI                      ; Branchement Signee si inferieur ou egal
                                ; <= 0
 ADD DX,WORD PTR NBBIT          ; augmente pour les bits manquants
 SUB DX,8                       ; soustrait de 8 a dx et le met dans dx
 JMP @NEXTBYTE                  ; effectue un branchement
@FINI:
 MOV WORD PTR RESTBITS,DX       ; Sauve le nombre de bits
 MOV AX,WORD PTR ACT_CODE       ; Le Charge en [AX]
 POP SI                         ; Depile [Si]
 RET
ENDP
;-----------------------------------------------------------------------------
READGIF PROC PASCAL
;Load Le Gif, Le Stock . . .
  PUSH DS                       ; Sauvegarde (emplile) le registe [DS]
  CALL GIFOPEN                  ; Ouvre le gif
  CALL GIFSEEK PASCAL, 0,13d    ; Saute les 13 premiers octet qui me serve pas
                                ; En mode 320x200
  PUSH 768d                     ; Empile 768 octets pour les palettes
  CALL GIFREAD                  ; Appelle gifread
  CALL SHIFTPAL                 ; Call le shiftpal pour la palette
  CALL GIFREAD PASCAL,1         ; Saute un octet
@EXTLOOP:                       ; Laisse tomber les blocs d'extension
  CMP WORD PTR BUFF[0],21h      ; compare pour savoir si il y a
                                ; encore un bloc d'extension ? ?
  JNE @NOEXT                    ; Branchement si pas d'extention
  CALL GIFREAD PASCAL,2         ; Lit les deux octets pour l'extention
  MOV AL,BYTE PTR BUFF[1]       ; Donnent la longueur du bloc...
  INC AL                        ; Incremente [AL] de 1 
  XOR AH,AH                     ; Met a zero le registre [AH]
  CALL GIFREAD PASCAL,AX        ; on passe par dessus
  JMP @EXTLOOP                  ; branchement pour l'extention
@NOEXT:
  CALL GIFREAD PASCAL, 10d      ; Lit 10 octets
  TEST BYTE PTR BUFF[8],128     ; Une palette locale  ?
  JE @NOLOC                     ; Branchement si negatifs 
  PUSH 768d                     ; Lit la palette 
  CALL GIFREAD                  ; Appelle Gifread
  CALL SHIFTPAL                 ; Convertit la pal
@NOLOC:
  LES DI,DWORD PTR VSCREEN      ; Charge l'adresse de destination
  MOV WORD PTR LBYTE,0          ; met zero dans lbyte pour le dernier code lu
  MOV WORD PTR FREE,258         ; 258
  MOV WORD PTR NBBIT,9          ; Nombre de bits d'un code = 9 
  MOV WORD PTR MAX,511          ; Maximum d'entr‚es = 511
  MOV WORD PTR STACKP,0         ; Pointeur sur d‚but
  MOV WORD PTR RESTBITS,0       ; Pas de bits restants
  MOV WORD PTR RESTBYTE,0       ; Rien a chercher
@MAINLOOP:                      ; boucle pour chaque code
  CALL GETLOGBYTE               ; lit un code
  CMP AX,EOF                    ; Signature pour la fin d'un gif
  JNE @NO_ABANDON               ; Branchement si different
  JMP @ABANDON                  ; Branchement 
@NO_ABANDON:
  CMP AX,CLR                    ; code clr  ?
  JNE @NO_CLEAR                 ; Branchement si different
  JMP @CLEAR                    ; Branchement vers Clear l'alphabet
@NO_CLEAR:
  MOV WORD PTR READBYT,AX       ; Save le code actuel
  CMP AX,WORD PTR FREE          ; Compare si deja dans l'alphabet
  JB @CODE_IN_AB                ; Brachement si inferieur et
                                ; passe au traitement
  MOV AX,WORD PTR OLD_CODE      ; Un cas special, dont il faut le transmettre 
  MOV WORD PTR ACT_CODE,AX      ; Au traitement la derniŠre chaŒne
  MOV BX,WORD PTR STACKP        ; Au traitement de l'alphabet
  MOV CX,WORD PTR CASSPECIAL    ; Accrocher le premier caractŠre
  MOV WORD PTR ABSTACK[BX],CX   ; Genere la pile
  INC WORD PTR STACKP           ; Incremente 
@CODE_IN_AB:                    ; Code disponible dans l'alphabet :
  CMP AX,CLR                    ; Compare le code clr ?
  JB @CONCRET                   ; Branchement si inferieur,caractŠre concret
@FILLSTACK_LOOP:                ; Decodage
  MOV BX,WORD PTR ACT_CODE      ; Le code est un pointeur dans l'alphabet
  SHL BX,1                      ; Word Array 
  PUSH BX                       ; Empile le Registre [BX]
  MOV AX,WORD PTR AB_SUFFX[BX]  ; Cherche le suffixe, qui est concret
  MOV BX,WORD PTR STACKP        ; Le place sur la pile
  SHL BX,1                      ; Consid‚r‚ comme Word Array
  MOV WORD PTR ABSTACK[BX],AX   ; Transmet pour le decodage
  INC WORD PTR STACKP           ; incremente Stackp
  POP BX                        ; Depile Bx
  MOV AX,WORD PTR AB_PRFX[BX]   ; Cherche le pr‚fixe
  MOV WORD PTR ACT_CODE,AX      ; Le prend comme code courant
  CMP AX,CLR                    ; compare pour le code clr 
  JA @FILLSTACK_LOOP            ; Brachement si superieur vers le d‚codage
@CONCRET:                       ; 
  MOV BX,WORD PTR STACKP        ; Empile le dernier code
  SHL BX,1                      ; Comme Un Word Array
  MOV WORD PTR ABSTACK[BX],AX   ; Trasmet pour le decodage
  MOV WORD PTR CASSPECIAL,AX    ; Utiliser pour les cas sp‚cial 
  INC WORD PTR STACKP           ; Incremente le pointeur
  MOV BX,WORD PTR STACKP        ; Prepare la lecture de la pile
  DEC BX                        ; Decremente le pointeur
  SHL BX,1                      ; Sur Word Array 
@READSTACK_LOOP:                ; Traite la pile
  MOV AX,WORD PTR ABSTACK[BX]   ; Prend un caractŠre
  STOSB                         ; Un Octet Loader de [AL] est charge dans la
                                ; memoire d'adresse [ES:DI], DI est (INC,1)
  CMP DI,0                      ; Compare le registre [DI] avec 0
  JNE @NOOVL1                   ; Branchement si Different
  CALL INIT_GRAPH PASCAL,VRAM_POS,16384d 
  ADD VRAM_POS,16384d           ; Exploite la m‚moire d'‚cran
  LES DI,DWORD PTR VSCREEN      ; Nouvelle position en m‚moire VGA
@NOOVL1:
  DEC BX                        ; Decremente [BX]
  DEC BX                        ; Decremente [BX]
  JNS @READSTACK_LOOP           ; fini ? non on poursuit
  MOV WORD PTR STACKP,0         ; r‚initialise le pointeur de pile
  MOV BX,WORD PTR FREE          ; met … jour l'alphabet
  SHL BX,1                      ; a la position "free" 
  MOV AX,WORD PTR OLD_CODE      ; Ecrit le dernier code dans pr‚fixe
  MOV WORD PTR AB_PRFX[BX],AX   ; Le Transfer pour l'alphabet
  MOV AX,WORD PTR ACT_CODE      ; Et le code courant dans suffixe
  MOV WORD PTR AB_SUFFX[BX],AX  ; Le transfer pour l'alphabet
  MOV AX,WORD PTR READBYT       ; Le code lu est le plus r‚cent
  MOV WORD PTR OLD_CODE,AX      ; Le met dans le vieux
  INC WORD PTR FREE             ; incremente la derniŠre position libre  
  MOV AX,WORD PTR FREE          ; met a jour l'alphabet
  CMP AX,WORD PTR MAX           ; compare pour la saturation
  JA @NO_MAINLOOP               ; Brachement si different
  JMP @MAINLOOP                 ; Branchement
@NO_MAINLOOP:
  CMP BYTE PTR NBBIT,12d        ; nombre de bits d‚j… ‚gal … 12 ?
  JB @NO_MAINLOOP2              ; Brachement si inferieur
  JMP @MAINLOOP                 ; Brachement pour le recommencement
  @NO_MAINLOOP2:                
  INC WORD PTR NBBIT            ; Incremente
  MOV CL,BYTE PTR NBBIT         ; Nouveau maximum d'entr‚es
  MOV AX,1                      ; 1 d‚cal‚ de nbbit vers la gauche
  SHL AX,CL                     ; Shiftage entre cl et ax
  DEC AX                        ; Decremente
  MOV WORD PTR MAX,AX           ; Enregistre le maximum 
  JMP @MAINLOOP                 ; Revient … la boucle principale
@CLEAR:                         ; r‚initialise l'alphabet:
  MOV WORD PTR NBBIT,9d         ; Nbbit reprend la valeur de d‚part
  MOV WORD PTR MAX,511d         ; Le maximum d'entr‚es est 511
  MOV WORD PTR free,258d        ; PremiŠre place libre = 258
  CALL GETLOGBYTE               ; Lit le code suivant
  MOV WORD PTR CASSPECIAL,AX    ; Le note pour le cas sp‚cial
  MOV WORD PTR OLD_CODE,AX      ; Le transfer dans le vieux
  STOSB                         ; Un Octet Loader de [AL] est charge dans la
                                ; memoire d'adresse [ES:DI], DI est (INC,1)
  CMP DI,0                      ; Compare entre di et 0
  JNE @NOOVL2                   ; brachement si different
  CALL INIT_GRAPH PASCAL,VRAM_POS,16384d
  ADD VRAM_POS,16384d           ; stockage dans la m‚moire d'‚cran
  LES DI,DWORD PTR VSCREEN      ; avance le pointeur en m‚moire VGA
@NOOVL2:
  JMP @MAINLOOP                 ; retour … la boucle principale
@ABANDON:                       ; Abandon par le code Eof
  CALL GIFCLOSE                 ; Ferme le Gif
  MOV REST,DI                   ; Memorise le nombre de codes restant
                                ; … copier
  POP DS                        ; depile en cloturant
  RET
ENDP                            ; The enD
;-----------------------------------------------------------------------------
CODE ENDS
END
;-----------------------------------------------------------------------------


{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
{ Turbo Pascal 7.0 
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
UNIT Load_Gif;
{Load un Gif de 320x200x256}
{----------------------------------------------------------------------------}
INTERFACE
{----------------------------------------------------------------------------}
VAR
  VSCREEN:POINTER;                   {Pointer d'un virtual screen}
  PALETTE:ARRAY[0..256*3-1] OF Byte; {Creation d'une palette}
  VRAM_POS,                          {Position courante dans la RAM VGA}
  REST:WORD;                         {Autres octets en m‚moire centrale
                                      et # d'erreur }
  GIFNAME:STRING;
{----------------------------------------------------------------------------}
PROCEDURE LOADGIF(GName:String);
{Load le Gif dans Vscreen, un pointer 64 000}
PROCEDURE SETPAL;
{Load la palette courante}
{----------------------------------------------------------------------------}
 IMPLEMENTATION

PROCEDURE SETPAL;EXTERNAL;

PROCEDURE READGIF;EXTERNAL;
{$L LOAD_GIF.OBJ}

PROCEDURE LOADGIF(GName:String);
  Begin
  GIFNAME:=GNAME+#0;                  {Fait une chaine Texte }
  VRAM_POS:=0;                        {OffSet 0 de $A000 }
  READGIF;                            {charge l'image }
  SETPAL;                             {Load la palette courante}
  MOVE(VSCREEN^,PTR($a000,0)^,64000); {Affiche le Gif}
  End;
{----------------------------------------------------------------------------}
Begin
 GetMem(VScreen,64000); {Donne 64000 octets dans le pointeur VSCREEN}
End.
{----------------------------------------------------------------------------}
{                            -= The enD !!! =-                               }
{----------------------------------------------------------------------------}



