Program TestAnm;

Uses Crt, PlayAnim;

Var i:word;

Procedure SetPalette;
Assembler;
 Asm
  PUSH SI
  MOV SI,OFFSET PALETTE
  MOV CX,768
  XOR AL,AL
  MOV DX,03C8h

  OUT DX,AL

  INC DX
  REP OUTSB

  POP SI
End;

Procedure WaitRetrace;
{----------------------------------------------------------------------------}
{ Fait Un Retour de Balayage Verticale                                       }
{----------------------------------------------------------------------------}
ASSEMBLER;
ASM
  MOV DX,03DAh               { Input Status Register 1 }
@WAIT1:
  IN AL,DX                   { Bit 3 = 0 si le rayon est en train de }
                             { dessiner l'image de l'ecran }
  TEST AL,11111111b          { Test avec 8h }
  JNZ @WAIT1                 { Branchement si different }
@WAIT2:
  IN AL,DX                   { Bit 3 = 1 si le rayon est en retour de }
                             { balayage }
  TEST AL,08h                { Test avec 8h }
  JZ @WAIT2                  { Branchement si different }
END;

Begin
 Asm
  Mov Ax,13h;
  Int 10h;
 End;

 AnmInit('BALLMONS.ANM') ;

 SetPalette;

Repeat
 For i:= 0 To header.nRecords-1 Do Begin
  AnmReadFrame(i);
  WaitRetrace;
 End;
Until keypressed;

 AnmDone;

 Asm
  Mov Ax,03;
  Int 10h;
 End;

End.
