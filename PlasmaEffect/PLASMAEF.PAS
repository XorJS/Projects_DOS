uses crt;

Var screen:Pointer;
Var palette:array[0..767] of byte;
Var x,y,colors:integer;
    time,s1,p1:integer;
    sinus:array[0..256] of integer;

Procedure Show;
Assembler;
Asm
 Push Ds

 Mov Dx,03DAh
 Mov Bl,08
@1:
 In Al,Dx
 Test AL,Bl
 Jnz @1
@2:
 In Al,Dx
 Test AL,BL
 Jz @2

 Lds Si,Dword Ptr screen
 Mov Ax,0A000h
 Mov Es,Ax
 Xor Di,Di
 Mov Cx,16000
 Db 066h
 Rep Movsw

 Pop Ds
End;

Procedure SetPalette;
Assembler;
Asm
 Push Si
 Mov Dx,03C8h
 Xor Al,Al
 Out Dx,Al
 Inc Dx
 Mov Si,Offset palette
 Mov Cx,768
 Rep Outsb
 Pop si
End;

Procedure Put2Pixels(x,y,z:word);
Assembler;
Asm
 Les Di,Dword Ptr screen
 Imul Ax,y,320
 Add Ax,x
 Add Ax,x
 Add Di,Ax
 Mov Bx,word ptr z
 Mov Es:[Di],Bx
End;

Begin
Asm
 Mov Ax,13h
 Int 10h
End;

for x:=0 to 256 do sinus[x]:=Round(Sin(2*pi*x/256)*127);

Getmem(screen,64000);

for x:=0 to 255 do
begin
 palette[3*x] := (sinus[(x+64) and 255] + 128) shr 2;
 palette[3*x+1] := (sinus[(x) and 255] + 128) shr 2;
 palette[3*x+2] := (sinus[(x-96) and 255] + 128) shr 2;
end;

SetPalette;

repeat
 for x:=0 to 159 do
 for y:=0 to 199 do
 begin
  s1 := (time-x shl 1) and 255;
  p1 := (x shl 1-159+sinus[(time+y) and 255]) and 255;

  colors := ((sinus[p1] * sinus[(y-99+sinus[s1]) and 255]) shr 7) or
  ((sinus[p1+1] * sinus[(y-99+sinus[(s1-1) and 255]) and 255]) shl 1) and 65280;

  Put2Pixels(x,y,colors);
 end;

 inc(time,3);
 Show;
until keypressed;

Asm
 Mov Ax,03h
 Int 10h
End;

Freemem(screen,64000);

End.