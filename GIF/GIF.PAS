PROGRAM GIF;

USES LOAD_GIF;

VAR VSCR:POINTER;               {pointeur pour les fonts}
    KEYB:BYTE;                  {Code de touche pour le Keyboard}
VAR B:BYTE;
VAR X1,Y1,Z1,X2,Y2:WORD;

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

PROCEDURE PUT_SPRITE (X1,Y1,LAR,HAU,X2,Y2:integer;SOURCE:pointer);
{ Met Un Sprite Dans La Memoire Video ($A000).                               }
{ X1 : Abscive ou l'on prend le Sprite
  Y1 : Ordonne ou l'on prend le Sprite
  LAR: Largeur Du Sprite
  HAU: Hauteur Du Sprite
  X2 : Abscive ou l'on place le Sprite
  Y2 : Ordonne ou l'on place le Sprite
  SOURCE: Pointeur d'image ou le Sprite provient}
ASSEMBLER;
 ASM
  CLD           {Met a zero l'indicateur [DF] pour l'ordre croissant}
  PUSH SI
  PUSH DS       { [DS:SI] }
  PUSH 0A000H   {Transfer dans la memoire video}
  POP  ES       { [ES:DI] }
  LDS  SI,DWORD PTR Source

  MOV  AX,320   {Fait la fonction 320Y+X pour placer un pixel}
  MUL  Y1       {320Y}
  ADD  AX,X1    {(320Y)+X1}
  ADD  SI,AX    {la formule (320Y+X) place a la position voulu dans [DS:SI]}

  MOV  AX,320
  MUL  Y2        {320*y}
  ADD  AX,X2     {(320*Y)+x}
  MOV  DI,AX     {Fait le Fonction 320Y+X pour placer directement dans la
                  memoire video (0A000h)}
  MOV  DX,HAU    {Copie la hauteur du Sprite}
  MOV  AX,LAR    {Copie la largeur du Sprite}
  MOV  BX,320    {une ligne equivaut a 320}
  SUB  BX,AX     {fait la difference pour que le Sprite soit droit et bien
                  placer}
 @HAUTEUR:
  DEC  DX        {decremente ce registre  }
  MOV  CX,AX     {Copie le nombre de pixel de largeur}
  REP  MOVSB     {active la boucle}
  ADD  SI,BX     {Add (320-largeur) dans la source}
  ADD  DI,BX     {Add (320-largeur) dans la memoire video}
  OR   DX,DX     {compage si dx est a zero}
  JNE  @HAUTEUR  {Branchement si pas equal}
  POP  DS
  POP  SI
END;


PROCEDURE PUT_SPRITE2 (X1,Y1,LAR,HAU,X2,Y2:word;SOURCE,DESTINATION:pointer);
{ Met Un Sprite Dans La Memoire Video ($A000).                               }
{ X1 : Abscive ou l'on prend le Sprite
  Y1 : Ordonne ou l'on prend le Sprite
  LAR: Largeur Du Sprite
  HAU: Hauteur Du Sprite
  X2 : Abscive ou l'on place le Sprite
  Y2 : Ordonne ou l'on place le Sprite
  SOURCE: Pointeur d'image ou le Sprite provient}
ASSEMBLER;
 ASM
  CLD            {Met a zero l'indicateur [DF] pour l'ordre croissant}
  PUSH  DS       { [DS:SI] }
  LES  DI,DWORD PTR Destination
  LDS  SI,DWORD PTR source
  MOV  AX,320    {Fait la fonction 320Y+X pour placer un pixel}
  MUL  Y1        {320Y}
  ADD  AX,X1     {(320Y)+X1}
  ADD  SI,AX     {la formule (320Y+X) place a la position voulu dans [DS:SI]}

  MOV  AX,320
  MUL  Y2        {320*y}
  ADD  AX,X2     {(320*Y)+x}
  add  DI,AX     {Fait le Fonction 320Y+X pour placer directement dans la
                  memoire video (0A000h)}
  MOV  DX, HAU   {Copie la hauteur du Sprite}
  MOV  AX, LAR   {Copie la largeur du Sprite}
  MOV  BX,320    {une ligne equivaut a 320}
  SUB  BX,AX     {fait la difference pour que le Sprite soit droit et bien
                   placer}
 @HAUTEUR:
  DEC  DX        {decremente ce registre  }
  MOV  CX, AX    {Copie le nombre de pixel de largeur}
  REP  MOVSB     {active la boucle}
  ADD  SI, BX    {Add (320-largeur) dans la source}
  ADD  DI, BX    {Add (320-largeur) dans la memoire video}
  OR   DX,DX     {compage si dx est a zero}
  JNE  @HAUTEUR  {Branchement si pas equal}
  POP  DS
END;

PROCEDURE INIT_MODE13;
{ Init le mode video a 13H}
ASSEMBLER;
 ASM
  MOV AX,13h
  INT 10h
END;

PROCEDURE QUIT;
BEGIN
 FREEMEM(VSCREEN,64000); {Libere la memoire du Back_Ground}
 FREEMEM(VSCR,64000);    {Libere la memoire des fonts}
 ASM
  MOV AX,0003h   {Init le mode Video Dos}
  INT 10h
 END;
 HALT;
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
  MOV DX,184d   {Position vertical maximal}
  INT 33H       {Declache l'interruption de la souris}
  MOV AX,0FH    {Defini la sensibiliter la souris}
  MOV CX,0FH    {sensibilit‚ horizontale}
  MOV DX,0FH    {sensibilit‚ verticale}
  INT 33H       {Declanche l'interrupt 33h}
END;

BEGIN
 GETMEM(VSCR,64000); {Donne 64000 octets dans le pointeur VS}

 INIT_MODE13;        {init le mode video}

 LIMIT_MOUSE;        {defini la zone limite de la souris}

 LOADGIF2('SPRITES.GIF',VSCR);
 LOADGIF('BG.GIF');
 
 B:=0;

REPEAT
 WAIT_RETRACE;
 
 PUT_SPRITE(1+(73*B),1,72,74,120,90,VSCR);
 WAIT_RETRACE;

 PUT_SPRITE(1+(73*B),1,72,74,120,90,VSCR);
 WAIT_RETRACE;

 ASM
  IN AL,60H
  MOV KEYB,AL
  MOV AX,03H;   {Lit les Coordonne de la souris}
  INT 33H;      {Declanche l'interruption de la souris}
  MOV X1,CX     {Coordonne de l'abscive}
  MOV Y1,DX     {coordonne de l'ordonne}
  MOV Z1,BX     {Lit si il y a un bouton active}
 END;

 B:= B XOR 1;

UNTIL (Z1 = 1) OR (Z1 = 2) OR (KEYB = 1) OR (KEYB = 28);

 QUIT;

END.

