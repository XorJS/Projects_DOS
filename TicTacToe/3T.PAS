PROGRAM TICTACTOE_GAME_320x200x256;
USES LOAD_GIF,KEYBOARD;
VAR VSCR:POINTER;               {pointeur pour les fonts}
    XCASE:ARRAY[1..9] OF BYTE;  {table pour ([X],[O],[Nil])}
    CLEAR:BYTE;                 {Vide a zero les 9 cases}
    KEYB:BYTE;                  {Code de touche pour le Keyboard}

TYPE XOT = RECORD               {objets pour les 9 cases}
 X1, {Coordonne a l'Abscive}
 Y1, {Coordonne a l'ordonne}
 DOM,{Largeur a l'Abscive}
 IMA {Largeur a l'ordonne}
 :WORD;
 TABLE : ARRAY [1..1920] OF WORD;
  {TABLE[COMPTX+(DOM*COMPTY)]:= (320*(COMPTY+Y1))+(COMPTX+X1)}
  {Cree un table pour que la souris puisse selectionner la case chosie}
END;

PROCEDURE BUILD_CASE (X1,Y1,DOM,IMA:WORD;VAR TABLE:ARRAY OF WORD);
{Fabrique une table quelconque}
VAR COMPTX,COMPTY:WORD;
BEGIN
 FOR COMPTY:= 0 to IMA-1 do {compter de hauteur}
 FOR COMPTX:= 0 to DOM-1 do {compter de largeur}
 TABLE[COMPTX+(DOM*COMPTY)]:= (320*(COMPTY+Y1))+(COMPTX+X1);
END;

VAR CASE1,CASE2,CASE3,CASE4,CASE5,CASE6,CASE7,CASE8,CASE9:XOT; {Les 9 cases}

PROCEDURE MAKE_9CASE;
BEGIN
{Construit 9 tables de coordonne pour la Souris}
 CASE1.X1:= 86 ; CASE1.Y1:= 51 ; CASE1.DOM:= 46 ; CASE1.IMA:= 38;
 CASE2.X1:= 134; CASE2.Y1:= 51 ; CASE2.DOM:= 46 ; CASE2.IMA:= 38;
 CASE3.X1:= 182; CASE3.Y1:= 51 ; CASE3.DOM:= 46 ; CASE3.IMA:= 38;
 CASE4.X1:= 86 ; CASE4.Y1:= 91 ; CASE4.DOM:= 46 ; CASE4.IMA:= 38;
 CASE5.X1:= 134; CASE5.Y1:= 91 ; CASE5.DOM:= 46 ; CASE5.IMA:= 38;
 CASE6.X1:= 182; CASE6.Y1:= 91 ; CASE6.DOM:= 46 ; CASE6.IMA:= 38;
 CASE7.X1:= 86 ; CASE7.Y1:= 131; CASE7.DOM:= 46 ; CASE7.IMA:= 38;
 CASE8.X1:= 134; CASE8.Y1:= 131; CASE8.DOM:= 46 ; CASE8.IMA:= 38;
 CASE9.X1:= 182; CASE9.Y1:= 131; CASE9.DOM:= 46 ; CASE9.IMA:= 38;
 BUILD_CASE (CASE1.X1,CASE1.Y1,CASE1.DOM,CASE1.IMA,CASE1.TABLE);
 BUILD_CASE (CASE2.X1,CASE2.Y1,CASE2.DOM,CASE2.IMA,CASE2.TABLE);
 BUILD_CASE (CASE3.X1,CASE3.Y1,CASE3.DOM,CASE3.IMA,CASE3.TABLE);
 BUILD_CASE (CASE4.X1,CASE4.Y1,CASE4.DOM,CASE4.IMA,CASE4.TABLE);
 BUILD_CASE (CASE5.X1,CASE5.Y1,CASE5.DOM,CASE5.IMA,CASE5.TABLE);
 BUILD_CASE (CASE6.X1,CASE6.Y1,CASE6.DOM,CASE6.IMA,CASE6.TABLE);
 BUILD_CASE (CASE7.X1,CASE7.Y1,CASE7.DOM,CASE7.IMA,CASE7.TABLE);
 BUILD_CASE (CASE8.X1,CASE8.Y1,CASE8.DOM,CASE8.IMA,CASE8.TABLE);
 BUILD_CASE (CASE9.X1,CASE9.Y1,CASE9.DOM,CASE9.IMA,CASE9.TABLE);
END;

PROCEDURE WAIT_RETRACE;
{----------------------------------------------------------------------------}
{ Fait Un Retour de Balayage Verticale                                       }
{----------------------------------------------------------------------------}
ASSEMBLER;
ASM
  MOV DX,03DAh               { Input Status Register 1 }
@WAIT1:
  IN AL,DX                   { Bit 3 = 0 si le rayon est en train de }
                             { dessiner l'image de l'ecran }
  TEST AL,8                  { Test avec 8h }
  JNZ @WAIT1                 { Branchement si different }
@WAIT2:
  IN AL,DX                   { Bit 3 = 1 si le rayon est en retour de }
                             { balayage }
  TEST AL,08h                { Test avec 8h }
  JZ @WAIT2                  { Branchement si different }
END;

{----------------------------------------------------------------------------}
{ Coordonner des Sprites [X] & [O] & Chiffres                                }
{----------------------------------------------------------------------------}
CONST  XX    = 20 ;     {Abscive de [X]}
       OX    = XX+236 ; {Abscive de [O]}
       XOY   = 79 ;     {Ordonne de [O] & [X]}
       XODOM = 46 ;     {Largeur de [O] & [X]}
       XOIMA = 39 ;     {Hauteur de [O] & [X]}
  FONTS:Array[0..11, 0..3] of Word=
  ((40,00,22,19), {X}  {x1,y1,dom,ima}
   (64,00,22,19), {O}
   (00,00,06,08), {0}
   (08,00,06,08), {1}
   (16,00,06,08), {2}
   (24,00,06,08), {3}
   (32,00,06,08), {4}
   (00,10,06,08), {5}
   (08,10,06,08), {6}
   (16,10,06,08), {7}
   (24,10,06,08), {8}
   (32,10,06,08)) {9};
 XYFONTS:Array[0..8, 0..1] of Word=
  ((147,177), {Case [Total] 1}
   (155,177), {Case [Total] 2}
   (163,177), {Case [Total] 3}
   (032,131), {Case [X] 1}
   (040,131), {Case [X] 2}
   (048,131), {Case [X] 3}
   (268,131), {Case [O] 1}
   (276,131), {Case [O] 2}
   (284,131)) {Case [O] 3};


PROCEDURE PUT_SPRITE(X1,Y1,DOM,IMA,X2,Y2,SOURCE:WORD);
{----------------------------------------------------------------------------}
{ Met Un Sprite Dans La Memoire Video ($A000).                               }
{----------------------------------------------------------------------------}
{ X1 : Abscive ou l'on prend le Sprite
  Y1 : Ordonne ou l'on prend le Sprite
  DOM: Largeur Du Sprite
  IMA: Hauteur Du Sprite
  X2 : Abscive ou l'on place le Sprite
  Y2 : Ordonne ou l'on place le Sprite
  SOURCE: Pointeur d'image ou le Sprite provient}
ASSEMBLER;
 ASM
  CLD             {Met a zero l'indicateur [DF] pour l'ordre croissant}
  PUSH  DS
  PUSH 0A000H     {Transfer dans la memoire video}
  POP ES
  MOV   DS, SOURCE  {Transfer le pointeur dans le registe [DS]}
  MOV   BX, x1
  MOV   AX, y1
  XCHG  AH, AL
  ADD   BX, AX
  SHR   AX, 1
  SHR   AX, 1
  ADD   BX, AX
  MOV   SI, BX
  MOV   BX, x2
  MOV   AX, y2
  XCHG  AH, AL
  ADD   BX, AX
  SHR   AX, 1
  SHR   AX, 1
  ADD   BX, AX
  MOV   DI, BX
  MOV   DX, IMA
  XOR   DH, DH
  MOV   AX, DOM
  MOV   BX, 320
  SUB   BX, AX
  SHR   AX, 1
  @boucle:
    INC   DH
    MOV   CX, AX
    REP   MOVSW
    ADD   SI, BX
    ADD   DI, BX
    CMP   DH, DL
    JNE   @boucle
    POP   DS
END;

PROCEDURE PUT_SPRITE2(X1,Y1,DOM,IMA,X2,Y2,SOURCE,DESTINATION:WORD);
{----------------------------------------------------------------------------}
{ Met Un Sprite Dans un pointeur                                             }
{----------------------------------------------------------------------------}
{ X1 : Abscive ou l'on prend le Sprite
  Y1 : Ordonne ou l'on prend le Sprite
  DOM: Largeur Du Sprite
  IMA: Hauteur Du Sprite
  X2 : Abscive ou l'on place le Sprite
  Y2 : Ordonne ou l'on place le Sprite
  SOURCE: Pointeur d'image ou le Sprite provient}
ASSEMBLER;
 ASM
  CLD             {Met a zero l'indicateur [DF] pour l'ordre croissant}
  PUSH  DS
  MOV   ES, DESTINATION
  MOV   DS, SOURCE  {Transfer le pointeur dans le registe [DS]}
  MOV   BX, x1
  MOV   AX, y1
  XCHG  AH, AL
  ADD   BX, AX
  SHR   AX, 1
  SHR   AX, 1
  ADD   BX, AX
  MOV   SI, BX
  MOV   BX, x2
  MOV   AX, y2
  XCHG  AH, AL
  ADD   BX, AX
  SHR   AX, 1
  SHR   AX, 1
  ADD   BX, AX
  MOV   DI, BX
  MOV   DX, IMA
  XOR   DH, DH
  MOV   AX, DOM
  MOV   BX, 320
  SUB   BX, AX
  SHR   AX, 1
  @boucle:
    INC   DH
    MOV   CX, AX
    REP   MOVSW
    ADD   SI, BX
    ADD   DI, BX
    CMP   DH, DL
    JNE   @boucle
    POP   DS
END;

PROCEDURE INIT_MODE13;
{ Init le mode video a 13H}
ASSEMBLER;
ASM
 MOV AX,13h
 INT 10h
END;

PROCEDURE NORMAL_FADE;
{----------------------------------------------------------------------------}
{ Fait un Fade vers le noir.                                                 }
{----------------------------------------------------------------------------}
VAR COMPT1,COMPT2:WORD;
BEGIN
FOR COMPT2:= 1 TO 64 DO BEGIN
FOR COMPT1:=0 TO 767 DO
 IF PALETTE[COMPT1] <> 0 THEN PALETTE[COMPT1]:=(PALETTE[COMPT1]-1);
 WAIT_RETRACE; {Fait un retour de balayage}
 SETPAL; {Init la nouvelle palette}
END;
END;

PROCEDURE Write_end;
VAR A,B,C,D,E,F,G,H:STRING;
    COMPT,RSTRING:BYTE;
BEGIN
A:=
'$$$$$$$ß!$$"ß#$$$$$#ßßßßßßß$$$$$$$ß#$$$$$#ß#$$$$$#ßßßßßßß$$$$$$$ß#$$$$$#ß#$$$$$$';
B:=
'ßß$$$ßßßß$$ßß$$ßßßßßß#####ßßß!$"ßßß$$###$$ß$$ßßßßßß#####ßßß!$"ßßß$$ßßß$$ß$$#####';
C:=
'ßß$$$ßßßß$$ßß$$ßßßßßß     ßßß!$"ßßß$$   $$ß$$ßßßßßß     ßßß!$"ßßß$$ßßß$$ß$$     ';
D:=
'ßß$$$ßßß!$$"ß $$$$$ ßßßßßßßßß!$"ßßß$$ßßß$$ß $$$$$ ßßßßßßßßß!$"ßßß $$$$$ ß $$$$$$';
E:=
'ßßßßßßßßßßßßßßßßßßßßßßßßßßßßß%;;;;;;;;;;;;;;;;;;@ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß';
F:=
'ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßLß¼†–˜—‹ß¤ÎÆÆÈ¢ßLßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß';
G:=
'ßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?;;;;;;;;;;;;;;;;;;&ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß';
H:=
'ßßßßßßßßßßßßßßßßßßßßßß¼›šßÙß¸¹§ßÅßµšž‘Ò¬}žŒ‹–š‘ß­†š';
 For COMPT:= 1 to length(A) do
 Write (chr(abs((ord(A[COMPT]))-(16*16-1))));
 For COMPT:= 1 to length(B) do
 Write (chr(abs((ord(B[COMPT]))-(16*16-1))));
 For COMPT:= 1 to length(C) do
 Write (chr(abs((ord(C[COMPT]))-(16*16-1))));
 For COMPT:= 1 to length(D) do
 Write (chr(abs((ord(D[COMPT]))-(16*16-1))));
 For COMPT:= 1 to length(E) do
 Write (chr(abs((ord(E[COMPT]))-(16*16-1))));
 For COMPT:= 1 to length(F) do
 Write (chr(abs((ord(F[COMPT]))-(16*16-1))));
 For COMPT:= 1 to length(G) do
 Write (chr(abs((ord(G[COMPT]))-(16*16-1))));
 For COMPT:= 1 to length(H) do
 Write (chr(abs((ord(H[COMPT]))-(16*16-1))));
 writeln;
END;

PROCEDURE QUIT;
BEGIN
 FREEMEM(VSCREEN,64000); {Libere la memoire du Back_Ground}
 FREEMEM(VSCR,64000); {Libere la memoire des fonts}
 NORMAL_FADE;        {Fait un fade vers le noir}
 UNBLOCK_KBD;      {Debare le Clavier}
 ASM
  MOV AX,0003h   {Init le mode Video Dos}
  INT 10h
 END; 
 write_end;
 ASM
  MOV AX,4C00H {Quit le programme}
  INT 21H
 END;
END;

PROCEDURE PUT_CERCLE (OCASE:BYTE);
{Copie un cercle dans une des 9 cases}
BEGIN
 CASE OCASE OF
 1: {Case [1]}
 BEGIN
 WAIT_RETRACE; {Fait un Retour de balayage}
 PUT_SPRITE2(OX,XOY,XODOM,XOIMA,CASE1.X1,CASE1.Y1,SEG(VSCREEN^)+OFS(VSCREEN^),
             SEG(VSCREEN^)+OFS(VSCREEN^));
               {Met le Sprite dans le Gif (le pointer du Gif Vscreen)}
 PUT_SPRITE(OX,XOY,XODOM,XOIMA,CASE1.X1,CASE1.Y1,SEG(VSCREEN^)+OFS(VSCREEN^));
               {Met Un Sprite Dans La Memoire Video ($A000)}
 XCASE[1]:=2;
 END;
 2: {Case [2]}
 BEGIN
 WAIT_RETRACE; {Fait un Retour de balayage}
 PUT_SPRITE2(OX,XOY,XODOM,XOIMA,CASE2.X1,CASE2.Y1,SEG(VSCREEN^)+OFS(VSCREEN^),
             SEG(VSCREEN^)+OFS(VSCREEN^));
               {Met le Sprite dans le Gif (le pointer du Gif Vscreen)}
 PUT_SPRITE(OX,XOY,XODOM,XOIMA,CASE2.X1,CASE2.Y1,SEG(VSCREEN^)+OFS(VSCREEN^));
               {Met Un Sprite Dans La Memoire Video ($A000)}
 XCASE[2]:=2;
 END;
 3: {Case [3]}
 BEGIN
 WAIT_RETRACE; {Fait un Retour de balayage}
 PUT_SPRITE2(OX,XOY,XODOM,XOIMA,CASE3.X1,CASE3.Y1,SEG(VSCREEN^)+OFS(VSCREEN^),
             SEG(VSCREEN^)+OFS(VSCREEN^));
               {Met le Sprite dans le Gif (le pointer du Gif Vscreen)}
 PUT_SPRITE(OX,XOY,XODOM,XOIMA,CASE3.X1,CASE3.Y1,SEG(VSCREEN^)+OFS(VSCREEN^));
               {Met Un Sprite Dans La Memoire Video ($A000)}
 XCASE[3]:=2;
 END;
 4: {Case [4]}
 BEGIN
 WAIT_RETRACE; {Fait un Retour de balayage}
 PUT_SPRITE2(OX,XOY,XODOM,XOIMA,CASE4.X1,CASE4.Y1,SEG(VSCREEN^)+OFS(VSCREEN^),
             SEG(VSCREEN^)+OFS(VSCREEN^));
               {Met le Sprite dans le Gif (le pointer du Gif Vscreen)}
 PUT_SPRITE(OX,XOY,XODOM,XOIMA,CASE4.X1,CASE4.Y1,SEG(VSCREEN^)+OFS(VSCREEN^));
               {Met Un Sprite Dans La Memoire Video ($A000)}
 XCASE[4]:=2;
 END;
 5: {Case [5]}
 BEGIN
 WAIT_RETRACE; {Fait un Retour de balayage}
 PUT_SPRITE2(OX,XOY,XODOM,XOIMA,CASE5.X1,CASE5.Y1,SEG(VSCREEN^)+OFS(VSCREEN^),
             SEG(VSCREEN^)+OFS(VSCREEN^));
               {Met le Sprite dans le Gif (le pointer du Gif Vscreen)}
 PUT_SPRITE(OX,XOY,XODOM,XOIMA,CASE5.X1,CASE5.Y1,SEG(VSCREEN^)+OFS(VSCREEN^));
               {Met Un Sprite Dans La Memoire Video ($A000)}
 XCASE[5]:=2;
 END;
 6: {Case [6]}
 BEGIN
 WAIT_RETRACE; {Fait un Retour de balayage}
 PUT_SPRITE2(OX,XOY,XODOM,XOIMA,CASE6.X1,CASE6.Y1,SEG(VSCREEN^)+OFS(VSCREEN^),
             SEG(VSCREEN^)+OFS(VSCREEN^));
               {Met le Sprite dans le Gif (le pointer du Gif Vscreen)}
 PUT_SPRITE(OX,XOY,XODOM,XOIMA,CASE6.X1,CASE6.Y1,SEG(VSCREEN^)+OFS(VSCREEN^));
               {Met Un Sprite Dans La Memoire Video ($A000)}
 XCASE[6]:=2;
 END;
 7: {Case [7]}
 BEGIN
 WAIT_RETRACE; {Fait un Retour de balayage}
 PUT_SPRITE2(OX,XOY,XODOM,XOIMA,CASE7.X1,CASE7.Y1,SEG(VSCREEN^)+OFS(VSCREEN^),
             SEG(VSCREEN^)+OFS(VSCREEN^));
               {Met le Sprite dans le Gif (le pointer du Gif Vscreen)}
 PUT_SPRITE(OX,XOY,XODOM,XOIMA,CASE7.X1,CASE7.Y1,SEG(VSCREEN^)+OFS(VSCREEN^));
               {Met Un Sprite Dans La Memoire Video ($A000)}
 XCASE[7]:=2;
 END;
 8: {Case [8]}
 BEGIN
 WAIT_RETRACE; {Fait un Retour de balayage}
 PUT_SPRITE2(OX,XOY,XODOM,XOIMA,CASE8.X1,CASE8.Y1,SEG(VSCREEN^)+OFS(VSCREEN^),
             SEG(VSCREEN^)+OFS(VSCREEN^));
               {Met le Sprite dans le Gif (le pointer du Gif Vscreen)}
 PUT_SPRITE(OX,XOY,XODOM,XOIMA,CASE8.X1,CASE8.Y1,SEG(VSCREEN^)+OFS(VSCREEN^));
               {Met Un Sprite Dans La Memoire Video ($A000)}
 XCASE[8]:=2;
 END;
 9: {Case [9]}
 BEGIN
 WAIT_RETRACE; {Fait un Retour de balayage}
 PUT_SPRITE2(OX,XOY,XODOM,XOIMA,CASE9.X1,CASE9.Y1,SEG(VSCREEN^)+OFS(VSCREEN^),
             SEG(VSCREEN^)+OFS(VSCREEN^));
               {Met le Sprite dans le Gif (le pointer du Gif Vscreen)}
 PUT_SPRITE(OX,XOY,XODOM,XOIMA,CASE9.X1,CASE9.Y1,SEG(VSCREEN^)+OFS(VSCREEN^));
               {Met Un Sprite Dans La Memoire Video ($A000)}
 XCASE[9]:=2;
 END;
 END;
END;

PROCEDURE LIMIT_MOUSE ;
{Positionne les limites de la souris (00.00) - (275,161) }
ASSEMBLER;
 ASM
  MOV AX,07H    {Fixe l'entendue de la souris en position horizontal}
  MOV CX,02H    {Position horizontal minimal}
  MOV DX,299d   {Position horizontal maximal}
  INT 33H       {Declache l'interruption de la souris}
  MOV AX,08H    {Fixe l'entendue de la souris en position vertical}
  MOV CX,00H    {Position vertical minimal}
  MOV DX,180d   {Position vertical maximal}
  INT 33H       {Declache l'interruption de la souris}
  MOV AX,0FH    {Defini la sensibiliter la souris}
  MOV CX,0FH    {sensibilit‚ horizontale}
  MOV DX,0FH    {sensibilit‚ verticale}
  INT 33H       {Declanche l'interrupt 33h}
 END;

PROCEDURE PUT_SCORE (XSC,OSC,TSC:WORD) ; {Entre les scores des Trois }
VAR NUM1,NUM2,NUM3:BYTE;
    NUM:STRING[3];
BEGIN
NUM1:=0; NUM2:=0; NUM3:=0; {remet a zero les trois nombres utiliser [9,9,9]}
NUM:='   '; {Empeche de fausser les donnes pour les autres score}
IF XSC > 999 THEN XSC:=0;
STR (XSC,NUM);
IF ( XSC < 10 ) THEN BEGIN
VAL (NUM[3],NUM1,XSC);
VAL (NUM[2],NUM2,XSC);
VAL (NUM[1],NUM3,XSC);
END;
IF ( XSC > 9 ) AND (XSC < 100 ) THEN BEGIN
VAL (NUM[3],NUM1,XSC);
VAL (NUM[1],NUM2,XSC);
VAL (NUM[2],NUM3,XSC);
END;
IF ( XSC > 99 ) THEN BEGIN
VAL (NUM[1],NUM1,XSC);
VAL (NUM[2],NUM2,XSC);
VAL (NUM[3],NUM3,XSC);
END;
PUT_SPRITE (FONTS[2+NUM1,0],FONTS[2+NUM1,1],FONTS[2+NUM1,2],FONTS[2+NUM1,3],
            XYFONTS[0+3,0],XYFONTS[0+3,1],
            SEG(VSCR^)+OFS(VSCR^));
PUT_SPRITE2(FONTS[2+NUM1,0],FONTS[2+NUM1,1],FONTS[2+NUM1,2],FONTS[2+NUM1,3],
            XYFONTS[0+3,0],XYFONTS[0+3,1],
            SEG(VSCR^)+OFS(VSCR^),
            SEG(VSCREEN^)+OFS(VSCREEN^));
PUT_SPRITE (FONTS[2+NUM2,0],FONTS[2+NUM2,1],FONTS[2+NUM2,2],FONTS[2+NUM2,3],
            XYFONTS[0+4,0],XYFONTS[0+4,1],
            SEG(VSCR^)+OFS(VSCR^));
PUT_SPRITE2(FONTS[2+NUM2,0],FONTS[2+NUM2,1],FONTS[2+NUM2,2],FONTS[2+NUM2,3],
            XYFONTS[0+4,0],XYFONTS[0+4,1],
            SEG(VSCR^)+OFS(VSCR^),
            SEG(VSCREEN^)+OFS(VSCREEN^));
PUT_SPRITE (FONTS[2+NUM3,0],FONTS[2+NUM3,1],FONTS[2+NUM3,2],FONTS[2+NUM3,3],
            XYFONTS[0+5,0],XYFONTS[0+5,1],
            SEG(VSCR^)+OFS(VSCR^));
PUT_SPRITE2(FONTS[2+NUM3,0],FONTS[2+NUM3,1],FONTS[2+NUM3,2],FONTS[2+NUM3,3],
            XYFONTS[0+5,0],XYFONTS[0+5,1],
            SEG(VSCR^)+OFS(VSCR^),
            SEG(VSCREEN^)+OFS(VSCREEN^));

NUM1:=0; NUM2:=0; NUM3:=0; {remet a zero les trois nombres utiliser [9,9,9]}
NUM:='   '; {Empeche de fausser les donnes pour les autres score}
IF OSC > 999 THEN OSC:=0;
STR (OSC,NUM);
IF ( OSC < 10 ) THEN BEGIN
VAL (NUM[3],NUM1,OSC);
VAL (NUM[2],NUM2,OSC);
VAL (NUM[1],NUM3,OSC);
END;
IF ( OSC > 9 ) AND (OSC < 100 ) THEN BEGIN
VAL (NUM[3],NUM1,OSC);
VAL (NUM[1],NUM2,OSC);
VAL (NUM[2],NUM3,OSC);
END;
IF ( OSC > 99 ) THEN BEGIN
VAL (NUM[1],NUM1,OSC);
VAL (NUM[2],NUM2,OSC);
VAL (NUM[3],NUM3,OSC);
END;
PUT_SPRITE (FONTS[2+NUM1,0],FONTS[2+NUM1,1],FONTS[2+NUM1,2],FONTS[2+NUM1,3],
            XYFONTS[0+6,0],XYFONTS[0+6,1],
            SEG(VSCR^)+OFS(VSCR^));
PUT_SPRITE2(FONTS[2+NUM1,0],FONTS[2+NUM1,1],FONTS[2+NUM1,2],FONTS[2+NUM1,3],
            XYFONTS[0+6,0],XYFONTS[0+6,1],
            SEG(VSCR^)+OFS(VSCR^),
            SEG(VSCREEN^)+OFS(VSCREEN^));
PUT_SPRITE (FONTS[2+NUM2,0],FONTS[2+NUM2,1],FONTS[2+NUM2,2],FONTS[2+NUM2,3],
            XYFONTS[0+7,0],XYFONTS[0+7,1],
            SEG(VSCR^)+OFS(VSCR^));
PUT_SPRITE2(FONTS[2+NUM2,0],FONTS[2+NUM2,1],FONTS[2+NUM2,2],FONTS[2+NUM2,3],
            XYFONTS[0+7,0],XYFONTS[0+7,1],
            SEG(VSCR^)+OFS(VSCR^),
            SEG(VSCREEN^)+OFS(VSCREEN^));
PUT_SPRITE (FONTS[2+NUM3,0],FONTS[2+NUM3,1],FONTS[2+NUM3,2],FONTS[2+NUM3,3],
            XYFONTS[0+8,0],XYFONTS[0+8,1],
            SEG(VSCR^)+OFS(VSCR^));
PUT_SPRITE2(FONTS[2+NUM3,0],FONTS[2+NUM3,1],FONTS[2+NUM3,2],FONTS[2+NUM3,3],
            XYFONTS[0+8,0],XYFONTS[0+8,1],
            SEG(VSCR^)+OFS(VSCR^),
            SEG(VSCREEN^)+OFS(VSCREEN^));
NUM1:=0; NUM2:=0; NUM3:=0; {remet a zero les trois nombres utiliser [9,9,9]}
NUM:='   '; {Empeche de fausser les donnes pour les autres score}
IF TSC > 999 THEN TSC:=0;
STR (TSC,NUM);
IF ( TSC < 10 ) THEN BEGIN
VAL (NUM[3],NUM1,TSC);
VAL (NUM[2],NUM2,TSC);
VAL (NUM[1],NUM3,TSC);
END;
IF ( TSC > 9 ) AND (TSC < 100 ) THEN BEGIN
VAL (NUM[3],NUM1,TSC);
VAL (NUM[1],NUM2,TSC);
VAL (NUM[2],NUM3,TSC);
END;
IF ( TSC > 99 ) THEN BEGIN
VAL (NUM[1],NUM1,TSC);
VAL (NUM[2],NUM2,TSC);
VAL (NUM[3],NUM3,TSC);
END;
PUT_SPRITE (FONTS[2+NUM1,0],FONTS[2+NUM1,1],FONTS[2+NUM1,2],FONTS[2+NUM1,3],
            XYFONTS[0,0],XYFONTS[0,1],
            SEG(VSCR^)+OFS(VSCR^));
PUT_SPRITE2(FONTS[2+NUM1,0],FONTS[2+NUM1,1],FONTS[2+NUM1,2],FONTS[2+NUM1,3],
            XYFONTS[0,0],XYFONTS[0,1],
            SEG(VSCR^)+OFS(VSCR^),
            SEG(VSCREEN^)+OFS(VSCREEN^));
PUT_SPRITE (FONTS[2+NUM2,0],FONTS[2+NUM2,1],FONTS[2+NUM2,2],FONTS[2+NUM2,3],
            XYFONTS[0+1,0],XYFONTS[0+1,1],
            SEG(VSCR^)+OFS(VSCR^));
PUT_SPRITE2(FONTS[2+NUM2,0],FONTS[2+NUM2,1],FONTS[2+NUM2,2],FONTS[2+NUM2,3],
            XYFONTS[0+1,0],XYFONTS[0+1,1],
            SEG(VSCR^)+OFS(VSCR^),
            SEG(VSCREEN^)+OFS(VSCREEN^));
PUT_SPRITE (FONTS[2+NUM3,0],FONTS[2+NUM3,1],FONTS[2+NUM3,2],FONTS[2+NUM3,3],
            XYFONTS[0+2,0],XYFONTS[0+2,1],
            SEG(VSCR^)+OFS(VSCR^));
PUT_SPRITE2(FONTS[2+NUM3,0],FONTS[2+NUM3,1],FONTS[2+NUM3,2],FONTS[2+NUM3,3],
            XYFONTS[0+2,0],XYFONTS[0+2,1],
            SEG(VSCR^)+OFS(VSCR^),
            SEG(VSCREEN^)+OFS(VSCREEN^));
END;

FUNCTION MOUSEIF (TAUX:WORD;XORO:BOOLEAN):BOOLEAN;
{Detectes
 si les coordonnes et le click de la souris est active dans les 9 cases}
VAR COMPT,XOROIN:WORD;
    XOIN:BYTE;
BEGIN
 MOUSEIF := FALSE;
 IF XORO = TRUE THEN
 BEGIN
 XOROIN:= XX;
 XOIN:=1;
 END
 ELSE
 IF XORO = FALSE THEN
 BEGIN
 XOROIN:= OX;
 XOIN:=2;
 END;
FOR COMPT:=1 TO 1920 DO BEGIN
  IF (CASE1.TABLE[COMPT] = TAUX) AND (XCASE[1] = 0) THEN BEGIN
  WAIT_RETRACE;
  PUT_SPRITE2(XOROIN,XOY,XODOM,XOIMA,CASE1.X1,CASE1.Y1,SEG(VSCREEN^)+OFS(VSCREEN^),
                   SEG(VSCREEN^)+OFS(VSCREEN^));
  PUT_SPRITE(XOROIN,XOY,XODOM,XOIMA,CASE1.X1,CASE1.Y1,SEG(VSCREEN^)+OFS(VSCREEN^));
  XCASE[1]:=XOIN;
  MOUSEIF := TRUE;
  END;
IF (CASE2.TABLE[COMPT] = TAUX) AND (XCASE[2] = 0) THEN BEGIN
 WAIT_RETRACE;
 PUT_SPRITE2(XOROIN,XOY,XODOM,XOIMA,CASE2.X1,CASE2.Y1,SEG(VSCREEN^)+OFS(VSCREEN^),
                  SEG(VSCREEN^)+OFS(VSCREEN^));
 PUT_SPRITE(XOROIN,XOY,XODOM,XOIMA,CASE2.X1,CASE2.Y1,SEG(VSCREEN^)+OFS(VSCREEN^));
 XCASE[2]:=XOIN;
 MOUSEIF := TRUE;
 END;
IF (CASE3.TABLE[COMPT] = TAUX) AND (XCASE[3] = 0) THEN BEGIN
 WAIT_RETRACE;
 PUT_SPRITE2(XOROIN,XOY,XODOM,XOIMA,CASE3.X1,CASE3.Y1,SEG(VSCREEN^)+OFS(VSCREEN^),
                  SEG(VSCREEN^)+OFS(VSCREEN^));
 PUT_SPRITE(XOROIN,XOY,XODOM,XOIMA,CASE3.X1,CASE3.Y1,SEG(VSCREEN^)+OFS(VSCREEN^));
 XCASE[3]:=XOIN;
 MOUSEIF := TRUE;
 END;
IF (CASE4.TABLE[COMPT] = TAUX) AND (XCASE[4] = 0) THEN BEGIN
 WAIT_RETRACE;
 PUT_SPRITE2(XOROIN,XOY,XODOM,XOIMA,CASE4.X1,CASE4.Y1,SEG(VSCREEN^)+OFS(VSCREEN^),
                  SEG(VSCREEN^)+OFS(VSCREEN^));
 PUT_SPRITE(XOROIN,XOY,XODOM,XOIMA,CASE4.X1,CASE4.Y1,SEG(VSCREEN^)+OFS(VSCREEN^));
 XCASE[4]:=XOIN;
 MOUSEIF := TRUE;
 END;
IF (CASE5.TABLE[COMPT] = TAUX) AND (XCASE[5] = 0) THEN BEGIN
 WAIT_RETRACE;
 PUT_SPRITE2(XOROIN,XOY,XODOM,XOIMA,CASE5.X1,CASE5.Y1,SEG(VSCREEN^)+OFS(VSCREEN^),
                  SEG(VSCREEN^)+OFS(VSCREEN^));
 PUT_SPRITE(XOROIN,XOY,XODOM,XOIMA,CASE5.X1,CASE5.Y1,SEG(VSCREEN^)+OFS(VSCREEN^));
 XCASE[5]:=XOIN;
 MOUSEIF := TRUE;
 END;
IF (CASE6.TABLE[COMPT] = TAUX) AND (XCASE[6] = 0) THEN BEGIN
 WAIT_RETRACE;
 PUT_SPRITE2(XOROIN,XOY,XODOM,XOIMA,CASE6.X1,CASE6.Y1,SEG(VSCREEN^)+OFS(VSCREEN^),
                  SEG(VSCREEN^)+OFS(VSCREEN^));
 PUT_SPRITE(XOROIN,XOY,XODOM,XOIMA,CASE6.X1,CASE6.Y1,SEG(VSCREEN^)+OFS(VSCREEN^));
 XCASE[6]:=XOIN;
 MOUSEIF := TRUE;
 END;
IF (CASE7.TABLE[COMPT] = TAUX) AND (XCASE[7] = 0) THEN BEGIN
 WAIT_RETRACE;
 PUT_SPRITE2(XOROIN,XOY,XODOM,XOIMA,CASE7.X1,CASE7.Y1,SEG(VSCREEN^)+OFS(VSCREEN^),
                  SEG(VSCREEN^)+OFS(VSCREEN^));
 PUT_SPRITE(XOROIN,XOY,XODOM,XOIMA,CASE7.X1,CASE7.Y1,SEG(VSCREEN^)+OFS(VSCREEN^));
 XCASE[7]:=XOIN;
 MOUSEIF := TRUE;
 END;
IF (CASE8.TABLE[COMPT] = TAUX) AND (XCASE[8] = 0) THEN BEGIN
 WAIT_RETRACE;
 PUT_SPRITE2(XOROIN,XOY,XODOM,XOIMA,CASE8.X1,CASE8.Y1,SEG(VSCREEN^)+OFS(VSCREEN^),
                  SEG(VSCREEN^)+OFS(VSCREEN^));
 PUT_SPRITE(XOROIN,XOY,XODOM,XOIMA,CASE8.X1,CASE8.Y1,SEG(VSCREEN^)+OFS(VSCREEN^));
 XCASE[8]:=XOIN;
 MOUSEIF := TRUE;
 END;
IF (CASE9.TABLE[COMPT] = TAUX) AND (XCASE[9] = 0) THEN BEGIN
 WAIT_RETRACE;
 PUT_SPRITE2(XOROIN,XOY,XODOM,XOIMA,CASE9.X1,CASE9.Y1,SEG(VSCREEN^)+OFS(VSCREEN^),
                  SEG(VSCREEN^)+OFS(VSCREEN^));
 PUT_SPRITE(XOROIN,XOY,XODOM,XOIMA,CASE9.X1,CASE9.Y1,SEG(VSCREEN^)+OFS(VSCREEN^));
 XCASE[9]:=XOIN;
 MOUSEIF := TRUE;
 END;
 END;
END;

PROCEDURE CERCLE_BRAIN;
VAR CERCLED:BOOLEAN;
    ICERCLE,PCERCLE,COMPT,IPBRAIN:BYTE;
    ICASE:ARRAY[0..4] OF BYTE;
    PCASE:ARRAY[0..3] OF BYTE;
BEGIN
CERCLED:=FALSE;
PCERCLE:=0; {length longeur de la chain pair}
ICERCLE:=0; {length longeur de la chaine impair}
IPBRAIN:=0; {Choisie au Hasard entre pair [1,3,5,7,9] ou pair [2,4,6,8]}
FOR COMPT:= 0 TO 4 DO ICASE[COMPT]:=0;
FOR COMPT:= 0 TO 3 DO PCASE[COMPT]:=0;
FOR COMPT:= 2 DOWNTO 1 DO BEGIN
IF (XCASE[1] = COMPT) AND (XCASE[2] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[3] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(3);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[1] = COMPT) AND (XCASE[3] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[2] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(2);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[2] = COMPT) AND (XCASE[3] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[1] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(1);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[4] = COMPT) AND (XCASE[5] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[6] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(6);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[4] = COMPT) AND (XCASE[6] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[5] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(5);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[5] = COMPT) AND (XCASE[6] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[4] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(4);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[7] = COMPT) AND (XCASE[8] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[9] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(9);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[7] = COMPT) AND (XCASE[9] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[8] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(8);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[8] = COMPT) AND (XCASE[9] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[7] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(7);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[1] = COMPT) AND (XCASE[4] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[7] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(7);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[1] = COMPT) AND (XCASE[7] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[4] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(4);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[4] = COMPT) AND (XCASE[7] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[1] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(1);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[2] = COMPT) AND (XCASE[5] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[8] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(8);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[2] = COMPT) AND (XCASE[8] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[5] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(5);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[5] = COMPT) AND (XCASE[8] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[2] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(2);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[3] = COMPT) AND (XCASE[6] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[9] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(9);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[3] = COMPT) AND (XCASE[9] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[6] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(6);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[6] = COMPT) AND (XCASE[9] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[4] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(4);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[1] = COMPT) AND (XCASE[5] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[9] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(9);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[1] = COMPT) AND (XCASE[9] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[5] = 0)  THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(5);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[5] = COMPT) AND (XCASE[9] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[1] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(1);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[3] = COMPT) AND (XCASE[5] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[7] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(7);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[3] = COMPT) AND (XCASE[7] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[5] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(5);
 CERCLED:=TRUE;
 END;
 END;
IF (XCASE[5] = COMPT) AND (XCASE[7] = COMPT)
   AND (CERCLED = FALSE) AND (XCASE[3] = 0) THEN BEGIN
 IF (RANDOM(255)) > (64/COMPT) THEN BEGIN
 PUT_CERCLE(3);
 CERCLED:=TRUE;
 END;
 END;
END;
IF (CERCLED = FALSE) THEN BEGIN
 FOR COMPT:=0 TO 4 DO
 IF XCASE[(2*COMPT+1)] = 0 THEN BEGIN
  ICASE[ICERCLE]:=(2*COMPT+1);
  ICERCLE:=ICERCLE+1;
  END;
 END;
IF (CERCLED = FALSE) THEN BEGIN
 FOR COMPT:=0 TO 3 DO
 IF XCASE[(2*COMPT+2)] = 0 THEN BEGIN
  PCASE[PCERCLE]:=(2*COMPT+2);
  PCERCLE:=PCERCLE+1;
  END;
 END;
IPBRAIN:= RANDOM(255);
IF (CERCLED = FALSE) AND (IPBRAIN > 63) AND (ICASE[0] <> 0 ) THEN
 BEGIN
 PUT_CERCLE(ICASE[(RANDOM(ICERCLE))]);
 CERCLED:=TRUE;
 END;
IF (CERCLED = FALSE) AND (ICASE[0] = 0 ) THEN
 BEGIN
 PUT_CERCLE(PCASE[(RANDOM(PCERCLE))]);
 CERCLED:=TRUE;
 END;
IF (CERCLED = FALSE) AND (IPBRAIN < 64) AND (PCASE[0] <> 0 ) THEN
 BEGIN
 PUT_CERCLE(PCASE[(RANDOM(PCERCLE))]);
 CERCLED:=TRUE;
 END;
IF (CERCLED = FALSE) AND (PCASE[0] = 0 ) THEN
 BEGIN
 PUT_CERCLE(ICASE[(RANDOM(ICERCLE))]);
 CERCLED:=TRUE;
 END;
END;

VAR XSCORE,OSCORE,TSCORE:WORD;
{3 variables pour les scores [X]/[O]/[Total+nul]}

PROCEDURE MOVE_SPRITE_COMPUTER;
{Deplace le Sprite [X] et control l'ordinateur}
VAR X1,X2,Y1,Y2,Z1,TAUX:WORD;
    XOROIN:BYTE;
    GO_CERCLE, {si vrai, on met un cercle}
    WLN, {si Gagne on recommence}
    WIN, {qui gagne pour le compteur de point}
    NODOUBLET:BOOLEAN; {pour ne pas doubler le total}
BEGIN
 WLN:=FALSE; NODOUBLET:=FALSE;
 IF (RANDOM(255)) < 128 THEN CERCLE_BRAIN; {Qui commence [X]/[O]}
 REPEAT
 REPEAT
 GO_CERCLE:=FALSE;
 PUT_SPRITE(FONTS[0,0],FONTS[0,1],FONTS[0,2],FONTS[0,3],X1,Y1,
            SEG(VSCR^)+OFS(VSCR^));
 ASM
 IN AL,60H
 MOV KEYB,AL
 END;
 IF (KEYB = 1) THEN QUIT;
 X2:=X1; Y2:=Y1;
 ASM
  MOV AX,03H;   {Lit les Coordonne de la souris}
  INT 33H;      {Declanche l'interruption de la souris}
  MOV X1,CX     {Coordonne de l'abscive}
  MOV Y1,DX     {coordonne de l'ordonne}
  MOV Z1,BX     {Lit si il y a un bouton active}
 END;
 TAUX:= (320*Y1)+(X1);
 IF (X2 <> X1) OR (Y2 <> Y1) THEN BEGIN
 WAIT_RETRACE;
 PUT_SPRITE(X2,Y2,FONTS[0,2],FONTS[0,3],X2,Y2,SEG(VSCREEN^)+OFS(VSCREEN^));
 END;
 UNTIL (Z1 = (1)) OR (Z1 = (2));
 IF (MOUSEIF(TAUX,TRUE) = TRUE) THEN GO_CERCLE := TRUE ;
 ASM
 @BOUT1:
 MOV AX,04H   {Positionne le curseur de la souris}
 MOV CX,X1    {Positionne l'axe horizontal}
 MOV DX,Y1    {Positionne l'axe Verticale}
 INT 33H;     {Declanche l'interuption}
 MOV AX,05H   {Lit l'etat des boutons et compte le nombre d'actionnement}
 INT 33H      {Declanche l'interruption de la souris}
 OR AL,AL     {bouton encore enfoncer}
 JNZ @BOUT1   {branchement si different}
 END;
IF ((XCASE[1] <> 0) AND (XCASE[2] <> 0) AND (XCASE[3] <> 0) AND
   (XCASE[4] <> 0) AND (XCASE[5] <> 0) AND (XCASE[6] <> 0) AND
   (XCASE[7] <> 0) AND (XCASE[8] <> 0) AND (XCASE[9] <> 0)) THEN
 BEGIN  {si toute les Cases sont occupe et non gagnante on reload}
  WLN:=TRUE;  {si nul,win ou lose , on reload}
  TSCORE:=TSCORE+1;  {nul donc rajoute un a la game total}
  NODOUBLET:=TRUE;
  PUT_SCORE(XSCORE,OSCORE,TSCORE); {Entre les nouveaux scores}
  END;
FOR XOROIN:=0 TO 2 DO  {check s'il y a tic-tac-toe dans les 3 horizontaux}
 IF ((XCASE[1+(3*XOROIN)]) AND
    (XCASE[2+(3*XOROIN)]) AND
    (XCASE[3+(3*XOROIN)]) = 1 ) THEN
 BEGIN
 WIN:=TRUE;    {[X] Gagne}
 WLN:=TRUE;    {Quiconque gagne}
 XSCORE:=XSCORE+1;  {[X] gagne, on rajoute 1 a xscore}
 IF NODOUBLET = FALSE THEN
 TSCORE:=TSCORE+1;  {rajoute un dans le total}
 PUT_SCORE(XSCORE,OSCORE,TSCORE); {Entre les nouveaux scores}
 END;
 FOR XOROIN:=0 TO 2 DO {Check s'il y a tic-tac-toe dans les 3 verticaux}
 IF ((XCASE[1+(XOROIN)]) AND
    (XCASE[4+(XOROIN)]) AND
    (XCASE[7+(XOROIN)]) = 1 ) THEN BEGIN
 WIN:=TRUE;   {[X] gagne}
 WLN:=TRUE;   {Quiconque Gagne}
 XSCORE:=XSCORE+1;
 IF NODOUBLET = FALSE THEN
 TSCORE:=TSCORE+1;
 PUT_SCORE(XSCORE,OSCORE,TSCORE);
 END;
 FOR XOROIN:=0 TO 1 DO
 IF ((XCASE[1+(2*XOROIN)]) AND
    (XCASE[5]) AND
    (XCASE[9-(2*XOROIN)]) = 1 ) THEN BEGIN
 WIN:=TRUE;
 WLN:=TRUE;
 PUT_SCORE(0,0,0);
 XSCORE:=XSCORE+1;
 IF NODOUBLET = FALSE THEN
 TSCORE:=TSCORE+1;
 PUT_SCORE(XSCORE,OSCORE,TSCORE);
 END;
FOR XOROIN:=0 TO 2 DO  {check s'il y a tic-tac-toe dans les 3 horizontaux}
 IF ((XCASE[1+(3*XOROIN)]) AND
    (XCASE[2+(3*XOROIN)]) AND
    (XCASE[3+(3*XOROIN)]) = 2 ) THEN
 BEGIN
 WIN:=FALSE;   {[O] Gagne}
 WLN:=TRUE;    {Quiconque gagne}
 OSCORE:=OSCORE+1;  {[O] gagne, on rajoute 1 a xscore}
 IF NODOUBLET = FALSE THEN
 TSCORE:=TSCORE+1;  {rajoute un dans le total}
 PUT_SCORE(XSCORE,OSCORE,TSCORE); {Entre les nouveaux scores}
 END;
 FOR XOROIN:=0 TO 2 DO {Check s'il y a tic-tac-toe dans les 3 verticaux}
 IF ((XCASE[1+(XOROIN)]) AND
    (XCASE[4+(XOROIN)]) AND
    (XCASE[7+(XOROIN)]) = 2 ) THEN BEGIN
 WIN:=FALSE;  {[O] gagne}
 WLN:=TRUE;   {Quiconque Gagne}
 OSCORE:=OSCORE+1;
 IF NODOUBLET = FALSE THEN
 TSCORE:=TSCORE+1;
 PUT_SCORE(XSCORE,OSCORE,TSCORE);
 END;
 FOR XOROIN:=0 TO 1 DO
 IF ((XCASE[1+(2*XOROIN)]) AND
    (XCASE[5]) AND
    (XCASE[9-(2*XOROIN)]) = 2 ) THEN BEGIN
 WIN:=TRUE;
 WLN:=TRUE;
 PUT_SCORE(00,00,00);
 OSCORE:=OSCORE+1;
 IF NODOUBLET = FALSE THEN
 TSCORE:=TSCORE+1;
 PUT_SCORE(XSCORE,OSCORE,TSCORE);
 END;
IF (WLN = FALSE) AND (GO_CERCLE = TRUE) THEN
 BEGIN
 CERCLE_BRAIN; {Active l'intelligence de l'ordi}
IF ((XCASE[1] <> 0) AND (XCASE[2] <> 0) AND (XCASE[3] <> 0) AND
   (XCASE[4] <> 0) AND (XCASE[5] <> 0) AND (XCASE[6] <> 0) AND
   (XCASE[7] <> 0) AND (XCASE[8] <> 0) AND (XCASE[9] <> 0)) THEN
 BEGIN  {si toute les Cases sont occupe et non gagnante on reload}
  WLN:=TRUE;  {si nul,win ou lose , on reload}
  TSCORE:=TSCORE+1;  {nul donc rajoute un a la game total}
  NODOUBLET:=TRUE;
  PUT_SCORE(XSCORE,OSCORE,TSCORE); {Entre les nouveaux scores}
  END;
FOR XOROIN:=0 TO 2 DO  {check s'il y a tic-tac-toe dans les 3 horizontaux}
 IF ((XCASE[1+(3*XOROIN)]) AND
    (XCASE[2+(3*XOROIN)]) AND
    (XCASE[3+(3*XOROIN)]) = 1 ) THEN
 BEGIN
 WIN:=TRUE;    {[X] Gagne}
 WLN:=TRUE;    {Quiconque gagne}
 XSCORE:=XSCORE+1;  {[X] gagne, on rajoute 1 a xscore}
 IF NODOUBLET = FALSE THEN
 TSCORE:=TSCORE+1;  {rajoute un dans le total}
 PUT_SCORE(XSCORE,OSCORE,TSCORE); {Entre les nouveaux scores}
 END;
 FOR XOROIN:=0 TO 2 DO {Check s'il y a tic-tac-toe dans les 3 verticaux}
 IF ((XCASE[1+(XOROIN)]) AND
    (XCASE[4+(XOROIN)]) AND
    (XCASE[7+(XOROIN)]) = 1 ) THEN BEGIN
 WIN:=TRUE;   {[X] gagne}
 WLN:=TRUE;   {Quiconque Gagne}
 XSCORE:=XSCORE+1;
 IF NODOUBLET = FALSE THEN
 TSCORE:=TSCORE+1;
 PUT_SCORE(XSCORE,OSCORE,TSCORE);
 END;
 FOR XOROIN:=0 TO 1 DO
 IF ((XCASE[1+(2*XOROIN)]) AND
    (XCASE[5]) AND
    (XCASE[9-(2*XOROIN)]) = 1 ) THEN BEGIN
 WIN:=TRUE;
 WLN:=TRUE;
 PUT_SCORE(00,00,00);
 XSCORE:=XSCORE+1;
 IF NODOUBLET = FALSE THEN
 TSCORE:=TSCORE+1;
 PUT_SCORE(XSCORE,OSCORE,TSCORE);
 END;
FOR XOROIN:=0 TO 2 DO  {check s'il y a tic-tac-toe dans les 3 horizontaux}
 IF ((XCASE[1+(3*XOROIN)]) AND
    (XCASE[2+(3*XOROIN)]) AND
    (XCASE[3+(3*XOROIN)]) = 2 ) THEN
 BEGIN
 WIN:=FALSE;   {[O] Gagne}
 WLN:=TRUE;    {Quiconque gagne}
 OSCORE:=OSCORE+1;  {[O] gagne, on rajoute 1 a xscore}
 IF NODOUBLET = FALSE THEN
 TSCORE:=TSCORE+1;  {rajoute un dans le total}
 PUT_SCORE(XSCORE,OSCORE,TSCORE); {Entre les nouveaux scores}
 END;
 FOR XOROIN:=0 TO 2 DO {Check s'il y a tic-tac-toe dans les 3 verticaux}
 IF ((XCASE[1+(XOROIN)]) AND
    (XCASE[4+(XOROIN)]) AND
    (XCASE[7+(XOROIN)]) = 2 ) THEN BEGIN
 WIN:=FALSE;  {[O] gagne}
 WLN:=TRUE;   {Quiconque Gagne}
 OSCORE:=OSCORE+1;
 IF NODOUBLET = FALSE THEN
 TSCORE:=TSCORE+1;
 PUT_SCORE(XSCORE,OSCORE,TSCORE);
 END;
 FOR XOROIN:=0 TO 1 DO
 IF ((XCASE[1+(2*XOROIN)]) AND
    (XCASE[5]) AND
    (XCASE[9-(2*XOROIN)]) = 2 ) THEN BEGIN
 WIN:=TRUE;
 WLN:=TRUE;
 PUT_SCORE(00,00,00);
 OSCORE:=OSCORE+1;
 IF NODOUBLET = FALSE THEN
 TSCORE:=TSCORE+1;
 PUT_SCORE(XSCORE,OSCORE,TSCORE);
 END;
END;
UNTIL WLN = TRUE    {WIN,LOSE,NUL}
END;

PROCEDURE MOVE_SPRITE_PLAYER(XORO:BOOLEAN);
{Deplace le Sprites [X] et [O] avec lectures et cliquement de la souris}
VAR X1,X2,Y1,Y2,Z1,TAUX,COMPT:WORD;
    XOROIN:BYTE;
    WLN,WIN,NODOUBLET:BOOLEAN;
BEGIN
 WLN:=FALSE;  NODOUBLET:=FALSE;
 REPEAT
 REPEAT
IF XORO = TRUE THEN XOROIN:= 0;
IF XORO = FALSE THEN XOROIN:= 1;
 PUT_SPRITE(FONTS[0+XOROIN,0],FONTS[0,1],FONTS[0,2],FONTS[0,3],X1,Y1,
            SEG(VSCR^)+OFS(VSCR^));
 ASM
 IN AL,60H   {lit le clavier}
 MOV KEYB,AL  {transfer le code dans la variable keyb}
 END;
 IF (KEYB = 1) THEN QUIT; {si escape, on quit le programme}
 X2:=X1; Y2:=Y1;
 ASM MOV AX,03H;   {Lit les Coordonne de la souris}
     INT 33H;      {Declanche l'interruption de la souris}
     MOV X1,CX     {Coordonne de l'abscive}
     MOV Y1,DX     {coordonne de l'ordonne}
     MOV Z1,BX     {Lit si il y a un bouton active}
 END;
 TAUX:= (320*Y1)+(X1);
 IF (X2 <> X1) OR (Y2 <> Y1) THEN BEGIN
 WAIT_RETRACE;
 PUT_SPRITE(X2,Y2,FONTS[0,2],FONTS[0,3],X2,Y2,SEG(VSCREEN^)+OFS(VSCREEN^));
 END;
 UNTIL (Z1 = (1)) OR (Z1 = (2));
 IF MOUSEIF(TAUX,XORO) = TRUE THEN
 IF XORO = TRUE THEN  XORO:=FALSE
 ELSE XORO := TRUE ;
 ASM
 @BOUT1:
 MOV AX,04H   {Positionne le curseur de la souris}
 MOV CX,X1    {Positionne l'axe horizontal}
 MOV DX,Y1    {Positionne l'axe Verticale}
 INT 33H;     {Declanche l'interuption}
 MOV AX,05H   {Lit l'etat des boutons et compte le nombre d'actionnement}
 INT 33H      {Declanche l'interruption de la souris}
 OR AL,AL     {bouton encore enfoncer}
 JNZ @BOUT1   {branchement si different}
 END;
IF ((XCASE[1] <> 0) AND (XCASE[2] <> 0) AND (XCASE[3] <> 0) AND
   (XCASE[4] <> 0) AND (XCASE[5] <> 0) AND (XCASE[6] <> 0) AND
   (XCASE[7] <> 0) AND (XCASE[8] <> 0) AND (XCASE[9] <> 0)) THEN
 BEGIN  {si toute les Cases sont occupe et non gagnante on reload}
  WLN:=TRUE;  {si nul,win ou lose , on reload}
  TSCORE:=TSCORE+1;  {nul donc rajoute un a la game total}
  NODOUBLET:=TRUE;
  PUT_SCORE(XSCORE,OSCORE,TSCORE); {Entre les nouveaux scores}
  END;
FOR XOROIN:=0 TO 2 DO  {check s'il y a tic-tac-toe dans les 3 horizontaux}
 IF ((XCASE[1+(3*XOROIN)]) AND
    (XCASE[2+(3*XOROIN)]) AND
    (XCASE[3+(3*XOROIN)]) = 1 ) THEN
 BEGIN
 WIN:=TRUE;    {[X] Gagne}
 WLN:=TRUE;    {Quiconque gagne}
 XSCORE:=XSCORE+1;  {[X] gagne, on rajoute 1 a xscore}
 IF NODOUBLET = FALSE THEN
 TSCORE:=TSCORE+1;  {rajoute un dans le total}
 PUT_SCORE(XSCORE,OSCORE,TSCORE); {Entre les nouveaux scores}
 END;
 FOR XOROIN:=0 TO 2 DO {Check s'il y a tic-tac-toe dans les 3 verticaux}
 IF ((XCASE[1+(XOROIN)]) AND
    (XCASE[4+(XOROIN)]) AND
    (XCASE[7+(XOROIN)]) = 1 ) THEN BEGIN
 WIN:=TRUE;   {[X] gagne}
 WLN:=TRUE;   {Quiconque Gagne}
 XSCORE:=XSCORE+1;
 IF NODOUBLET = FALSE THEN
 TSCORE:=TSCORE+1;
 PUT_SCORE(XSCORE,OSCORE,TSCORE);
 END;
 FOR XOROIN:=0 TO 1 DO
 IF ((XCASE[1+(2*XOROIN)]) AND
    (XCASE[5]) AND
    (XCASE[9-(2*XOROIN)]) = 1 ) THEN BEGIN
 WIN:=TRUE;
 WLN:=TRUE;
 PUT_SCORE(00,00,00);
 XSCORE:=XSCORE+1;
 IF NODOUBLET = FALSE THEN
 TSCORE:=TSCORE+1;
 PUT_SCORE(XSCORE,OSCORE,TSCORE);
 END;
FOR XOROIN:=0 TO 2 DO  {check s'il y a tic-tac-toe dans les 3 horizontaux}
 IF ((XCASE[1+(3*XOROIN)]) AND
    (XCASE[2+(3*XOROIN)]) AND
    (XCASE[3+(3*XOROIN)]) = 2 ) THEN
 BEGIN
 WIN:=FALSE;   {[O] Gagne}
 WLN:=TRUE;    {Quiconque gagne}
 OSCORE:=OSCORE+1;  {[O] gagne, on rajoute 1 a xscore}
 IF NODOUBLET = FALSE THEN
 TSCORE:=TSCORE+1;  {rajoute un dans le total}
 PUT_SCORE(XSCORE,OSCORE,TSCORE); {Entre les nouveaux scores}
 END;
 FOR XOROIN:=0 TO 2 DO {Check s'il y a tic-tac-toe dans les 3 verticaux}
 IF ((XCASE[1+(XOROIN)]) AND
    (XCASE[4+(XOROIN)]) AND
    (XCASE[7+(XOROIN)]) = 2 ) THEN BEGIN
 WIN:=FALSE;  {[O] gagne}
 WLN:=TRUE;   {Quiconque Gagne}
 OSCORE:=OSCORE+1;
 IF NODOUBLET = FALSE THEN
 TSCORE:=TSCORE+1;
 PUT_SCORE(XSCORE,OSCORE,TSCORE);
 END;
 FOR XOROIN:=0 TO 1 DO
 IF ((XCASE[1+(2*XOROIN)]) AND
    (XCASE[5]) AND
    (XCASE[9-(2*XOROIN)]) = 2 ) THEN BEGIN
 WIN:=TRUE;
 WLN:=TRUE;
 PUT_SCORE(00,00,00);
 OSCORE:=OSCORE+1;
 IF NODOUBLET = FALSE THEN
 TSCORE:=TSCORE+1;
 PUT_SCORE(XSCORE,OSCORE,TSCORE);
 END;
UNTIL WLN = TRUE    {WIN,LOSE,NUL}
END;

FUNCTION CHOOSE_PLAYER : BOOLEAN;
{Chosie Choix le player vs player ou player vs computer avec le clicquement
 de la souris gauche et droite}
VAR S1:WORD; {variable pour les boutons}
BEGIN
LOADGIF('3TCHOOSE.GIF'); {load le gif}
REPEAT
 ASM
 IN AL,60H   {lit le clavier}
 MOV KEYB,AL  {transfer le code dans la variable keyb}
 END;
 IF (KEYB = 1) THEN QUIT; {si escape, on quit le programme}
 ASM
     MOV AX,04H   {Positionne le curseur de la souris}
     MOV CX,159   {Positionne l'axe horizontal}
     MOV DX,100   {Positionne l'axe Verticale}
     INT 33H;     {Declanche l'interuption}
     MOV AX,03H;  {Lit les Coordonne de la souris}
     INT 33H;     {Declanche l'interruption de la souris}
     MOV S1,BX    {Lit si il y a un bouton active}
 END;
UNTIL (S1 = 1) OR (S1 = 2) ;
IF S1 = 1 THEN CHOOSE_PLAYER := TRUE ;  {player vs player}
IF S1 = 2 THEN CHOOSE_PLAYER := FALSE ; {player vs player}
END;
VAR WHOBEGIN:BOOLEAN; {Qui commence entre rond et carre}
BEGIN
BLOCK_KBD;           {Block le Keyboard}
GETMEM(VSCR,64000); {Donne 64000 octets dans le pointeur VS}
INIT_MODE13;        {init le mode video}
MAKE_9CASE;         {Construit les 9 tables pour la souris}
XSCORE:=0;          {Score pour le [X]}
OSCORE:=0;          {Score pour le [O]}
TSCORE:=0;          {Score pour le [X] + [O] + nul}
RANDOMIZE; {commence le compteur de Hasard}
{Si vrai, player vs player, sinon player vs computer}
IF CHOOSE_PLAYER = TRUE THEN BEGIN
LIMIT_MOUSE; {defini la zone limite de la souris}
LOADGIF2('TTTFONTS.GIF',VSCR); {load les fonts}
REPEAT
FOR CLEAR := 1 TO 9 DO XCASE[CLEAR]:=0;
LOADGIF ('TICTACTO.GIF'); {load le gif}
PUT_SPRITE2(92,0,80,14,243,61,SEG(VSCR^)+OFS(VSCR^), {Met le sprite du }
            SEG(VSCREEN^)+OFS(VSCREEN^));            { deuxieme player }
PUT_SPRITE(92,0,80,14,243,61,SEG(VSCR^)+OFS(VSCR^));
PUT_SCORE(XSCORE,OSCORE,TSCORE); {Initialise le Score pour [X],[O],[total]}
CLEAR:=RANDOM(255);
IF CLEAR > 127 THEN WHOBEGIN := FALSE;
IF CLEAR < 128 THEN WHOBEGIN := TRUE;
MOVE_SPRITE_PLAYER(WHOBEGIN);
UNTIL KEYB = 1 ;
END
{-*/*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-/*-*/-*/-*/-*/-*/-*/-*/}
ELSE
{-*/*/-*/-*/-*/-*/-*/-*/-*/-*/-*/-/*-*/-*/-*/-*/-*/-*/-*/}
BEGIN
LIMIT_MOUSE; {defini la zone limite de la souris}
LOADGIF2('TTTFONTS.GIF',VSCR); {load les fonts}
REPEAT
FOR CLEAR := 1 TO 9 DO XCASE[CLEAR]:=0;
LOADGIF ('TICTACTO.GIF'); {load le gif}
PUT_SCORE(XSCORE,OSCORE,TSCORE); {Initialise le Score pour [X],[O],[total]}
MOVE_SPRITE_COMPUTER;
UNTIL KEYB = 1;
QUIT;
END;
END.

